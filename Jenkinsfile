pipeline{

    agent any

    triggers {
        pollSCM('H/2 * * * *')
    }

    tools{
        nodejs 'NodeJS 25.7.0'
    }

    environment {
        REGISTRY       = 'https://index.docker.io/v1/'
        DOCKERHUB_CRED = 'bb835d88-f2f7-402f-a964-a492f5cd7cbf'
        IMAGE          = 'andriohanania/frontend'
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
        stage('docker build & push'){
            when { branch 'master' }   // build/push images only from the main line, not from PRs
            steps {
                script {
                    def gitsha = (env.GIT_COMMIT ?: 'dev').take(7)
                    def tag    = "${env.BUILD_NUMBER}-${gitsha}"
                    docker.withRegistry(env.REGISTRY, env.DOCKERHUB_CRED) {
                        def image = docker.build("${env.IMAGE}:${tag}", ".")
                        image.push()          // immutable tag
                        image.push('latest')  // moving tag
                    }
                }
            }
        }
    }
}