package com.mindgame.battleship.game.islands.flags
{
   public class Flag2 extends Flag
   {
       
      
      public function Flag2()
      {
         super();
      }
      
      override public function init() : void
      {
         clip = new Flag2_mc();
         super.init();
      }
   }
}
