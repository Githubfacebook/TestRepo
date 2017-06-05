public with sharing class CreateContactFromCan {

public void createContactL(List<Candidate__c> candsFromTrigger){
	
    system.debug('candsFromTrigger >>' + candsFromTrigger);
	Account candAccount = [Select a.Id From Account a Where a.Name = 'Sameer Account'];
	
	List<Contact> conList = new List<Contact>(); 
	
	for(Candidate__c currentCandidate: candsFromTrigger){
		  
		Contact cont = new Contact();
		cont.Id= candAccount.Id;
		cont.FirstName = currentCandidate.First_Name__c;
		cont.LastName = currentCandidate.Last_Name__c;
		cont.User_Email__c=  currentCandidate.Email__c;
		
		
		conList.add(cont);
		
	}
	Database.insert(conList);
}

}