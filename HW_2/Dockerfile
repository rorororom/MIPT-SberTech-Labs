FROM python:3.13.7-slim-bookworm@sha256:adafcc17694d715c905b4c7bebd96907a1fd5cf183395f0ebc4d3428bd22d92d
WORKDIR /app
COPY app/main.py .
USER 10001:10001
EXPOSE 8080
HEALTHCHECK --interval=15s --timeout=30s --start-period=60s --retries=3 CMD ["python", "-c", "from urllib.request import urlopen; urlopen('http://127.0.0.1:8080/health', timeout=3).close()"]
CMD ["python", "main.py"]
