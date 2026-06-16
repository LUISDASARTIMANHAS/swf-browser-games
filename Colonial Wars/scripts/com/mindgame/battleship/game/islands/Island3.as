package com.mindgame.battleship.game.islands
{
   public class Island3 extends Island
   {
       
      
      public function Island3()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         type = 2;
         clip = new i3();
         super.init();
      }
   }
}
