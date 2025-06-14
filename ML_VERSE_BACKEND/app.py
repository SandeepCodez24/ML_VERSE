from flask import Flask, request, jsonify
from pymongo import MongoClient
from flask_cors import CORS
import bcrypt
import base64

app = Flask(__name__)
CORS(app)

# MongoDB setup
client = MongoClient("mongodb://localhost:27017/")
db = client["ML_VERSE_DB"]
users = db["users"]

def hash_password(password):
    hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
    return base64.b64encode(hashed).decode('utf-8')

def check_password(password, hashed_str):
    hashed = base64.b64decode(hashed_str.encode('utf-8'))
    return bcrypt.checkpw(password.encode('utf-8'), hashed)

@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')
    userName = data.get('userName')

    if not email or not password or not userName:
        return jsonify({'message': 'Missing fields'}), 400

    if users.find_one({'email': email}):
        return jsonify({'message': 'Email already exists'}), 400

    hashed_pw = hash_password(password)
    users.insert_one({'email': email, 'password': hashed_pw, 'username': userName})
    return jsonify({'message': 'User registered successfully'}), 201

@app.route('/signin', methods=['POST'])
def signin():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    user = users.find_one({'email': email})
    if user and check_password(password, user['password']):
        return jsonify({'message': 'Login successful', 'userName': user.get('username', '')}), 200
    return jsonify({'message': 'Invalid credentials'}), 401

if __name__ == '__main__':
    app.run(debug=True)