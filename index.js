const { spawn } = require('child_process');

// Railway assegna automaticamente la porta tramite la variabile env PORT
const port = process.env.PORT || 3000;

const inspector = spawn('npx', [
  '@modelcontextprotocol/inspector',
  '.',                   // root folder contenente mcp.json
  '--host', '0.0.0.0',
  '--port', port.toString()
]);

inspector.stdout.on('data', (data) => {
  console.log(`MCP stdout: ${data}`);
});

inspector.stderr.on('data', (data) => {
  console.error(`MCP stderr: ${data}`);
});

inspector.on('close', (code) => {
  console.log(`MCP process exited with code ${code}`);
});
