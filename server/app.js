const express = require("express");

app=express();

app.use(express.json());
    


app.get("/",(req,res)=>{
    res.status(200).send("hello world");
})

app.listen(8001,()=>{
    console.log("listening");
}
)
