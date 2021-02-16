import express from 'express';
import cors from 'cors';

const app = express();
const port = process.env.PORT || 3000;
const debug = process.env.DEBUG  || false;


app.options('/', cors());

app.use(express.json());
app.get('/', (req, res) => {
  if (debug === "true") {
    console.log("these are the headers: %j", req.headers);
  }
  res.json({ "msg": "this is some serious bar", "code": 200 })
});

app.listen(port, () =>
  console.log(`Example app listening on port ${port}!`),
);
