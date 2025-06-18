import json
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.environ.get("PORT", 3000))

def echo_tool(params):
    return {"echo": params.get("message", "")}

class MCPHandler(BaseHTTPRequestHandler):
    def _set_headers(self, code=200):
        self.send_response(code)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

    def do_GET(self):
        if self.path == "/mcp/":
            with open("mcp.json", "r") as f:
                data = json.load(f)
            self._set_headers()
            self.wfile.write(json.dumps(data).encode("utf-8"))
        else:
            self._set_headers(404)
            self.wfile.write(b'{"error": "Not Found"}')

    def do_POST(self):
        if self.path.startswith("/mcp/tools/"):
            tool_name = self.path.split("/")[-1]
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            params = json.loads(post_data)

            if tool_name == "echo_tool":
                result = echo_tool(params)
                self._set_headers()
                self.wfile.write(json.dumps(result).encode("utf-8"))
            else:
                self._set_headers(404)
                self.wfile.write(b'{"error": "Tool not found"}')
        else:
            self._set_headers(404)
            self.wfile.write(b'{"error": "Not Found"}')

def run():
    server_address = ("", PORT)
    httpd = HTTPServer(server_address, MCPHandler)
    print(f"🚀 MCP Python Toolbox running on port {PORT} at /mcp/")
    httpd.serve_forever()

if __name__ == "__main__":
    run()
