package com.mindgame.battleship.game.atmosphery
{
   import com.mindgame.framework.*;
   
   public class SharkFin extends AtmParent
   {
       
      
      private var speed:Evector;
      
      public function SharkFin()
      {
         this.speed = new Evector();
         super();
      }
      
      override public function init() : void
      {
         nameInManager = "Fin";
         super.init();
      }
      
      public function setPosition(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
         endAnimation = false;
         visible = true;
         clip.pauseCheck();
      }
      
      public function update() : void
      {
         if(clip.currentFrame == clip.totalFrames - 2)
         {
            hide();
         }
         else
         {
            clip.update();
         }
      }
   }
}
