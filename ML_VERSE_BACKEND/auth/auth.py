from flask import Flask, request, jsonify
from pymongo import MongoClient
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Configure MongoDB connection
client = MongoClient("mongodb://localhost:27017/")
db = client["mlverse"]
users = db["users"]

@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if users.find_one({'email': email}):
        return jsonify({'message': 'Email already exists'}), 400

    users.insert_one({'email': email, 'password': password})
    return jsonify({'message': 'User registered successfully'}), 201

@app.route('/signin', methods=['POST'])
def signin():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    user = users.find_one({'email': email})
    if user and user['password'] == password:
        return jsonify({'message': 'Login successful'}), 200
    return jsonify({'message': 'Invalid credentials'}), 401

if __name__ == '__main__':
    app.run(debug=True)