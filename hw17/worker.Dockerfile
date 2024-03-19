# Use a base image that includes an SSH server
FROM ubuntu:latest

# Install SSH server and sudo
RUN apt-get update && \
    apt-get install -y openssh-server sudo nano && \
    apt-get install -y openjdk-17-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create the missing privilege separation directory
RUN mkdir -p /run/sshd

# Create a user for SSH access
RUN useradd -ms /bin/bash -G sudo worker

# Set a password for the worker user
RUN echo 'worker:password' | chpasswd

# Allow SSH access for the worker user
RUN mkdir -p /home/worker/.ssh && \
    chmod 700 /home/worker/.ssh

# Copy SSH public key for passwordless authentication
COPY authorized_keys /home/worker/.ssh/authorized_keys
RUN chown worker:worker /home/worker/.ssh/authorized_keys && \
    chmod 600 /home/worker/.ssh/authorized_keys

# Enable password authentication and root login
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
