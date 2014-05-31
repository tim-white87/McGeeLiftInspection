package com.mcgeecompany.model.vo
{
	import spark.components.Image;

	[Bindable]
	public class QuestionVO
	{
		public var id:String;
		public var questionText:String;
		public var answer:String;
		public var comment:String;
		public var photoURL:String;
		public var liftID:int;
	
		public function QuestionVO(questionText:String = null, 
								   comment:String = null, 
								   photoURL:String = null, 
								   answer:String = null, 
								   liftID:int = 0)
		{
			this.questionText = questionText;
			this.comment = comment;
			this.photoURL = photoURL;
			this.answer = answer;
			this.liftID = liftID;
		}
	}
}