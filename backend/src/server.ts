import express, { type Express, Request, Response } from "express";
import dotenv from "dotenv";

dotenv.config();

const app: Express = express();
const port = process.env.PORT;

app.get("/", (_: Request, res: Response) => {
  res.send("Hello from backend");
});

app.listen(port, () => {
  console.log(`🚀 Server listening on ${process.env.PORT}.`);
});
