package com.mindgame.framework
{
   public class AnimationManager
   {
       
      
      private var animations:Object;
      
      internal var animation:Animation;
      
      public function AnimationManager()
      {
         this.animations = new Object();
         super();
      }
      
      public function addAnimation(param1:String, param2:String, param3:Number = 2) : void
      {
         if(!this.animations[param1] || param1 == "Whirlpool")
         {
            this.animation = new Animation();
            switch(param1)
            {
               case "Fish":
                  this.animation.scaleXY = 0.3;
                  break;
               case "Fin":
                  this.animation.scaleXY = 1.1;
                  break;
               case "Ship1":
                  this.animation.scaleXY = 0.65;
                  break;
               case "Ship2":
                  this.animation.scaleXY = 0.45;
                  break;
               case "Ship3":
                  this.animation.scaleXY = 0.9;
                  break;
               case "Ship4":
                  this.animation.scaleXY = 0.75;
                  break;
               case "Air1":
                  this.animation.scaleXY = 1;
                  break;
               case "Air2":
                  this.animation.scaleXY = 0.9;
                  break;
               case "Air3":
                  this.animation.scaleXY = 0.45;
                  break;
               case "Air4":
                  this.animation.scaleXY = 0.9;
                  break;
               case "Smoke":
                  this.animation.scaleXY = 1;
                  break;
               case "Water1":
                  this.animation.scaleXY = 0.83;
                  break;
               case "Water2":
                  this.animation.scaleXY = 1;
                  break;
               case "Water3":
                  this.animation.scaleXY = 0.5;
                  break;
               case "Water4":
                  this.animation.scaleXY = 0.63;
                  break;
               case "Pause":
                  this.animation.scaleXY = 1;
                  break;
               case "Whirlpool":
                  this.animation.scaleXY = param3;
                  break;
               case "Blast":
                  this.animation.scaleXY = 1.5;
                  break;
               case "Blast2":
                  this.animation.scaleXY = 1.3;
                  break;
               case "Blast3":
                  this.animation.scaleXY = 1.3;
                  break;
               case "Bird":
                  this.animation.scaleXY = 1;
                  break;
               default:
                  this.animation.scaleXY = 1;
            }
            this.animation.buildCacheFromLibrary(param2);
            this.animations[param1] = this.animation;
            this.animation = null;
         }
      }
      
      public function clear(param1:String) : void
      {
         if(this.animations[param1])
         {
            (this.animations[param1] as Animation).remove();
            this.animations[param1] = null;
         }
      }
      
      public function getAnimation(param1:String) : Animation
      {
         if(!this.animations[param1])
         {
            return null;
         }
         this.animation = new Animation();
         this.animation.frames = (this.animations[param1] as Animation).frames;
         return this.animation;
      }
   }
}
