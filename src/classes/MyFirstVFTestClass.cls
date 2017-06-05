public with sharing class MyFirstVFTestClass {

public List<Candidate__c> candidate {get; set;}
  
    
public myfirstVFTestClass(){
	
	candidate = [Select c.Name, c.First_Name__c, c.Last_Name__c, c.Email__c, c.Type__c from Candidate__c c];
	
}



public PageReference save() {
Update candidate;
return null;
} 


}