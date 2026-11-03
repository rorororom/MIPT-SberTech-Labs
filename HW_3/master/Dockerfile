FROM python:3.13.7-slim-bookworm
RUN apt-get update && apt-get install -y --no-install-recommends openssh-client \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir ansible-core==2.19.3 \
    && mkdir -p /root/.ssh && chmod 700 /root/.ssh
WORKDIR /ansible
CMD ["sleep", "infinity"]
