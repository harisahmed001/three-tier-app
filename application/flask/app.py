from flask import Flask, request
from flask_cors import CORS, cross_origin
import psycopg2, os

app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

conn = psycopg2.connect(
        host="innovationai_postgres",
        database="app",
        user = os.environ['DB_USERNAME'],
        password= os.environ['DB_PASSWORD']
)

@app.route('/')
def index():
    return {"status": "App is up and running"}

@app.route('/data')
def data():
    name = request.args.get('key', 'testuser')
    cur = conn.cursor()
    cur.execute("SELECT name FROM users where name='" + name + "'")
    users = cur.fetchone()
    return {"users": users[0]}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)