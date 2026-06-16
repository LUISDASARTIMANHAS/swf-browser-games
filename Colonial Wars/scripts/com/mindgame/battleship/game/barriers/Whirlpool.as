package com.mindgame.battleship.game.barriers
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.*;
   import com.mindgame.battleship.game.ship.*;
   import com.mindgame.framework.Animation;
   import flash.display.Sprite;
   
   public class Whirlpool extends Sprite
   {
      
      public static var rotateSpeed:Number = 1;
       
      
      private var _world:WorldComp;
      
      public var animation:Animation;
      
      private var names:String = "Whirlpool";
      
      public function Whirlpool()
      {
         this._world = WorldComp.returnWorld;
         super();
      }
      
      public function init(param1:int = 0, param2:int = 0, param3:Number = 2) : void
      {
         this._world.animationManager.addAnimation(this.names,"Whirlpool_mc",param3);
         this.animation = this._world.animationManager.getAnimation(this.names);
         this.animation.update();
         this.addChild(this.animation);
         this.x = param1;
         this.y = param2;
         this.animation.x = -this.animation.width * 0.5;
         this.animation.y = -this.animation.height * 0.5;
         this._world.islands.addChild(this);
         CPUv2.whirpoolXY.x = x;
         CPUv2.whirpoolXY.y = y;
         CPUv2.whirpool = this;
         Car.whirpool = this;
      }
      
      public function remove() : void
      {
         this._world.islands.removeChild(this);
         this._world.animationManager.clear(this.names);
         this.animation.remove();
         this.animation = null;
         delete global[this];
      }
      
      private function rotateThis() : void
      {
         this.rotation += rotateSpeed;
      }
      
      public function update() : void
      {
         this.animation.update();
         this.rotateThis();
      }
   }
}
