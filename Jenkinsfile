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
        vercel_token=credentials('vercel_token')
    }
    stages {
        stage('Install') {
            steps {
                sh "apt-get update -y && apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb"
                sh "npm install cypress -g"
                sh "npm install -g vercel"
                sh "npm install"
            }
        }
        stage('Linter') {
            steps {
                script {
                    env.LINT_RESULT = sh (script: "npm run lint",returnStatus: true)
                }
            }
        }
        stage('Run_App') {
            steps {
                sh "npm run build && npm run start&"
            }
        }
        stage('Test') {
            steps {
                script {
                    env.CYPRESS_RESULT = sh (script: "npx cypress run",returnStatus: true)
                }
                echo env.CYPRESS_RESULT
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
                    env.README_RESULT = sh(script:"""./jenkinsScripts/readmeScript.sh ${env.CYPRESS_RESULT}""",returnStatus:true)
                }
            }
        }
        stage('Push_Changes') {
            steps {
                script {
                    env.PUSH_RESULT = sh(script:"""./jenkinsScripts/pushScript.sh ${params.Ejecutor} ${params.Motivo} ${github_origin}""",returnStatus:true)
                }
            }
        }
        stage('Deploy_to_Vercel') {
            steps {
                script {
                    env.DEPLOY_RESULT = sh(script: """./jenkinsScripts/vercel.sh ${env.LINT_RESULT} ${env.CYPRESS_RESULT} ${env.README_RESULT} ${env.PUSH_RESULT} ${vercel_token}""", returnStatus: true)
                }
            }
        }
    }
}