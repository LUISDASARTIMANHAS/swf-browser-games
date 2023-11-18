package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Tips_92")]
   public dynamic class Tips_92 extends MovieClip
   {
       
      
      public var bottomRightCor:MovieClip;
      
      public var topRightCor:MovieClip;
      
      public var lowerBody:MovieClip;
      
      public var leftBody:MovieClip;
      
      public var bottomLeftCor:MovieClip;
      
      public var upperBody:MovieClip;
      
      public var infoList:TextField;
      
      public var body:MovieClip;
      
      public var textHeight:*;
      
      public var rightBody:MovieClip;
      
      public var topLeftCor:MovieClip;
      
      public function Tips_92()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         infoList.autoSize = TextFieldAutoSize.LEFT;
         infoList.mouseEnabled = false;
         textHeight = infoList.height;
         body.height = textHeight;
         leftBody.height = body.height;
         rightBody.height = body.height;
         bottomLeftCor.y = body.height;
         bottomRightCor.y = body.height;
         lowerBody.y = body.height;
      }
   }
}
