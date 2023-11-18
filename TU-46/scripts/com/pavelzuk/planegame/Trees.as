package com.pavelzuk.planegame
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="com.pavelzuk.planegame.Trees")]
   public class Trees extends Background
   {
       
      
      public var grass:MovieClip;
      
      public var water:MovieClip;
      
      public var mountains:MovieClip;
      
      public function Trees()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         this.grass.gotoAndStop(100);
      }
      
      override public function changeFrame(param1:int = 0) : void
      {
      }
      
      override public function update() : void
      {
         x = Controller.level.gameClip.x * slowDown + startX;
         y = Controller.level.gameClip.y * slowDown + startY;
         if(x < -tileWidth)
         {
            startX += tileWidth * count;
         }
         if(x > tileWidth * (count - 1))
         {
            startX -= tileWidth * count;
         }
         x = Controller.level.gameClip.x * slowDown + startX;
         y = Controller.level.gameClip.y * slowDown + startY;
         if(Controller.level.treesGoto == "waterbg")
         {
            if(this.grass.currentFrame == 100)
            {
               this.grass.play();
            }
            if(this.mountains.currentFrame == 100)
            {
               this.mountains.play();
            }
            if(this.water.currentFrame == 1)
            {
               this.water.gotoAndPlay(2);
            }
         }
         else if(Controller.level.treesGoto == "treesbg")
         {
            if(this.water.currentFrame == 100)
            {
               this.water.play();
            }
            if(this.mountains.currentFrame == 100)
            {
               this.mountains.play();
            }
            if(this.grass.currentFrame == 1)
            {
               this.grass.gotoAndPlay(2);
            }
         }
         else if(Controller.level.treesGoto == "mountainsbg")
         {
            if(this.water.currentFrame == 100)
            {
               this.water.play();
            }
            if(this.grass.currentFrame == 100)
            {
               this.grass.play();
            }
            if(this.mountains.currentFrame == 1)
            {
               this.mountains.gotoAndPlay(2);
            }
         }
      }
      
      override public function create(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:String) : void
      {
         count = param4;
         slowDown = param5;
         tileWidth = param3;
         x = tileWidth * param1 - tileWidth;
         y = param2;
         startX = x;
         startY = y;
         if(Tracker.currentCity == "brazil")
         {
            this.mountains.gotoAndStop(100);
            this.grass.gotoAndStop(1);
         }
         gotoAndStop(Controller.level.treesGoto);
         this.changeFrame(param1);
      }
   }
}
