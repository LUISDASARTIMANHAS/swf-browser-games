package com.pavelzuk.planegame
{
   import flash.display.MovieClip;
   
   public class Background extends MovieClip
   {
       
      
      public var slowDown:Number = 0;
      
      public var count:Number = 0;
      
      public var startX:Number = 0;
      
      public var startY:Number = 0;
      
      public var tileWidth:Number = 0;
      
      public function Background()
      {
         super();
      }
      
      public function update() : void
      {
         x = Controller.level.gameClip.x * this.slowDown + this.startX;
         y = Controller.level.gameClip.y * this.slowDown + this.startY;
         if(x < -this.tileWidth)
         {
            this.startX += this.tileWidth * this.count;
         }
         if(x > this.tileWidth * (this.count - 1))
         {
            this.startX -= this.tileWidth * this.count;
         }
         x = Controller.level.gameClip.x * this.slowDown + this.startX;
         y = Controller.level.gameClip.y * this.slowDown + this.startY;
      }
      
      public function create(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:String) : void
      {
         this.count = param4;
         this.slowDown = param5;
         this.tileWidth = param3;
         x = this.tileWidth * param1 - this.tileWidth;
         y = param2;
         this.startX = x;
         this.startY = y;
         this.changeFrame(param1);
      }
      
      public function changeFrame(param1:int = 0) : void
      {
      }
   }
}
