# Jenkins-Homework

## Előfeltételek

### Rendszergazdai jogosultság

A feladat megoldásának tesztelése és ellenőrzésének egyik alapvető feltétele, hogy a jenkins felhasználó sudo jogosultsággal rendelkezzen.
Ezt az ellenőrzés előtt egy rendszergazdai jogokkal rendelkező felhasználóval ki kell adni a lent látható kódot azon gépen, ahol a jenkins-slave node fut.

```
sudo echo "jenkins  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins
```

### Címkézés

A jenkins-slave node címkéjnek mindenképp a "terraform" értéket kell megadni.

## Leírás

### Jenkinsfile

A Jenkinsfile a terraform címkével ellátott node-ot fogja alapértelmezetten használni. Három stage-re van bontva.
Az első stage telepíti a git-et majd ebből (https://github.com/nagykaroly94/Jenkins-Homework) a repositoryból letölti a main branch-en található legfrissebb file-okat. A második stage a letöltött apache_date.sh scriptet futtathatóvá teszi, majd elvégzi a futtatását is. A harmadik stage folyamán létrehozza az artifactot abból a txt file-ból amit a bash script végén generál.

### apache_date.sh

Az egész script azzal kezdődik, hogy az "uname" parancs használatával létrehozok egy os nevű változóz. 

```
os=$(uname)
```

A következőkben egy alapvető vizsgálat indul, ami azt nézni meg, hogy egyáltalán Linux disztribúciót használ-e a felhasználó. 

```
if [ "$os" = "Linux" ]; then echo "Ez egy Linux disztribúció"
else
  echo "Nem támogatott Operációs Rendszer"
  exit 1
fi
```

Ezen a vizsgálaton belül inul egy következő vizsgálat ami azt figyeli, hogy az adott disztribúció redhat vagy debian alapú rendszer. Ezt szintén változókkal valósítottam meg. Amennyiben a vizsgálat folyamán a script redhat alapú rendszert érzékelt a pkg_manager felveszi a yum értéket, ha ugyanennek a vizsgálatnak a végeredménye az hogy debian alapú rendszeren fut akkor pedig az apt értéket kapja meg a fent említett változó. 

```
  if [[ -f /etc/redhat-release ]]; then
    pkg_manager=yum
  elif [[ -f /etc/debian_version ]]; then
    pkg_manager=apt
  fi
```

Az előbbiek után elindul annak a vizsgálata, hogy a pkg_manager milyen értéket vett fel. Az elágazás két vonala ugyanazokat az utasításokat tartalmazza, viszont az adott disztribúcióra szabva. Az utasítások segítségével lefut egy webszerver telepítése. Ezután a szolgáltatást engedélyezi és elindítja.

```
  if [ $pkg_manager = "yum" ]; then
    sudo yum install httpd -y
    sudo systemctl enable httpd && sudo systemctl start httpd
  elif [ $pkg_manager = "apt" ]; then  
    sudo apt install apache2 -y
    sudo systemctl enable apache2 && sudo systemctl start apache2
  fi
```

Az egész végén a feladatnak megfelelően létrehoz a script egy apache_install_date.txt file-t ami a futásnak a percre pontos időpontját tartalmazza.
