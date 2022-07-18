node {
   def commit_id
   stage('Preparation') {
     checkout scm
     sh "git rev-parse --short HEAD > .git/commit-id"                        
     commit_id = readFile('.git/commit-id').trim()
   }
   
   stage('Build') {
       sh 'dotnet build'  
   }

   stage('Test') {
       sh 'dotnet test'
   }

   stage('docker build/push') {
     docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
       def app = docker.build("prasoonchaubey/docker-onlineshoppingapi:${commit_id}", '.').push()
     }
   }
}