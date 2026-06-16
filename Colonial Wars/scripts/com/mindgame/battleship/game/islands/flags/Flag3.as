package com.mindgame.battleship.game.islands.flags
{
   public class Flag3 extends Flag
   {
       
      
      public function Flag3()
      {
         super();
      }
      
      override public function init() : void
      {
         clip = new Flag3_mc();
         super.init();
      }
   }
}
