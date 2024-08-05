// server.mjs
import { randomUUID } from 'crypto';
import { createServer } from 'http';
import { parse } from 'url';

// Make our HTTP server
const server = createServer((req, res) => {
  // Parse the request url
  const reqUrl = parse(req.url).pathname;
  const aulas = [
    {
      id: randomUUID(),
      title: "Aula 1",
      description: "Estudando AWS + Terraform na marra com ajuda do StackSpotAi"
    },
    {
      id: randomUUID(),
      title: "Aula 2",
      description: "Estudando AWS + Terraform na marra com ajuda do StackSpotAi"
    },
    {
      id: randomUUID(),
      title: "Aula 3",
      description: "Estudando AWS + Terraform na marra com ajuda do StackSpotAi"
    }
  ]
  // Compare our request method
  if (req.method === "GET") {
    if (reqUrl === "/aulas") {
      res.setHeader('Content-Type', 'application/json');
      res.write(JSON.stringify(aulas));
      res.end();
    }
  }
});

// starts a simple http server locally on port 8081
server.listen(8081, () => {
  console.log('Listening on port 8081');
});

// run with `node server.mjs`