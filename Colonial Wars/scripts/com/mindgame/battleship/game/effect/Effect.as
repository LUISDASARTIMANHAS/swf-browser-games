package com.mindgame.battleship.game.effect
{
   import com.mindgame.battleship.game.ship.Car;
   import com.mindgame.framework.Animation;
   import flash.display.Sprite;
   
   public class Effect extends Sprite
   {
       
      
      protected var lastAnimated:Boolean = false;
      
      protected var ship:Car;
      
      public var effectName:String;
      
      public var clip:Animation;
      
      public var endAnimated:Boolean = false;
      
      public function Effect()
      {
         super();
      }
      
      public function checkVisible() : void
      {
         if(visible)
         {
            visible = false;
         }
         else
         {
            visible = true;
         }
      }
      
      public function init() : void
      {
         addChild(this.clip);
      }
      
      public function crash() : void
      {
         this.parent.removeChild(this);
         delete global[this];
      }
      
      public function set setCar(param1:Car) : void
      {
         this.ship = param1;
         this.configurationStatus();
      }
      
      protected function configurationStatus() : void
      {
      }
      
      public function update() : void
      {
      }
   }
}
