trigger CaseUpdateonTaskInsert on Task (after insert)
{
    List<Case> lstCase = new List<Case>();
    for(Task T : Trigger.New)
    {
        if(T.WhatId != null && string.valueof(T.WhatId).startsWith('500'))
        {
            Case cs = new Case(id=T.WhatId);
            lstCase.add(cs);
        }
    }
    
    update lstCase;
}