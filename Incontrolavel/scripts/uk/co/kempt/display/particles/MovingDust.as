package uk.co.kempt.display.particles
{
   import flash.events.Event;
   import uk.co.kempt.display.PlayOnce;
   
   public class MovingDust extends PlayOnce
   {
      
      private static const DEFAULT_FRICTION:Number = 0.99;
       
      
      private var _speedX:Number = 0;
      
      private var _speedY:Number = 0;
      
      private var _friction:Number = 0.99;
      
      public function MovingDust()
      {
         super();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameEvent,false,0,true);
      }
      
      public function get speedY() : Number
      {
         return this._speedY;
      }
      
      public function set speedY(param1:Number) : void
      {
         this._speedY = param1;
      }
      
      private function onEnterFrameEvent(param1:Event) : void
      {
         x += this.speedX;
         y += this.speedY;
         this.speedX *= this.friction;
      }
      
      public function set speedX(param1:Number) : void
      {
         this._speedX = param1;
      }
      
      public function set friction(param1:Number) : void
      {
         this._friction = param1;
      }
      
      public function get speedX() : Number
      {
         return this._speedX;
      }
      
      public function get friction() : Number
      {
         return this._friction;
      }
   }
}
