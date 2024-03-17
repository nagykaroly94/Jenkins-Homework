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
    yum install httpd -y
    systemctl enable httpd && systemctl start httpd
  elif [ $pkg_manager = "apt" ]; then  
    apt install apache2 -y
    systemctl enable apache2 && systemctl start apache2
  fi
else
  echo "Nem támogatott Operációs Rendszer"
  exit 1

fi

echo "Apache webszerver telepítése sikeres volt!"

date +%Y_%m_%d_%H_%M >> apache_install_date.txt
