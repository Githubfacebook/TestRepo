public with sharing class CSign_SignatureController
{
	public Id targetId {get; set;}
	public String prefix {get; set;}

	public Boolean signatureCaptured {
		get {
			if (signatureCaptured == null) {
				checkSignatureCaptured();
			}
			return signatureCaptured;
		}
		set;
	}

	public Attachment sigAttachment {get;  set;} 

	public CSign_SignatureController()
	{
	}

	public PageReference checkSignatureCaptured()
	{
		PageReference pageRef = null;

		List<Attachment> lstAttachment = [
				SELECT Id, Name
				FROM   Attachment
				WHERE  ParentId = :this.targetId
				AND    Name = :(this.prefix + '-' + this.targetId)
		];

		if(lstAttachment != null && lstAttachment.size() > 0)
		{
			this.signatureCaptured = true;	
			this.sigAttachment = lstAttachment[0];
		}
		else
		{
			this.signatureCaptured = false;
		}
		
		return null;
	}

	public PageReference captureSignature()
	{	
		System.debug('## in captureSignature');
		String param = Apexpages.currentPage().getParameters().get('one');
		System.debug('## param : ' + param);

		if(param != null && param.startsWith('data:image/png;base64,'))
		{
			param = param.replace('data:image/png;base64,', '');

			System.debug('## param : ' + param);

			Blob img = Encodingutil.base64Decode(param);

			sigAttachment = new Attachment();
			sigAttachment.Body = img;
			sigAttachment.Name = this.prefix + '-' + this.targetId;
			sigAttachment.ParentId = this.targetId;
			sigAttachment.ContentType = 'image/png';

			insert sigAttachment;

			this.signatureCaptured = true;	
		}
		return null;
	}

	static testMethod void testCNuke_SignatureController() 
	{
		Lead lead = new Lead();
		insert lead;

		PageReference pageRef = Page.CaptureSignature;
		Test.setCurrentPage(pageRef);

		Apexpages.Standardcontroller ctrl = new Apexpages.Standardcontroller(lead);
		CSign_SignatureController ext = new CSign_SignatureController();

		// no signature should exist
		ext.checkSignatureCaptured();		

		// capture signature
		Apexpages.currentPage().getParameters().put('one', 'data:image/png;base64,123');
		ext.captureSignature();

		// signature should exist
		ext.checkSignatureCaptured();
	}
}