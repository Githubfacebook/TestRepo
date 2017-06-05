@isTest(seeAllData=false)
private class CaseUpdateonTaskInsertTest {
    
    public static testMethod void testTTrigger(){
        
        Case cs = new Case();
        cs.Status='Open';
        
        insert cs;
        
        Task ts = new Task();
        ts.WhatId = cs.id;
        ts.Subject='Test';
        ts.Status='Completed';
        ts.Priority='Normal';
        
        insert ts;
        /*
        List<Case> lstCase = new List<Case>();
        if(ts.WhatId != null && string.valueof(ts.WhatId).startsWith('500'))
        {
            Case cs1 = new Case(id=ts.WhatId);
            lstCase.add(cs1);
        }
        
        update lstCase;
        */
        
    }
}