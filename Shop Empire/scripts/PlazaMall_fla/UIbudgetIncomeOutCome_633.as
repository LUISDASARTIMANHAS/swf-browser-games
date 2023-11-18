package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UIbudgetIncomeOutCome_633")]
   public dynamic class UIbudgetIncomeOutCome_633 extends MovieClip
   {
       
      
      public var textList:TextField;
      
      public function UIbudgetIncomeOutCome_633()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         textList.autoSize = TextFieldAutoSize.RIGHT;
         textList.mouseEnabled = false;
      }
   }
}
