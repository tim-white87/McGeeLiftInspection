package com.mcgeecompany.control
{
	import com.mcgeecompany.model.AppModel;
	import com.mcgeecompany.model.DataModel;
	import com.mcgeecompany.model.constants.ParameterizedSQLQueries;
	import com.mcgeecompany.model.vo.FormVO;
	import com.mcgeecompany.model.vo.QuestionVO;
	
	import flash.data.SQLStatement;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	public class SQLControl 
	{
		
		//[Bindable] private var _lastExecuteResult:String;
		[Bindable] private var loadedFormsArray:Array;
		[Bindable] private var loadedQuestionsArray:Array;
		[Bindable] private var loadedManufacturers:Array;
		[Bindable] private var result:Array;
		[Bindable] private var loadedJobArray:Array;
		private var appModel:AppModel = AppModel.getInstance();
		private var dataModel:DataModel = DataModel.getInstance();
		
	
		//// Opening \\\\
		
		public function SQLControl()
		{
			dataModel.openDatabase();
			//dataModel.sqlGateway.addEventListener( SQLiteGatewayEvent.STATEMENT_EXECUTION_COMPLETE, _onSQLExecuteComplete );
		}
		
		//// Writing \\\\
		public function writeFormData():void
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.INSERT_INTO_FORM;
			sqlStatement.parameters['@companyID'] = dataModel.lastCompanyID;
			sqlStatement.parameters['@liftID'] = dataModel.lastLiftID;
			sqlStatement.parameters['@signature'] = appModel.form.signature;
			sqlStatement.parameters['@sro'] = appModel.form.sro;
			sqlStatement.parameters['@date'] = appModel.form.date;
			sqlStatement.parameters['@inspector'] = appModel.form.inspector;
			sqlStatement.parameters['@inspectionPass'] = appModel.form.inspectionPass;
			dataModel.sqlGateway.executeStatement( sqlStatement );
		}
		
		public function writeCompanyData():void
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.INSERT_INTO_COMPANY;
			sqlStatement.parameters['@location'] = appModel.company.location;
			sqlStatement.parameters['@email'] = appModel.company.email;
			dataModel.sqlGateway.executeStatement( sqlStatement);
			dataModel.lastCompanyID = sqlStatement.sqlConnection.lastInsertRowID;
		}
		
		public function writeAddressData():void
		{			
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.INSERT_INTO_ADDRESS;
			sqlStatement.parameters['@streetNumber'] = appModel.address.streetNumber;
			sqlStatement.parameters['@streetName'] = appModel.address.streetName;
			sqlStatement.parameters['@city'] = appModel.address.city;
			sqlStatement.parameters['@state'] = appModel.address.state;
			sqlStatement.parameters['@zipCode'] = appModel.address.zipCode;
			sqlStatement.parameters['@phoneNumber'] = appModel.address.phoneNumber;
			sqlStatement.parameters['@companyID'] = dataModel.lastCompanyID;
			dataModel.sqlGateway.executeStatement( sqlStatement ); 
		}
		
		public function writeLiftData():void
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.INSERT_INTO_LIFT;
			sqlStatement.parameters['@serial'] = appModel.lift.serial;
			sqlStatement.parameters['@modelNumber'] = appModel.lift.modelNumber;
			sqlStatement.parameters['@bay'] = appModel.lift.bay;
			sqlStatement.parameters['@manufacturerID'] = appModel.lift.manufacturer;
			sqlStatement.parameters['@type'] = appModel.lift.type;
			sqlStatement.parameters['@subtype'] = appModel.lift.subType;
			sqlStatement.parameters['@structure'] = appModel.lift.structure;
			sqlStatement.parameters['@details'] = appModel.lift.details.toString();
			sqlStatement.parameters['@capacity'] = appModel.lift.capacity;
			dataModel.sqlGateway.executeStatement( sqlStatement ); 
			dataModel.lastLiftID = sqlStatement.sqlConnection.lastInsertRowID;
		}
		
		public function writeQuestionData():void
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.INSERT_INTO_QUESTION;
			sqlStatement.parameters['@questionText'] = appModel.question.questionText;
			sqlStatement.parameters['@answer'] = appModel.question.answer;
			sqlStatement.parameters['@comment'] = appModel.question.comment;
			sqlStatement.parameters['@photoURL'] = appModel.question.photoURL;
			sqlStatement.parameters['@liftID'] = dataModel.lastLiftID;
			dataModel.sqlGateway.executeStatement( sqlStatement );
		}
		
		
		
		//// Loading \\\\
		public function loadSQLData():void
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.SELECT_ALL_COMPANIES;
			dataModel.sqlGateway.executeStatement( sqlStatement );
			result = sqlStatement.getResult().data;
			
			loadedFormsArray = [ ];
			for each(var obj:Object in result)
				loadedFormsArray.push(obj); 
			
			//Store SQL Data in dataModel
			dataModel.loadedForms = new ArrayCollection(loadedFormsArray);		
		} 	
		
		public function loadSQLManufacturers():void
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.SELECT_MANUFACTURERS;
			dataModel.sqlGateway.executeStatement( sqlStatement );
			result = sqlStatement.getResult().data;
			
			loadedManufacturers = [ ];
			for each(var obj:Object in result) 
				loadedManufacturers.push(obj);
				
			dataModel.loadedManufacturers = new ArrayCollection(loadedManufacturers);
		}
		
		public function loadSQLQuestions(liftID:int):void
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.SELECT_THESE_QUESTIONS + liftID;
			dataModel.sqlGateway.executeStatement( sqlStatement );
			result = sqlStatement.getResult().data;
			
			loadedQuestionsArray = [ ];
			for each(var obj:Object in result)
			{
				appModel.question = new QuestionVO();
				appModel.question.questionText = obj['questionText'];
				appModel.question.answer = obj['answer'];
				appModel.question.comment = obj['comment'];
				appModel.question.photoURL = obj['photoURL'];
				//trace(ObjectUtil.toString(appModel.question));
				loadedQuestionsArray.push(appModel.question);
			}
			
			//Store questions in current appModel
			appModel.questionList = new ArrayCollection(loadedQuestionsArray);
			
		}
		
		/*public function loadJob(sro:String):void
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.SELECT_JOB;
			sqlStatement.parameters['@sro'] = sro;
			dataModel.sqlGateway.executeStatement( sqlStatement );
			result = sqlStatement.getResult().data;
			loadedJobArray = [ ];
			for each(var obj:Object in result)
			{
				appModel.form = new FormVO();
				appModel.form.
			}
		}*/
		
		//// Deleting \\\\
		public function DeleteSQLForm(companyID:int):void
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = ParameterizedSQLQueries.DELETE_SPECIFIC_USER;
			sqlStatement.parameters['@id'] = companyID;
			dataModel.sqlGateway.executeStatement( sqlStatement );
			
		}
		
		
		/*private function _onSQLExecuteComplete(event:SQLiteGatewayEvent):void
		{
			if( event.payload )
			{	
				if( event.payload is SQLEvent )
				{	
					var statement:SQLStatement = SQLEvent( event.payload ).target as SQLStatement;
					
					dataModel.lastCompanyID = statement.getResult().lastInsertRowID;					
				}
				else
				{
					_lastExecuteResult = "Failure\n" + SQLErrorEvent( event.payload ).error.details;
				}
			}
			else
			{
				_lastExecuteResult = "UNKNOWN";
			}
		}*/				
	}
}