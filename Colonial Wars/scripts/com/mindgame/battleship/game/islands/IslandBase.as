package com.mindgame.battleship.game.islands
{
   import com.mindgame.battleship.Worlds.*;
   
   public class IslandBase
   {
       
      
      public var allIsland:Array;
      
      private var _world:WorldComp;
      
      private var delta:Number;
      
      private var counter:int;
      
      private var mnog:int = 1;
      
      private var num:int = 1;
      
      private var playerRace:int;
      
      private var raceCount:int;
      
      private var neutral:int = 4;
      
      private var neutralCount:int;
      
      public function IslandBase()
      {
         this.allIsland = [];
         this.neutralCount = this.neutral;
         super();
      }
      
      public function init() : void
      {
         this._world = WorldComp.returnWorld;
         this.delta = WorldComp.fps;
         this.counter = this.delta * this.mnog;
         this.playerRace = this._world.playerRace;
         this.raceCount = this._world.raceCount;
      }
      
      public function clear() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.allIsland.length)
         {
            _loc2_ = 0;
            while(_loc2_ < (this.allIsland[_loc1_] as Array).length)
            {
               ((this.allIsland[_loc1_] as Array)[_loc2_] as Island).destroyIsland();
               _loc2_++;
            }
            _loc1_++;
         }
         this.allIsland = [];
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!Island.firstStep)
         {
            if(this.counter <= 0)
            {
               _loc1_ = 0;
               while(_loc1_ < this.allIsland.length)
               {
                  if(_loc1_ != 0)
                  {
                     _loc2_ = 0;
                     while(_loc2_ < (this.allIsland[_loc1_] as Array).length)
                     {
                        if(_loc1_ != this.playerRace)
                        {
                           (this.allIsland[_loc1_][_loc2_] as Island).timerPlusPeople = (this.allIsland[_loc1_][_loc2_] as Island).speedRegeneration;
                        }
                        else
                        {
                           (this.allIsland[_loc1_][_loc2_] as Island).timerPlusPeople = (this.allIsland[_loc1_][_loc2_] as Island).speedRegeneration + this._world.upgradeRegenUp;
                        }
                        _loc2_++;
                     }
                  }
                  else if(this.neutralCount <= 0)
                  {
                     _loc2_ = 0;
                     while(_loc2_ < (this.allIsland[_loc1_] as Array).length)
                     {
                        (this.allIsland[_loc1_][_loc2_] as Island).timerPlusPeople = (this.allIsland[_loc1_][_loc2_] as Island).speedRegeneration;
                        _loc2_++;
                     }
                     this.neutralCount = this.neutral;
                  }
                  else
                  {
                     --this.neutralCount;
                  }
                  _loc1_++;
               }
               this.counter = this.delta * this.mnog;
            }
            else
            {
               --this.counter;
            }
            this.flagWrite();
         }
      }
      
      public function flagWrite() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.allIsland.length)
         {
            if(_loc1_ != 0)
            {
               _loc2_ = 0;
               while(_loc2_ < (this.allIsland[_loc1_] as Array).length)
               {
                  if(!(this.allIsland[_loc1_][_loc2_] as Island).showFlag)
                  {
                     if((this.allIsland[_loc1_][_loc2_] as Island).minusShowFlagTime())
                     {
                        (this.allIsland[_loc1_][_loc2_] as Island).showFlag = true;
                        this._world.flagBase.addIsland(this.allIsland[_loc1_][_loc2_] as Island);
                     }
                  }
                  _loc2_++;
               }
            }
            _loc1_++;
         }
      }
      
      public function changeButtonMode(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.allIsland.length)
         {
            _loc3_ = 0;
            while(_loc3_ < (this.allIsland[_loc2_] as Array).length)
            {
               if(_loc2_ == this.playerRace)
               {
                  ((this.allIsland[_loc2_] as Array)[_loc3_] as Island).buttonMode = true;
               }
               else
               {
                  ((this.allIsland[_loc2_] as Array)[_loc3_] as Island).buttonMode = param1;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function checkRaceIsland(param1:Island, param2:int, param3:int) : void
      {
         param1.people = param2 - param1.people + param1.plusArmy;
         this.transferIslands(param1,param1.getRace,param3,param1.number);
         if(this.checkIslands(param1.getRace))
         {
            if(param1.getRace == this.playerRace)
            {
               this.changeButtonMode(Island.haveSelect);
               param1.changeRace(param3);
               this._world.playerLose();
               return;
            }
            ++this._world.killedRace;
         }
         if(param1.selected && param3 != this.playerRace)
         {
            param1.selected = false;
            Island.haveSelect = false;
         }
         this._world.killedRace = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.allIsland.length)
         {
            if((this.allIsland[_loc4_] as Array).length == 0)
            {
               ++this._world.killedRace;
            }
            _loc4_++;
         }
         param1.changeRace(param3);
         if(this._world.killedRace == this._world.raceCount - 1)
         {
            this._world.playerWin();
         }
         this.changeButtonMode(Island.haveSelect);
      }
      
      public function transferIslands(param1:Island, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:int = 0;
         if(this.allIsland.length > 0)
         {
            if(param1 == null)
            {
               return;
            }
            param1.number = (this.allIsland[param3] as Array).length;
            if(this.allIsland[param3] as Array != null)
            {
               (this.allIsland[param3] as Array)[(this.allIsland[param3] as Array).length] = param1;
            }
            if(this.allIsland[param2] as Array != null)
            {
               (this.allIsland[param2] as Array).splice(param4,1);
            }
            if(param3 != this._world.nautralRace && param3 != this._world.playerRace)
            {
               param1.cpu = this._world.getCpu(param3);
            }
            if(this.allIsland[param2] != undefined)
            {
               _loc5_ = 0;
               while(_loc5_ < (this.allIsland[param2] as Array).length)
               {
                  if(this.allIsland[param2][_loc5_] as Island != null)
                  {
                     (this.allIsland[param2][_loc5_] as Island).number = _loc5_;
                  }
                  _loc5_++;
               }
            }
         }
         if(param2 == this.playerRace)
         {
            this._world.soundManager.playShortSound("capture");
            if(param1.clip)
            {
               param1.clip.island.border.visible = false;
            }
         }
      }
      
      public function checkIslands(param1:int) : Boolean
      {
         if(this.allIsland.length > 0)
         {
            if(param1 == this.playerRace)
            {
               if((this.allIsland[param1] as Array).length <= 0)
               {
                  return true;
               }
            }
            if((this.allIsland[param1] as Array).length <= 0)
            {
               this._world.shipBase.deactivatedRace[this._world.shipBase.deactivatedRace.length] = param1;
               return true;
            }
            return false;
         }
         return null;
      }
      
      public function get getAllIsland() : Array
      {
         return this.allIsland;
      }
   }
}
