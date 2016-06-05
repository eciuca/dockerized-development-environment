REM Create folders mapped to the docker containers
md %userprofile%\.docker\volumes\dev-env-setup
md %userprofile%\.docker\volumes\dev-env-setup\jenkins
md %userprofile%\.docker\volumes\dev-env-setup\jenkins\jenkins_home
md %userprofile%\.docker\volumes\dev-env-setup\nexus
md %userprofile%\.docker\volumes\dev-env-setup\nexus\sonatype-work
md %userprofile%\.docker\volumes\dev-env-setup\nginx
REM Copy nginx configuration file
copy nginx\nginx.conf %userprofile%\.docker\volumes\dev-env-setup\nginx\