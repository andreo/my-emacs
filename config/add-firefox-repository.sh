#!/bin/bash

echo -e "\ndeb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main" | sudo tee -a /etc/apt/sources.list > /dev/null
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1289A29
