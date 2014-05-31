package com.mcgeecompany.model.vo
{
	

	[Bindable]	
	public class AddressVO
	{
		public var id:int;
		public var streetNumber:String;
		public var streetName:String;
		public var city:String;
		public var state:String;
		public var zipCode:String;
		public var phoneNumber:String;
		public var companyID:String;
		
		public function AddressVO(id:int=0,
								  streetNumber:String=null, 
								  streetName:String=null, 
								  city:String=null,
								  state:String=null, 
								  zipCode:String=null, 
								  phoneNumber:String=null, 
								  companyID:String=null)
		{
			this.id = id;
			this.streetNumber = streetNumber;
			this.streetName = streetName;
			this.city = city;
			this.state = state;
			this.zipCode = zipCode;
			this.phoneNumber = phoneNumber;
			this.companyID = companyID;
		}
	}
}
