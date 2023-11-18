package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_129")]
   public dynamic class UI_129 extends MovieClip
   {
       
      
      public var diff:*;
      
      public var noteSymbol:MovieClip;
      
      public var topRightCor:MovieClip;
      
      public var lowerBody:MovieClip;
      
      public var leftBody:MovieClip;
      
      public var bottomLeftCor:MovieClip;
      
      public var upperBody:MovieClip;
      
      public var body:MovieClip;
      
      public var bottomRight:MovieClip;
      
      public var info:TextField;
      
      public var textHeight:*;
      
      public var rightBody:MovieClip;
      
      public var topLeftCor:MovieClip;
      
      public function UI_129()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         info.autoSize = TextFieldAutoSize.CENTER;
         info.mouseEnabled = false;
         textHeight = info.numLines * 18;
         diff = textHeight - info.height;
         info.y = -(textHeight - diff / 2);
         body.height = textHeight - (upperBody.height + lowerBody.height);
         body.y = -(textHeight - upperBody.height);
         leftBody.height = body.height;
         leftBody.y = body.y;
         rightBody.height = body.height;
         rightBody.y = body.y;
         upperBody.y = -textHeight;
         topLeftCor.y = upperBody.y;
         topRightCor.y = upperBody.y;
         noteSymbol.y = -textHeight / 2 - noteSymbol.height / 2;
      }
   }
}
