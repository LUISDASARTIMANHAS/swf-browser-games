package com.mindgame.battleship.game.atmosphery
{
   import com.mindgame.battleship.*;
   
   public class Birds extends AtmParent
   {
       
      
      public function Birds()
      {
         super();
      }
      
      override public function init() : void
      {
         nameInManager = "Bird";
         super.init();
      }
      
      public function setPosition(param1:int, param2:int, param3:int) : void
      {
         this.x = param1;
         this.y = param2;
         endAnimation = false;
         visible = true;
         clip.pauseCheck();
         App.soundManager.playShortSound("birds");
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
