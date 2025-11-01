pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Clonando repositorio...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Instalando dependencias...'
                sh 'npm ci'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Construyendo imagen Docker...'
                sh 'docker build -t pokemons-api:latest .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Desplegando contenedor...'
                sh '''
                    echo "Eliminando contenedor previo (si existe)..."
                    docker rm -f pokemons_api || true
                    
                    echo "Ejecutando nuevo contenedor..."
                    docker run -d --name pokemons_api -p 8081:8080 -e PORT=8080 pokemons-api:latest
                    
                    echo "Contenedor desplegado correctamente."
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completado exitosamente.'
            sh 'docker ps -a'
        }
        failure {
            echo 'Error en el pipeline.'
        }
    }
}
