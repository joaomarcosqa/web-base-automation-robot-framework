pipeline {
    agent any

    tools {
        nodejs 'NodeJS_LTS'
    }

    environment {
        VENV_DIR = '.venv'
        TEST_DIR = './src/test'
    }

    stages {
        stage('Criar Virtualenv') {
            steps {
                sh '''
                    python3 -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Instalar Playwright via rfbrowser') {
            steps {
                sh '''
                    . ${VENV_DIR}/bin/activate

                    # Adiciona o npm ao PATH dentro do venv
                    export PATH=$PATH:$(npm bin -g)

                    # Executa o rfbrowser init
                    rfbrowser init
                '''
            }
        }

        stage('Executar testes') {
            steps {
                sh '''
                    . ${VENV_DIR}/bin/activate
                    robot -v device:s1 ${TEST_DIR}
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '/output.xml,/log.html,/report.html', allowEmptyArchive: true
        }
    }
}