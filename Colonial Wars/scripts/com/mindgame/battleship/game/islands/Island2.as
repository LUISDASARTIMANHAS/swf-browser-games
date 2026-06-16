package com.mindgame.battleship.game.islands
{
   public class Island2 extends Island
   {
       
      
      public function Island2()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         type = 2;
         clip = new i2();
         super.init();
      }
   }
}
