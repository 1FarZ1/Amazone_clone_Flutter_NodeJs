import {Product} from '../models/product.js';


let getCategoryProducts = async (req, res) => {
    try {  
        // change it to title

        const category = req.query.category;
        const products = await Product.find({category:category});
        return res.status(200).json({msg:"All Products of category : " + category,products:products});
    } catch (error) {
            return res.status(400).json({msg:"error happend " + error.message});
    }
}
let getSearchProducts = async (req, res) => {
    try {  

        const searchQuery = req.query.searchQuery;
        const products = await Product.find({name:{$regex:searchQuery,$options:"i"}});


        return res.status(200).json({msg:"All Products of That Seach Query are  : " + searchQuery,products:products});
    } catch (error) {
            return res.status(400).json({msg:"error happend " + error.message});
    }
}
let rateProduct =  async (req, res) => {
    try {
        console.log(req.body);
      const { id, rating } = req.body;
      let product = await Product.findById(id);
  
      for (let i = 0; i < product.ratings.length; i++) {
        if (product.ratings[i].userId == req.user) {
          product.ratings.splice(i, 1);
          break;
        }
      }
      const ratingSchema = {
        userId: req.user,
        rating,
      };
  
      product.ratings.push(ratingSchema);
      product = await product.save();
      res.json(product);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  };




export {getCategoryProducts,getSearchProducts,rateProduct}