package uk.co.kempt.world
{
   import flash.display.DisplayObject;
   import uk.co.kempt.Engine;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class Person extends WorldObject
   {
      
      private static const RANGE:Number = 100;
      
      private static const RANGE_SQUARED:Number = RANGE * RANGE;
       
      
      private var _speed:Number;
      
      private var _runningAngle:Number;
      
      private var _angleTimeout:int;
      
      public function Person()
      {
         super();
         this._speed = 0.1 + Math.random() * 0.3;
         this._runningAngle = NaN;
      }
      
      override public function die() : void
      {
         GarbageUtil.kill(this);
      }
      
      override public function get updateable() : Boolean
      {
         return true;
      }
      
      override public function update() : void
      {
         var _loc1_:Train = null;
         if(isNaN(this._runningAngle))
         {
            if(Engine.instance.trainSystem)
            {
               _loc1_ = Engine.instance.trainSystem.train;
               if(_loc1_)
               {
                  this.checkProximity(_loc1_);
               }
            }
         }
         if(!isNaN(this._runningAngle))
         {
            x += Math.cos(this._runningAngle) * this._speed;
            y += Math.sin(this._runningAngle) * this._speed;
            if(this._angleTimeout > 0)
            {
               --this._angleTimeout;
            }
            else
            {
               this._runningAngle = NaN;
            }
         }
         else
         {
            --this._angleTimeout;
         }
      }
      
      override public function get cost() : int
      {
         return 0;
      }
      
      public function get runningAngle() : Number
      {
         return this._runningAngle;
      }
      
      private function checkProximity(param1:DisplayObject) : void
      {
         var _loc2_:Number = param1.x - x;
         var _loc3_:Number = param1.y - y;
         var _loc4_:Number;
         if((_loc4_ = _loc2_ * _loc2_ + _loc3_ * _loc3_) < RANGE_SQUARED)
         {
            this._runningAngle = Math.atan2(_loc3_,_loc2_) + Math.PI;
            this._runningAngle += (Math.random() - 0.5) * Math.PI / 3;
            if(this._angleTimeout < 1)
            {
               this.triggerSound();
            }
            this._angleTimeout = 10 + Math.random() * 6;
         }
      }
      
      protected function triggerSound() : void
      {
         Engine.instance.personScream(this);
      }
   }
}
