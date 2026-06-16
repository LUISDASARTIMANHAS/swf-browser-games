package com.mindgame.battleship.game.islands.flags
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.islands.Island;
   
   public class FlagBase
   {
       
      
      private var writeFlags:Array;
      
      private var _world:WorldComp;
      
      public function FlagBase()
      {
         this.writeFlags = [];
         this._world = WorldComp.returnWorld;
         super();
      }
      
      public function addIsland(param1:Island) : void
      {
         if(param1.flag != null)
         {
            if(param1.getRace == param1.flag.race)
            {
               this.writeFlags[this.writeFlags.length] = param1.flag;
            }
            else
            {
               param1.flag.remove();
               this.setRaceFlag(param1);
            }
         }
         else
         {
            this.setRaceFlag(param1);
         }
      }
      
      private function setRaceFlag(param1:Island) : void
      {
         var _loc2_:Flag = null;
         switch(param1.getRace)
         {
            case 1:
               _loc2_ = new Flag1();
               break;
            case 2:
               _loc2_ = new Flag2();
               break;
            case 3:
               _loc2_ = new Flag3();
               break;
            case 4:
               _loc2_ = new Flag4();
         }
         _loc2_.init();
         _loc2_.setPosition(param1.x,param1.y,true);
         param1.flag = _loc2_;
         this.writeFlags[this.writeFlags.length] = _loc2_;
         _loc2_.island = param1;
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.writeFlags.length)
         {
            this.writeFlags[_loc1_].remove();
            _loc1_++;
         }
         this.writeFlags = [];
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.writeFlags.length)
         {
            if((this.writeFlags[_loc1_] as Flag).visible == false)
            {
               (this.writeFlags[_loc1_] as Flag).update();
            }
            else
            {
               this.writeFlags[_loc1_].endShow();
               this.writeFlags.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
   }
}
