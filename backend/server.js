const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { spawn } = require('child_process');
const path = require('path');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Endpoint to handle parsing requests
app.post('/parse', (req, res) => {
    const { code } = req.body;

    // Path to your parser binary (adjust the path accordingly)
    const parserPath = path.resolve('./js_parser');
    const parser = spawn(parserPath);

    let output = '';
    let error = '';

    parser.stdin.write(code);
    parser.stdin.end();

    parser.stdout.on('data', (data) => {
        output += data.toString();
    });

    parser.stderr.on('data', (data) => {
        error += data.toString();
    });

    parser.on('close', (exitCode) => {
        if (exitCode === 0) {
            res.json({ ast: output });
        } else {
            res.status(500).json({ error: error || 'Parsing failed' });
        }
    });
});

const PORT = 5000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
