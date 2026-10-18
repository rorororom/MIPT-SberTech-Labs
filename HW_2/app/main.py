from http.server import BaseHTTPRequestHandler, HTTPServer


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/":
            body = '<!doctype html><html lang="ru"><meta charset="utf-8"><title>Лаба 2</title><h1>Приложение работает</h1></html>'
            content_type = "text/html; charset=utf-8"
        elif self.path == "/health":
            body = '{"status":"UP"}'
            content_type = "application/json"
        else:
            self.send_error(404)
            return

        data = body.encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
