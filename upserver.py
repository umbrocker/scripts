#!/usr/bin/env python3

# Description:
# 	Starts an http python3 upload server on chosen port.
# Dependencies:
# 	python3, python3-cgi, python3-http-server, python3-os
# Short description: uploadserver | starts python3 http server to upload files with curl.

import os
from http.server import HTTPServer, BaseHTTPRequestHandler
from cgi import FieldStorage

UPLOAD_DIR = f"{os.getcwd()}/uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)

class MultipartUploadHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        # Feldolgozza a multipart form-ot
        form = FieldStorage(
            fp=self.rfile,
            headers=self.headers,
            environ={'REQUEST_METHOD': 'POST',
                     'CONTENT_TYPE': self.headers['Content-Type'],}
        )

        if 'file' not in form:
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b"No file field provided\n")
            return

        file_item = form['file']
        filename = file_item.filename or "uploaded_file"
        filepath = os.path.join(UPLOAD_DIR, filename)

        # Írás fájlba
        with open(filepath, 'wb') as f:
            f.write(file_item.file.read())

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"File uploaded successfully\n")

    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Upload server running\n")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Simple multipart file upload server")
    parser.add_argument('--port', type=int, default=8000, help='Port to listen on')
    args = parser.parse_args()

    print(f"Starting server on port {args.port}, uploads dir: {UPLOAD_DIR}")
    server = HTTPServer(('0.0.0.0', args.port), MultipartUploadHandler)
    server.serve_forever()

