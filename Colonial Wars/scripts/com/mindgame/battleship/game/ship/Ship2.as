package com.mindgame.battleship.game.ship
{
   import com.mindgame.battleship.game.islands.Island;
   
   public class Ship2 extends Car
   {
       
      
      public function Ship2()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         nameInManager = "Ship2";
         effectName = "Water4";
         super.init();
      }
      
      override public function setWay(param1:int, param2:int, param3:Island, param4:Island) : void
      {
         super.setWay(param1,param2,param3,param4);
         if(haveDest)
         {
            _world.effectManager.addAnimation(effectName,this,false);
         }
      }
   }
}
