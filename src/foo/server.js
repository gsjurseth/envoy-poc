import express from 'express';
import cors from 'cors';
import fetch from 'node-fetch';

const app = express();
const port = process.env.PORT || 3000;
const debug = process.env.DEBUG || "false";

const bar_host = process.env.BAR_HOST || "localhost:3000";


app.options('/', cors());
app.options('/passauth', cors());
app.options('/nopassauth', cors());

app.use(express.json());

app.get('/', (req, res) => {
  res.json({ "msg": "this is some serious foo", "code": 200 })
});

app.get('/passauth', (req, res) => {
  if (debug === "true") {
    console.log("The authorization header: %s", req.headers.authorization);
  }
  fetch(`http://${bar_host}/`, {
    headers: {'Authorization': req.headers.authorization}
  })
  .then( r => r.json() )
  .then( r => res.json(r) );
});

app.get('/nopassauth', (req, res) => {
  if (debug === "true") {
    console.log("The authorization header: %s", req.headers.authorization);
  }
  fetch(`http://${bar_host}/`)
  .then( r => r.json() )
  .then( r => res.json(r) );
});

app.listen(port, () =>
  console.log(`Example app listening on port ${port}!`),
);
