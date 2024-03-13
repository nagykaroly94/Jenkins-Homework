pipeline {
    agent {label 'terraform'}

    stages {
        stage('git') {
            steps {
                sh 'sudo yum install git -y'
                git branch: 'main', credentialsId: '7b154a8c-a333-41d5-8f00-d0e983f8bcb0', url: 'https://github.com/nagykaroly94/Jenkins-Homework'
            }
        }
        stage('apache') {
            steps {
                sh 'chmod +x ./apache_date.sh'
                sh './apache_date.sh'
            }
        }
        stage('artifact') {
            steps {
                archiveArtifacts artifacts: 'apache_install_date.txt', followSymlinks: false
            }
        }
    }
}
