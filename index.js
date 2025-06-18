const { spawn } = require('child_process');

const port = process.env.PORT || 3000;

const inspector = spawn('npx', [
  '@modelcontextprotocol/inspector',
  '.',
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
  console.log(`child process exited with code ${code}`);
});
