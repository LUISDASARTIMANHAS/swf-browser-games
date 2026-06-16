package com.mindgame.battleship.game.atmosphery
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.framework.*;
   
   public class Whale extends AtmParent
   {
       
      
      private var speed:Evector;
      
      public function Whale()
      {
         this.speed = new Evector();
         super();
      }
      
      override public function init() : void
      {
         nameInManager = "Fish";
         super.init();
      }
      
      public function setPosition(param1:int, param2:int, param3:int) : void
      {
         this.x = param1;
         this.y = param2;
         this.rotation = param3;
         this.speed.asSpeed(30 / WorldComp.fps,Emath.toRadians(param3));
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
            this.x += this.speed.x;
            this.y += this.speed.y;
         }
      }
   }
}
