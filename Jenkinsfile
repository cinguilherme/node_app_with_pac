node {

    def commit_id

    stage('Preparation') {
        checkout scm
        sh "git rev-parse --short HEAD > .git/commit_id"
        commit_id = readFile('.git/commit_id').trim()
    }

    stage('build and test') {
        def myTestContainer = docker.image('node:15-alpine')
        myTestContainer.pull()
        myTestContainer.inside {
            sh 'npm install --only=dev'
            sh 'npm run build'
            sh 'npm test'
        }
    }

    stage('code checks') {
        def myTestContainer = docker.image('node:15-alpine')
        myTestContainer.pull()
        myTestContainer.inside {
            sh 'npm install --only=dev'
            sh 'npm run lint'
        }
    }

    stage('integration tests') {
        def mysql = docker.image('mysql').run("-e MYSQL_ALLOW_EMPTY_PASSWORD=yes --rm")
        def myTestContainer = docker.image('node:15-alpine')
        myTestContainer.pull()
        myTestContainer.inside("--link ${mysql.id}") {
            sh 'npm i --only=dev'
            sh 'npm test'
        }
    }

    stage('OWASP wannabe') {
        sh "echo owasp wannabe stage"
    }

    stage('sonarqube') {
        def sonarQubeScannerHome = tool name: 'sonar', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        sh "${sonarQubeScannerHome}/bin/sonar-scanner -e -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login=sonar -Dsonar.password=sonarpasswd -Dsonar.projectName=node_app_with_pac -Dsonar.projectVersion=${env.BUILD_NUMBER} -Dsonar.projectKey=NAPP -Dsonar.sources=src/ -Dsonar.tests=src/ -Dsonar.language=typescript"
    }

//     stage('docker build/push') {
//         docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
//             def app = docker.build("cinguilherme/node-docker:${commit_id}", '.').push()
//         }
//     }
}
