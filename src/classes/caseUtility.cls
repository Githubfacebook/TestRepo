public with Sharing class caseUtility {
    
    Public String ParentCaseId = '';
    Public String caseStatus = '';
    Public String caseReason = '';
    Public String caseType = '';
    Public String caseSubject = '';
    Public String caseDescription = '';
    
    //constructor
    public caseUtility(){
        
    }
    
    public void checkChildcases(List<Case> cases, map<id,case> oldcase)
    {        
        List<Case> casestoUpdate = new List<case>();
        Map<Id,Case> mapofCases = oldcase;
        List<Case> ParentCase = new List<Case>();
        
        Boolean IfUpdate = False;

        for(Case c : cases)
        {
            caseStatus = c.status;
            caseType= c.Type;
            caseSubject= c.Subject;
            caseDescription= c.Description;
            caseReason= c.Reason;
            ParentCaseId = c.Id;
            IfUpdate = c.Update_Child_Case__c;           
        }
        
        If(IfUpdate){

            List<Case> strQuery = [Select Id, Status from Case Where ParentId IN :mapofCases.keyset()];
            
            for( Case childCase : strQuery)
            {   
                childCase.Status = caseStatus;
                childCase.Type= caseType;
                childCase.Subject= caseSubject;
                ChildCase.Description= caseDescription;
                ChildCase.Reason= caseReason;
                casestoupdate.add(childCase);
            }
            If(casestoupdate.size() > 0){
                update casestoUpdate;
            }
            
            List<Case> strPCase = [Select Id, Status,Update_Child_Case__c from Case Where Id =: ParentCaseId];   
            for (Case pCase : strPCase){
                pCase.Update_Child_Case__c = false;
                ParentCase.add(pCase);
                update ParentCase;
                
            }            
        }
    }
}