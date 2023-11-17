package uk.co.kempt.data
{
   public class LevelStatisticsCollection
   {
       
      
      private var _stats:Array;
      
      public function LevelStatisticsCollection()
      {
         super();
         this._stats = [];
      }
      
      public function add(param1:LevelStatistics) : void
      {
         this._stats.push(param1);
      }
      
      public function get gross() : int
      {
         var _loc1_:LevelStatistics = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._stats.length)
         {
            _loc1_ = this._stats[_loc3_];
            if(_loc1_.gross >= 0)
            {
               _loc2_ += _loc1_.gross;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get totalValue() : int
      {
         var _loc1_:LevelStatistics = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._stats.length)
         {
            _loc1_ = this._stats[_loc3_];
            _loc2_ += _loc1_.totalValue;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get totalTotal() : int
      {
         return this.totalCost - this.totalBonus;
      }
      
      public function get totalCost() : int
      {
         var _loc1_:LevelStatistics = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._stats.length)
         {
            _loc1_ = this._stats[_loc3_];
            _loc2_ += _loc1_.totalCost;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get percentCost() : Number
      {
         return this.totalCost / this.totalValue;
      }
      
      public function get percentDestroyed() : int
      {
         var _loc1_:LevelStatistics = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this._stats.length)
         {
            _loc1_ = this._stats[_loc4_];
            _loc2_ += _loc1_.totalDestructibles;
            _loc3_ += _loc1_.totalDestroyed;
            _loc4_++;
         }
         return Math.round(_loc3_ / _loc2_ * 100);
      }
      
      public function getStatByIndex(param1:int) : LevelStatistics
      {
         return this._stats[param1];
      }
      
      public function removeLast() : void
      {
         this._stats.pop();
      }
      
      public function get totalBonus() : int
      {
         var _loc1_:LevelStatistics = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._stats.length)
         {
            _loc1_ = this._stats[_loc3_];
            _loc2_ += _loc1_.totalBonus;
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
