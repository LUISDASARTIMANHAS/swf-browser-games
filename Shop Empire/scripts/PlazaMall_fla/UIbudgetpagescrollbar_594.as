package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UIbudgetpagescrollbar_594")]
   public dynamic class UIbudgetpagescrollbar_594 extends MovieClip
   {
       
      
      public var line:MovieClip;
      
      public var btnScroll:SimpleButton;
      
      public function UIbudgetpagescrollbar_594()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function MouseDownEvent(param1:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_MOVE,Dragging);
         stage.addEventListener(MouseEvent.MOUSE_UP,StopDragging);
      }
      
      internal function frame1() : *
      {
         btnScroll.y = line.y;
         btnScroll.x = line.x + line.width / 2;
         btnScroll.addEventListener(MouseEvent.MOUSE_DOWN,MouseDownEvent);
      }
      
      public function Dragging(param1:MouseEvent) : void
      {
         btnScroll.y = mouseY;
         if(btnScroll.y < line.y)
         {
            btnScroll.y = line.y;
         }
         if(btnScroll.y > line.y + line.height)
         {
            btnScroll.y = line.y + line.height;
         }
      }
      
      public function StopDragging(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,Dragging);
         stage.removeEventListener(MouseEvent.MOUSE_UP,StopDragging);
      }
      
      public function getPosition() : Number
      {
         var _loc1_:* = undefined;
         return (btnScroll.y - line.y) / line.height;
      }
   }
}
