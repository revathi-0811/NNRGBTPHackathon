sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'stockinformation/test/integration/FirstJourney',
		'stockinformation/test/integration/pages/StockList',
		'stockinformation/test/integration/pages/StockObjectPage'
    ],
    function(JourneyRunner, opaJourney, StockList, StockObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('stockinformation') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheStockList: StockList,
					onTheStockObjectPage: StockObjectPage
                }
            },
            opaJourney.run
        );
    }
);