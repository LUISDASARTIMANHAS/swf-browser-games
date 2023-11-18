package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_105")]
   public dynamic class UI_105 extends MovieClip
   {
       
      
      public var capacity:TextField;
      
      public function UI_105()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         capacity.autoSize = TextFieldAutoSize.LEFT;
      }
   }
}
