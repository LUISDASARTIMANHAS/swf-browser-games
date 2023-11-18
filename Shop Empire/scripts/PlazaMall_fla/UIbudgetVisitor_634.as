package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UIbudgetVisitor_634")]
   public dynamic class UIbudgetVisitor_634 extends MovieClip
   {
       
      
      public var textList:TextField;
      
      public function UIbudgetVisitor_634()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         textList.autoSize = TextFieldAutoSize.CENTER;
         textList.mouseEnabled = false;
      }
   }
}
