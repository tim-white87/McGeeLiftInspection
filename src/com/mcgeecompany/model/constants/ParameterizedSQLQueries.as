package com.mcgeecompany.model.constants
{
	public class ParameterizedSQLQueries
	{
		
		// INSERT STATEMENTS
		public static const INSERT_INTO_COMPANY:String = 
			'INSERT OR REPLACE INTO company (location, email) ' +
			'VALUES (@location, @email)';
		
		public static const INSERT_INTO_ADDRESS:String = 
			'INSERT OR REPLACE INTO address (streetNumber, streetName, city, state, zipCode, phoneNumber, companyID) ' +
			'VALUES (@streetNumber, @streetName, @city, @state, @zipCode, @phoneNumber, @companyID)';
		
		public static const INSERT_INTO_LIFT:String =
			'INSERT OR REPLACE INTO lift (serial, modelNumber, bay, manufacturerID, type, subtype, structure, details, capacity) ' +
			'VALUES (@serial, @modelNumber, @bay, @manufacturerID, @type, @subtype, @structure, @details, @capacity)';	
		
		public static const INSERT_INTO_QUESTION:String =
			'INSERT OR REPLACE INTO question (questionText, answer, comment, photoURL, liftID) ' +
			'VALUES (@questionText, @answer, @comment, @photoURL, @liftID)';
		
		public static const INSERT_INTO_FORM:String =
			'INSERT OR REPLACE INTO form (companyID, liftID, signature, sro, date, inspector, inspectionPass) ' +
			'VALUES (@companyID, @liftID, @signature, @sro, @date, @inspector, @inspectionPass)';
		
		// SELECT STATEMENTS
		public static const SELECT_ALL_FORMS:String = 'SELECT * FROM company ' +
			'JOIN address ON company.id = address.companyID ' +
			'JOIN lift ON company.id = lift.companyID ' +
			'JOIN form ON company.id = form.companyID';
		
		public static const SELECT_ALL_COMPANIES:String = 'SELECT * FROM form ' +
			'JOIN company ON company.id = form.companyID ' +
			'JOIN address ON company.id = address.companyID ' +
			'JOIN lift ON lift.id = form.liftID';
		
		public static const SELECT_THESE_QUESTIONS:String = 'SELECT * FROM question ' +
			'WHERE liftID = ';
		
		public static const SELECT_MANUFACTURERS:String = 'SELECT * FROM manufacturer';
		
		public static const SELECT_JOB:String = 'SELECT * FROM form ' +
			'WHERE sro = @sro';
		
		// UPDATE STATEMENTS
		public static const UPDATE_EXISTING_COMPANY:String = 'UPDATE company ' +
															'SET location = @location ' +
															'WHERE id = @id';
		
		// DELETE STATEMENTS
		public static const DELETE_SPECIFIC_USER:String = 'DELETE FROM company ' +
															'WHERE id = @id';
		
	}
}

