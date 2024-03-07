pipeline {
    agent {
        label 'jenkins-slave'
    }
     
    options {
        buildDiscarder(logRotator(numToKeepStr:'5'))
    }
    stages {
        stage('gitclone') {
            steps {
                git branch: 'main',
                url: 'https://github.com/nagykaroly94/Jenkins-Homework.git'              
            }
        }
        stage('apache'){
            steps{
                sh './Jenkins-Homework/apache_date.sh'
            }
        }
        stage('artifact'){
            steps{ 
                archiveArtifacts artifacts: 'apache_install_date.txt'
            }
        }
    }
}