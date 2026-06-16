package com.mindgame.battleship.game.islands
{
   public class Island9 extends Island
   {
       
      
      public function Island9()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         type = 30;
         clip = new i9();
         super.init();
      }
   }
}
