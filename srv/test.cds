using {com.test.sdb as db} from '../db/schema';

service Market {
    entity Business_Partner as projection on db.Business_Partner;
    entity States           as projection on db.States;
    entity Store            as projection on db.Store;
    entity Product            as projection on db.Product;
}

annotate Market.Business_Partner with @odata.draft.enabled;
annotate Market.Store with @odata.draft.enabled;
annotate Market.Product with @odata.draft.enabled;

annotate Market.Business_Partner with {
    bp_no @assert.format: '^[0-9]{2,}$';
    name  @assert.format: '^[a-zA-Z]{2,}$';
    add1  @assert.format: '^[a-zA-z0-9.-./.\.,]{2,}$';
    add2  @assert.format: '^[a-zA-z0-9.-./.\.,]{2,}$';
    city   @assert.format: '^[a-zA-Z]{2,}$';
    state @assert.format: '^[a-zA-Z]{2,}$';
    pinCode @assert.format: '^[1-9]{1}[0-9]{2}\\s{0, 1}[0-9]{3}$';
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
    ],
    UI.FieldGroup #BusinessP: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Bussiness Partner Id',
                Value: bp_no
            },
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
    UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'storeFacet',
            Label:'store facets',
            Target:'@UI.FieldGroup#store'
        },
    ],
);


annotate Market.Product with @(
UI.LineItem:[
    {
        Label:'Product id',
        Value:p_id
    },
     {
        Label:'Product Name',
        Value:name
    },
    {
        Label:'Product Image URL',
        Value:imageURL
    },
    {
        Label:'Cost Price',
        Value:costPrice
    },
       {
        Label:'Sell Price',
        Value:sellPrice
    },
],
UI.FieldGroup #product :{
     $Type: 'UI.FieldGroupType',
     Data:[
          {
        Label:'Product id',
        Value:p_id
    },
     {
        Label:'Product Name',
        Value:name
    },
    {
        Label:'Product Image URL',
        Value:imageURL
    },
    {
        Label:'Cost Price',
        Value:costPrice
    },
       {
        Label:'Sell Price',
        Value:sellPrice
    },
     ],
},
         UI.Facets:[
        {
            $Type:'UI.ReferenceFacet',
            ID:'productFacet',
            Label:'product facets',
            Target:'@UI.FieldGroup#product'
        },
    ],

);


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
