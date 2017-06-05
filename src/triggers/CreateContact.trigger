trigger CreateContact on Candidate__c (after insert) {
CreateContactFromCan cc = new CreateContactFromCan();

cc.createContactL(Trigger.new);

}