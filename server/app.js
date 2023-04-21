import express, { json, urlencoded } from "express";
import auth from "./routes/auth.js";
import connectDb from "./mongoDbConnect.js";
import jwt from "jsonwebtoken";

const app=express();
const PORT=8001;


app.use(json());
app.use(urlencoded({extended:true}));

app.use(auth); 




app.use((req,res,next)=>{
  res.status(404).json({msg:"404 Not Found"});
})

 
const main = () => {
  connectDb();
  app.listen(PORT, "0.0.0.0",() => {
      console.log("Server is running on port http://localhost:" + PORT);
  })
}

main();




// add nodemon as dev dependency
// const dbURI="mongodb://FarZ:mrfares77@ac-iazyxlm-shard-00-00.fnzafv5.mongodb.net:27017,ac-iazyxlm-shard-00-01.fnzafv5.mongodb.net:27017,ac-iazyxlm-shard-00-02.fnzafv5.mongodb.net:27017/?ssl=true&replicaSet=atlas-humg6a-shard-0&authSource=admin&retryWrites=true&w=majority";

