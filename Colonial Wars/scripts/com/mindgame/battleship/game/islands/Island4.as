package com.mindgame.battleship.game.islands
{
   public class Island4 extends Island
   {
       
      
      public function Island4()
      {
         super();
         this.init();
      }
      
      override protected function init() : void
      {
         type = 2;
         clip = new i4();
         super.init();
      }
   }
}
