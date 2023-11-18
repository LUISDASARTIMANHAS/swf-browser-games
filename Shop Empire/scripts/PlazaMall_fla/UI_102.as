package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_102")]
   public dynamic class UI_102 extends MovieClip
   {
       
      
      public var upgradeCost:TextField;
      
      public var otherNote:TextField;
      
      public var upgradeCapacity:TextField;
      
      public function UI_102()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         upgradeCapacity.autoSize = TextFieldAutoSize.LEFT;
         upgradeCost.autoSize = TextFieldAutoSize.LEFT;
         otherNote.autoSize = TextFieldAutoSize.LEFT;
      }
   }
}
