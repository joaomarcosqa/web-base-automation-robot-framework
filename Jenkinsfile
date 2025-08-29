pipeline {
    agent any

    environment {
        VENV_DIR = '.venv'
        TEST_COMMAND = 'robot -v device:s1 ./src/test'
        REQUIREMENTS_FILE = 'requirements.txt'
    }

    stages {
        stage('Preparar Ambiente Python') {
            steps {
                sh '''
                    python3 -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -r ${REQUIREMENTS_FILE}
                '''
            }
        }

        stage('Instalar Browser Library') {
            steps {
                sh '''
                    . ${VENV_DIR}/bin/activate
                    rfbrowser init
                '''
            }
        }

        stage('Executar Testes Robot Framework') {
            steps {
                sh '''
                    . ${VENV_DIR}/bin/activate
                    ${TEST_COMMAND}
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline finalizada.'
        }
    }
}