package com.mindgame.battleship.game.ship
{
   public class Air3 extends Car
   {
       
      
      public function Air3()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         nameInManager = "Air3";
         super.init();
      }
   }
}
