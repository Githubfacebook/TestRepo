public with sharing class CalloutsRequest {

    public static final Integer SUCCESS_CODE = 200;
    
    Public String URL{get;set;}
    Public String cEmail='';
    public String searchString{get;set;}
    boolean success;
    public CalloutsRequest(){
        // Token = 'qVSsHexyd2TQr3ihqSfssxz8e31f5E8F';
         URL = 'https://stage-tms.govdelivery.com/messages/email';
        
          
    }
   

    
    //System.debug(doCallout(URL)); 
    
    public String SendEmail(List<Contact> contactFromTrigger){
        system.debug('This is called >>> ' + contactFromTrigger);
     	
        for(Contact currentContact: contactFromTrigger){
            cEmail = currentContact.Email;
        }
         doCallout(URL,cEmail);
        return null;
    }
    
    /*
     public String SendEmailBySearch(String search){
         doCallout(URL,searchString);
        return null;
    }
*/
    @future(callout=true)
    public static void doCallout(string hitURL, String strEmail){
        system.debug('The url being called = ' + hitURL);
        
        EENClass objlinkedinpostshare_API = new EENClass(); 
        objlinkedinpostshare_API.body = 'This is test body';
        objlinkedinpostshare_API.subject = 'Test Subject - Mahmood';
        
        EENClass.Recipients objCls_Recipients = new EENClass.Recipients();
		objCls_Recipients.email = strEmail;

//        objlinkedinpostshare_API.Recipients =objCls_Recipients;  
        
        
      //  System.debug('objCls_Recipients.email >>>' + objCls_Recipients.email);

        String jsonBody = json.serialize(objlinkedinpostshare_API);
        String Token = 'qVSsHexyd2TQr3ihqSfssxz8e31f5E8F';
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(hitURL);
        req.setMethod('POST');
        
        req.setHeader('X-AUTH-TOKEN', Token);
        req.setHeader('Content-Type','application/json');
        system.debug('req>>>' + req);

        if(jsonBody != null )
         { 
             req.setBody(jsonBody);
             req.setHeader('Content-length',string.valueOf(jsonBody.length()));
         }
         HttpResponse res = new http().send(req);

       system.debug(res.getBody());
        
	/*
        HttpResponse res;
        
        // Send the request, and return a response
        try {
            res = h.send(req);
            
        } catch (CalloutException e) {
            return e.getMessage();
        }
        if (res.getStatusCode() != SUCCESS_CODE){
            success = false;
            system.debug('Authentication failed!!!' + res + res.getStatusCode());
        }
        else{
            success = true;
            system.debug('getbody == ' + res.getBody());
        }
        return res.getBody(); 
    */
    }

}