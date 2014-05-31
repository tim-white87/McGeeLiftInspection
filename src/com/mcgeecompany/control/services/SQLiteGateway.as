package com.mcgeecompany.control.services
{
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import com.mcgeecompany.control.events.SQLiteGatewayEvent;
	
	// JH: You should add an attribution comment to any file where you're using someone else's code. The comment should 
	//		note the source and document any required copyright notices, etc. In the case of classroom code samples, you can just say what was 
	//		built off from a code sample.
	// TW: Added! Originally put this in the readme file
	
	// SQL Gateway Code built based off SQLiteExample code sample by Jun Heider
	
	
	[Event(name="writableDBReady",type="com.mcgeecompany.control.events.SQLiteGatewayEvent")]
	[Event(name="statementExecutionComplete",type="com.mcgeecompany.control.events.SQLiteGatewayEvent")]
	
	public class SQLiteGateway extends EventDispatcher
	{
		
		private const DB_FILE_URI:String = 'assets/data/mcgeeliftdatabase.sqlite';

		private var _targetDBFile:File;
		private var _sqlDBConnection:SQLConnection;

		
		public function openWritableDB():void
		{
			_targetDBFile = File.applicationStorageDirectory.resolvePath( DB_FILE_URI );
			
			if( !_targetDBFile.exists )
			{
				_copyDBFromAppDirToApplicationStorageDir();	
			}
			else
			{
				_openDBFile();
				trace("database file open");
			}
		}
		
		public function executeStatement( sqlStatement:SQLStatement ):void
		{
			sqlStatement.sqlConnection = _sqlDBConnection;
			sqlStatement.addEventListener( SQLEvent.RESULT,_onSQLExecuteComplete );
			sqlStatement.addEventListener( SQLErrorEvent.ERROR,_onSQLExecuteComplete );
			sqlStatement.execute();
			
		}
		
		private function _copyDBFromAppDirToApplicationStorageDir():void
		{
			trace( "DB File is being copied to application storage for write access" );
			var sourceDBFile:File = File.applicationDirectory.resolvePath( DB_FILE_URI );
			_targetDBFile = File.applicationStorageDirectory.resolvePath( DB_FILE_URI );
			
			if( sourceDBFile.exists )
			{
				sourceDBFile.copyTo( _targetDBFile );
			}
			
			if( _targetDBFile.exists )
			{
				_openDBFile();
				
			}
		}
		
		private function _openDBFile():void
		{
			_sqlDBConnection = new SQLConnection();
			_sqlDBConnection.addEventListener( SQLEvent.OPEN, _onDBOpened );
 			
			_sqlDBConnection.open( _targetDBFile );
		}
		
		protected function _onSQLExecuteComplete(event:Event):void
		{
			dispatchEvent( new SQLiteGatewayEvent( SQLiteGatewayEvent.STATEMENT_EXECUTION_COMPLETE, event, true ) );		
			
			event.target.removeEventListener( SQLEvent.RESULT,_onSQLExecuteComplete );
			event.target.removeEventListener( SQLErrorEvent.ERROR,_onSQLExecuteComplete );			
		}
		
		
		private function _onDBOpened(event:SQLEvent):void
		{
			dispatchEvent( new SQLiteGatewayEvent( SQLiteGatewayEvent.WRITABLE_DB_READY ) );
		}
	}
}