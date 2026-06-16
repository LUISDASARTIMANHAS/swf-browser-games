package com.mindgame.battleship.game.effect
{
   public class Water4 extends Effect
   {
       
      
      public function Water4()
      {
         super();
         effectName = "Water4";
      }
      
      override public function init() : void
      {
         clip.update();
         clip.x = -clip.width * 0.6;
         clip.y = -clip.height * 0.5;
         super.init();
      }
      
      override protected function configurationStatus() : void
      {
         if(ship.haveDest)
         {
            rotation = ship.rotation;
            x = ship.x;
            y = ship.y;
         }
      }
      
      override public function update() : void
      {
         if(ship.haveDest)
         {
            this.configurationStatus();
            if(clip.currentFrame < clip.totalFrames - 1)
            {
               clip.update();
            }
            else
            {
               clip.currentFrame = 0;
            }
         }
         else
         {
            this.endAnimated = true;
         }
      }
   }
}
