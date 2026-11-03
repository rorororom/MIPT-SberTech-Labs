FROM python:3.13-slim
WORKDIR /app
RUN pip install --no-cache-dir "psycopg[binary]==3.2.10"
COPY app/main.py .
USER 10001:10001
CMD ["python", "main.py"]
