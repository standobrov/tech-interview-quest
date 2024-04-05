#! /bin/bash
set -xe

#installing stuff
sudo apt install -y nginx
sudo apt install -y python3-pip
sudo apt install -y python3.10-venv
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

#launching the broken backend...
python3 ./app/broken_backend.py &

#correct backend file is interview_backend.py