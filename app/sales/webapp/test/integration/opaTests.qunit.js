sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sales/test/integration/FirstJourney',
		'sales/test/integration/pages/salesList',
		'sales/test/integration/pages/salesObjectPage'
    ],
    function(JourneyRunner, opaJourney, salesList, salesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sales') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThesalesList: salesList,
					onThesalesObjectPage: salesObjectPage
                }
            },
            opaJourney.run
        );
    }
);