# Jenkins-Homework
Jenkins házifeladat megoldása

A feladat megoldásának tesztelése és ellenőrzésének egyik alapvető feltétele, hogy a jenkins felhasználó sudo jogosultsággal rendelkezzen.
Ezt az ellenőrzés előtt egy rendszergazdai jogokkal rendelkező felhasználóval ki kell adni a lent látható kódot a gépen, ahol a jenkins-slave node fut.
```
sudo echo "jenkins  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins
```
