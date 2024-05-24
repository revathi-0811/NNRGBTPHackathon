using {com.test.sdb as db} from '../db/schema';

service Market {
    entity Business_Partner as projection on db.Business_Partner;
    entity States           as projection on db.States;
    entity Purchase         as projection on db.purchase;
    entity sales            as projection on db.sales;
    entity Store            as projection on db.Store  {
         @UI.Hidden : true
        ID,
        * 
    };
    entity Product          as projection on db.Product {
         @UI.Hidden : true
        ID,
        * 
    };
    entity Stock            as projection on db.Stock;
}

annotate Market.Business_Partner with @odata.draft.enabled;
annotate Market.Store with @odata.draft.enabled;
annotate Market.Product with @odata.draft.enabled;
annotate Market.Purchase with @odata.draft.enabled;
annotate Market.sales with  @odata.draft.enabled;
annotate Market.Stock with @odata.draft.enabled;
annotate Market.Business_Partner with {
   // pinCode @assert.format: '^[1-9]{1}[0-9]{2}\\s{0, 1}[0-9]{3}$';
    Gst_num @assert.format: '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[Z]{1}[0-9]{1}$';
}

annotate Market.States with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: code
    },
    {
        $Type: 'UI.DataField',
        Value: description
    },
],

);

annotate Market.Business_Partner with @(
    UI.LineItem             : [

        {
            Label: 'Bussiness Partner Id',
            Value: bp_no
        },
        {
            Label: 'Name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: add1
        },
        {
            Label: 'Address 2',
            Value: add2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'Is_gstn_registered',
            Value: Is_gstn_registered
        },
        {
            Label: 'GSTIN Number',
            Value: Gst_num
        },
        {
            Label: 'Is_Vendor',
            Value:  Is_vendor
        },
        {
            Label: 'Is_Customer',
            Value:  Is_customer
        },
    ],
    UI.FieldGroup #BusinessP: {
        $Type: 'UI.FieldGroupType',
        Data : [
            //{
             //   $Type: 'UI.DataField',
             //   Label: 'Bussiness Partner Id',
             //   Value: bp_no
           // },
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: add1
            },
            {
                $Type: 'UI.DataField',
                Value: add2
            },
            {
                $Type: 'UI.DataField',
                Value: city
            },
            {
                $Type: 'UI.DataField',
                Value: pinCode
            },
            {
                $Type: 'UI.DataField',
                Value: state_code
            },
            {
                $Type: 'UI.DataField',
                Value: Is_vendor
            },

            {Value: Is_gstn_registered},
            {
                $Type: 'UI.DataField',
                Value: Gst_num
            },
        ],
    },
    UI.Facets               : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'BusinessPFacet',
        Label : 'BusinessP',
        Target: '@UI.FieldGroup#BusinessP',
    }, ],
);


annotate Market.Store with @(
    UI.LineItem         : [
        {
            Label: 'Store Id',
            Value: store_id
        },
        {
            Label: 'Store name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: add1
        },
        {
            Label: 'Address 2',
            Value: add2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'Pin code',
            Value: PinCode // corrected to PinCode
        },
    ],
    UI.FieldGroup #store: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Store Id',
                Value: store_id
            },
            {
                Label: 'Store name',
                Value: name
            },
            {
                Label: 'Address 1',
                Value: add1
            },
            {
                Label: 'Address 2',
                Value: add2
            },
            {
                Label: 'City',
                Value: city
            },
            {
                Label: 'State',
                Value: state_code
            },
            {
                Label: 'Pin code',
                Value: PinCode
            },
        ],
    },
    UI.Facets           : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'storeFacet',
        Label : 'store facets',
        Target: '@UI.FieldGroup#store'
    }, ],
);

annotate Market.Product with @(
    UI.LineItem           : [
        {
            Label: 'Product id',
            Value: product_id
        },
        {
            Label: 'Product Name',
            Value: name
        },
        {
            Label: 'Product Image URL',
            Value: imageURL
        },
        {
            Label: 'Cost Price',
            Value: costPrice
        },
        {
            Label: 'Sell Price',
            Value: sellPrice
        },
    ],
    UI.FieldGroup #product: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Product id',
                Value: product_id
            },
            {
                Label: 'Product Name',
                Value: name
            },
            {
                Label: 'Product Image URL',
                Value: imageURL
            },
            {
                Label: 'Cost Price',
                Value: costPrice
            },
            {
                Label: 'Sell Price',
                Value: sellPrice
            },
        ],
    },
    UI.Facets             : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'productFacet',
        Label : 'product facets',
        Target: '@UI.FieldGroup#product'
    }, ],

);

annotate Market.Stock with @(
    UI.LineItem:[
        {
            Label:'Store Id',
            Value:storeId_ID
        },
         {
            Label:'Product Id',
            Value:productId_ID
        },
        {
            Label:'Stock Quantity',
            Value:stock_qty
        }
    ],
    UI.FieldGroup #stock :{
        $Type:'UI.FieldGroupType',
        Data:[
             {
            Label:'Store Id',
            Value:storeId_ID
        },
         {
            Label:'Product Id',
            Value:product_id
        },
         {
            Label:'Stock Quantity',
            Value:stock_qty
        }
        ],
    },
      UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'stockFacet',
            Label:'stock facets',
            Target:'@UI.FieldGroup#stock'
        },
    ],
);


annotate Market.Purchase with @(
    UI.LineItem:[
        {
            $Type:'UI.DataField',
            Label:'Purchase order',
            Value: pur_orderno
        },
         {
            $Type:'UI.DataField',
            Label:'Business Partner',
            Value:bp_no_ID
        },
        {
            $Type:'UI.DataField',
            Label:'Purchase Date',
            Value:pur_orderdate
        },
   
    ],
    UI.FieldGroup #purchase :{
        $Type:'UI.FieldGroupType',
        Data:[
             {
            $Type:'UI.DataField',
            Label:'Purchase order',
            Value:pur_orderno
        },
         {
            $Type:'UI.DataField',
            Label:'Business Partner',
            Value:bp_no_ID
        },
        {
            $Type:'UI.DataField',
            Label:'Purchase Date',
            Value:pur_orderdate
        },

        ],
    },
      UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'purchaseItemsFacet',
            Label:'purchase facets',
            Target:'@UI.FieldGroup#purchase'
        },
        {
            $Type:'UI.ReferenceFacet',
            ID:'salesFacet',
            Label:'sales facets',
            Target:'Items/@UI.LineItem',
        },
    ],
);

annotate Market.Purchase with {
    bp_no @(
        Common.Text: bp_no.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Business Partners',
            CollectionPath : 'Business_Partner',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : bp_no_ID,
                    ValueListProperty : 'ID'
                },
               {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'bp_no'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
            ]
        }
    )
}

annotate Market.sales with {
    bp_no @(
        Common.Text: bpno.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Business Partners',
            CollectionPath : 'Business_Partner',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : bp_no_ID,
                    ValueListProperty : 'ID'
                },
               {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'bp_no'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
            ]
        }
    )
}



annotate Market.sales with @(
    UI.LineItem:[
        {
           $Type:'UI.DataField',
           Label:'Sales Order',
            Value: sal_orderno
        },
         {
            $Type:'UI.DataField',
            Label:'Business Partner',
            Value:Business_Partner
        },
        {
           $Type:'UI.DataField',
           Label:'Sales Date',
            Value:sal_date
        }
    ],
    UI.FieldGroup #sales :{
        $Type:'UI.FieldGroupType',
        Data:[
             {
            $Type:'UI.DataField',
            Label:'Sales Order',
            Value:sal_orderno
        },
         {
            $Type:'UI.DataField',
            Label:'Business Partner',
            Value:Business_Partner
        },
         {
           $Type:'UI.DataField',
            Label:'Sales Date',
            Value:sal_date
        }
        ],
    },
      UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'salesItemsFacet',
            Label:'sales facets',
            Target:'@UI.FieldGroup#sales'
        },
        {
            $Type:'UI.ReferenceFacet',
            ID:'salesFacet',
            Label:'sales facets',
            Target:'Items/@UI.LineItem',
        },
    ],
);

annotate Market.Stock with {
    storeId @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Store id',
            CollectionPath : 'Store',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : storeId_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
             
            ]
        }
    );

productId @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Product id',
            CollectionPath : 'Product',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : productId_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
             
            ]
        }
    );
}

annotate Market.Business_Partner with {
    state @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'State',
            CollectionPath: 'States',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: state_code,
                    ValueListProperty: 'code'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                },
            ]
        }
    );
};

annotate Market.Store with {
    state @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'State',
            CollectionPath: 'States',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: state_code,
                    ValueListProperty: 'code'
                },

                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                },
            ]
        }
    );
};
annotate Market.Purchase.Items with @(
    UI.LineItem:[
        
        {
            Label: 'Product ID',
            Value: product_id_ID
        },
        {
            Label: 'Quantity',
            Value: qty
        },
        {
            Label: 'Price',
            Value: price
        },
       {
            Label: 'Store',
            Value: store_id_ID
        },
    ],
     UI.FieldGroup #PurchaseItems : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
            Label: 'Product ID',
            Value: product_id_ID
        },
        {
            Label: 'Quantity',
            Value: qty
        },
        {
            Label: 'Price',
            Value: price
        },
       {
            Label: 'Store',
            Value: store_id_ID
        },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'ItemsFacet',
            Label : 'Items',
            Target : '@UI.FieldGroup#PurchaseItems',
        },
    ],  
);

annotate Market.Purchase.Items with {
    store_id @(
        Common.Text: store_id.store_id,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Stores',
            CollectionPath : 'Store',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : store_id_ID,
                    ValueListProperty : 'ID'
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'store_id'
                },
                   {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                }
            ]
        }
    );
     product_id @(
        Common.Text: product_id.product_id,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Products',
            CollectionPath : 'Product',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : product_id_ID,
                    ValueListProperty : 'ID'
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'product_id'
                },
                   {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                }
            ]
        }
    )
};
annotate Market.sales.Items with @(
    UI.LineItem:[
        
        {
            Label: 'Product ID',
            Value: product_id_ID
        },
        {
            Label: 'Quantity',
            Value: stock_qty_ID
        },
        {
            Label: 'Price',
            Value: price
        },
       {
            Label: 'Store',
            Value: store_id_ID
        },
    ],
    UI.FieldGroup #SalesItems : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
            Label: 'Product ID',
            Value: product_id_ID
        },
        {
            Label: 'Quantity',
            Value: stock_qty_ID
        },
        {
            Label: 'Price',
            Value: price
        },
       {
            Label: 'Store',
            Value: store_id_ID
        },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'ItemsFacet',
            Label : 'Items',
            Target : '@UI.FieldGroup#SalesItems',
        },
    ],  
);

annotate Market.sales.Items with {
    store_id @(
        Common.Text: store_id.store_id,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Stores',
            CollectionPath : 'Store',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : store_id_ID,
                    ValueListProperty : 'ID'
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'store_id'
                },
                   {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                }
            ]
        }
    );
    product_id @(
        Common.Text: product_id.product_id,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Products',
            CollectionPath : 'Product',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : product_id_ID,
                    ValueListProperty : 'ID'
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'product_id'
                },
                   {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                }
            ]
        }
    )
};

annotate Market.Product {
    @Common.Text : '{Product}'
    @Core.IsURL : true
    @Core.MediaType : 'image/jpg'
    imageURL;
};