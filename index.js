const { spawn } = require('child_process');

const port = process.env.PORT || 3000;
console.log('🚀 Avvio MCP Python server su porta', port);

const server = spawn('bash', ['setup.sh'], {
  env: { ...process.env, PORT: port.toString() }
});

server.stdout.on('data', (data) => console.log(`stdout: ${data}`));
server.stderr.on('data', (data) => console.error(`stderr: ${data}`));
server.on('close', (code) => console.log(`process exited with code ${code}`));
