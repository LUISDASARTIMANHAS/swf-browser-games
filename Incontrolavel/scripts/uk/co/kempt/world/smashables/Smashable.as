package uk.co.kempt.world.smashables
{
   import org.cove.ape.AbstractParticle;
   import org.cove.ape.CollisionEvent;
   import org.cove.ape.RigidItem;
   import org.cove.ape.RigidRectangle;
   import org.cove.ape.Vector2;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.Lookup;
   import uk.co.kempt.utils.GarbageUtil;
   import uk.co.kempt.world.WorldObject;
   
   public class Smashable extends WorldObject
   {
      
      private static const FRICTION:Number = 0.15;
      
      private static const IMPACT_VELOCITY:Number = 12;
       
      
      private var _collided:Boolean;
      
      private var _particle:AbstractParticle;
      
      public function Smashable()
      {
         super();
      }
      
      override public function die() : void
      {
         removeParticles();
         this._particle = null;
         GarbageUtil.kill(this);
      }
      
      override public function get updateable() : Boolean
      {
         return true;
      }
      
      public function get particle() : AbstractParticle
      {
         return this._particle;
      }
      
      private function onCollisionEvent(param1:CollisionEvent) : void
      {
         var _loc2_:AbstractParticle = null;
         if(param1.collidingItem.solid)
         {
            if(param1.collidingItem is AbstractParticle)
            {
               _loc2_ = param1.collidingItem as AbstractParticle;
               this._collided = true;
            }
         }
      }
      
      override public function get destructible() : Boolean
      {
         return true;
      }
      
      override public function update() : void
      {
         if(!this._particle)
         {
            trace(this + " no particle " + state);
            return;
         }
         x = this._particle.px;
         y = this._particle.py;
         if(this.rectangleParticle)
         {
            rotation = this.rectangleParticle.angle;
         }
         else if(this.rigidParticle)
         {
            rotation = this.rigidParticle.angle;
         }
         this._particle.velocity = this._particle.velocity.mult(1 - FRICTION);
         if(this.rectangleParticle)
         {
            this.rectangleParticle.angularVelocity *= 1 - FRICTION;
         }
         if(Math.abs(this._particle.velocity.x) <= 1 / 20 && Math.abs(this._particle.velocity.y) <= 1 / 20)
         {
            this._particle.velocity = new Vector2();
         }
      }
      
      override public function updateBeforeAPE() : void
      {
         super.updateBeforeAPE();
         if(this._collided)
         {
            this._collided = false;
         }
      }
      
      override public function prepareForSimulation() : Boolean
      {
         if(super.prepareForSimulation())
         {
            if(this._particle)
            {
               this._particle.collidable = true;
            }
         }
         return true;
      }
      
      protected function get rigidParticle() : RigidItem
      {
         return Boolean(this._particle) && this._particle is RigidItem ? this._particle as RigidItem : null;
      }
      
      protected function get rectangleParticle() : RigidRectangle
      {
         return Boolean(this._particle) && this._particle is RigidRectangle ? this._particle as RigidRectangle : null;
      }
      
      override protected function addParticle(param1:AbstractParticle) : void
      {
         if(!this._particle)
         {
            this._particle = param1;
            Engine.instance.addParticle(param1);
            Lookup.register(param1,this);
            this._particle.px = x;
            this._particle.py = y;
            if(this.rectangleParticle)
            {
               this.rectangleParticle.angle = rotation;
            }
            this._particle.addEventListener(CollisionEvent.COLLIDE,this.onCollisionEvent,false,0,true);
         }
      }
      
      override public function prepareForDrawing() : Boolean
      {
         if(super.prepareForDrawing())
         {
            if(this._particle)
            {
               this._particle.collidable = false;
            }
         }
         return true;
      }
      
      override protected function onDying() : void
      {
         super.onDying();
         var _loc1_:Vector2 = this._particle.velocity.normalize().mult(IMPACT_VELOCITY);
         this._particle.velocity = _loc1_;
      }
   }
}
