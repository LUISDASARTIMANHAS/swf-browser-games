package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UIbudgetDiscription_635")]
   public dynamic class UIbudgetDiscription_635 extends MovieClip
   {
       
      
      public var writeArea:MovieClip;
      
      public var textList:TextField;
      
      public function UIbudgetDiscription_635()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         textList.autoSize = TextFieldAutoSize.LEFT;
         textList.mouseEnabled = false;
      }
   }
}
