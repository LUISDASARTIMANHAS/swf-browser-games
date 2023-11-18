package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_564")]
   public dynamic class Game_564 extends MovieClip
   {
       
      
      public function Game_564()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function mouseOverEvent(param1:MouseEvent) : void
      {
         gotoAndStop(3);
      }
      
      public function mouseDownEvent(param1:MouseEvent) : void
      {
         gotoAndStop(4);
      }
      
      public function mouseUpEvent(param1:MouseEvent) : void
      {
         gotoAndStop(3);
      }
      
      internal function frame1() : *
      {
         buttonMode = true;
         gotoAndStop(2);
         stop();
         addEventListener(MouseEvent.MOUSE_OVER,mouseOverEvent);
         addEventListener(MouseEvent.MOUSE_OUT,mouseOutEvent);
         addEventListener(MouseEvent.MOUSE_DOWN,mouseDownEvent);
         addEventListener(MouseEvent.MOUSE_UP,mouseUpEvent);
      }
      
      public function mouseOutEvent(param1:MouseEvent) : void
      {
         gotoAndStop(2);
      }
   }
}
