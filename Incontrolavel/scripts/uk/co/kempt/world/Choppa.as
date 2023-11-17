package uk.co.kempt.world
{
   import flash.geom.Point;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.TrackNode;
   import uk.co.kempt.sounds.Snd;
   import uk.co.kempt.sounds.UnstoppableSounds;
   import uk.co.kempt.state.WorldObjectState;
   import uk.co.kempt.utils.GarbageUtil;
   import uk.co.kempt.utils.MathUtil;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.Choppa")]
   public class Choppa extends WorldObject
   {
       
      
      private var _reachedTarget:Boolean;
      
      private var _atTargetFor:int;
      
      private var _speed:Number;
      
      private var _target:Point;
      
      private var _heliSound:Snd;
      
      public function Choppa()
      {
         super();
         this._heliSound = Engine.instance.soundMan.loopSound(UnstoppableSounds.HELICOPTER,0);
      }
      
      public function get reachedTarget() : Boolean
      {
         return this._reachedTarget;
      }
      
      public function get atTargetFor() : int
      {
         return this._atTargetFor;
      }
      
      override public function die() : void
      {
         this._target = null;
         this._heliSound.die();
         this._heliSound = null;
         GarbageUtil.kill(this);
      }
      
      override public function update() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(this._target)
         {
            _loc2_ = this._target.x - x;
            _loc3_ = this._target.y - y;
            _loc4_ = Number(Math.sqrt(Math.pow(_loc2_,2) + Math.pow(_loc3_,2)));
            _loc5_ = Number(Math.atan2(_loc3_,_loc2_));
            _loc6_ = Number(Math.min(this._speed,_loc4_));
            x += _loc6_ * Math.cos(_loc5_);
            y += _loc6_ * Math.sin(_loc5_);
            _loc7_ = MathUtil.radianDiff(rotation / 180 * Math.PI,_loc5_) / Math.PI * 180 / 6;
            _loc8_ = 4;
            _loc7_ = Number(Math.max(-_loc8_,Math.min(_loc8_,_loc7_)));
            if(_loc6_ > 0.2)
            {
               rotation += _loc7_;
            }
            if(_loc4_ <= this._speed)
            {
               if(!this._reachedTarget)
               {
                  this._reachedTarget = true;
                  this._atTargetFor = 0;
               }
            }
         }
         if(this._reachedTarget)
         {
            ++this._atTargetFor;
         }
         var _loc1_:Number = !!this._target ? 1 : 0;
         if(state != WorldObjectState.ALIVE)
         {
            _loc1_ = 0;
         }
         this._heliSound.volume += (_loc1_ - this._heliSound.volume) / 6;
      }
      
      override public function updateBeforeAPE() : void
      {
      }
      
      public function flyToTargetPoint(param1:Point) : void
      {
         this._target = param1;
         this._reachedTarget = false;
         this._atTargetFor = 0;
         var _loc2_:Number = this._target.x - x;
         var _loc3_:Number = this._target.y - y;
         var _loc4_:Number = Number(Math.sqrt(Math.pow(_loc2_,2) + Math.pow(_loc3_,2)));
         this._speed = _loc4_ / (Engine.GAME_FRAMERATE * 3);
      }
      
      override protected function onDying() : void
      {
         this.clearTarget();
         super.onDying();
      }
      
      public function clearTarget() : void
      {
         this._target = null;
         this._heliSound.volume = 0;
      }
      
      public function flyToTarget(param1:TrackNode) : void
      {
         this.flyToTargetPoint(param1.position);
      }
   }
}
