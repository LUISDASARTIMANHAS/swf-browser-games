package com.mindgame.battleship.game.effect
{
   public class Blast extends Effect
   {
       
      
      public function Blast()
      {
         super();
         if(Math.random() < 0.35)
         {
            effectName = "Blast";
         }
         else if(Math.random() < 0.5)
         {
            effectName = "Blast2";
         }
         else
         {
            effectName = "Blast3";
         }
      }
      
      override public function init() : void
      {
         clip.currentFrame = 0;
         clip.update();
         clip.y = -clip.height * 0.5;
         clip.x = -clip.width * 0.5;
         x = ship.x;
         y = ship.y;
         this.endAnimated = false;
         super.init();
      }
      
      override public function update() : void
      {
         if(clip.currentFrame < clip.totalFrames - 1)
         {
            clip.update();
         }
         else
         {
            this.endAnimated = true;
         }
      }
   }
}
