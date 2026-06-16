package com.mindgame.battleship.game.islands
{
   public class Island1 extends Island
   {
       
      
      public function Island1()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         type = 1;
         clip = new i1();
         super.init();
      }
   }
}
