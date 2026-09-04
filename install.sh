#!/bin/bash

echo "Installing pylarexx in /usr/local/pylarexx"
mkdir -p /usr/local/pylarexx
python3 -m venv /usr/local/pylarexx
source /usr/local/pylarexx/bin/activate
pip3 install .
if [ ! -f /etc/pylarexx.yml ] ; then
  echo "Placing example config to /etc/pylarexx.yml"
  cp example_pylarexx.yml /etc/pylarexx.yml
fi
if [ -f /usr/bin/systemctl ] ; then
  echo "Add user pylarexx to run daemon"
  mkdir /var/run/pylarexx/
  useradd pylarexx --system --user-group --home-dir /var/run/pylarexx/
  echo "Install udev rule to allow daemon device access"
  cp etc/udev/rules.d/51-rf_usb.rules /etc/udev/rules.d/
  echo "Creating pylarexx systemd service. Start it with: systemctl start pylarexx"
  echo "Start at boot with: systemctl enable pylarexx"
  cp etc/systemd/pylarexx.service /etc/systemd/system
  systemctl daemon-reload
fi
