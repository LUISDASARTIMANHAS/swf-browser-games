package uk.co.kempt.system
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   import org.cove.ape.CollisionEvent;
   import org.cove.ape.RigidCircle;
   import org.cove.ape.Vector2;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.Lookup;
   import uk.co.kempt.data.NodeData;
   import uk.co.kempt.data.SpriteData;
   import uk.co.kempt.data.TrackNode;
   import uk.co.kempt.display.particles.BuildingDustGrouped;
   import uk.co.kempt.sounds.Snd;
   import uk.co.kempt.sounds.UnstoppableSounds;
   import uk.co.kempt.world.Building;
   import uk.co.kempt.world.Choppa;
   import uk.co.kempt.world.WorldObject;
   import uk.co.kempt.world.nonstatic.BridgeBuilderVehicle;
   import uk.co.kempt.world.nonstatic.TrackBuilderTruck;
   import uk.co.kempt.world.nonstatic.TrackBuilderVehicle;
   import uk.co.kempt.world.nonstatic.Workman;
   import uk.co.kempt.world.statics.Restriction;
   
   public class TrackBuilder
   {
      
      private static const ACCELERATION:Number = 0.2;
      
      private static const S_WAIT:String = "wait";
      
      private static const BRIDGE_COST:int = 30000;
      
      private static const S_CRASHING:String = "crashing";
      
      private static const RADIUS:Number = 10 / 2;
      
      private static const WORKMAN_RANGE:Number = 70;
      
      private static const WORKMAN_RANGE_SQUARED:Number = WORKMAN_RANGE * WORKMAN_RANGE;
      
      private static const TIME_TO_CHARGE_FOR_BRIDGE:int = Engine.GAME_FRAMERATE * 2;
      
      private static const S_BRIDGING:String = "bridging";
      
      private static const S_MOVING:String = "moving";
      
      public static const TOP_SPEED:Number = 3;
      
      private static const DECELERATION:Number = 0.4;
       
      
      private var _bridgeAmt:int;
      
      private var _currentBridgeNode:TrackNode;
      
      private var _crashIndex:int;
      
      private var _distPastCurrentBridgeNode:Number;
      
      private var _bridgeEnd:TrackNode;
      
      private var _choppaReachedBridgeEnd:Boolean;
      
      private var _collisions:Array;
      
      private var _demolishSound:Snd;
      
      private var _nodeData:NodeData;
      
      private var _constructionSound:Snd;
      
      private var _bridgeSound:Snd;
      
      private var _speed:Number;
      
      private var _previous:Point;
      
      private var _currentNode:TrackNode;
      
      private var _truck:TrackBuilderTruck;
      
      private var _builder:BuildingDustGrouped;
      
      private var _distPastCurrentNode:Number;
      
      private var _pastLocations:Array;
      
      private var _bridgeVehicle:BridgeBuilderVehicle;
      
      private var _workers:Array;
      
      private var _display:DisplayObjectContainer;
      
      private var _choppaReachedBridge:Boolean;
      
      private var _collidingWithRestriction:Boolean;
      
      private var _state:String;
      
      private var _choppa:Choppa;
      
      private var _bridgeStart:TrackNode;
      
      private var _exitNode:TrackNode;
      
      private var _hasReachedExit:Boolean;
      
      private var _collidingWithBuilding:Boolean;
      
      private var _crashPoint:Point;
      
      private var _sprite:Sprite;
      
      private var _particle:RigidCircle;
      
      private var _nonRestrictionCollisionTime:int;
      
      private var _vehicle:TrackBuilderVehicle;
      
      private var _displacement:Number;
      
      public function TrackBuilder(param1:NodeData, param2:DisplayObjectContainer)
      {
         super();
         this._nodeData = param1;
         this._displacement = 0;
         this._distPastCurrentNode = 0;
         this._speed = TOP_SPEED;
         this._state = S_WAIT;
         this._display = param2;
         this._pastLocations = [];
         this._hasReachedExit = false;
         this._crashIndex = -1;
         this._bridgeAmt = TIME_TO_CHARGE_FOR_BRIDGE - 1;
         this._sprite = this.createSprite();
         this._builder = new BuildingDustGrouped();
         this._vehicle = new TrackBuilderVehicle();
         this._truck = new TrackBuilderTruck();
         this._bridgeVehicle = new BridgeBuilderVehicle();
         this._choppa = new Choppa();
         this._workers = this.createWorkers();
         this._bridgeVehicle.visible = false;
         this._constructionSound = Engine.instance.soundMan.loopSound(UnstoppableSounds.CONSTRUCTION,0);
         this._demolishSound = Engine.instance.soundMan.loopSound(UnstoppableSounds.CONSTRUCTION_THROUGH_BUILDING,0);
         this._bridgeSound = Engine.instance.soundMan.loopSound(UnstoppableSounds.CONSTRUCTION_BRIDGES,0);
         Engine.instance.addParticle(this.particle);
         this._sprite.addChild(this._builder);
         this._sprite.addChild(this._vehicle);
         param2.addChild(this._sprite);
         param2.addChild(this._truck);
         param2.addChild(this._bridgeVehicle);
         param2.addChild(this._choppa);
      }
      
      private function get isLastNode() : Boolean
      {
         return this._nodeData.getNode(this._nodeData.length - 1) == this._currentNode || this.reachedCrashPoint;
      }
      
      private function onBrushCollisionEvent(param1:CollisionEvent) : void
      {
         var _loc3_:WorldObject = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this.hasReachedExit)
         {
            return;
         }
         var _loc2_:Object = Lookup.getParent(param1.collidingItem);
         if(_loc2_ is WorldObject)
         {
            _loc3_ = _loc2_ as WorldObject;
            this.collisions.push(_loc3_);
            if(_loc3_ is Building)
            {
               this._collidingWithBuilding = true;
            }
            if(_loc3_ is Restriction)
            {
               if(!this._bridgeStart)
               {
                  this._bridgeEnd = null;
                  this._state = S_BRIDGING;
                  this._currentBridgeNode = this._bridgeStart = this._currentNode;
                  Engine.instance.animateScreen.currentBridgeIndex = this._bridgeStart.parent.getNodeIndex(this._bridgeStart);
                  this._distPastCurrentBridgeNode = this._distPastCurrentNode;
                  this._choppaReachedBridge = false;
                  _loc4_ = this.getClosestCorner(this._bridgeStart.position);
                  this._choppa.x = _loc4_.x;
                  this._choppa.y = _loc4_.y;
                  this._choppa.flyToTarget(this._bridgeStart);
               }
               else if(this._bridgeEnd)
               {
                  _loc5_ = this._bridgeEnd.parent.getNodeIndex(this._bridgeEnd);
                  if((_loc6_ = this._currentNode.parent.getNodeIndex(this._currentNode)) > _loc5_)
                  {
                     this._bridgeStart = null;
                     this._bridgeEnd = null;
                  }
               }
               this._collidingWithRestriction = true;
            }
         }
      }
      
      private function createWorkers() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc1_.push(this.createWorker());
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get crashPoint() : Point
      {
         return this._crashPoint;
      }
      
      public function get currentNode() : TrackNode
      {
         return this._currentNode;
      }
      
      private function positionBridgeBuilder() : void
      {
         var _loc1_:Number = this._currentBridgeNode.distanceToLatter;
         while(this._distPastCurrentBridgeNode >= _loc1_)
         {
            this._distPastCurrentBridgeNode -= _loc1_;
            if(!this._currentBridgeNode.latter)
            {
               trace("ran out of nodes");
               break;
            }
            this._currentBridgeNode = this._currentBridgeNode.latter;
            _loc1_ = this._currentBridgeNode.distanceToLatter;
         }
         TrainSystem.positionAtNode(this._currentBridgeNode,this._bridgeVehicle,this._distPastCurrentBridgeNode);
      }
      
      public function get collidingWithRestriction() : Boolean
      {
         return this._collidingWithRestriction;
      }
      
      public function get reachedCrashPoint() : Boolean
      {
         var _loc1_:Number = NaN;
         return false;
      }
      
      public function updateBeforeAPE() : void
      {
         this._choppa.updateBeforeAPE();
         this._collisions = null;
         this._collidingWithBuilding = false;
         this._collidingWithRestriction = false;
         if(this._state == S_MOVING)
         {
            this._previous = this.current.clone();
            if(this._speed < TOP_SPEED)
            {
               this._speed = Math.min(TOP_SPEED,this._speed + ACCELERATION);
            }
            this._displacement += this._speed;
            this._distPastCurrentNode += this._speed;
            this.positionSprite();
            this.particle.velocity = new Vector2(this._sprite.x - this.particle.px,this._sprite.y - this.particle.py);
            this.particle.angularVelocity = 0;
         }
         else if(this._state == S_BRIDGING)
         {
            if(this._choppaReachedBridge && !this._bridgeEnd)
            {
               this._speed = Math.min(TOP_SPEED,this._speed + ACCELERATION);
               this._distPastCurrentBridgeNode += this._speed;
               if(!this._bridgeVehicle.visible)
               {
                  this._bridgeVehicle.visible = true;
               }
               this.positionBridgeBuilder();
               ++this._bridgeAmt;
               this.particle.velocity = new Vector2(this._bridgeVehicle.x - this.particle.px,this._bridgeVehicle.y - this.particle.py);
               this.particle.angularVelocity = 0;
            }
            else
            {
               this.particle.velocity = new Vector2();
               this.particle.angularVelocity = 0;
            }
         }
         else
         {
            this.particle.velocity = new Vector2();
            this.particle.angularVelocity = 0;
         }
      }
      
      public function get exitNode() : TrackNode
      {
         return this._exitNode;
      }
      
      public function set crashPoint(param1:Point) : void
      {
         this._crashPoint = param1;
      }
      
      private function positionSprite() : void
      {
         var _loc1_:Number = this._currentNode.distanceToLatter;
         while(this._distPastCurrentNode >= _loc1_)
         {
            this._distPastCurrentNode -= _loc1_;
            if(!this._currentNode.latter)
            {
               trace("ran out of nodes");
               break;
            }
            this._currentNode = this._currentNode.latter;
            _loc1_ = this._currentNode.distanceToLatter;
         }
         TrainSystem.positionAtNode(this._currentNode,this._sprite,this._distPastCurrentNode);
         this._builder.rotation = -this._sprite.rotation;
      }
      
      private function getClosestCorner(param1:Point) : Point
      {
         return new Point(param1.x < Engine.GAME_WIDTH / 2 ? 0 : Engine.GAME_WIDTH,param1.y < Engine.GAME_HEIGHT / 2 ? 0 : Engine.GAME_HEIGHT);
      }
      
      public function get crashIndex() : int
      {
         return this._crashIndex;
      }
      
      private function updateMoving() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:SpriteData = null;
         var _loc5_:Point = null;
         var _loc6_:Number = NaN;
         this._choppa.update();
         if(this._choppa.reachedTarget)
         {
            this._choppa.clearTarget();
         }
         if(!this._builder.visible)
         {
            this._builder.visible = true;
         }
         this.checkCollisions();
         if(this.isLastNode)
         {
            this._state = S_WAIT;
         }
         if(Engine.instance.gameTime % 1 == 0)
         {
            Engine.instance.particleEngine.spawnDust(this.current);
         }
         this._workers.forEach(this.checkAndUpdateWorker);
         this._pastLocations.push(new SpriteData(this._sprite.x,this._sprite.y,this._sprite.rotation));
         if(this._pastLocations.length > 15)
         {
            _loc4_ = this._pastLocations.shift() as SpriteData;
            this._truck.x = _loc4_.x;
            this._truck.y = _loc4_.y;
            this._truck.rotation = _loc4_.rotation;
         }
         if(!this.hasReachedExit)
         {
            if((_loc6_ = (_loc5_ = Engine.instance.currentLevel.exit.position.subtract(this.current)).x * _loc5_.x + _loc5_.y * _loc5_.y) < Engine.instance.currentLevel.exit.radiusSquared)
            {
               this._hasReachedExit = true;
               this._exitNode = this.currentNode;
            }
         }
         var _loc1_:Number = (this.current.x - Engine.GAME_WIDTH / 2) / Engine.GAME_WIDTH;
         var _loc2_:Boolean = this.isLastNode;
         if(this._constructionSound)
         {
            _loc3_ = _loc2_ ? 0 : Number(Math.max(0.7,this._speed / TOP_SPEED));
            this._constructionSound.volume += (_loc3_ - this._constructionSound.volume) / 6;
            this._constructionSound.pan = _loc1_;
         }
         if(this._demolishSound)
         {
            _loc3_ = _loc2_ ? 0 : (this._collidingWithBuilding ? 1 : 0);
            this._demolishSound.volume += (_loc3_ - this._demolishSound.volume) / 6;
            this._demolishSound.pan = _loc1_;
         }
         if(this._bridgeSound)
         {
            _loc3_ = 0;
            this._bridgeSound.volume += (_loc3_ - this._bridgeSound.volume) / 6;
         }
      }
      
      public function get current() : Point
      {
         return new Point(this._sprite.x,this._sprite.y);
      }
      
      public function die() : void
      {
         if(this._constructionSound)
         {
            this._constructionSound.die();
         }
         if(this._demolishSound)
         {
            this._demolishSound.die();
         }
         if(this._bridgeSound)
         {
            this._bridgeSound.die();
         }
         this._particle = null;
         this._builder = null;
         this._vehicle = null;
         this._truck = null;
         this._workers = null;
         this._display = null;
         this._sprite = null;
         this._nodeData = null;
         this._constructionSound = null;
         this._demolishSound = null;
         this._bridgeSound = null;
      }
      
      private function get collisions() : Array
      {
         return this._collisions = this._collisions || [];
      }
      
      public function get currentBridgeNode() : TrackNode
      {
         return this._currentBridgeNode;
      }
      
      public function get particle() : RigidCircle
      {
         return this._particle = this._particle || this.createParticle();
      }
      
      public function get hasReachedExit() : Boolean
      {
         return this._hasReachedExit;
      }
      
      private function createWorker() : Workman
      {
         var _loc1_:Workman = new Workman();
         _loc1_.x = Engine.instance.currentLevel.entrance.x;
         _loc1_.y = Engine.instance.currentLevel.entrance.y;
         this._display.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createParticle() : RigidCircle
      {
         var _loc1_:RigidCircle = new RigidCircle(this._sprite.x,this._sprite.y,RADIUS);
         _loc1_.solid = false;
         _loc1_.addEventListener(CollisionEvent.COLLIDE,this.onBrushCollisionEvent,false,0,true);
         Lookup.register(_loc1_,this);
         return _loc1_;
      }
      
      public function crash() : void
      {
         this._state = S_CRASHING;
      }
      
      private function checkCollisions() : void
      {
         var _loc1_:WorldObject = null;
         if(this.collisions.length)
         {
            _loc1_ = this.collisions[0];
            if(this._state == S_BRIDGING || !(_loc1_ is Restriction))
            {
               this._speed *= 1 - _loc1_.friction;
            }
         }
         if(this.collidingWithRestriction)
         {
            this._nonRestrictionCollisionTime = 0;
         }
         else
         {
            ++this._nonRestrictionCollisionTime;
         }
      }
      
      public function get collidingWithBuilding() : Boolean
      {
         return this._collidingWithBuilding;
      }
      
      private function updateCrashing() : void
      {
         var _loc1_:Number = NaN;
         if(this._constructionSound)
         {
            _loc1_ = 0;
            this._constructionSound.volume += (_loc1_ - this._constructionSound.volume) / 6;
         }
         if(this._demolishSound)
         {
            _loc1_ = 0;
            this._demolishSound.volume += (_loc1_ - this._demolishSound.volume) / 6;
         }
         if(this._bridgeSound)
         {
            _loc1_ = 0;
            this._bridgeSound.volume += (_loc1_ - this._bridgeSound.volume) / 6;
         }
      }
      
      public function update() : void
      {
         switch(this._state)
         {
            case S_WAIT:
               this.updateWait();
               break;
            case S_MOVING:
               this.updateMoving();
               break;
            case S_BRIDGING:
               this.updateBridging();
               break;
            case S_CRASHING:
               this.updateCrashing();
         }
      }
      
      public function set crashIndex(param1:int) : void
      {
         this._crashIndex = param1;
      }
      
      private function updateWait() : void
      {
         var _loc2_:Number = NaN;
         if(this._builder.visible)
         {
            this._builder.visible = false;
         }
         if(!this._currentNode)
         {
            if(this._nodeData.length)
            {
               this._currentNode = this._nodeData.getNode(0);
               this._state = S_MOVING;
            }
         }
         else if(!this.isLastNode)
         {
            this._state = S_MOVING;
         }
         var _loc1_:Boolean = this.isLastNode;
         if(this._constructionSound)
         {
            _loc2_ = _loc1_ ? 0 : 0.1;
            this._constructionSound.volume += (_loc2_ - this._constructionSound.volume) / 6;
         }
         if(this._demolishSound)
         {
            _loc2_ = 0;
            this._demolishSound.volume += (_loc2_ - this._demolishSound.volume) / 6;
         }
         if(this._bridgeSound)
         {
            _loc2_ = 0;
            this._bridgeSound.volume += (_loc2_ - this._bridgeSound.volume) / 6;
         }
      }
      
      public function prepareForSimulation() : void
      {
      }
      
      private function updateBridging() : void
      {
         var _loc1_:Number = NaN;
         this._choppa.update();
         if(!this._choppaReachedBridge)
         {
            if(this._choppa.reachedTarget)
            {
               if(this._choppa.atTargetFor > 20)
               {
                  this._choppaReachedBridge = true;
                  this._choppa.flyToTargetPoint(this.getClosestCorner(this._choppa.position));
               }
            }
         }
         else
         {
            if(!this._bridgeEnd)
            {
               this.checkCollisions();
               if(!this.collidingWithRestriction)
               {
                  if(this._nonRestrictionCollisionTime > 3)
                  {
                     this._bridgeEnd = this._currentBridgeNode;
                     this._bridgeVehicle.visible = false;
                     this._state = S_MOVING;
                     this._choppaReachedBridge = false;
                     this._choppaReachedBridgeEnd = false;
                     this._currentBridgeNode = null;
                  }
               }
            }
            if(this._choppa.atTargetFor > 10)
            {
               this._choppa.clearTarget();
            }
         }
         var _loc2_:Number = (this.current.x - Engine.GAME_WIDTH / 2) / Engine.GAME_WIDTH;
         if(this._constructionSound)
         {
            _loc1_ = 0;
            this._constructionSound.volume += (_loc1_ - this._constructionSound.volume) / 6;
         }
         if(this._bridgeSound)
         {
            _loc1_ = !!this._bridgeVehicle.visible ? 1 : 0;
            this._bridgeSound.volume += (_loc1_ - this._bridgeSound.volume) / 6;
            this._bridgeSound.pan = _loc2_;
         }
         var _loc3_:int = TIME_TO_CHARGE_FOR_BRIDGE;
         if(this._bridgeAmt >= _loc3_)
         {
            this._bridgeAmt -= _loc3_;
            Engine.instance.accost2(BRIDGE_COST,new Point(this._bridgeVehicle.x,this._bridgeVehicle.y - 10));
         }
      }
      
      private function createSprite() : Sprite
      {
         return new Sprite();
      }
      
      private function checkAndUpdateWorker(param1:Workman, param2:int, param3:Array) : void
      {
         var _loc4_:Point = this.current;
         var _loc5_:Number;
         if((_loc5_ = Math.pow(_loc4_.x - param1.x,2) + Math.pow(_loc4_.y - param1.y,2)) >= WORKMAN_RANGE_SQUARED)
         {
            _loc4_.x += (Math.random() - 0.5) * 25;
            _loc4_.y += (Math.random() - 0.5) * 25;
            param1.destination = _loc4_;
         }
         param1.update();
      }
      
      public function get previous() : Point
      {
         return this._previous;
      }
   }
}
