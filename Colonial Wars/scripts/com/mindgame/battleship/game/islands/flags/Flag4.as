package com.mindgame.battleship.game.islands.flags
{
   public class Flag4 extends Flag
   {
       
      
      public function Flag4()
      {
         super();
      }
      
      override public function init() : void
      {
         clip = new Flag4_mc();
         super.init();
      }
   }
}
