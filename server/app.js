import express, { json, urlencoded } from "express";
import auth from "./routes/auth.js";
import { set, connect } from "mongoose";

const dbURI= "mongodb+srv://Farz:mrfares77@cluster0.6zstawu.mongodb.net/?retryWrites=true&w=majority";

const app=express();
const HOSTNAME ="locaLhost";
const PORT=8001;
app.use(json());
app.use(urlencoded({extended:true}));

app.use(auth); 

set('strictQuery', true);
connect(dbURI,{useNewUrlParser:true, useUnifiedTopology:true}).then((result)=>{
  console.log("connected to db");

 
}
).catch((err)=>console.log(err));

 

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
}
);
// app.listen(8001,"0.0.0.0",()=>{
//     console.log("listening");
// }
// )




// add nodemon as dev dependency
// const dbURI="mongodb://FarZ:mrfares77@ac-iazyxlm-shard-00-00.fnzafv5.mongodb.net:27017,ac-iazyxlm-shard-00-01.fnzafv5.mongodb.net:27017,ac-iazyxlm-shard-00-02.fnzafv5.mongodb.net:27017/?ssl=true&replicaSet=atlas-humg6a-shard-0&authSource=admin&retryWrites=true&w=majority";

