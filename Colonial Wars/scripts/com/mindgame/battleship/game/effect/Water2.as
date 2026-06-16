package com.mindgame.battleship.game.effect
{
   public class Water2 extends Effect
   {
       
      
      public function Water2()
      {
         super();
         effectName = "Water2";
      }
      
      override public function init() : void
      {
         clip.update();
         clip.x = -clip.width * 0.55;
         clip.y = -clip.height * 0.555;
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
