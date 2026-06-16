package com.mindgame.battleship.game.atmosphery
{
   import com.mindgame.framework.Animation;
   import flash.display.Sprite;
   
   public class AtmParent extends Sprite
   {
      
      protected static var atmosphBase:AtmospheryBase = AtmospheryBase.returnABase;
       
      
      public var endAnimation:Boolean = true;
      
      public var clip:Animation;
      
      protected var nameInManager:String;
      
      public function AtmParent()
      {
         super();
      }
      
      public function init() : void
      {
         visible = false;
         this.clip = atmosphBase.animationManager.getAnimation(this.nameInManager);
         this.clip.update();
         this.clip.pauseCheck();
         this.clip.x -= this.clip.width * 0.5;
         this.clip.y -= this.clip.height * 0.5;
         addChild(this.clip);
      }
      
      public function hide() : void
      {
         this.visible = false;
         this.clip.pauseCheck();
         this.endAnimation = true;
         this.clip.currentFrame = 0;
      }
   }
}
