package com.mindgame.battleship.game.ship
{
   public class Air1 extends Car
   {
       
      
      public function Air1()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         nameInManager = "Air1";
         super.init();
      }
   }
}
