package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_104")]
   public dynamic class UI_104 extends MovieClip
   {
       
      
      public var priceOrTicket:TextField;
      
      public var price:TextField;
      
      public var capacity:TextField;
      
      public function UI_104()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         capacity.autoSize = TextFieldAutoSize.LEFT;
         priceOrTicket.autoSize = TextFieldAutoSize.LEFT;
         price.autoSize = TextFieldAutoSize.LEFT;
      }
   }
}
