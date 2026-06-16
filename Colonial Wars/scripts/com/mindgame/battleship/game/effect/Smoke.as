package com.mindgame.battleship.game.effect
{
   public class Smoke extends Effect
   {
       
      
      public function Smoke()
      {
         super();
         effectName = "Smoke";
      }
      
      override public function init() : void
      {
         clip.currentFrame = 0;
         clip.update();
         clip.y = -clip.height * 0.5;
         this.endAnimated = false;
         super.init();
      }
      
      override protected function configurationStatus() : void
      {
         if(ship.haveDest)
         {
            rotation = ship.rotation - 180;
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
