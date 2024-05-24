namespace com.test.sdb;
using {managed,cuid} from '@sap/cds/common';
@assert.unique:{
    bp_no:[bp_no]
}
entity Business_Partner : cuid,managed {
    key ID: UUID;
    bp_no: Integer default 0 @Core.Computed;
    @title:'Name'
    name:String(20); 
    @title:'Address 1'
    add1:String(70);
    @title:'Address 2'
    add2:String(70);
    @title:'City'
    city:String(20);
    @title:'State'
    state:Association to States;
    @title:'pin code'
    pinCode:String(10);
    @title:' Is_gstn_registered'
    Is_gstn_registered:Boolean default false;
    @title:' GSTIN number'
    Gst_num:String(20);
    @title:' is vendor'
    Is_vendor:Boolean default false;
    @title:' is customer'
    Is_customer:Boolean default false;
}

entity Store : cuid,managed {
    key ID: UUID;
    store_id :String(10);
    name         : String(100);
    add1     : String(255);
    add2     : String(255);
    city         : String(100);
    state        : Association to States;
    PinCode      : String(10);
}

entity Product : cuid,managed {
    key ID: UUID;
    product_id           : String(20); 
    name     : String(100);
    imageURL        : String default 'https://2.bp.blogspot.com/-I4K6kTCRUEU/WOKSA6Xey6I/AAAAAAAAAFc/BeVS0wQwgYo-9QHZSYImaXoAzPzu750yQCK4B/s1600/electronics.jpg';
    costPrice       : Decimal(15, 2); 
    sellPrice       : Decimal(15, 2); 
}


entity Stock  : cuid,managed {
    key ID            : UUID;
    storeId         : Association to Store;
    product_id       : Association to Product;
    stock_qty        : Integer;
}


@cds.persistence.skip
entity States {
    @title:'code'
    key code: String(3);
    @title:'description'
    description:String(10);
    
}

entity purchase : cuid,managed {
    key ID :  UUID;
    pur_orderno : String(20);
    bp_no : Association to Business_Partner ;
    pur_orderdate : Date;
    Items: Composition of many  {
        key ID : UUID;
        product_id : Association to Product;
        qty : Integer;
        price : Integer;
        store_id : Association to Store;
    }

}

entity sales : cuid,managed {
    key ID : UUID;
    sal_orderno : String(20);
    Business_Partner :String(20);
    sal_date : Date;
    Items:  Composition of many {
        key ID : UUID;
        product_id : Association to Product;
        stock_qty : Association to Stock;
        price : Integer;
        store_id : Association to Store;

    }
}

