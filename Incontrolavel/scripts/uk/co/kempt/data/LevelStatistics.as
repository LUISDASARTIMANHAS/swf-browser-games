package uk.co.kempt.data
{
   import uk.co.kempt.Engine;
   
   public class LevelStatistics
   {
       
      
      private var _hitSteepCorner:Boolean;
      
      private var _hitDangerousBuilding:Boolean;
      
      private var _totalValue:int;
      
      private var _totalCost:int;
      
      private var _hitHospital:Boolean;
      
      private var _totalDestructibles:int;
      
      private var _crashed:Boolean;
      
      private var _reachedExit:Boolean;
      
      private var _timeLeft:int;
      
      private var _totalDestroyed:int;
      
      private var _distanceToExitCenter:Number;
      
      private var _budget:int;
      
      private var _exitRadius:Number;
      
      public function LevelStatistics()
      {
         super();
         this._totalDestructibles = 0;
         this._totalDestroyed = 0;
         this._timeLeft = 0;
         this._exitRadius = 25;
         this._distanceToExitCenter = this._exitRadius;
         this._reachedExit = false;
         this._hitDangerousBuilding = false;
         this._budget = 2000000;
      }
      
      public function get distanceToExitCenter() : Number
      {
         return this._distanceToExitCenter;
      }
      
      public function set distanceToExitCenter(param1:Number) : void
      {
         this._distanceToExitCenter = param1;
      }
      
      public function set budget(param1:int) : void
      {
         this._budget = param1;
      }
      
      public function get totalValue() : int
      {
         return this._totalValue;
      }
      
      public function set crashed(param1:Boolean) : void
      {
         this._crashed = param1;
      }
      
      public function get crashed() : Boolean
      {
         return this._crashed;
      }
      
      public function set hitDangerousBuilding(param1:Boolean) : void
      {
         this._hitDangerousBuilding = param1;
      }
      
      public function get reachedExit() : Boolean
      {
         return this._reachedExit;
      }
      
      public function set totalValue(param1:int) : void
      {
         this._totalValue = param1;
      }
      
      public function nullify() : void
      {
         this._budget = 0;
         this._totalCost = 1;
      }
      
      public function set exitRadius(param1:Number) : void
      {
         this._exitRadius = param1;
      }
      
      public function get accuracyBonus() : int
      {
         return Math.round(10000 * (1 - this.exitAccuracy));
      }
      
      public function get totalDestructibles() : int
      {
         return this._totalDestructibles;
      }
      
      public function set reachedExit(param1:Boolean) : void
      {
         this._reachedExit = param1;
      }
      
      public function get totalCost() : int
      {
         return this._totalCost;
      }
      
      public function get exitAccuracy() : Number
      {
         return Math.max(0,Math.min(1,this.distanceToExitCenter / this.exitRadius));
      }
      
      public function get totalBonus() : int
      {
         return this.timeBonus + this.accuracyBonus + this.damageBonus;
      }
      
      public function get totalDestroyed() : int
      {
         return this._totalDestroyed;
      }
      
      public function get budget() : int
      {
         return this._budget;
      }
      
      public function get gross() : int
      {
         return this.budget - this.totalCost;
      }
      
      public function set totalDestructibles(param1:int) : void
      {
         this._totalDestructibles = param1;
      }
      
      public function get exitRadius() : Number
      {
         return this._exitRadius;
      }
      
      public function get timeBonus() : int
      {
         return Math.round(this.timeLeft / Engine.GAME_FRAMERATE * 1000);
      }
      
      public function get hitDangerousBuilding() : Boolean
      {
         return this._hitDangerousBuilding;
      }
      
      public function set hitHospital(param1:Boolean) : void
      {
         this._hitHospital = param1;
      }
      
      public function get percentDestroyed() : Number
      {
         return Math.round(this.totalDestroyed / this.totalDestructibles * 100);
      }
      
      public function set timeLeft(param1:int) : void
      {
         this._timeLeft = param1;
      }
      
      public function set totalCost(param1:int) : void
      {
         this._totalCost = param1;
      }
      
      public function set totalDestroyed(param1:int) : void
      {
         this._totalDestroyed = param1;
      }
      
      public function get hitHospital() : Boolean
      {
         return this._hitHospital;
      }
      
      public function get damageBonus() : int
      {
         return this.totalDestroyed == 0 ? 10000 : 0;
      }
      
      public function get hitSteepCorner() : Boolean
      {
         return this._hitSteepCorner;
      }
      
      public function get timeLeft() : int
      {
         return this._timeLeft;
      }
      
      public function set hitSteepCorner(param1:Boolean) : void
      {
         this._hitSteepCorner = param1;
      }
   }
}
