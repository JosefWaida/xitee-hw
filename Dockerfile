FROM almalinux/8-base

RUN dnf check-update; \
  dnf install -y gcc libffi-devel python3 epel-release; \
  dnf install -y openssh-clients; \
  pip3 install --upgrade pip; \
  pip3 install ansible