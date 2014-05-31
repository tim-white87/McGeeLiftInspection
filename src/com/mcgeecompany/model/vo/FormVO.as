package com.mcgeecompany.model.vo
{
	import flash.utils.ByteArray;
	
	[Bindable]
	public class FormVO
	{
		public var companyID:int;
		public var liftID:int;
		public var signature:String;
		public var sigByteArr:ByteArray;
		public var sro:String;
		public var date:String;
		public var inspector:String;
		public var inspectionPass:Boolean;
		
		
		public function FormVO(
							   companyID:int = 0, 
							   liftID:int = 0, 
							   signature:String = null, 
							   sro:String = null,
							   date:String = null, 
							   inspector:String = null, 
							   inspectionPass:Boolean = false)
		{
			this.companyID = companyID;
			this.liftID = liftID;
			this.signature = signature;
			this.sro = sro;
			this.date = date;
			this.inspector = inspector;
			this.inspectionPass = inspectionPass;
		}
	}
}