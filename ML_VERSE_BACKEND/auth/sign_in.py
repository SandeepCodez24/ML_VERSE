from flask import Flask, jsonify, request
from pymongo import MongoClient
from flask_cors import CORS
import bcrypt
app = Flask(__name__)
CORS(app)

client = MongoClient('mongodb://localhost:27017/')
db = client['ML_VERSE_DB']
users = db['users']

@app.route('/sign_in', methods=['POST'])
def sign_up():
    data = request.get_json()
    email = data['email']
    password = data['password']
    userName = data['userName']
    
    if users.find_one({"email":email}):
        return jsonify({"message":"Email already exists"}), 400
    hased_pw = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
    users.insert_one({'email':email, 'password':hased_pw, 'username': userName})
    return jsonify({"message":"Successfully signed up"}), 201

@app.route('/sign_in', methods=['GET'])
def sign_in():
    data = request.get_json()
    email = data['email']
    password = data['password']
    user = users.find_one({"email":email})
    
    if user and bcrypt.checkpw(password.encode('utf-8'), user['password']):
        return jsonify({"message":"Successfully signed in"}), 200
    else:
        return jsonify({"message":"Invalid email or password"}), 401

if __name__ == '__main__':
    app.run(debug=True)
    

