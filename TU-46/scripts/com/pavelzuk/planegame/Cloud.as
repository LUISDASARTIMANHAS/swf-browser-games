package com.pavelzuk.planegame
{
   [Embed(source="/_assets/assets.swf", symbol="com.pavelzuk.planegame.Cloud")]
   public class Cloud extends Background
   {
       
      
      public function Cloud()
      {
         super();
      }
      
      override public function update() : void
      {
         x = Controller.level.gameClip.x * slowDown + startX;
         y = Controller.level.gameClip.y * slowDown + startY;
         if(x < -tileWidth)
         {
            startX += tileWidth * count;
            this.changeFrame(0);
         }
         if(x > tileWidth * (count - 1))
         {
            startX -= tileWidth * count;
            this.changeFrame(0);
         }
         x = Controller.level.gameClip.x * slowDown + startX;
         y = Controller.level.gameClip.y * slowDown + startY;
      }
      
      override public function create(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:String) : void
      {
         count = param4;
         slowDown = param5;
         tileWidth = param3;
         x = 500 * param1 - tileWidth;
         y = Controller.level.plane.y - (Math.random() - Math.random()) * 500;
         startX = x;
         startY = y;
         gotoAndStop(param6);
         this.changeFrame(param1);
      }
      
      override public function changeFrame(param1:int = 0) : void
      {
         gotoAndStop(Math.floor(Math.random() * 5 + 1));
         startY = Controller.level.plane.y - (Math.random() - Math.random()) * 500;
         if(startY > 200)
         {
            startY = 200;
         }
      }
   }
}
