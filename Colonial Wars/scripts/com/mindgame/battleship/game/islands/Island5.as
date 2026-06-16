package com.mindgame.battleship.game.islands
{
   public class Island5 extends Island
   {
       
      
      public function Island5()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         type = 3;
         clip = new i5();
         super.init();
      }
   }
}
