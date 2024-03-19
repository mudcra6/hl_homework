FROM jenkins/jenkins:latest

# Set the user to root to perform installation
USER root

USER jenkins

ENV JENKINS_HOME=/var/jenkins_home

EXPOSE 8080

EXPOSE 50000

COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY --chown=jenkins:jenkins jobs /var/jenkins_home/jobs

RUN jenkins-plugin-cli --plugins < /usr/share/jenkins/ref/plugins.txt

RUN chown -R jenkins:jenkins "$JENKINS_HOME"

VOLUME /var/jenkins_home

CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
