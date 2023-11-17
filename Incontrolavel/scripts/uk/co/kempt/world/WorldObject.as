package uk.co.kempt.world
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import org.cove.ape.AbstractParticle;
   import org.cove.ape.RigidRectangle;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.ParticleType;
   import uk.co.kempt.state.GameState;
   import uk.co.kempt.state.WorldObjectState;
   import uk.co.kempt.utils.GarbageUtil;
   import uk.co.kempt.world.primitives.Primitive;
   import uk.co.kempt.world.primitives.RigidSolidRectangle;
   import uk.co.kempt.world.primitives.SolidCircle;
   import uk.co.kempt.world.primitives.SolidRectangle;
   
   public class WorldObject extends Sprite
   {
       
      
      private var _gameState:String;
      
      private var _state:String;
      
      private var _friction:Number;
      
      private var _size:Number;
      
      private var _cost:int = 0;
      
      private var _particles:Array;
      
      private var _anim:MovieClip;
      
      public function WorldObject()
      {
         super();
         this.state = WorldObjectState.ALIVE;
         this.friction = 0;
         this._size = 0;
         this._particles = [];
         this.checkChildren();
         Engine.addWorldObject(this);
         if(this.destructible)
         {
            Engine.instance.levelStatistics.totalValue += this.cost;
            ++Engine.instance.levelStatistics.totalDestructibles;
         }
         if(this.updateable)
         {
            Engine.addUpdatable(this);
         }
         switch(Engine.instance.state)
         {
            case GameState.DRAWING:
               this.prepareForDrawing();
               break;
            case GameState.SIMULATION:
               this.prepareForSimulation();
         }
      }
      
      public function get size() : Number
      {
         return this._size;
      }
      
      protected function addAnimClip(param1:MovieClip) : void
      {
         param1.gotoAndStop(1);
         param1.addFrameScript(param1.totalFrames,param1.stop);
         if(this._anim)
         {
            trace("multiple anim clips detected " + this);
         }
         this._anim = param1;
      }
      
      public function prepareForDrawing() : Boolean
      {
         if(this._gameState == GameState.DRAWING)
         {
            return false;
         }
         this._gameState == GameState.DRAWING;
         return true;
      }
      
      private function prepareParticle(param1:AbstractParticle) : void
      {
         if(this.ignoreBrush)
         {
            param1.typesToIgnore.push(ParticleType.BRUSH);
         }
         this.particles.push(param1);
         this.addParticle(param1);
      }
      
      public function get ignoreBrush() : Boolean
      {
         return true;
      }
      
      public function update() : void
      {
      }
      
      protected function translateParticle(param1:AbstractParticle) : void
      {
         var _loc4_:RigidRectangle = null;
         var _loc2_:Number = Math.atan2(param1.py,param1.px) + rotation / 180 * Math.PI;
         var _loc3_:Number = Number(Math.sqrt(Math.pow(param1.px,2) + Math.pow(param1.py,2)));
         param1.px = Math.cos(_loc2_) * _loc3_;
         param1.py = Math.sin(_loc2_) * _loc3_;
         param1.px += x;
         param1.py += y;
         if(param1 is RigidRectangle)
         {
            _loc4_ = param1 as RigidRectangle;
            _loc4_.radian += rotation / 180 * Math.PI;
         }
      }
      
      public function get cost() : int
      {
         return this._cost > 0 ? this._cost : this.defaultCost;
      }
      
      public function updateBeforeAPE() : void
      {
      }
      
      protected function removeParticles() : void
      {
         Engine.instance.removeParticles(this.particles);
         this._particles.length = 0;
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      protected function onDying() : void
      {
      }
      
      protected function addParticle(param1:AbstractParticle) : void
      {
      }
      
      public function flagAsInSight() : void
      {
      }
      
      public function destroy(param1:WorldObject) : void
      {
         if(this.state == WorldObjectState.ALIVE)
         {
            if(this._anim)
            {
               if(this._anim.totalFrames > 2)
               {
                  this._anim.gotoAndPlay(2);
               }
               else
               {
                  this._anim.gotoAndStop(2);
               }
            }
            if(this.cost > 0)
            {
               Engine.instance.accost(this);
            }
            if(this.destructible)
            {
               ++Engine.instance.levelStatistics.totalDestroyed;
            }
            this.state = WorldObjectState.DYING;
         }
      }
      
      private function processTextField(param1:TextField) : void
      {
         this._cost = parseInt(param1.text);
         GarbageUtil.kill(param1);
      }
      
      public function set state(param1:String) : void
      {
         this._state = param1;
         this.onSetState();
      }
      
      public function get updateable() : Boolean
      {
         return false;
      }
      
      private function onSetState() : void
      {
         switch(this.state)
         {
            case WorldObjectState.ALIVE:
               this.onAlive();
               break;
            case WorldObjectState.DYING:
               this.onDying();
               break;
            case WorldObjectState.DEAD:
               this.onDead();
               break;
            case WorldObjectState.BURIED:
               this.onBuried();
         }
      }
      
      public function get destructible() : Boolean
      {
         return false;
      }
      
      public function get position() : Point
      {
         return new Point(x,y);
      }
      
      protected function onDead() : void
      {
         Engine.removeWorldObject(this);
      }
      
      protected function get particles() : Array
      {
         return this._particles;
      }
      
      protected function onBuried() : void
      {
         this.die();
      }
      
      public function set friction(param1:Number) : void
      {
         this._friction = Math.max(0,Math.min(1,param1));
      }
      
      protected function get defaultCost() : int
      {
         return 1;
      }
      
      private function checkChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:SolidRectangle = null;
         var _loc4_:RigidSolidRectangle = null;
         var _loc5_:SolidCircle = null;
         var _loc6_:MovieClip = null;
         if(numChildren)
         {
            _loc1_ = numChildren - 1;
            while(_loc1_ >= 0)
            {
               _loc2_ = getChildAt(_loc1_);
               if(_loc2_ is Primitive)
               {
                  if(_loc2_ is SolidRectangle)
                  {
                     _loc3_ = _loc2_ as SolidRectangle;
                     this._size = Math.max(_loc3_.particleWidth,this._size);
                     this._size = Math.max(_loc3_.particleHeight,this._size);
                     this.prepareParticle(_loc3_.getParticle());
                     _loc3_.cleanup();
                  }
                  else if(_loc2_ is RigidSolidRectangle)
                  {
                     _loc4_ = _loc2_ as RigidSolidRectangle;
                     this.prepareParticle(_loc4_.getParticle());
                     _loc4_.cleanup();
                  }
                  else if(_loc2_ is SolidCircle)
                  {
                     _loc5_ = _loc2_ as SolidCircle;
                     this._size = Math.max(_loc5_.particleRadius,this._size);
                     this.prepareParticle(_loc5_.getParticle());
                     _loc5_.cleanup();
                  }
                  else
                  {
                     trace("found unknown primitive");
                  }
               }
               else if(_loc2_ is TextField)
               {
                  this.processTextField(_loc2_ as TextField);
               }
               else if(_loc2_ is MovieClip)
               {
                  if((_loc6_ = _loc2_ as MovieClip).totalFrames >= 2)
                  {
                     this.addAnimClip(_loc6_);
                  }
               }
               _loc1_--;
            }
         }
         else
         {
            trace("world object has no internal children " + this);
         }
      }
      
      public function prepareForSimulation() : Boolean
      {
         if(this._gameState == GameState.SIMULATION)
         {
            return false;
         }
         this._gameState == GameState.SIMULATION;
         return true;
      }
      
      public function die() : void
      {
         trace("world object hasnt implemented die " + this);
      }
      
      public function get friction() : Number
      {
         return this._friction;
      }
      
      public function flagAsDestroyed() : void
      {
      }
      
      public function get hasDebris() : Boolean
      {
         return true;
      }
      
      protected function onAlive() : void
      {
      }
      
      protected function get anim() : MovieClip
      {
         return this._anim;
      }
   }
}
