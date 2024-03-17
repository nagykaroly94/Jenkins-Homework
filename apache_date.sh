#!/bin/bash

os=$(uname)

if [ "$os" = "Linux" ]; then

echo "Ez egy Linux disztribúció"

  if [[ -f /etc/redhat-release ]]; then
    pkg_manager=yum
  elif [[ -f /etc/debian_version ]]; then
    pkg_manager=apt
  fi

  if [ $pkg_manager = "yum" ]; then
    sudo yum install httpd -y
    sudo systemctl enable httpd && sudo systemctl start httpd
  elif [ $pkg_manager = "apt" ]; then  
    sudo apt install apache2 -y
    sudo systemctl enable apache2 && sudo systemctl start apache2
  fi
else
  echo "Nem támogatott Operációs Rendszer"
  exit 1

fi

echo "Apache webszerver telepítése sikeres volt!"

date +%Y_%m_%d_%H_%M > apache_install_date.txt
