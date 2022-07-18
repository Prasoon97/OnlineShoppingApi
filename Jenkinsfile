node {
   def commit_id
   stage('Preparation') {
     checkout scm
     bat "git rev-parse --short HEAD > .git/commit-id"                        
     commit_id = readFile('.git/commit-id').trim()
   }
   
   stage('Build') {
       bat 'dotnet build'  
   }

   stage('Test') {
       bat 'dotnet test'
   }

   stage('docker build/push') {
     docker.withRegistry('https://index.docker.io/v2/', 'dockerhub') {
       def app = docker.build("prasoonchaubey/docker-onlineshoppingapi:${commit_id}", '.').push()
     }
   }
}
