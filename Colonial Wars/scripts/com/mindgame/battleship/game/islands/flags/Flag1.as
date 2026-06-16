package com.mindgame.battleship.game.islands.flags
{
   public class Flag1 extends Flag
   {
       
      
      public function Flag1()
      {
         super();
      }
      
      override public function init() : void
      {
         clip = new Flag1_mc();
         super.init();
      }
   }
}
