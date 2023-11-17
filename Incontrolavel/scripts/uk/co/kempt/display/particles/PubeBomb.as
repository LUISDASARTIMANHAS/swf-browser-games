package uk.co.kempt.display.particles
{
   import flash.display.MovieClip;
   import uk.co.kempt.utils.GarbageUtil;
   import uk.co.kempt.world.WorldObject;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.particles.PubeBomb")]
   public class PubeBomb extends WorldObject
   {
       
      
      private var smallDustFrequency:Number = 20;
      
      private var radiusDecay:Number = 0.975;
      
      private var scaleDown:Number = 1.3;
      
      private var maxScale:Number = 750;
      
      private var radiusRatio:Number = 0.5;
      
      private var frequency:Number = 3;
      
      private var animationSkip:Number = 10;
      
      private var radiusInc:Number = 12;
      
      private var _radius:Number = 1;
      
      private var xCentre:Number = 0;
      
      private var yCentre:Number = 0;
      
      private var animationStart:Number = 5;
      
      public function PubeBomb()
      {
         super();
      }
      
      override public function die() : void
      {
         GarbageUtil.kill(this);
      }
      
      override public function update() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:MovieClip = null;
         this.xCentre = x;
         this.yCentre = y;
         var _loc1_:int = 0;
         while(_loc1_ < this._radius * this.radiusRatio)
         {
            _loc2_ = Math.PI * (_loc1_ / (this._radius * this.radiusRatio)) * 2 + Math.random();
            _loc3_ = 500 - this._radius * this.scaleDown;
            _loc3_ /= 100;
            _loc4_ = this.xCentre + Math.sin(_loc2_) * this._radius;
            _loc5_ = this.yCentre + Math.cos(_loc2_) * this._radius;
            if(_loc4_ > -20 && _loc4_ < 500 && _loc5_ > -20 && _loc5_ < 330)
            {
               if(_loc3_ > 0)
               {
                  if(parent.numChildren % this.smallDustFrequency == 0)
                  {
                     (_loc6_ = new NukeDust()).inner.gotoAndPlay(this.animationStart + Math.ceil(Math.random() * this.animationSkip));
                  }
                  else
                  {
                     _loc6_ = new NukeDustFast();
                  }
                  _loc6_.x = _loc4_;
                  _loc6_.y = _loc5_;
                  _loc6_.scaleX = _loc3_;
                  _loc6_.scaleY = _loc3_;
                  _loc6_.rotation = _loc2_ * (180 / Math.PI) - 180;
                  if(parent)
                  {
                     parent.addChildAt(_loc6_,0);
                  }
               }
            }
            _loc1_ += this.frequency;
         }
         this.radiusInc *= this.radiusDecay;
         this._radius += this.radiusInc;
      }
      
      public function get radius() : Number
      {
         return this._radius;
      }
      
      override public function get cost() : int
      {
         return 0;
      }
      
      override public function get updateable() : Boolean
      {
         return true;
      }
   }
}
