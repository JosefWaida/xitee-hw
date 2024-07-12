# Use TODO upload img to repo
FROM jupyter/minimal-notebook:x86_64-ubuntu-22.04

# Set environment variables for the new users
ENV ANSIBLE_USER_NAME ansible
ENV ANSIBLE_USER_HOME /home/$ANSIBLE_USER_NAME
ENV XITEE_USER_NAME xitest
ENV XITEE_USER_HOME /home/$XITEE_USER_NAME
# Test user used by me, includes my pub key
ENV TEST_USER_NAME test123
ENV TEST_USER_HOME /home/$TEST_USER_NAME

# Install required packages
USER root
RUN apt -y update && \
    apt -y install \
    openssh-server \
    sudo \
    python3 \
    python3-pip && \
    apt clean all
# Permit root login
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Create the new users and their home directories + set sudo rules, just basic
RUN useradd -m -d $ANSIBLE_USER_HOME -s /bin/bash $ANSIBLE_USER_NAME && \
    echo "$ANSIBLE_USER_NAME ALL=(ALL) NOPASSWD:/usr/bin/ansible" >> /etc/sudoers && \
    useradd -m -d $XITEE_USER_HOME -s /bin/bash $XITEE_USER_NAME && \
    echo "$XITEE_USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    useradd -m -d $TEST_USER_HOME -s /bin/bash $TEST_USER_NAME && \
    echo "$TEST_USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up SSH for both users
RUN mkdir -p /var/run/sshd && \
    mkdir -p $ANSIBLE_USER_HOME/.ssh && \
    mkdir -p $XITEE_USER_HOME/.ssh && \
    mkdir -p $TEST_USER_HOME/.ssh && \
    chmod 700 $ANSIBLE_USER_HOME/.ssh && \
    chmod 700 $XITEE_USER_HOME/.ssh && \
    chmod 700 $TEST_USER_HOME/.ssh

RUN touch $TEST_USER_HOME/.ssh/authorized_keys && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJSrEw9z6XMtpZfzFivSEMCmvxpwUtLpIXOQxpvnb4qEVxK+PbTLHDo05eEa3cFh0VPCUgP0zOQcjjkq+kaU1ekPf0S2z4cHITDB12G1XRAMcnxMVqmWB8wtphiC29ShsHFLBa9Q5tiD6KXloZ0jxChxLKYz3vS44xnL6+h9yil2+L7GP31VohjsLiLF10jYGt/1qIMNrPJm54npG5dTibcFzu+V3+ySM78vGuCVHRNxiBu/ZGFeNwVEaprsDjp3LZ+d7FLTPJnHVgpd+7Mvljuz2j5+kv/fzX9+7fTXoufzrwtizv82LhTs8eZoAqteqj4CQhPYYg+ziSlvQEp0lH github-key-ao" >> $TEST_USER_HOME/.ssh/authorized_keys && \
    chmod 600 $TEST_USER_HOME/.ssh/authorized_keys && \
    chown -R $TEST_USER_NAME:$TEST_USER_NAME $TEST_USER_HOME/.ssh && \
    echo "$TEST_USER_NAME:test123 | chpasswd


# Add SSH keys for xitee_user + set password
RUN touch $XITEE_USER_HOME/.ssh/authorized_keys && \
    echo "ssh-ed25519AAAAC3NzaC1lZDI1NTE5AAAAIOH/TlOb8TAXiMhN8u7VNqPC7W2hrhygm/1BZBZZp0qo marek@GUADALAJARA-WSL" >> $XITEE_USER_HOME/.ssh/authorized_keys && \
    echo "ssh-ed25519AAAAC3NzaC1lZDI1NTE5AAAAIP7FHrfu37DbzYBs6T3P/aq+XOeJAtu8Ftl1/3g1EN/Ktkuba" >> $XITEE_USER_HOME/.ssh/authorized_keys && \
    chmod 600 $XITEE_USER_HOME/.ssh/authorized_keys && \
    chown -R $XITEE_USER_NAME:$XITEE_USER_NAME $XITEE_USER_HOME/.ssh && \
    echo "$XITEE_USER_NAME:pasx.123" | chpasswd


# Install Ansible
RUN pip3 install --no-cache-dir ansible

# Expose SSH port
EXPOSE 22

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]
#CMD ["/bin/bash"]

