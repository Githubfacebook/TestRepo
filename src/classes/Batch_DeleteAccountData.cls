global class Batch_DeleteAccountData implements Database.Batchable<sObject>,Database.StateFul{
  
    global final String query;
    

    
  //Constructor for class
  global Batch_DeleteAccountData  (string q){ 
    query = q;
      
  }
  
  global Database.Querylocator start(Database.batchableContext BC){
    system.debug('****  Batch job started ****');
    Database.Querylocator queryLocator = null;
    try{
	    // This executes the query
        queryLocator = Database.getQueryLocator(query);
    }catch(Exception e){
      }
      return queryLocator;
   }
   
   // This does the actual execution. It's called from  Database.executeBatch in class Batch_ScheduledEquipmentDataFetch
   //The contact list below is the list of contacts returned from the above query which was then passed from the Schedule job.
   global void execute(Database.BatchableContext BC, List<Account> scope){     
     
     system.debug('****  Inside BA Execute  Call whatever your function is called in your handler class****');

       
        List <Account> accountList = new List <Account>();
       System.debug('The scope is === ' + scope);
       for (Account con: scope ){
           
           //Changing the description with Account rating..
           con.Batch_Field__c = 'Updated at ' + Date.today();
           accountList.add(con);
       }
       if(accountList.size()>0)
           update accountList;
   }

   global void finish(Database.BatchableContext BC){
       AsyncApexJob a = 
           [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob WHERE Id =
            :BC.getJobId()];
                          
       // Send an email to the Apex job's submitter 
       //   notifying of job completion. 
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[] {a.CreatedBy.Email};
       mail.setToAddresses(toAddresses);
       mail.setSubject('Record processed Status: ' + a.Status);
       mail.setPlainTextBody
       ('The batch Apex job processed ' + a.TotalJobItems +
       ' : ' + a.JobItemsProcessed +
       ' batches with '+ a.NumberOfErrors + ' failures.');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }
}