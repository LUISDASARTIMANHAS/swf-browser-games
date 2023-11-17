package uk.co.kempt.system
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Point;
   import org.cove.ape.CollisionEvent;
   import org.cove.ape.RigidRectangle;
   import org.cove.ape.SpringConstraint;
   import org.cove.ape.Vector2;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.Lookup;
   import uk.co.kempt.data.NodeData;
   import uk.co.kempt.data.TrackNode;
   import uk.co.kempt.sounds.Snd;
   import uk.co.kempt.sounds.UnstoppableSounds;
   import uk.co.kempt.state.WorldObjectState;
   import uk.co.kempt.utils.MathUtil;
   import uk.co.kempt.utils.RangeFinder;
   import uk.co.kempt.world.Train;
   import uk.co.kempt.world.TrainCar;
   import uk.co.kempt.world.WorldObject;
   import uk.co.kempt.world.smashables.TrainCarSmashable;
   import uk.co.kempt.world.smashables.TrainSmashable;
   
   public class TrainSystem
   {
      
      private static const ACCELERATION:Number = 0.07;
      
      private static const DECELERATION_TRAIN_SLOWER:Number = 0.5;
      
      private static const NUMBER_OF_CARS:int = 10;
      
      public static const S_NORMAL:String = "normal";
      
      public static const CARRIAGE_SEPERATION:Number = 15;
      
      public static const S_CRASHING:String = "crashing";
      
      private static const END_OF_LINE_TIMEOUT:int = 160;
      
      private static const DECELERATION:Number = 0.35;
      
      private static const MIN_SPEED:Number = 2;
      
      private static const TOP_SPEED:Number = 5.5;
      
      private static const DECELERATION_CRASH:Number = 0.1;
      
      private static const NUMBER_OF_CARS_IN_TAIL:int = 0;
       
      
      private var _whipThresholdTime:int;
      
      private var _rangeFinder:RangeFinder;
      
      private var _train:Train;
      
      private var _trainRotationSpeeds:Vector.<Number>;
      
      private var _state:String;
      
      private var _smashables:Array;
      
      private var _hasExploded:Boolean;
      
      private var _endOfLineCount:int;
      
      private var _whipCharge:Number;
      
      private var _carriageConstraints:Array;
      
      private var _trainSqueakLoop:Snd;
      
      private var _speed:Number;
      
      private var _crashNode:TrackNode;
      
      private var _trainLoop:Snd;
      
      private var _currentNode:TrackNode;
      
      private var _distPastCurrentNode:Number;
      
      private var _crashPosition:Point;
      
      private var _waitToExplode:Boolean;
      
      private var _displacement:Number;
      
      private var _carriageParticles:Array;
      
      private var _cars:Array;
      
      public function TrainSystem(param1:NodeData, param2:DisplayObjectContainer)
      {
         var _loc3_:int = 0;
         super();
         this._currentNode = param1.getNode(0);
         this._displacement = 0;
         this._distPastCurrentNode = 0;
         this._speed = TOP_SPEED;
         this._endOfLineCount = 0;
         this._rangeFinder = new RangeFinder();
         this._state = S_NORMAL;
         this._whipCharge = 0;
         this._trainRotationSpeeds = new Vector.<Number>();
         this._smashables = [];
         this._train = new Train();
         this._cars = [];
         _loc3_ = 0;
         while(_loc3_ < NUMBER_OF_CARS)
         {
            this._cars.push(new TrainCar());
            _loc3_++;
         }
         this.positionTrain();
         this.createTail();
         this._trainLoop = Engine.instance.soundMan.loopSound(UnstoppableSounds.TRAIN_LOOP,0);
         this._trainSqueakLoop = Engine.instance.soundMan.loopSound(UnstoppableSounds.TRAIN_SQUEAK_LOOP,0);
         this._train.addEventListener("firstImpact",this.onTrainCollision,false,0,true);
         _loc3_ = this._cars.length - 1;
         while(_loc3_ >= 0)
         {
            param2.addChild(this._cars[_loc3_]);
            _loc3_--;
         }
         param2.addChild(this._train);
      }
      
      public static function getPositionAtNode(param1:TrackNode, param2:Number = 0) : Object
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc3_:Number = param1.x;
         var _loc4_:Number = param1.y;
         var _loc5_:Number = param1.angle / Math.PI * 180;
         if(param2 > 0)
         {
            _loc7_ = !!param1.latter ? MathUtil.radianAngle(param1.position,param1.latter.position) : param1.angle;
            _loc3_ += Math.cos(_loc7_) * param2;
            _loc4_ += Math.sin(_loc7_) * param2;
            if(param1.latter)
            {
               _loc6_ = param2 / param1.distanceToLatter;
               _loc5_ += MathUtil.radianDiff(param1.angle,param1.latter.angle) / Math.PI * 180 * _loc6_;
            }
         }
         else if(param2 < 0)
         {
            _loc7_ = !!param1.former ? MathUtil.radianAngle(param1.former.position,param1.position) : param1.angle;
            _loc3_ += Math.cos(_loc7_) * param2;
            _loc4_ += Math.sin(_loc7_) * param2;
            if(param1.former)
            {
               _loc6_ = -param2 / param1.distanceToFormer;
               _loc5_ += MathUtil.radianDiff(param1.angle,param1.former.angle) / Math.PI * 180 * _loc6_;
            }
         }
         return {
            "x":_loc3_,
            "y":_loc4_,
            "rotation":_loc5_,
            "angle":param1.angle
         };
      }
      
      public static function positionAtNode(param1:TrackNode, param2:DisplayObject, param3:Number = 0) : void
      {
         var _loc4_:Object = null;
         _loc4_ = getPositionAtNode(param1,param3);
         param2.x = _loc4_.x;
         param2.y = _loc4_.y;
         param2.rotation = _loc4_.rotation;
      }
      
      public function die() : void
      {
         this._train = null;
         this._currentNode = null;
         this._cars = null;
      }
      
      protected function set speed(param1:Number) : void
      {
         this._speed = Math.max(this.isCrashing ? 0 : MIN_SPEED,Math.min(TOP_SPEED,param1));
      }
      
      public function get train() : Train
      {
         return this._train;
      }
      
      private function updateNormal() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         this._train.update();
         this.positionTailByContraints();
         var _loc1_:NodeData = this._currentNode.parent;
         if(this._endOfLineCount <= 0)
         {
            _loc5_ = _loc1_.getNodeIndex(Engine.instance.trackBuilder.exitNode || Engine.instance.trackBuilder.currentNode);
            if(_loc1_.getNodeIndex(this._currentNode) >= _loc5_)
            {
               this.onEndOfLineReached();
            }
         }
         else
         {
            this._endOfLineCount += 3;
         }
         var _loc2_:Number = (this._train.x - Engine.GAME_WIDTH / 2) / Engine.GAME_WIDTH;
         var _loc3_:Number = 0.8;
         _loc2_ = Number(Math.max(-_loc3_,Math.min(_loc3_,_loc2_)));
         if(this._trainLoop)
         {
            _loc4_ = this.speed / TOP_SPEED;
            if(this.train.x < 0 || this.train.x > Engine.GAME_WIDTH)
            {
               _loc4_ = 0.6;
            }
            this._trainLoop.volume += (_loc4_ - this._trainLoop.volume) / 6;
            this._trainLoop.pan = _loc2_;
         }
         if(this._trainSqueakLoop)
         {
            this._trainSqueakLoop.volume = Math.abs(TrainCar(this._cars[0]).leanRatio);
            this._trainSqueakLoop.pan = _loc2_;
         }
      }
      
      private function positionTail() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Vector2 = null;
         var _loc1_:RigidRectangle = this._carriageParticles[0];
         var _loc2_:TrainCar = this._cars[this._cars.length - 1 - NUMBER_OF_CARS_IN_TAIL];
         if(!_loc2_)
         {
            trace("no last car");
         }
         if(_loc1_)
         {
            _loc3_ = _loc2_.rotation / 180 * Math.PI;
            _loc4_ = 8 - this.speed;
            _loc5_ = new Vector2(_loc2_.x,_loc2_.y).minus(new Vector2(_loc4_ * Math.cos(_loc3_),_loc4_ * Math.sin(_loc3_)));
            _loc1_.position = _loc5_;
            _loc1_.velocity = new Vector2();
         }
      }
      
      public function slow() : void
      {
         this.speed -= DECELERATION_TRAIN_SLOWER;
      }
      
      public function get isCrashing() : Boolean
      {
         return this._state == S_CRASHING;
      }
      
      public function crash(param1:Array = null) : void
      {
         if(Engine.instance.trackBuilder.exitNode)
         {
            if(this._currentNode.index >= Engine.instance.trackBuilder.exitNode.index)
            {
               return;
            }
         }
         if(this._state != S_CRASHING)
         {
            this._crashNode = this._currentNode;
            this._crashPosition = !!param1 ? WorldObject(param1[0]).position : this._crashNode.position;
            ++this._endOfLineCount;
            this._state = S_CRASHING;
            this.train.state = S_CRASHING;
            this.createTrainSmashable();
            this.train.visible = false;
            this.train.disable();
            Engine.instance.onTrainCrash(param1);
         }
      }
      
      private function createTrainSmashable() : void
      {
         var _loc1_:TrainSmashable = new TrainSmashable();
         var _loc2_:RigidRectangle = _loc1_.particle as RigidRectangle;
         _loc2_.px = this.train.x;
         _loc2_.py = this.train.y;
         _loc2_.angle = this.train.rotation;
         _loc1_.destroy(null);
         _loc2_.velocity = this.train.trainParticle.velocity.mult(1.2);
         _loc1_.updateBeforeAPE();
         _loc1_.update();
         this.train;
         Engine.instance.currentLevel.addChild(_loc1_);
      }
      
      private function getCombinedRotationSpeed() : Number
      {
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._trainRotationSpeeds.length)
         {
            _loc1_ += this._trainRotationSpeeds[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function onTailCollision(param1:CollisionEvent) : void
      {
         var _loc3_:WorldObject = null;
         var _loc4_:* = false;
         var _loc2_:Object = Lookup.getParent(param1.collidingItem);
         if(_loc2_ is WorldObject)
         {
            _loc3_ = _loc2_ as WorldObject;
            _loc4_ = _loc3_.state == WorldObjectState.ALIVE;
            _loc3_.destroy(null);
         }
      }
      
      private function positionTailByContraints() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SpringConstraint = null;
         var _loc3_:TrainCar = null;
         _loc1_ = 0;
         while(_loc1_ < this._carriageConstraints.length)
         {
            _loc2_ = this._carriageConstraints[_loc1_];
            _loc3_ = this._cars[this._cars.length - NUMBER_OF_CARS_IN_TAIL + _loc1_];
            _loc3_.x = _loc2_.center.x;
            _loc3_.y = _loc2_.center.y;
            _loc3_.rotation = _loc2_.angle;
            _loc1_++;
         }
      }
      
      private function updateCrashing() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TrainCar = null;
         ++this._endOfLineCount;
         this.positionTailByContraints();
         if(this._endOfLineCount % 2 == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._cars.length)
            {
               _loc2_ = this._cars[_loc1_];
               if(Boolean(_loc2_) && !_loc2_.isCrashing)
               {
                  break;
               }
               _loc1_++;
            }
         }
         if(this.isExploding)
         {
            _loc1_ = 0;
            while(_loc1_ < this._cars.length)
            {
               if(this._cars[_loc1_].visible)
               {
                  this._cars[_loc1_].destroy();
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this._smashables.length)
            {
               this._smashables[_loc1_].destroy(null);
               _loc1_++;
            }
            this._hasExploded = true;
            Engine.instance.particleEngine.spawnEpicExplosion(this._crashPosition);
         }
         if(this._trainLoop)
         {
            this._trainLoop.volume = 0;
         }
         if(this._trainSqueakLoop)
         {
            this._trainSqueakLoop.volume = 0;
         }
      }
      
      protected function get speed() : Number
      {
         return this._speed;
      }
      
      public function update() : void
      {
         switch(this._state)
         {
            case S_NORMAL:
               this.updateBeforeAPENormal();
               break;
            case S_CRASHING:
               this.updateBeforeAPECrashing();
         }
      }
      
      private function onEndOfLineReached() : void
      {
         if(Engine.instance.trackBuilder.hasReachedExit)
         {
            ++this._endOfLineCount;
         }
         else
         {
            this._waitToExplode = true;
            this.crash();
         }
      }
      
      public function updateBeforeAPE() : void
      {
         switch(this._state)
         {
            case S_NORMAL:
               this.updateNormal();
               break;
            case S_CRASHING:
               this.updateCrashing();
         }
      }
      
      public function get isExploding() : Boolean
      {
         return this._endOfLineCount == int(this._waitToExplode ? 60 : 2);
      }
      
      private function updateBeforeAPENormal() : void
      {
         if(!this._currentNode)
         {
            return;
         }
         var _loc1_:Number = this._train.rotation / 180 * Math.PI;
         this._displacement += this.speed;
         this._distPastCurrentNode += this.speed;
         this.positionTrain();
         this._train.updateBeforeAPE();
         this.speed += ACCELERATION;
         var _loc2_:Number = MathUtil.radianDiff(_loc1_,this._train.rotation / 180 * Math.PI);
         var _loc3_:Number = Math.max(0,Math.min(1,_loc2_ / 0.3)) * 0.5;
         this.speed -= _loc3_ * DECELERATION;
         this.positionTail();
         this._trainRotationSpeeds.push(_loc2_);
         if(this._trainRotationSpeeds.length > 5)
         {
            this._trainRotationSpeeds.shift();
         }
         if(Math.abs(this.getCombinedRotationSpeed()) > Math.PI / 2.5)
         {
            this._waitToExplode = true;
            Engine.instance.levelStatistics.hitSteepCorner = true;
            this.crash();
         }
      }
      
      private function onTrainCollision(param1:Event) : void
      {
         this.speed -= DECELERATION;
      }
      
      public function get hasExploded() : Boolean
      {
         return this._hasExploded;
      }
      
      private function positionTrain() : void
      {
         var _loc6_:TrainCar = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(!this._currentNode)
         {
            trace("TrainSystem: no nodes");
            return;
         }
         var _loc1_:Number = this._currentNode.distanceToLatter;
         while(this._distPastCurrentNode >= _loc1_)
         {
            this._distPastCurrentNode -= _loc1_;
            this._currentNode = this._currentNode.latter;
            if(!this._currentNode)
            {
               trace("ran out of nodes");
               break;
            }
            _loc1_ = this._currentNode.distanceToLatter;
         }
         positionAtNode(this._currentNode,this._train,this._distPastCurrentNode);
         var _loc2_:TrackNode = this._currentNode;
         var _loc3_:Number = 17;
         var _loc4_:Number = -this._distPastCurrentNode + 6;
         var _loc5_:Number = _loc2_.distanceToFormer;
         if(!isNaN(_loc5_))
         {
            _loc7_ = 0;
            while(_loc7_ < this._cars.length)
            {
               _loc4_ += _loc3_;
               while(_loc4_ >= _loc5_)
               {
                  _loc4_ -= _loc5_;
                  _loc2_ = _loc2_.former;
                  if(!_loc2_)
                  {
                     break;
                  }
                  _loc5_ = _loc2_.distanceToFormer;
               }
               (_loc6_ = this._cars[_loc7_]).trackPosition = getPositionAtNode(_loc2_,-_loc4_);
               if(true || !_loc6_.isCrashing)
               {
                  if(_loc7_ < this._cars.length - NUMBER_OF_CARS_IN_TAIL)
                  {
                     _loc6_.useTrackPosition();
                  }
               }
               if(this._state == S_CRASHING)
               {
                  _loc8_ = this._crashNode.parent.getNodeIndex(this._crashNode);
                  if((_loc9_ = _loc2_.parent.getNodeIndex(_loc2_)) >= _loc8_)
                  {
                     if(_loc6_.visible)
                     {
                        _loc6_.visible = false;
                        this.createTrainCarSmashable(_loc6_,_loc7_ % 2 - 0.5);
                     }
                  }
               }
               _loc6_.updateBeforeAPE();
               _loc7_++;
            }
         }
      }
      
      private function updateBeforeAPECrashing() : void
      {
         if(this.speed == 0)
         {
            return;
         }
         this._displacement += this.speed;
         this._distPastCurrentNode += this.speed;
         this.positionTrain();
         this._train.updateBeforeAPE();
         if(this.speed > 0)
         {
            this.speed = Math.max(0,this.speed - DECELERATION_CRASH);
         }
         this.positionTail();
      }
      
      private function createTrainCarSmashable(param1:TrainCar, param2:Number) : void
      {
         var _loc3_:TrainCarSmashable = new TrainCarSmashable();
         var _loc4_:RigidRectangle;
         (_loc4_ = _loc3_.particle as RigidRectangle).position = new Vector2(param1.x,param1.y);
         _loc4_.angle = param1.rotation;
         var _loc5_:Number = this._crashNode.angle;
         var _loc6_:Number = 8;
         var _loc7_:Number = 1.6;
         _loc4_.velocity = new Vector2(param1.speedX * _loc7_,param1.speedY * _loc7_);
         _loc4_.angularVelocity = param2 * 0.3;
         this._smashables.push(_loc3_);
         Engine.instance.currentLevel.addChild(_loc3_);
      }
      
      private function createTail() : void
      {
         var _loc2_:int = 0;
         var _loc7_:RigidRectangle = null;
         var _loc8_:RigidRectangle = null;
         var _loc9_:RigidRectangle = null;
         var _loc10_:SpringConstraint = null;
         var _loc11_:int = 0;
         var _loc12_:TrainCar = null;
         this._carriageParticles = [];
         this._carriageConstraints = [];
         if(NUMBER_OF_CARS_IN_TAIL < 1)
         {
            return;
         }
         var _loc1_:int = NUMBER_OF_CARS_IN_TAIL;
         var _loc3_:TrainCar = this._cars[this._cars.length - 1];
         var _loc4_:Point = new Point(this.train.x,this.train.y);
         var _loc5_:Number = _loc3_.rotation / 180 * Math.PI;
         var _loc6_:Point = new Point(Math.cos(_loc5_) * CARRIAGE_SEPERATION,Math.sin(_loc5_) * CARRIAGE_SEPERATION);
         _loc4_.x += Math.cos(_loc5_) * -CARRIAGE_SEPERATION * this._cars.length;
         _loc4_.y += Math.sin(_loc5_) * -CARRIAGE_SEPERATION * this._cars.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_ + 1)
         {
            (_loc7_ = new RigidRectangle(_loc4_.x,_loc4_.y,8,8,_loc5_,false,1,0,0)).mass = _loc2_ == 0 ? 100 : 15;
            _loc7_.collidable = true;
            _loc7_.addEventListener(CollisionEvent.COLLIDE,this.onTailCollision,false,0,true);
            this._carriageParticles.push(_loc7_);
            _loc4_ = _loc4_.subtract(_loc6_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._carriageParticles.length - 1)
         {
            _loc8_ = this._carriageParticles[_loc2_];
            _loc9_ = this._carriageParticles[_loc2_ + 1];
            _loc10_ = new SpringConstraint(_loc8_,_loc9_,1,false,5);
            this._carriageConstraints.push(_loc10_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._carriageParticles.length)
         {
            Engine.instance.addParticle(this._carriageParticles[_loc2_]);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._carriageConstraints.length)
         {
            Engine.instance.addConstraint(this._carriageConstraints[_loc2_]);
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ < this._carriageParticles.length)
         {
            _loc11_ = this._cars.length - 1 - NUMBER_OF_CARS_IN_TAIL + _loc2_;
            (_loc12_ = this._cars[_loc11_]).rearParticle = this._carriageParticles[_loc2_];
            _loc12_.rotationSpeedThreshold = TrainCar.DEFAULT_ROTATION_SPEED_THRESHOLD + TrainCar.DEFAULT_ROTATION_SPEED_THRESHOLD_INCREMENT * (NUMBER_OF_CARS_IN_TAIL - _loc2_);
            _loc12_.sibling = this._cars[_loc11_ - 1];
            _loc2_++;
         }
      }
      
      public function get endCar() : TrainCar
      {
         return this._cars[this._cars.length - 1];
      }
      
      public function get reachedEndOfLine() : Boolean
      {
         return this._endOfLineCount >= END_OF_LINE_TIMEOUT;
      }
      
      public function fadeOutSound() : void
      {
         if(this._trainLoop)
         {
            this._trainLoop.fadeTo(0,2);
         }
         if(this._trainSqueakLoop)
         {
            this._trainSqueakLoop.fadeTo(0,2);
         }
      }
      
      public function get middleCar() : TrainCar
      {
         return this._cars[Math.floor(this._cars.length / 2)];
      }
   }
}
