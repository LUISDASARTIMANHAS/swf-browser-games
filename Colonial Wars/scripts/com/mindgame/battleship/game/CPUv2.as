package com.mindgame.battleship.game
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.barriers.Whirlpool;
   import com.mindgame.battleship.game.islands.*;
   import com.mindgame.battleship.game.ship.ShipBase;
   import com.mindgame.framework.*;
   import flash.geom.*;
   
   public class CPUv2
   {
      
      public static var whirpoolXY:Point = new Point();
      
      public static var whirpool:Whirlpool;
       
      
      private var _world:WorldComp;
      
      private var fps:int;
      
      private var fpsCounter:Number;
      
      public var cpuRace:int;
      
      private var neutralRace:int;
      
      private var playerRace:int;
      
      private var shipBase:ShipBase;
      
      private var targetIsland:Island;
      
      private var stockIsland:Island;
      
      private var biggestIsland:Island;
      
      private var bigIsland:Island;
      
      private var allIsland:Array;
      
      private var allEnemyIsland:Array;
      
      private var mainIsland:Array;
      
      private var bubble:int;
      
      private var summPeopleCpu:int;
      
      private var canAttack:Boolean = false;
      
      public var playerStep:Boolean = false;
      
      private var haveIsland:Boolean = true;
      
      private var neutralIsland:Array;
      
      public var iteration:Number = 1;
      
      public var freeIteration:Number = 0;
      
      public var bubbleForPlayer:Number = 0;
      
      public var populControl:Number = 0;
      
      public var helpShip:Number = 0;
      
      public var protectIsland:Number = 0;
      
      public var cpuAttackNeutral:Number = 0;
      
      public var cpuChangeIslandForAttack:Number = 0;
      
      public var playerStepd:int = 0;
      
      public function CPUv2()
      {
         this._world = WorldComp.returnWorld;
         this.fps = WorldComp.fps;
         this.fpsCounter = this.fps * this.iteration;
         this.neutralRace = this._world.nautralRace;
         this.playerRace = this._world.playerRace;
         this.shipBase = this._world.shipBase;
         this.allIsland = this._world.islandBase.allIsland;
         this.allEnemyIsland = [];
         this.bubble = this.cpuRace;
         this.neutralIsland = [];
         super();
      }
      
      public function playerStepNow() : void
      {
         if(this.playerStepd - 1 <= 0)
         {
            this.playerStep = true;
         }
         else
         {
            --this.playerStepd;
         }
      }
      
      public function protectedIsland(param1:int, param2:Island) : void
      {
         if(XORRandom.random < this.protectIsland)
         {
            if(this._world.barriers.setBarrier)
            {
               if(param2.people < param1 && param2.getRace == this.cpuRace)
               {
                  this.biggestIslandCpuWithWhirpool();
                  if(this.bigIsland != param2 && param2.getRace == this.cpuRace)
                  {
                     this.shipBase.startIsland = this.bigIsland;
                     this.shipBase.finalIsland = param2;
                     this.shipBase.startShipMove(this.cpuRace);
                  }
               }
            }
            else
            {
               this.checkMyIsland();
               if(param2.people < param1 && param2.getRace == this.cpuRace)
               {
                  this.biggestIslandCpu();
                  if(this.biggestIsland != param2 && param2.getRace == this.cpuRace)
                  {
                     this.shipBase.startIsland = this.biggestIsland;
                     this.shipBase.finalIsland = param2;
                     this.shipBase.startShipMove(this.cpuRace);
                  }
               }
            }
         }
      }
      
      private function leastPopulatedNeutral() : void
      {
         var _loc1_:int = 0;
         this.checkNeutralIsland();
         if(this.neutralIsland.length <= 0)
         {
            this.leastPopulated();
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.neutralIsland.length)
            {
               if(this.targetIsland == null)
               {
                  this.targetIsland = this.neutralIsland[_loc1_] as Island;
               }
               if(this.targetIsland.people > (this.neutralIsland[_loc1_] as Island).people)
               {
                  this.targetIsland = this.neutralIsland[_loc1_] as Island;
               }
               else if(this.targetIsland.people == (this.neutralIsland[_loc1_] as Island).people)
               {
                  if(Emath.distance(this.biggestIsland.x,this.biggestIsland.y,this.targetIsland.x,this.targetIsland.y) > Emath.distance(this.biggestIsland.x,this.biggestIsland.y,(this.neutralIsland[_loc1_] as Island).x,(this.neutralIsland[_loc1_] as Island).y))
                  {
                     this.targetIsland = this.neutralIsland[_loc1_] as Island;
                  }
               }
               _loc1_++;
            }
            if(this.targetIsland.people > this.biggestIsland.people)
            {
               if(XORRandom.random < this.cpuChangeIslandForAttack)
               {
                  this.leastPopulated();
               }
            }
            if(this.targetIsland.getRace == this.cpuRace)
            {
               this.canAttack = false;
            }
            else
            {
               this.canAttack = true;
            }
         }
      }
      
      private function randomRaceForAttack() : void
      {
         if(XORRandom.random < this.cpuAttackNeutral)
         {
            this.leastPopulatedNeutral();
         }
         else if(XORRandom.random < this.bubbleForPlayer)
         {
            this.leastPopulatedNeutral();
         }
         else
         {
            this.leastPopulated();
         }
         this.attack();
      }
      
      private function havingSecureIsland() : void
      {
         var _loc1_:int = 10;
         var _loc2_:int = 0;
         this.targetIsland = this.allEnemyIsland[_loc2_] as Island;
         while(!this.checkPresenceWhirpool())
         {
            this.targetIsland = this.allEnemyIsland[_loc2_] as Island;
            _loc2_++;
            if(_loc1_ < 0)
            {
               break;
            }
            _loc1_--;
            if(_loc2_ >= this.allEnemyIsland.length)
            {
               break;
            }
         }
         if(this.targetIsland.getRace == this.cpuRace)
         {
            this.canAttack = false;
         }
         else
         {
            this.canAttack = true;
         }
         this.attackWithWhirpool();
      }
      
      private function attackWithWhirpool() : void
      {
         if(this.canAttack)
         {
            if(this.mainIsland.length > 1)
            {
               this.shipBase.startIsland = this.bigIsland;
               this.shipBase.finalIsland = this.targetIsland;
               this.shipBase.startShipMove(this.cpuRace);
            }
            else
            {
               this.shipBase.startIsland = this.mainIsland[0] as Island;
               this.shipBase.finalIsland = this.targetIsland;
               this.shipBase.startShipMove(this.cpuRace);
            }
         }
      }
      
      private function biggestIslandCpuWithWhirpool() : void
      {
         if(this.bigIsland == null)
         {
            if(this.mainIsland.length == 0)
            {
               this.checkMyIsland();
            }
            else
            {
               this.bigIsland = this.mainIsland[0] as Island;
            }
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.mainIsland.length)
         {
            if(this.bigIsland.people < (this.mainIsland[_loc1_] as Island).people)
            {
               this.bigIsland = this.mainIsland[_loc1_] as Island;
            }
            _loc1_++;
         }
      }
      
      private function writeAllEnemyIsl() : void
      {
         var _loc2_:int = 0;
         this.allEnemyIsland = [];
         var _loc1_:int = 0;
         while(_loc1_ < this.allIsland.length)
         {
            if(_loc1_ != this.cpuRace)
            {
               _loc2_ = 0;
               while(_loc2_ < (this.allIsland[_loc1_] as Array).length)
               {
                  this.allEnemyIsland[this.allEnemyIsland.length] = (this.allIsland[_loc1_] as Array)[_loc2_] as Island;
                  _loc2_++;
               }
            }
            _loc1_++;
         }
         this.sortAllEnemyIsland();
      }
      
      private function write() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.allEnemyIsland.length)
         {
            _loc1_++;
         }
      }
      
      private function sortAllEnemyIsland() : void
      {
         var _loc1_:Island = null;
         var _loc2_:Object = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.allEnemyIsland.length)
         {
            _loc1_ = this.allEnemyIsland[_loc3_] as Island;
            _loc2_ = {
               "isl":this.allEnemyIsland[_loc3_] as Island,
               "num":_loc3_
            };
            _loc4_ = _loc3_;
            while(_loc4_ < this.allEnemyIsland.length)
            {
               if(_loc2_.isl.people >= (this.allEnemyIsland[_loc4_] as Island).people)
               {
                  _loc2_ = {
                     "isl":this.allEnemyIsland[_loc4_] as Island,
                     "num":_loc4_
                  };
               }
               _loc4_++;
            }
            this.allEnemyIsland[_loc2_.num] = _loc1_;
            this.allEnemyIsland[_loc3_] = _loc2_.isl;
            _loc3_++;
         }
      }
      
      private function leastPopulatedWithWhirpool() : void
      {
         if(this.targetIsland == null)
         {
            if(this.allEnemyIsland.length > 0)
            {
               this.targetIsland = this.allEnemyIsland[0];
            }
            else
            {
               this.writeAllEnemyIsl();
            }
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.allEnemyIsland.length)
         {
            if(this.targetIsland.people > (this.allEnemyIsland[_loc1_] as Island).people)
            {
            }
            _loc1_++;
         }
      }
      
      private function checkPresenceWhirpool() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = Number(Emath.toDegrees(Emath.getAngle(this.bigIsland.x,this.bigIsland.y,this.targetIsland.x,this.targetIsland.y)));
         var _loc3_:Number = Number(Emath.toDegrees(Emath.getAngle(this.bigIsland.x,this.bigIsland.y,whirpoolXY.x,whirpoolXY.y)));
         var _loc4_:Number = _loc3_ + 90;
         var _loc5_:Number = _loc3_ - 90;
         var _loc6_:Evector = new Evector();
         var _loc7_:Evector = new Evector();
         _loc6_.asSpeed(whirpool.width * 0.3,Emath.toRadians(_loc4_));
         _loc7_.asSpeed(whirpool.width * 0.3,Emath.toRadians(_loc5_));
         var _loc8_:Point = new Point(whirpoolXY.x + _loc6_.x,whirpoolXY.y + _loc6_.y);
         var _loc9_:Point = new Point(whirpoolXY.x + _loc7_.x,whirpoolXY.y + _loc7_.y);
         var _loc10_:Number = Number(Emath.toDegrees(Emath.getAngle(this.bigIsland.x,this.bigIsland.y,_loc8_.x,_loc8_.y)));
         var _loc11_:Number = Number(Emath.toDegrees(Emath.getAngle(this.bigIsland.x,this.bigIsland.y,_loc9_.x,_loc9_.y)));
         if(_loc10_ - _loc11_ > 180)
         {
            if((_loc11_ += 360) - 360 - _loc2_ > 0 && _loc11_ - 360 - _loc2_ < _loc11_ - _loc10_)
            {
               _loc1_ = false;
            }
            else
            {
               _loc1_ = true;
            }
         }
         else if(_loc11_ - _loc10_ > 180)
         {
            if((_loc10_ += 360) - 360 - _loc2_ > 0 && _loc10_ - 360 - _loc2_ < _loc10_ - _loc11_)
            {
               _loc1_ = false;
            }
            else
            {
               _loc1_ = true;
            }
         }
         else if(_loc11_ > _loc10_)
         {
            if(_loc11_ - _loc2_ > 0 && _loc11_ - _loc2_ < _loc11_ - _loc10_)
            {
               _loc1_ = false;
            }
            else
            {
               _loc1_ = true;
            }
         }
         else if(_loc10_ - _loc2_ > 0 && _loc10_ - _loc2_ < _loc10_ - _loc11_)
         {
            _loc1_ = false;
         }
         else
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function leastPopulated() : void
      {
         var _loc2_:int = 0;
         this.targetIsland = null;
         if((this.allIsland[this.neutralRace] as Array).length > 0)
         {
            if(XORRandom.random < this.bubbleForPlayer)
            {
               this.bubble = this.playerRace;
            }
            else
            {
               this.bubble = this.cpuRace;
            }
         }
         else
         {
            this.bubble = this.cpuRace;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.allIsland.length)
         {
            if(_loc1_ != this.cpuRace && _loc1_ != this.bubble)
            {
               _loc2_ = 0;
               while(_loc2_ < (this.allIsland[_loc1_] as Array).length)
               {
                  if(this.targetIsland == null)
                  {
                     this.targetIsland = (this.allIsland[_loc1_] as Array)[_loc2_] as Island;
                  }
                  if(this.targetIsland.people > ((this.allIsland[_loc1_] as Array)[_loc2_] as Island).people)
                  {
                     this.targetIsland = (this.allIsland[_loc1_] as Array)[_loc2_] as Island;
                  }
                  else if(this.targetIsland.people == ((this.allIsland[_loc1_] as Array)[_loc2_] as Island).people)
                  {
                     if(Emath.distance(this.biggestIsland.x,this.biggestIsland.y,this.targetIsland.x,this.targetIsland.y) > Emath.distance(this.biggestIsland.x,this.biggestIsland.y,((this.allIsland[_loc1_] as Array)[_loc2_] as Island).x,((this.allIsland[_loc1_] as Array)[_loc2_] as Island).y))
                     {
                        this.targetIsland = (this.allIsland[_loc1_] as Array)[_loc2_] as Island;
                     }
                  }
                  _loc2_++;
               }
            }
            _loc1_++;
         }
         if(this.targetIsland.getRace == this.cpuRace)
         {
            this.canAttack = false;
         }
         else
         {
            this.canAttack = true;
         }
      }
      
      private function biggestIslandCpu() : void
      {
         if(this.biggestIsland == null)
         {
            if(this.mainIsland.length == 0)
            {
               this.checkMyIsland();
            }
            else
            {
               this.biggestIsland = this.mainIsland[0] as Island;
            }
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.mainIsland.length)
         {
            if(this.biggestIsland.people < (this.mainIsland[_loc1_] as Island).people)
            {
               this.biggestIsland = this.mainIsland[_loc1_] as Island;
            }
            _loc1_++;
         }
      }
      
      private function checkMyIsland() : void
      {
         this.allIsland = this._world.islandBase.allIsland;
         this.mainIsland = this.allIsland[this.cpuRace];
         this.checkIslandCount();
         if(this.haveIsland)
         {
            this.createSummPeopleCpu();
            if(this.stockIsland == null || this.stockIsland.getRace != this.cpuRace)
            {
               this.mostSpacious();
            }
         }
      }
      
      private function mostSpacious() : void
      {
         if(this.stockIsland == null)
         {
            this.stockIsland = this.mainIsland[0] as Island;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.mainIsland.length)
         {
            if(this.stockIsland.maxPeople <= (this.mainIsland[_loc1_] as Island).maxPeople)
            {
               this.stockIsland = this.mainIsland[_loc1_] as Island;
            }
            _loc1_++;
         }
      }
      
      private function populationControl() : void
      {
         this.checkMyIsland();
         var _loc1_:int = 0;
         while(_loc1_ < this.mainIsland.length)
         {
            if((this.mainIsland[_loc1_] as Island).getRace == this.cpuRace)
            {
               if(this.mainIsland[_loc1_] as Island != this.stockIsland)
               {
                  if((this.mainIsland[_loc1_] as Island).people >= (this.mainIsland[_loc1_] as Island).maxPeople * 0.9)
                  {
                     this.shipBase.startIsland = this.mainIsland[_loc1_] as Island;
                     this.shipBase.finalIsland = this.stockIsland;
                     this.shipBase.startShipMove(this.cpuRace);
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private function attack() : void
      {
         if(this.canAttack)
         {
            if(this.mainIsland.length > 1)
            {
               if(this.biggestIsland.people * 0.6 > this.targetIsland.people)
               {
                  if(this.biggestIsland.people * 0.5 >= this.targetIsland.people)
                  {
                     this.shipBase.startIsland = this.biggestIsland;
                     this.shipBase.finalIsland = this.targetIsland;
                     this.shipBase.startShipMove(this.cpuRace);
                  }
                  else
                  {
                     this.generateHelpShips();
                  }
               }
               else if(XORRandom.random < this.helpShip)
               {
                  this.generateHelpShips();
               }
            }
            else
            {
               this.shipBase.startIsland = this.mainIsland[0] as Island;
               this.shipBase.finalIsland = this.targetIsland;
               this.shipBase.startShipMove(this.cpuRace);
            }
         }
      }
      
      private function generateHelpShips() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         if(this.summPeopleCpu > this.targetIsland.people)
         {
            _loc1_ = [];
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc4_ < this.mainIsland.length)
            {
               _loc2_ += (this.mainIsland[_loc4_] as Island).people;
               _loc1_[_loc1_.length] = this.mainIsland[_loc4_] as Island;
               if(_loc2_ * 0.6 > this.targetIsland.people)
               {
                  _loc3_ = true;
                  break;
               }
               if(XORRandom.random > 0.5)
               {
                  break;
               }
               _loc4_++;
            }
            if(_loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc1_.length)
               {
                  if((_loc1_[_loc4_] as Island).getRace == this.cpuRace)
                  {
                     this.shipBase.startIsland = _loc1_[_loc4_] as Island;
                     this.shipBase.finalIsland = this.targetIsland;
                     this.shipBase.startShipMove(this.cpuRace);
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      private function createSummPeopleCpu() : void
      {
         this.summPeopleCpu = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.mainIsland.length)
         {
            this.summPeopleCpu += (this.mainIsland[_loc1_] as Island).people;
            _loc1_++;
         }
      }
      
      private function checkNeutralIsland() : void
      {
         this.neutralIsland = this.allIsland[this.neutralRace] as Array;
      }
      
      private function checkIslandCount() : void
      {
         if(this.mainIsland.length <= 0)
         {
            this.haveIsland = false;
         }
      }
      
      public function update() : void
      {
         if(this.haveIsland)
         {
            if(this.playerStep)
            {
               if(this.fpsCounter <= 0)
               {
                  if(XORRandom.random > this.freeIteration)
                  {
                     this.checkMyIsland();
                     if(this._world.barriers.setBarrier)
                     {
                        this.biggestIslandCpuWithWhirpool();
                        this.writeAllEnemyIsl();
                        this.havingSecureIsland();
                     }
                     else
                     {
                        this.biggestIslandCpu();
                        this.randomRaceForAttack();
                     }
                     if(XORRandom.random < this.populControl)
                     {
                        this.populationControl();
                     }
                  }
                  this.fpsCounter = this.fps * this.iteration;
               }
               else
               {
                  --this.fpsCounter;
               }
            }
            else
            {
               this.checkMyIsland();
               this.biggestIslandCpu();
            }
         }
      }
   }
}
