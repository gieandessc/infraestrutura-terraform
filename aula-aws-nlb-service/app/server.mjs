// server.mjs
import { createServer } from 'http';
import { parse } from 'url';

// Make our HTTP server
const server = createServer((req, res) => {
  // Parse the request url
  const reqUrl = parse(req.url).pathname;

  // Compare our request method
  if (req.method === "GET") {
    if (reqUrl === "/") {
      res.setHeader('Content-Type', 'application/json');
      res.write(JSON.stringify({ message: "you're boring" }));
      res.end();
    }
  } else if (req.method === "POST") {
    if (reqUrl === "/hello") {
      res.setHeader('Content-Type', 'application/json');
      res.write(JSON.stringify({ message: "hello world" }));
      res.end();
    }
  }
});

// starts a simple http server locally on port 8081
server.listen(8081, () => {
  console.log('Listening on port 8081');
});

// run with `node server.mjs`