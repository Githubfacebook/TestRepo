public with sharing class CaptureSignatureEXT 
{

    public CaptureSignatureEXT(MyController controller) {

    }

    //public Audit__c audit {get; set;}
    public Account audit {get; set;}
    public Boolean signatureCaptured {get; set;}
    public String param {get; set;}
    public Attachment sigAttachment {get; set;} 
    
    public CaptureSignatureEXT(ApexPages.StandardController stdController) 
    {
        this.audit = (Account)stdController.getRecord();
        signatureCaptured = false;
    }
    
    public PageReference checkSignatureCaptured()
    {
        PageReference pageRef = null;
        String signatureName = 'Signature-' + audit.Id;
        
        List<Attachment> lstAttachment = [Select Id, Name from Attachment where ParentId =:audit.Id and Name =:signatureName];
        
        if(lstAttachment != null && lstAttachment.size() > 0)
        {
            signatureCaptured = true;   
            sigAttachment = lstAttachment[0];
        }
        else
        {
            signatureCaptured = false;
        }
        
        return null;
    }
    
    public PageReference captureSignature()
    {
        System.debug('## in captureSignature');
        param = Apexpages.currentPage().getParameters().get('one');
        System.debug('## param : ' + param);
        
        if(param != null && param.startsWith('data:image/png;base64,'))
        {
            param = param.replace('data:image/png;base64,', '');
            
            System.debug('## param : ' + param);
            
            Blob img = Encodingutil.base64Decode(param);
            
            sigAttachment = new Attachment();
            sigAttachment.Body = img;
            sigAttachment.Name = 'Signature-' + audit.Id;
            sigAttachment.ParentId = audit.Id;
            sigAttachment.ContentType = 'image/png';
            
            insert sigAttachment;       
            
            signatureCaptured = true;   
        }
        return null;
    }
    
    static testMethod void testCaptureSignatureEXT() 
    {
        Account audit = new Account();
        insert audit;
        
        PageReference pageRef = Page.CaptureSignature;
        Test.setCurrentPage(pageRef);
        
        Apexpages.Standardcontroller ctrl = new Apexpages.Standardcontroller(audit); 
        CaptureSignatureEXT ext = new CaptureSignatureEXT(ctrl);
        
        // no signature should exist
        ext.checkSignatureCaptured();       
        
        // capture signature
        Apexpages.currentPage().getParameters().put('one', 'data:image/png;base64,123');
        ext.captureSignature();
        
        // signature should exist
        ext.checkSignatureCaptured();
    }
}