const cds=require('@sap/cds')
module.exports = cds.service.impl(async function () {
    const { States, Business_Partner, Product} = this.entities;
    this.on("READ", Business_Partner, async (req) => {
        const results = await cds.run(req.query);
        return results;
      });
    this.before("CREATE",  Business_Partner, async (req) => {
        const { bp_no, Is_gstn_registered, Gst_num } = req.data;
        if (Is_gstn_registered && !Gst_num) {
            req.error({
                code: "MISSING_GST_NUM",
                message: "GSTIN number is mandatory when Is_gstn_registered is true",
                target: "Gst_num",
            });
        }
        const query1 = SELECT.from( Business_Partner).where({ bp_no: req.data.bp_no });
        const result = await cds.run(query1); // Execute the query using cds.run()
        if (result.length > 0) {
          req.error({
            code: "STEMAILEXISTS",
            message: " already exists",
            target: "bp_np",
          });
        }
        
      });

      this.before(["CREATE", "UPDATE"], Business_Partner, async (req) => {
        const gst = req.data.gst_no;
        const is_gstn_registered = req.data.is_gstn_registered;
        if (is_gstn_registered == true && gst == null) {
          req.error({
            code: "INVALID_GST_NO",
            message: "Enter gst registered number please",
            target: "is_gstn_registered",
          });
        }
        const results = await cds
          .transaction(req)
          .run(SELECT.from(Business_Partner));
        const count = results.length;
    
        req.data.bp_no = count+1;
    });
    

      
    this.before(["CREATE"], Product, async (req) => {
      const sellPrice = req.data.sellPrice ;
      const costPrice = req.data.costPrice;
  
      if (sellPrice < costPrice) {
          req.error({
              code: "INVALID_SELL PRICE",
              message: "Product Sell Price cannot be less than Cost Price",
              target: "sell_price"
          });
      }
  });
  
      this.on('READ',States,async(req)=>{
        genders=[
            {"code":"TS","description":"Telangana"},
            {"code":"AP","description":"Andra Pradesh"},
            {"code":"TN","description":"Tamil Nadu"},
        ]
        genders.$count=genders.length
        return genders;
    })

});