from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return "ERROR 502 Bad Gateway. This Backend is hopelessly broken and can't be restored.", 502

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)