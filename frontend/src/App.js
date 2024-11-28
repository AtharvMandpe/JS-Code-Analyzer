// // import logo from './logo.svg';
// // import './App.css';

// // function App() {
// //   return (
// //     <div className="App">
// //       <header className="App-header">
// //         <img src={logo} className="App-logo" alt="logo" />
// //         <p>
// //           Edit <code>src/App.js</code> and save to reload.
// //         </p>
// //         <a
// //           className="App-link"
// //           href="https://reactjs.org"
// //           target="_blank"
// //           rel="noopener noreferrer"
// //         >
// //           Learn React
// //         </a>
// //       </header>
// //     </div>
// //   );
// // }

// // export default App;


// WORKING code
import React, { useState } from 'react';
import axios from 'axios';

function App() {
    const [code, setCode] = useState('');
    const [ast, setAst] = useState('');
    const [error, setError] = useState('');

    const handleSubmit = async (e) => {
        e.preventDefault();
        setAst('');
        setError('');

        try {
            const response = await axios.post('http://localhost:5000/parse', { code });
            setAst(response.data.ast);
        } catch (err) {
            setError(err.response?.data?.error || 'An error occurred while parsing.');
        }
    };

    return (
        <div style={{ padding: '20px' }}>
            <h1>MANDPE</h1>
            <form onSubmit={handleSubmit}>
                <textarea
                    value={code}
                    onChange={(e) => setCode(e.target.value)}
                    placeholder="Enter your JavaScript code here..."
                    rows="10"
                    style={{ width: '100%', marginBottom: '10px' }}
                />
                <button type="submit">Generate AST</button>
            </form>

            <h2>Abstract Syntax Tree:</h2>
            {error && <div style={{ color: 'red' }}>{error}</div>}
            {ast && (
                <pre
                    style={{
                        backgroundColor: '#f4f4f4',
                        padding: '10px',
                        border: '1px solid #ddd',
                        borderRadius: '5px',
                        overflow: 'auto',
                    }}
                >
                    {ast}
                </pre>
            )}
        </div>
    );
}

export default App;
