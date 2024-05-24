sap.ui.define(["sap/m/MessageToast"], function (MessageToast) {
    "use strict";
  
    return {
      is_vendor: function (oBindingContext, aSelectedContexts) {
        aSelectedContexts.forEach((element) => {
          var oData = jQuery
            .ajax({
              type: "PATCH",
              contentType: "application/json",
              url: "/odata/v4/market" + element.sPath,
              data: JSON.stringify({ Is_vendor: true }),
            })
            .then(element.requestRefresh());
        });
      },
      is_customer: function (oBindingContext, aSelectedContexts) {
        aSelectedContexts.forEach((element) => {
          var oData = jQuery
            .ajax({
              type: "PATCH",
              contentType: "application/json",
              url: "/odata/v4/market" + element.sPath,
              data: JSON.stringify({ Is_customer: true }),
            })
            .then(element.requestRefresh());
        });
      },
    };
});
