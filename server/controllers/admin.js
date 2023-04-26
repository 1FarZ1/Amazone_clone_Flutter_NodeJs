import {Product} from '../models/product.js';
import {Order} from '../models/order.js';

let addProduct = async (req, res) => {
    try {
        const {name,price,description,category,quantity,images} = req.body;
        if(!name || !price || !description || !category || !quantity ||!images){
            return res.status(400).json({msg:"Please fill all the fields"});
        }
        const product = new Product({
            name,
            price,
            description,
            category,
            quantity,
            images
        });
        const savedProduct = await product.save();
        return res.status(200).json({msg:"Product Added Successfully",product:savedProduct});
    } catch (error) {
            return res.status(400).json({msg:"error happend" + error.message});
    }
}
let allProducts = async (req, res) => {
    try {
        const products = await Product.find({});
        return res.status(200).json({msg:"All Products",products:products});
    } catch (error) {
            return res.status(400).json({msg:"error happend " + error.message});
    }
}
let deleteProduct = async (req,res)=>{
    try {
            const {id} = req.body;
            await Product.findByIdAndDelete(id);
            const products = await Product.find({});
            return res.status(200).json({msg:"Product Deleted Successfully",products:products});
    } catch (error) {
            console.log(error);
            return res.status(400).json({error:{
                error:"my name is jhon cena",
                msg:error
            }});
    }
}
let getOrders = async (req, res) => {
    try {
      const orders = await Order.find({});
      res.json(orders);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
  
let changeOrderStatus =async (req, res) => {
    try {
      const { id, status } = req.body;
      let order = await Order.findById(id);
      order.status = status;
      order = await order.save();
      res.json(order);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
  
let getAnalytics=  async (req, res) => {
    try {
      const orders = await Order.find({});
      let totalEarnings = 0;
  
      for (let i = 0; i < orders.length; i++) {
        for (let j = 0; j < orders[i].products.length; j++) {
          totalEarnings +=
            orders[i].products[j].quantity * orders[i].products[j].product.price;
        }
      }
      // CATEGORY WISE ORDER FETCHING
      let mobileEarnings = await fetchCategoryWiseProduct("Mobiles");
      let essentialEarnings = await fetchCategoryWiseProduct("Essentials");
      let applianceEarnings = await fetchCategoryWiseProduct("Appliances");
      let booksEarnings = await fetchCategoryWiseProduct("Books");
      let fashionEarnings = await fetchCategoryWiseProduct("Fashion");
  
      let earnings = {
        totalEarnings,
        mobileEarnings,
        essentialEarnings,
        applianceEarnings,
        booksEarnings,
        fashionEarnings,
      };
  
      res.json(earnings);
    } catch (e) {
        console.log(e);
      res.status(500).json({ error: e.message });
    }
  }
   



export {addProduct,allProducts,deleteProduct,getOrders,changeOrderStatus,getAnalytics}



//  reusability of code
async function fetchCategoryWiseProduct(category) {
    let earnings = 0;
    let categoryOrders = await Order.find({
      "products.product.category": category,
    });
  
    for (let i = 0; i < categoryOrders.length; i++) {
      for (let j = 0; j < categoryOrders[i].products.length; j++) {
        earnings +=
          categoryOrders[i].products[j].quantity *
          categoryOrders[i].products[j].product.price;
      }
    }
    return earnings;
  }