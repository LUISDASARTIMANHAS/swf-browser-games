package uk.co.kempt
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class Shaker
   {
      
      protected static var m_shaking:Dictionary = new Dictionary(true);
       
      
      public function Shaker()
      {
         super();
      }
      
      public static function stopShaking(param1:DisplayObject) : void
      {
         if(m_shaking[param1])
         {
            m_shaking[param1].stopShake();
            delete m_shaking[param1];
         }
      }
      
      public static function shake(param1:DisplayObject, param2:Number, param3:Number, param4:Number = 0, param5:Number = 0, param6:uint = 4294967295, param7:Boolean = false) : void
      {
         if(m_shaking[param1])
         {
            stopShaking(param1);
         }
         m_shaking[param1] = new ShakingVars(param1,param2,param3,param4 < 0 ? 0 : (param4 > 1 ? 1 : param4),param5 < 0 ? 0 : (param5 > 1 ? 1 : param5),param6,param7);
         param1.addEventListener(Event.ENTER_FRAME,m_shaking[param1].doShake);
      }
      
      public static function stopShakingAll() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in m_shaking)
         {
            m_shaking[_loc1_].stopShake();
            delete m_shaking[_loc1_];
         }
      }
   }
}

import flash.display.DisplayObject;
import flash.events.Event;

class ShakingVars
{
    
   
   public var time:uint;
   
   public var jx:Number;
   
   public var jy:Number;
   
   public var dx:int = 1;
   
   public var dy:int = 1;
   
   public var timeRemaining:uint;
   
   public var ix:Number;
   
   public var obj:DisplayObject;
   
   public var x:Number;
   
   public var y:Number;
   
   public var decay:Boolean;
   
   public var iy:Number;
   
   public function ShakingVars(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:Boolean)
   {
      super();
      this.obj = param1;
      this.x = param2;
      this.y = param3;
      this.jx = param4;
      this.jy = param5;
      this.ix = this.obj.x;
      this.iy = this.obj.y;
      this.timeRemaining = this.time = param6;
      this.decay = param7;
   }
   
   public function stopShake() : void
   {
      if(!this.obj)
      {
         return;
      }
      this.obj.removeEventListener(Event.ENTER_FRAME,this.doShake);
      this.obj.x = this.ix;
      this.obj.y = this.iy;
      this.obj = null;
   }
   
   public function doShake(param1:Event) : void
   {
      this.dx = Math.random() > 0.5 ? 1 : -1;
      this.dy = Math.random() > 0.5 ? 1 : -1;
      var _loc2_:Number = this.x - Math.random() * this.jx * this.x;
      var _loc3_:Number = this.y - Math.random() * this.jy * this.y;
      var _loc4_:Number = !!this.decay ? this.timeRemaining / this.time : 1;
      this.obj.x = this.ix + _loc2_ * this.dx * _loc4_;
      this.obj.y = this.iy + _loc3_ * this.dy * _loc4_;
      --this.timeRemaining;
      if(this.timeRemaining <= 0)
      {
         this.stopShake();
      }
   }
}
