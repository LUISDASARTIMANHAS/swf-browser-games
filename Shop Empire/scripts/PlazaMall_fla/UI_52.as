package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_52")]
   public dynamic class UI_52 extends MovieClip
   {
       
      
      public var cashList:TextField;
      
      public function UI_52()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         cashList.autoSize = TextFieldAutoSize.CENTER;
      }
   }
}
