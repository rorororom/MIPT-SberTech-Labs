import os
from http.server import BaseHTTPRequestHandler, HTTPServer

import psycopg


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path not in ("/", "/health"):
            self.send_error(404)
            return

        try:
            with psycopg.connect(
                host=os.environ["DB_HOST"],
                dbname=os.environ["DB_NAME"],
                user=os.environ["DB_USER"],
                password=os.environ["DB_PASSWORD"],
                connect_timeout=3,
            ) as db:
                if self.path == "/health":
                    db.execute("SELECT 1")
                    body = "OK"
                else:
                    visits = db.execute(
                        "UPDATE counter SET value = value + 1 WHERE id = 1 RETURNING value"
                    ).fetchone()[0]
                    body = f"Приложение работает. Посещений: {visits}"
        except psycopg.Error:
            self.send_error(503, "Database unavailable")
            return

        data = body.encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
