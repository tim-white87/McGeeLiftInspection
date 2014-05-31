package com.mcgeecompany.model
{
	import com.mcgeecompany.control.SQLControl;
	import com.mcgeecompany.control.events.SQLiteGatewayEvent;
	import com.mcgeecompany.control.services.SQLiteGateway;
	
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	public class DataModel extends EventDispatcher
	{
		
		
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		[Bindable] private var _lastExecuteResult:String;
		
		private static var _instance:DataModel;
		private var _sqlGateway:SQLiteGateway;
		private var _sqlControl:SQLControl;
		private var _lastCompanyRowID:Number;
		private var _lastLiftRowID:Number;
		private var _loadedForms:ArrayCollection;
		private var _loadedQuestions:ArrayCollection;
		private var _loadedManufacturers:ArrayCollection;
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function DataModel(enforcer:SingletonEnforcer)
		{
			sqlGateway = new SQLiteGateway();
			//sqlControl = new SQLControl();
		}
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------	
		public static function getInstance():DataModel
		{
			if( _instance == null ) 
			{
				_instance = new DataModel ( new SingletonEnforcer() );
			}
			return _instance;
		}
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------
		public function openDatabase():void
		{
			
			sqlGateway.openWritableDB();
		}
		
		[Bindable]
		public function get sqlGateway():SQLiteGateway
		{
			return _sqlGateway;
		}

		public function set sqlGateway(value:SQLiteGateway):void
		{
			_sqlGateway = value;
		}
		
		[Bindable]
		public function get lastCompanyID():Number
		{
			return _lastCompanyRowID;
		}

		public function set lastCompanyID(value:Number):void
		{
			_lastCompanyRowID = value;
		}
		
		[Bindable]
		public function get sqlControl():SQLControl
		{
			return _sqlControl;
		}

		public function set sqlControl(value:SQLControl):void
		{
			_sqlControl = value;
		}
		
		[Bindable]
		public function get lastLiftID():Number
		{
			return _lastLiftRowID;
		}

		public function set lastLiftID(value:Number):void
		{
			_lastLiftRowID = value;
		}

		[Bindable]
		public function get loadedForms():ArrayCollection
		{
			return _loadedForms;
		}

		public function set loadedForms(value:ArrayCollection):void
		{
			_loadedForms = value;
		}

		[Bindable]
		public function get loadedQuestions():ArrayCollection
		{
			return _loadedQuestions;
		}

		public function set loadedQuestions(value:ArrayCollection):void
		{
			_loadedQuestions = value;
		}

		[Bindable]
		public function get loadedManufacturers():ArrayCollection
		{
			return _loadedManufacturers;
		}

		public function set loadedManufacturers(value:ArrayCollection):void
		{
			_loadedManufacturers = value;
		}

	
		
		
	}
}
internal class SingletonEnforcer{}