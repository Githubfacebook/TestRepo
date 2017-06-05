public with sharing class InnovateDRCProcess {

    Public List<Account> acc = new List<Account>();    
    Public List<Account> AllAccId = new List<Account>();
    public list<Contact> contlist{get;set;}
    public List<Account> delAccountList;

    //Constructor
    public InnovateDRCProcess(){
        AllAccId = [Select Id,Name from Account limit 1];
    }
    
    
    Public String getAllAccountsContact(){
        
        For(Account c: AllAccId){
            system.debug('Account being checked >>> ' + c.Name);
            if(c.Id !=null ){
                
                contlist= [select id,firstname,lastname,phone,email from contact where Account.Id=:c.Id];
                if(contList.size() > 0){
                    acc.add(c);
                    system.debug('Account has contact :>>> ' + c.Name);
                }
                else{
                    delAccountList.add(c);
                    system.debug('Account does not have a contact :>>> ' + c.Name);
                }
            }
               
                
        } 
        
        return null;

    }

}