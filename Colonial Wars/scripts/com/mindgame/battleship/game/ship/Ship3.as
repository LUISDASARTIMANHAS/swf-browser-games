package com.mindgame.battleship.game.ship
{
   import com.mindgame.battleship.game.islands.Island;
   
   public class Ship3 extends Car
   {
       
      
      public function Ship3()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         nameInManager = "Ship3";
         effectName = "Water2";
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
