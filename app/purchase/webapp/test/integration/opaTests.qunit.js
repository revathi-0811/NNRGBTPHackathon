sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'purchase/test/integration/FirstJourney',
		'purchase/test/integration/pages/PurchaseList',
		'purchase/test/integration/pages/PurchaseObjectPage'
    ],
    function(JourneyRunner, opaJourney, PurchaseList, PurchaseObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('purchase') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePurchaseList: PurchaseList,
					onThePurchaseObjectPage: PurchaseObjectPage
                }
            },
            opaJourney.run
        );
    }
);