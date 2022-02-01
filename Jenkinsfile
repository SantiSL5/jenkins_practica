pipeline {
    agent any
    triggers {
        pollSCM('0 */3 * * *')
    }
    parameters {
        string(name: 'Ejecutor', defaultValue: 'Santi')
        string(name: 'Motivo', defaultValue: 'test')
        string(name: 'Correo notificación')
    }
    environment {
        github_origin=credentials('github_origin')
    }
    stages {
        stage('Install') {
            steps {
                sh "apt-get update -y && apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb"
                sh "npm install cypress -g"
                sh "npm install"
            }
        }
        stage('Linter') {
            steps {
                script {
                    env.LINT_RESULT = sh (script: "npm run lint",returnStdout: true)
                }
            }
        }
        stage('Run_App') {
            steps {
                sh "npm run dev&"
            }
        }
        stage('Test') {
            steps {
                script {
                    env.CYPRESS_RESULT = sh (script: "NO_COLOR=1 npx cypress run",returnStdout: true)
                }
            }
        }
        stage('Scripts_exec') {
            steps {
                sh "chmod +x ./jenkinsScripts/*"
            }
        }
        stage('Update_Readme') {
            steps {
                script {
                    // echo env.CYPRESS_RESULT
                    env.README_RESULT = sh(script:"""./jenkinsScripts/readmeScript.sh ${env.CYPRESS_RESULT}""",returnStatus:true)
                }
                // sh '''
                //     env.README_RESULT = ./jenkinsScripts/readmeScript.sh $env.CYPRESS_RESULT
                // '''
            }
        }
        stage('Push_Changes') {
            steps {
                script {
                    // sh "./jenkinsScripts/pushScript.sh ${params.Ejecutor} ${params.Motivo}"
                    script {
                        env.README_RESULT = sh(script:"""./jenkinsScripts/pushScript.sh ${params.Ejecutor} ${params.Motivo} $github_origin""",returnStatus:true)
                    }
                }
            }
        }
    }
}