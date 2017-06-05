trigger TriggerContact on Contact (after insert, after update) {

    
    CalloutsRequest cr = new CalloutsRequest();
    cr.SendEmail(Trigger.new);
}