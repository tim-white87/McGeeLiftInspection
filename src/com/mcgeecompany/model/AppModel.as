package com.mcgeecompany.model
{
	import com.mcgeecompany.model.vo.AddressVO;
	import com.mcgeecompany.model.vo.CompanyVO;
	import com.mcgeecompany.model.vo.FormVO;
	import com.mcgeecompany.model.vo.LiftVO;
	import com.mcgeecompany.model.vo.QuestionVO;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	public class AppModel extends EventDispatcher
	{
		
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------	
		private static var _instance:AppModel;
		private var _address:AddressVO;
		private var _company:CompanyVO;
		private var _form:FormVO;
		private var _lift:LiftVO;
		private var _question:QuestionVO;
		private var _questionList:ArrayCollection;
		private var _questionArray:Array;
		private var _questionID:int;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------	
		public function AppModel( enforcer:SingletonEnforcer )
		{
			
		}
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------	
		public static function getInstance():AppModel
		{
			if( _instance == null ) 
			{
				_instance = new AppModel( new SingletonEnforcer() );
				
			}
			
			return _instance;
		}
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------
		[Bindable]	
		public function get company():CompanyVO
		{
			return _company;
		}

		public function set company(value:CompanyVO):void
		{
			_company = value;
		}
		[Bindable]	
		public function get lift():LiftVO
		{
			return _lift;
		}

		public function set lift(value:LiftVO):void
		{
			_lift = value;
		}
		
		[Bindable]
		public function get questionList():ArrayCollection
		{
			return _questionList;
		}
		public function set questionList( value:ArrayCollection ):void
		{
			_questionList = value;
		}
		
		[Bindable]
		public function get form():FormVO
		{
			return _form;
		}

		public function set form(value:FormVO):void
		{
			_form = value;
		}

		[Bindable]
		public function get question():QuestionVO
		{
			return _question;
		}

		public function set question(value:QuestionVO):void
		{
			_question = value;
		}

		
		[Bindable]
		public function get address():AddressVO
		{
			return _address;
		}

		public function set address(value:AddressVO):void
		{
			_address = value;
		}

		[Bindable]
		public function get questionArray():Array
		{
			return _questionArray;
		}

		public function set questionArray(value:Array):void
		{
			_questionArray = value;
		}		
		
		[Bindable]
		public function get questionID():int
		{
			return _questionID;
		}

		public function set questionID(value:int):void
		{
			_questionID = value;
		}

	}
}
internal class SingletonEnforcer{}