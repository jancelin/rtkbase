#!/bin/bash
set -ex

sudo systemctl status str2str_file.service &
sudo systemctl status str2str_ntrip.service &
sudo systemctl status str2str_tcp.service
