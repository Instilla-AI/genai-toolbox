const { spawn } = require('child_process');

const port = process.env.PORT || 3000;

console.log('🚀 Avvio MCP su porta', port);

const inspector = spawn('npx', [
  '@modelcontextprotocol/toolbox',
  '--host', '0.0.0.0',
  '--port', port.toString()
]);

inspector.stdout.on('data', (data) => {
  console.log(`stdout: ${data}`);
});

inspector.stderr.on('data', (data) => {
  console.error(`stderr: ${data}`);
});

inspector.on('close', (code) => {
  console.log(`MCP process exited with code ${code}`);
});
