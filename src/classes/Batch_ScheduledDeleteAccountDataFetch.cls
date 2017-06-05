global class Batch_ScheduledDeleteAccountDataFetch implements Schedulable{

    private string generalEnquirer;
    private string otherCategory;
    private boolean testMode;
    
  
    /******************************************************************************************
     Ensure it includes the Schedulable Context
     ******************************************************************************************/
    global void execute(SchedulableContext sc) {

      Innovate_API_Org_Settings__c orgSettings = Innovate_API_Org_Settings__c.getOrgDefaults();
        this.generalEnquirer = orgSettings.General_Enquirer__c;
        this.otherCategory = orgSettings.Other_Category__c;
        this.testMode = orgSettings.Test_Mode__c;

        try{
         
            String queryString = 'Select id, name' 
                                + ' from Account' 
                                + ' WHERE'
                				+ ' Id Not In (Select AccountId from Case) AND '
                				+ ' Id Not In (Select AccountId from Contact) AND '
                                + ' Date_Difference__c  > '+ this.generalEnquirer;

       
            // create an instance of the batchable class  
            system.debug ('SOQL = ' + queryString);
            
            Batch_DeleteAccountData ba = new Batch_DeleteAccountData(queryString); 
            
            //Check the maximum batchSizes that can be applied (Governor limits. The following may be out of date as it was from 2 years ago)
            Integer batchSize = 2000;
            
            // Execute the batch >. This will call the Execue function in MyBatchApexClass and wlll execute in batches of batchSize.
            Database.executeBatch(ba,batchSize);
            
        }catch(Exception e){
       }
    }
}