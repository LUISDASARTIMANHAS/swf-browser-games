package uk.co.kempt.world.smashables
{
   import flash.filters.DropShadowFilter;
   import org.cove.ape.CollisionEvent;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.Lookup;
   import uk.co.kempt.display.particles.Burning;
   import uk.co.kempt.sounds.UnstoppableSounds;
   import uk.co.kempt.state.WorldObjectState;
   import uk.co.kempt.utils.GarbageUtil;
   import uk.co.kempt.world.WorldObject;
   
   public class Vehicle extends Smashable
   {
      
      private static const TIME_TO_BURN:int = Engine.GAME_FRAMERATE * 3;
       
      
      protected var _burnCount:int;
      
      private var _timeOfCollsion:int;
      
      private var _burning:Burning;
      
      public function Vehicle()
      {
         super();
         this._burnCount = 0;
         var _loc1_:Number = 1;
         filters = [new DropShadowFilter(1,90,0,1,_loc1_,_loc1_)];
      }
      
      override public function die() : void
      {
         GarbageUtil.kill(this._burning);
         this._burning = null;
         super.die();
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         super.update();
         if(this._burnCount > 0)
         {
            --this._burnCount;
            _loc1_ = Engine.instance.gameTime - this._timeOfCollsion;
            if(particle.velocity.magnitude() > 0.1)
            {
               if(_loc1_ % 6 == 0)
               {
                  Engine.instance.particleEngine.spawnVehicleDust(position);
               }
            }
            if(this._burnCount == 0)
            {
               state = WorldObjectState.DEAD;
            }
         }
      }
      
      override protected function onDead() : void
      {
         super.onDead();
         Engine.instance.particleEngine.spawnExplosion(position,size);
      }
      
      private function onProjectileCollision(param1:CollisionEvent) : void
      {
         var _loc3_:WorldObject = null;
         var _loc4_:* = false;
         var _loc2_:Object = Lookup.getParent(param1.collidingItem);
         if(_loc2_ is WorldObject)
         {
            _loc3_ = _loc2_ as WorldObject;
            if(_loc4_ = _loc3_.state == WorldObjectState.ALIVE)
            {
               _loc3_.destroy(this);
            }
         }
      }
      
      override protected function onDying() : void
      {
         super.onDying();
         filters = null;
         var _loc1_:Number = Math.atan2(particle.velocity.y,particle.velocity.x) / Math.PI * 180;
         Engine.instance.particleEngine.spawnAngledFloorDamage(position,_loc1_);
         Engine.instance.particleEngine.spawnExplosion(position,size);
         Engine.instance.particleEngine.spawnAngledDebris(position,_loc1_);
         Engine.instance.soundMan.playSound(UnstoppableSounds.CAR_CRASH);
         this._burnCount = Engine.GAME_FRAMERATE * 2;
         this._timeOfCollsion = Engine.instance.gameTime;
         particle.addEventListener(CollisionEvent.COLLIDE,this.onProjectileCollision,false,0,true);
      }
   }
}
