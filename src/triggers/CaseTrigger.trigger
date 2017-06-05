trigger CaseTrigger on Case (after update) {
    if(trigger.isUpdate) {
       caseUtility cU = new caseUtility();
       cU.checkChildcases(Trigger.new, trigger.oldmap);
    }
}