package com.mcgeecompany.model.vo
{
	


	[Bindable]
	public class CompanyVO
	{
		public var id:int;
		public var location:String;
		public var email:String;
		
		
		public function CompanyVO(id:int=0, location:String=null,
								  email:String=null)
		{
			this.id = id;
			this.location = location;
			this.email = email;
		}
	}
}
