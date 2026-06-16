package com.mindgame.battleship.game.islands
{
   public class Island6 extends Island
   {
       
      
      public function Island6()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         type = 4;
         clip = new i6();
         super.init();
      }
   }
}
