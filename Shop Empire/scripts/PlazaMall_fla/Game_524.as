package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_524")]
   public dynamic class Game_524 extends MovieClip
   {
       
      
      public var jobDesk:TextField;
      
      public function Game_524()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         jobDesk.autoSize = TextFieldAutoSize.CENTER;
      }
   }
}
