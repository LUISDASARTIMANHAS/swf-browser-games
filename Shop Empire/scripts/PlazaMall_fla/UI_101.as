package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_101")]
   public dynamic class UI_101 extends MovieClip
   {
       
      
      public var upgradeCost:TextField;
      
      public var priceOrTicket:TextField;
      
      public var upgradePrice:TextField;
      
      public var upgradeCapacity:TextField;
      
      public function UI_101()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         upgradeCapacity.autoSize = TextFieldAutoSize.LEFT;
         priceOrTicket.autoSize = TextFieldAutoSize.LEFT;
         upgradePrice.autoSize = TextFieldAutoSize.LEFT;
         upgradeCost.autoSize = TextFieldAutoSize.LEFT;
      }
   }
}
