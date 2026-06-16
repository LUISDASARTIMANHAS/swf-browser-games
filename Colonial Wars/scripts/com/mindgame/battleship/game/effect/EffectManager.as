package com.mindgame.battleship.game.effect
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.ship.Car;
   import com.mindgame.framework.Animation;
   import com.mindgame.framework.AnimationManager;
   
   public class EffectManager
   {
       
      
      private var _world:WorldComp;
      
      private var animationManager:AnimationManager;
      
      private var allEffect:Array;
      
      private var k:int = 0;
      
      private var clip:Animation;
      
      public function EffectManager()
      {
         this._world = WorldComp.returnWorld;
         this.allEffect = [];
         super();
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(this.allEffect.length > _loc1_)
         {
            (this.allEffect[_loc1_] as Effect).crash();
            _loc1_++;
         }
         this.allEffect = [];
      }
      
      public function addAnimation(param1:String, param2:Car = null, param3:Boolean = true) : void
      {
         var _loc4_:Effect = null;
         if(this.animationManager == null)
         {
            this.animationManager = this._world.animationManager;
         }
         switch(param1)
         {
            case "Smoke":
               _loc4_ = new Smoke();
               break;
            case "Water1":
               _loc4_ = new Water1();
               break;
            case "Water2":
               _loc4_ = new Water2();
               break;
            case "Water3":
               _loc4_ = new Water3();
               break;
            case "Water4":
               _loc4_ = new Water4();
               break;
            case "Blast":
               _loc4_ = new Blast();
         }
         _loc4_.checkVisible();
         if(param2 != null)
         {
            _loc4_.setCar = param2;
         }
         _loc4_.clip = this.animationManager.getAnimation(_loc4_.effectName);
         _loc4_.init();
         if(param3)
         {
            this._world.effectLayer.addChild(_loc4_);
         }
         else
         {
            this._world.bottomLayer.addChild(_loc4_);
         }
         this.allEffect[this.allEffect.length] = _loc4_;
         _loc4_.checkVisible();
      }
      
      public function update() : void
      {
         this.k = 0;
         while(this.k < this.allEffect.length)
         {
            if((this.allEffect[this.k] as Effect).endAnimated)
            {
               (this.allEffect[this.k] as Effect).crash();
               this.allEffect.splice(this.k,1);
            }
            else
            {
               (this.allEffect[this.k] as Effect).update();
            }
            ++this.k;
         }
      }
   }
}
