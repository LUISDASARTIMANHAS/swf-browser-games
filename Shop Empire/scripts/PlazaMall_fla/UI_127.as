package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_127")]
   public dynamic class UI_127 extends MovieClip
   {
       
      
      public var upgradeCost:TextField;
      
      public var ticketPrice:TextField;
      
      public var eventPrice:TextField;
      
      public function UI_127()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         ticketPrice.autoSize = TextFieldAutoSize.LEFT;
         eventPrice.autoSize = TextFieldAutoSize.LEFT;
         upgradeCost.autoSize = TextFieldAutoSize.LEFT;
      }
   }
}
