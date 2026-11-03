FROM debian:12.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends openssh-server python3 \
    && rm -rf /var/lib/apt/lists/* /etc/ssh/ssh_host_* \
    && mkdir -p /run/sshd /root/.ssh \
    && chmod 700 /root/.ssh \
    && printf 'PasswordAuthentication no\nPermitRootLogin prohibit-password\n' > /etc/ssh/sshd_config.d/lab.conf
COPY start.sh /start.sh
ENTRYPOINT ["sh", "/start.sh"]
