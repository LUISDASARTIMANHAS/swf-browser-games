package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Menu_468")]
   public dynamic class Menu_468 extends MovieClip
   {
       
      
      public var body:MovieClip;
      
      public function Menu_468()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function MouseDownEvent(param1:MouseEvent) : void
      {
         gotoAndStop("DOWN");
      }
      
      public function MouseOverEvent(param1:MouseEvent) : void
      {
         gotoAndStop("OVER");
      }
      
      internal function frame1() : *
      {
         this.buttonMode = true;
         addEventListener(MouseEvent.MOUSE_OVER,MouseOverEvent);
         addEventListener(MouseEvent.MOUSE_OUT,MouseOutEvent);
         addEventListener(MouseEvent.MOUSE_DOWN,MouseDownEvent);
         addEventListener(MouseEvent.MOUSE_UP,MouseUpEvent);
         gotoAndStop("NEUTRAL");
      }
      
      public function MouseOutEvent(param1:MouseEvent) : void
      {
         gotoAndStop("NEUTRAL");
      }
      
      public function MouseUpEvent(param1:MouseEvent) : void
      {
         gotoAndStop("OVER");
      }
   }
}
