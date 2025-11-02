pipeline {
    agent any

    environment {
        IMAGE_NAME = "pokemons-api:latest"
        CONTAINER_NAME = "pokemons-api"
        APP_PORT = "8081"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Clonando repositorio...'
                git url: 'https://github.com/isawi16/express-pokemonsApi.git', branch: 'master'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Instalando dependencias...'
                sh 'npm ci'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Construyendo imagen Docker...'
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Deploy Container') {
            steps {
                echo 'Desplegando contenedor...'
                // Si ya existe, eliminarlo primero
                sh "docker rm -f ${CONTAINER_NAME} || true"
                sh "docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:3000 ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completado correctamente!'
        }
        failure {
            echo 'Pipeline falló!'
        }
    }
}
