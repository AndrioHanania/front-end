pipeline{

    agent any

    tools{
        maven 'NodeJS 25.7.0'
    }

    stages{
        stage('build'){
            steps{
                sh 'npm install'
            }
        }
        stage('test'){
            steps{
                sh 'npm test'
            }
        }
        stage('package'){
            steps{
                sh 'npm run package'
            }

            post {
                success {
                    archiveArtifacts '**/distribution/*.zip'
                }
            }
        }
    }
}