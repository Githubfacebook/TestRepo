Global with sharing class RetrieveCustomSettings {

 
    
    Global RetrieveCustomSettings(){
   //     DataRetention_BatchJob__c orgSettings =  DataRetention_BatchJob__c.DataRetentionSettings();
		  	Innovate_API_Org_Settings__c orgSettings = Innovate_API_Org_Settings__c.getOrgDefaults();
        

       
    }
}