package com.mcgeecompany.control.events
{
	import flash.events.Event;
	
	// JH: You should add an attribution comment to any file where you're using someone else's code. The comment should 
	//		note the source and document any required copyright notices, etc. In the case of classroom code samples, you can just say what was 
	//		built off from a code sample.
	// TW: Added! Originally put this in the readme file
	
	// SQL Gateway Code built based off SQLiteExample code sample by Jun Heider
	
	public class SQLiteGatewayEvent extends Event
	{
		// Declarations
		public static const WRITABLE_DB_READY:String = "writableDBReady";
		public static const STATEMENT_EXECUTION_COMPLETE:String = "statementExecutionComplete";
		
		public var payload:Object;
		
		// Init
		public function SQLiteGatewayEvent(type:String, payload:Object=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.payload = payload;
		}
		
		
		// Control
		override public function clone():Event
		{
			return new SQLiteGatewayEvent( type, payload, bubbles, cancelable );
		}
	}
}