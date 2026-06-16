package com.mindgame.battleship.game.ship
{
   public class Air2 extends Car
   {
       
      
      public function Air2()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         nameInManager = "Air2";
         super.init();
      }
   }
}
