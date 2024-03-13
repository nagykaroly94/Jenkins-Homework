pipeline {
    agent {label 'terraform'}

    stages {
        stage('git') {
            steps {
                git branch: 'main',
                url: 'https://github.com/nagykaroly94/Jenkins-Homework'
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
