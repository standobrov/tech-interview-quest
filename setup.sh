#! /bin/bash
set -xe

#installing stuff
apt install -y nginx python3-pip python3-venv
/usr/bin/python3 -m venv .venv
source .venv/bin/activate
pip3 install -r requirements.txt

#cleanup prev installations
sudo rm -fv /etc/nginx/sites-available/flask_app
sudo rm -fv /etc/nginx/sites-enabled/flask_app

#setting stuff up
sudo cp -r app/html/* /var/www/html/
sudo cp flask_app /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/flask_app /etc/nginx/sites-enabled/
sudo rm -fv /etc/nginx/sites-enabled/default
sudo systemctl restart nginx.service
cp -f interview-backend.service /etc/systemd/system/interview-backend.service
chmod 644 /etc/systemd/system/interview-backend.service

#launching the broken backend...
nohup python3 ./app/broken_backend.py 2>&1 &
disown

systemctl enable interview-backend.service
systemctl start interview-backend.service


