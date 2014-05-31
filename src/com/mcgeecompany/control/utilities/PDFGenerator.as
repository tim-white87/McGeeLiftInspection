package com.mcgeecompany.control.utilities
{
	import co.moodshare.pdf.MSPDF;
	
	import com.mcgeecompany.model.AppModel;
	import com.mcgeecompany.model.DataModel;
	import com.mcgeecompany.model.vo.QuestionVO;
	
	import flash.display.Sprite;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	
	import mx.utils.Base64Decoder;
	import mx.utils.StringUtil;
	
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.display.Display;
	import org.alivepdf.fonts.*;
	import org.alivepdf.images.ColorSpace;
	import org.alivepdf.layout.*;
	import org.alivepdf.saving.Method;
	
	public class PDFGenerator extends Sprite
	{	
		[Bindable]private var appModel:AppModel = AppModel.getInstance();
		[Bindable] private var dataModel:DataModel = DataModel.getInstance();
		private var base64Dec:Base64Decoder;
		private var pdf: MSPDF;
		private var file: File;
		private var background1:Rectangle = new Rectangle();
		private var i:int = 1;
		
		public function PDFGenerator()
		{
			pdf = new MSPDF();
			
			pdf.setDisplayMode (Display.FULL_PAGE,
				Layout.SINGLE_PAGE);
			 
			pdf.addPage();
			drawBackground();
			writeText();
			savePDF();
			
		}
		
		private function drawBackground():void
		{
			// Draw background
			pdf.lineStyle(new RGBColor (0x344F72), 1, .3);
			pdf.beginFill(new RGBColor (0x344F72));
			pdf.drawRect(new Rectangle (0, 0, 800, 1200));
			pdf.end();
			pdf.endFill();
			
			pdf.lineStyle(new RGBColor (0xEFEFEF), 1, .3);
			pdf.beginFill(new RGBColor (0xEFEFEF));
			pdf.drawRoundRect(new Rectangle(5, 5, 197.5, 285), 5);
			pdf.end();
			pdf.endFill();
			
			//pdf.addImage(new mcGeeLogo());
			
		}
		
		private function writeText():void
		{
			var manufacturer:String = dataModel.loadedManufacturers.getItemAt(appModel.lift.manufacturer)['name'];
			var myCoreFont:IFont = new CoreFont(FontFamily.ARIAL);
			pdf.setFont(myCoreFont, 20);
			pdf.textStyle(new RGBColor(0x344F72));
			pdf.setXY( 55, 15);
			pdf.writeText(15, "McGee Multi-Point Lift Inspection \n");
			
			pdf.setFont(myCoreFont, 12);
			pdf.textStyle(new RGBColor(0x000000));
			pdf.addText(appModel.form.date, 170, 10);
			pdf.addText("SRO: " + appModel.form.sro, 170, 16);
			pdf.writeText(6, 
				"Location: " + appModel.company.location + " \n" +
				"Address: " + appModel.address.streetNumber + ' ' + appModel.address.streetName + ' ' + 
				appModel.address.city + ' ' + appModel.address.state + ' ' + appModel.address.zipCode + " \n" +
				"Phone number: " + appModel.address.phoneNumber + " \n" +
				"Email: " + appModel.company.email + " \n");
			pdf.setFont(myCoreFont, 16);
			pdf.textStyle(new RGBColor(0x344F72));
			pdf.writeText(6, '\n'  + '          ' + appModel.lift.subType + ' ' + appModel.lift.type + ' Inspection \n \n');
			pdf.setFont(myCoreFont, 12);
			pdf.textStyle(new RGBColor(0x000000));
			pdf.writeText(6, 
				"Bay: " + appModel.lift.bay + " \n" +
				"Serial: " + appModel.lift.serial + " \n" +
				"Model Number: " + appModel.lift.modelNumber + " \n" +
				"Manufacturer: " + manufacturer + " \n" +
				"Capacity: " + appModel.lift.capacity + " \n\n");
			
			for each (var question:QuestionVO in appModel.questionList)
			{
				
				if(question.answer == 'pass')
				{
					pdf.textStyle(new RGBColor(0x25E642));
					pdf.writeText(6, 'Pass              ');
				}
				if(question.answer == 'attentionNeeded')
				{
					pdf.textStyle(new RGBColor(0xE6E625));
					pdf.writeText(6, 'Attn Needed  ');
				}
				if(question.answer == 'fail')
				{
					pdf.textStyle(new RGBColor(0xFF0000));
					pdf.writeText(6, 'Fail                ');
				}
				if (question.answer == 'na' || question.answer == null)
				{
					pdf.textStyle(new RGBColor(0xB3B3B3));
					pdf.writeText(6, 'N/A                ');
				}
				
				pdf.setFont(myCoreFont, 12);
				pdf.textStyle(new RGBColor(0x000000));
				pdf.writeText(6, i + '. ' + question.questionText + '\n');
				
				if (question.comment !== null) pdf.writeText(6, '      Comments: ' + question.comment + ' \n'); 
				i++;
			}
			
			pdf.addText('Use of this lift is ', 20, 285);
			if(appModel.form.inspectionPass == true)
			{
				pdf.textStyle(new RGBColor(0x25E642));
				pdf.addText('                           RECOMMENDED', 20, 285);
			} else {
				pdf.textStyle(new RGBColor(0xFF0000));
				pdf.addText('                           NOT RECOMMENDED', 20, 285);
			}
			decodeSignature();
			pdf.textStyle(new RGBColor(0x000000));
			pdf.addText('Inspector: ' + appModel.form.inspector, 160, 285);
			pdf.addImageStream(appModel.form.sigByteArr, ColorSpace.DEVICE_RGB, null, 140, 250, 50, 20);
			
			
			
			
			pdf.end();
			pdf.endFill();
		}
		
		private function decodeSignature():void
		{
			base64Dec = new Base64Decoder();
			StringUtil.trim(appModel.form.signature);
			base64Dec.decode(appModel.form.signature);
			appModel.form.sigByteArr = base64Dec.toByteArray();
		}
		
		private function savePDF():void
		{
			var f:FileStream = new FileStream();
			var file:File =
				File.documentsDirectory.resolvePath( appModel.form.sro +'-' + appModel.lift.bay + '.pdf' );
			f.open( file, FileMode.WRITE);
			var bytes:ByteArray = pdf.save(Method.LOCAL);
			f.writeBytes(bytes);
			f.close();
			var request:URLRequest = new URLRequest( file.url );
			navigateToURL(request);
		}
	}
}