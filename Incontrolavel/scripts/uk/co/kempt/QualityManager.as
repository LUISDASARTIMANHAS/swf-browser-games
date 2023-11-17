package uk.co.kempt
{
   import flash.display.Sprite;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class QualityManager extends Sprite
   {
       
      
      private var _quality:int;
      
      private var _slowAt:int;
      
      private var _fastAt:int;
      
      private var _lastUpdate:int;
      
      public function QualityManager()
      {
         super();
         this._lastUpdate = getTimer();
         this._slowAt = -1;
         this._fastAt = -1;
         this._quality = 2;
         addEventListener(Event.ENTER_FRAME,this.update);
      }
      
      private function update(param1:Event) : void
      {
         var _loc2_:int = int(getTimer());
         var _loc3_:int = _loc2_ - this._lastUpdate;
         var _loc4_:Number = 1000 / _loc3_;
         var _loc5_:Number = 15;
         var _loc6_:Number = 25;
         if(_loc4_ < _loc5_)
         {
            this._fastAt = -1;
            if(this._slowAt == -1)
            {
               this._slowAt = getTimer();
            }
            else if(_loc2_ - this._slowAt > 1000)
            {
               this.stepDown();
            }
         }
         else if(_loc4_ > _loc6_)
         {
            if(this._fastAt == -1)
            {
               this._fastAt = getTimer();
            }
            else if(_loc2_ - this._fastAt > 1000)
            {
               this.stepUp();
            }
         }
         this._lastUpdate = getTimer();
      }
      
      private function stepDown() : void
      {
         var _loc1_:int = int(Math.max(0,this._quality - 1));
         if(_loc1_ != this._quality)
         {
            this._quality = _loc1_;
            this.updateQuality();
         }
         this._slowAt = -1;
         this._fastAt = -1;
      }
      
      private function stepUp() : void
      {
         var _loc1_:int = int(Math.min(2,this._quality + 1));
         if(_loc1_ != this._quality)
         {
            this._quality = _loc1_;
            this.updateQuality();
         }
         this._slowAt = -1;
         this._fastAt = -1;
      }
      
      private function updateQuality() : void
      {
         switch(this._quality)
         {
            case 2:
               stage.quality = StageQuality.HIGH;
               break;
            case 1:
               stage.quality = StageQuality.MEDIUM;
               break;
            case 0:
               stage.quality = StageQuality.LOW;
         }
      }
   }
}
