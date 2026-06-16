package com.mindgame.battleship.game.ship
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.islands.Island;
   
   public class ShipBase
   {
      
      public static var speedShip:int = 1;
       
      
      public var startIsland:Island;
      
      public var finalIsland:Island;
      
      public var startIslandPl:Island;
      
      public var finalIslandPl:Island;
      
      public var allShips:Array;
      
      public var deactivatedRace:Array;
      
      private var _world:WorldComp;
      
      private var playerRace:int;
      
      public function ShipBase()
      {
         this.allShips = [];
         this.deactivatedRace = [];
         super();
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.allShips.length)
         {
            (this.allShips[_loc1_] as Car).removing();
            _loc1_++;
         }
         this.allShips = [];
         this.deactivatedRace = [];
         this.startIsland = null;
         this.finalIsland = null;
         this.startIslandPl = null;
         this.finalIslandPl = null;
      }
      
      public function init() : void
      {
         this._world = WorldComp.returnWorld;
         this.playerRace = this._world.playerRace;
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.allShips.length)
         {
            if(this.allShips[_loc1_].haveDest)
            {
               this.allShips[_loc1_].update();
            }
            else
            {
               if(this.allShips[_loc1_] != null)
               {
                  this.allShips[_loc1_].update();
               }
               this.allShips.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      public function check(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.deactivatedRace.length)
         {
            if(this.deactivatedRace[_loc2_] == param1)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function conversionSpeed(param1:int) : Number
      {
         if(param1 <= 10)
         {
            return 0.9;
         }
         if(param1 > 10 && param1 <= 100)
         {
            if(param1 > 10 && param1 <= 25)
            {
               return 1;
            }
            if(param1 > 25 && param1 <= 35)
            {
               return 1.2;
            }
            if(param1 > 35 && param1 <= 45)
            {
               return 1.3;
            }
            if(param1 > 45 && param1 <= 60)
            {
               return 1.4;
            }
            if(param1 > 60 && param1 <= 70)
            {
               return 1.5;
            }
            if(param1 > 70 && param1 <= 80)
            {
               return 1.6;
            }
            if(param1 > 90 && param1 <= 100)
            {
               return 1.8;
            }
            return 1.9;
         }
         return 2;
      }
      
      private function conversionTypeCar(param1:Car, param2:int, param3:int = 0) : Car
      {
         param2 *= 0.5;
         if(param2 <= 5)
         {
            if(Boolean(this._world.upgradeAllAir) && param3 == this.playerRace)
            {
               param1 = new Air1();
               param1.ship = false;
            }
            else
            {
               param1 = new Ship1();
               param1.findPath = true;
            }
         }
         else if(param2 > 5 && param2 <= 10)
         {
            if(Boolean(this._world.upgradeAllAir) && param3 == this.playerRace)
            {
               param1 = new Air1();
               param1.ship = false;
            }
            else
            {
               param1 = new Ship2();
               param1.findPath = true;
            }
         }
         else if(param2 > 10 && param2 <= 16)
         {
            if(Boolean(this._world.upgradeAllAir) && param3 == this.playerRace)
            {
               param1 = new Air2();
               param1.ship = false;
            }
            else
            {
               param1 = new Ship3();
               param1.findPath = true;
            }
         }
         else if(param2 > 16 && param2 <= 25)
         {
            if(Boolean(this._world.upgradeAllAir) && param3 == this.playerRace)
            {
               param1 = new Air2();
               param1.ship = false;
            }
            else
            {
               param1 = new Ship4();
               param1.findPath = true;
            }
         }
         else if(param2 > 25 && param2 <= 35)
         {
            if(Boolean(this._world.upgradeAllAir) && param3 == this.playerRace)
            {
               param1 = new Air2();
               param1.ship = false;
            }
            else
            {
               param1 = new Air1();
               param1.ship = false;
            }
         }
         else if(param2 > 35 && param2 <= 45)
         {
            if(Boolean(this._world.upgradeAllAir) && param3 == this.playerRace)
            {
               param1 = new Air3();
               param1.ship = false;
            }
            else
            {
               param1 = new Air2();
               param1.ship = false;
            }
         }
         else if(param2 > 45 && param2 <= 55)
         {
            param1 = new Air3();
            param1.ship = false;
         }
         else
         {
            param1 = new Air4();
            param1.ship = false;
         }
         param1.speed = speedShip * this.conversionSpeed(param2);
         if(param3 == this.playerRace)
         {
            param1.speed *= this._world.upgradeSpeedUp;
            if(this._world.upgradeAllAir)
            {
               param1.speed *= 1.2;
            }
         }
         else
         {
            param1.speed *= this._world.upgradeSpeedEnemyRed;
         }
         return param1;
      }
      
      public function startShipMove(param1:int = 1, param2:Boolean = false) : void
      {
         var _loc3_:Car = null;
         if(this.check(param1))
         {
            if(param2)
            {
               if(this.startIslandPl.getRace == this.playerRace)
               {
                  _loc3_ = this.conversionTypeCar(_loc3_,this.startIslandPl.people,this.playerRace);
                  _loc3_.setRace = this.startIslandPl.getRace;
                  _loc3_.setPeople = this.startIslandPl.getPeoples;
               }
               if(this.startIslandPl.getRace == this.playerRace)
               {
                  _loc3_.setWay(this.startIslandPl.x,this.startIslandPl.y,this.finalIslandPl,this.startIslandPl);
                  this.setForShip = _loc3_;
                  this._world.tooltip.hideTooltip();
                  if(this.finalIslandPl.getRace != this._world.nautralRace && this.finalIslandPl.getRace != this.playerRace)
                  {
                     this.finalIslandPl.alarm(_loc3_.getPeople);
                  }
               }
               else if(_loc3_ != null)
               {
                  _loc3_.removing();
               }
               this.startIslandPl = null;
               this.finalIslandPl = null;
            }
            else
            {
               if(this.startIsland.getRace == param1)
               {
                  _loc3_ = this.conversionTypeCar(_loc3_,this.startIsland.people);
                  _loc3_.setRace = this.startIsland.getRace;
               }
               if(this.startIsland.getRace == param1)
               {
                  _loc3_.setPeople = this.startIsland.getPeoples;
                  _loc3_.setWay(this.startIsland.x,this.startIsland.y,this.finalIsland,this.startIsland);
                  this.setForShip = _loc3_;
                  if(this.finalIsland.getRace != this._world.nautralRace && this.finalIsland.getRace != this.playerRace && this.finalIsland.getRace != this.startIsland.cpu.cpuRace)
                  {
                     this.finalIsland.alarm(_loc3_.getPeople);
                  }
               }
               else if(_loc3_ != null)
               {
                  _loc3_.removing();
               }
               this.finalIsland = null;
               this.startIsland = null;
            }
         }
      }
      
      public function set setForShip(param1:Car) : void
      {
         param1.washoutRate = this._world.washoutRate;
         param1.shiftRate = this._world.shiftRate;
      }
      
      public function set setStartIslandPl(param1:Island) : void
      {
         this.startIslandPl = param1;
      }
      
      public function set setFinalIslandPl(param1:Island) : void
      {
         this.finalIslandPl = param1;
      }
      
      public function set setStartIsland(param1:Island) : void
      {
         this.startIsland = param1;
      }
      
      public function set setFinalIsland(param1:Island) : void
      {
         this.finalIsland = param1;
      }
   }
}
