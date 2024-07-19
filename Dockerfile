FROM debian:bookworm-slim
LABEL description="Debian based postfix SMTP container for Kubernetes deployment"
LABEL version="0.1"

USER root
WORKDIR /root

COPY files/postfix.pre-install .
RUN debconf-set-selections /root/postfix.pre-install

RUN apt-get update -y && \
  apt-get install -y postfix

EXPOSE 25/tcp

VOLUME [ "/var/spool/postfix" ]

ENTRYPOINT ["/usr/sbin/postfix", "-c /etc/postfix", "start-fg"]    
