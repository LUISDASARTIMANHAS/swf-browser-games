package uk.co.kempt.world
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import uk.co.kempt.display.Entrance;
   import uk.co.kempt.display.Exit;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class Level extends Sprite
   {
      
      private static const TIMES:Array = [25,20,20,15,10,25,20,20,15,15,25,20,20,15,10,20,15,15,15,10,25,20,20,15,10];
      
      private static const BUDGETS:Array = [2000000,1500000,1200000,1000000,1500000,1500000,1200000,1000000,750000,500000,1500000,1200000,1000000,500000,250000,1000000,1250000,750000,750000,750000,1500000,1200000,1000000,500000,250000];
       
      
      public var track:Sprite;
      
      private var _track:Sprite;
      
      private var _entrance:Entrance;
      
      private var _exit:Exit;
      
      public function Level()
      {
         super();
         this.checkChildren();
      }
      
      public static function getTimeInSeconds(param1:int) : Number
      {
         var _loc2_:int = int(TIMES[param1 - 1]);
         if(_loc2_ <= 0)
         {
            _loc2_ = 15;
         }
         return _loc2_;
      }
      
      public static function getTotalBudget() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < BUDGETS.length)
         {
            _loc1_ += BUDGETS[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function getBudgetInDollars(param1:int) : Number
      {
         var _loc2_:int = int(BUDGETS[param1 - 1]);
         if(_loc2_ <= 0)
         {
            _loc2_ = 2000000;
         }
         return _loc2_;
      }
      
      public function die() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         this.killChildren();
         this._track = null;
         this._entrance = null;
         this._exit = null;
      }
      
      private function createTrackDisplay() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function killChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:WorldObject = null;
         if(numChildren)
         {
            _loc1_ = numChildren - 1;
            while(_loc1_ >= 0)
            {
               _loc2_ = getChildAt(_loc1_);
               if(_loc2_ is WorldObject)
               {
                  _loc3_ = _loc2_ as WorldObject;
               }
               else
               {
                  GarbageUtil.kill(_loc2_);
               }
               _loc1_--;
            }
         }
      }
      
      public function get entrance() : Entrance
      {
         return this._entrance;
      }
      
      private function checkChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         if(numChildren)
         {
            _loc1_ = numChildren - 1;
            while(_loc1_ >= 0)
            {
               _loc2_ = getChildAt(_loc1_);
               if(_loc2_ is Entrance)
               {
                  this._entrance = _loc2_ as Entrance;
               }
               else if(_loc2_ is Exit)
               {
                  this._exit = _loc2_ as Exit;
               }
               else if(_loc2_ is WorldObject)
               {
               }
               _loc1_--;
            }
         }
      }
      
      public function get trackDisplay() : Sprite
      {
         return this.track || (this._track = this._track || this.createTrackDisplay());
      }
      
      public function get exit() : Exit
      {
         return this._exit;
      }
   }
}
