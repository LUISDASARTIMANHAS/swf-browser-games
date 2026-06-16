package com.mindgame.battleship.game.levels
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.islands.*;
   
   public class MatrixParser
   {
       
      
      private var cellSize:int;
      
      private var cellHalfSize:int;
      
      private var _world:WorldComp;
      
      private var targetIsland:Island;
      
      public function MatrixParser()
      {
         this.cellSize = WorldComp.CELL_SIZE;
         this.cellHalfSize = WorldComp.CELL_HALF_SIZE;
         super();
      }
      
      public function parseMatrix(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         this._world = WorldComp.returnWorld;
         var _loc2_:Array = param1[0] as Array;
         var _loc3_:Object = param1[1] as Object;
         this._world.setCPUCount = _loc3_.raceCount;
         this._world.maxTimeForLevel = _loc3_.maxTime;
         this._world.mnogSecond = _loc3_.mg;
         this._world.showTooltip = Boolean(_loc3_.st);
         if(param1.length == 3)
         {
            _loc7_ = param1[2] as Object;
            this._world.setCpuDifficult(_loc7_.it,_loc7_.fi,_loc7_.bp,_loc7_.pc,_loc7_.hs,_loc7_.pi,_loc7_.an,_loc7_.ci,_loc7_.ps);
         }
         var _loc4_:int = int(_loc2_.length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = int(_loc2_[_loc6_].length);
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               if(_loc2_[_loc6_][_loc8_] != 0)
               {
                  if((_loc2_[_loc6_][_loc8_] as Object).type != 11)
                  {
                     this.changeIsland((_loc2_[_loc6_][_loc8_] as Object).type);
                     if((_loc2_[_loc6_][_loc8_] as Object).speed == undefined)
                     {
                        (_loc2_[_loc6_][_loc8_] as Object).speed = 1;
                     }
                     if((_loc2_[_loc6_][_loc8_] as Object).pA == undefined)
                     {
                        (_loc2_[_loc6_][_loc8_] as Object).pA = 10;
                     }
                     this.setIsland(_loc8_,_loc6_,(_loc2_[_loc6_][_loc8_] as Object).race,(_loc2_[_loc6_][_loc8_] as Object).people,(_loc2_[_loc6_][_loc8_] as Object).maxPeople,(_loc2_[_loc6_][_loc8_] as Object).speed,(_loc2_[_loc6_][_loc8_] as Object).pA);
                  }
                  else
                  {
                     this._world.barriers.setCoord((_loc8_ + 1) * this.cellSize - this.cellHalfSize,(_loc6_ + 1) * this.cellSize - this.cellHalfSize);
                     this._world.barriers.scaleXY = (_loc2_[_loc6_][_loc8_] as Object).size;
                  }
               }
               _loc8_++;
            }
            _loc6_++;
         }
      }
      
      private function changeIsland(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               this.targetIsland = new Island1();
               this.targetIsland.clip.rotation = int(Math.random() * 360);
               break;
            case 2:
               this.targetIsland = new Island2();
               this.targetIsland.clip.rotation = int(Math.random() * 360);
               break;
            case 3:
               this.targetIsland = new Island3();
               this.targetIsland.clip.rotation = int(Math.random() * 360);
               break;
            case 4:
               this.targetIsland = new Island4();
               this.targetIsland.clip.rotation = int(Math.random() * 360);
               break;
            case 5:
               this.targetIsland = new Island5();
               this.targetIsland.clip.rotation = int(Math.random() * 360);
               break;
            case 6:
               this.targetIsland = new Island6();
               this.targetIsland.clip.rotation = int(Math.random() * 360);
               break;
            case 9:
               this.targetIsland = new Island9();
         }
      }
      
      private function setIsland(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:int = 0, param6:Number = 1, param7:int = 10) : void
      {
         this.targetIsland.x = (param1 + 1) * this.cellSize - this.cellHalfSize;
         this.targetIsland.y = (param2 + 1) * this.cellSize - this.cellHalfSize;
         if(this._world.islandBase.allIsland[param3] == undefined)
         {
            this._world.islandBase.allIsland[param3] = [];
         }
         this.targetIsland.number = (this._world.islandBase.allIsland[param3] as Array).length;
         this.targetIsland.setSetup(param4,param5,param3,param6,param7);
         if(param3 != 0 && param3 != 1)
         {
            this.targetIsland.cpu = this._world.getCpu(param3);
            this.targetIsland.cpu.cpuRace = param3;
         }
         (this._world.islandBase.allIsland[param3] as Array).push(this.targetIsland);
      }
   }
}
