package com.mcgeecompany.model.vo
{
	[Bindable]
	public class LiftVO
	{
		public var bay:String;
		public var serial:String;
		public var modelNumber:String;
		public var manufacturer:int;
		public var type:String;
		public var subType:String;
		public var structure:String;
		public var details:Array;
		public var capacity:String;
		
		public function LiftVO(	  bay:String=null,
								  serial:String=null, 
								  modelNumber:String=null,  
								  manufacturer:int=0, 
								  type:String=null, 
								  subType:String=null,
								  structure:String=null, 
								  details:Array=null, 
								  capacity:String=null)
		{
			this.bay = bay;
			this.serial = serial;
			this.modelNumber = modelNumber;
			this.manufacturer = manufacturer;
			this.type = type;
			this.subType = subType;
			this.structure = structure;
			this.details = details;
			this.capacity = capacity;
		}
	}
}