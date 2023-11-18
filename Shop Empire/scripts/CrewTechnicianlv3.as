package
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="CrewTechnicianlv3")]
   public dynamic class CrewTechnicianlv3 extends MovieClip
   {
       
      
      public var toiletTarget:*;
      
      public var worldX:*;
      
      public var backDelay:*;
      
      public var crewNote:*;
      
      public var homePos:*;
      
      public var worldY:*;
      
      public var isRepairing:*;
      
      public var elevatorTarget:*;
      
      public var rideElevator:*;
      
      public var destination:*;
      
      public var myParent:*;
      
      public var dirrection:*;
      
      public var nameType:*;
      
      public var delay:*;
      
      public var waiting:*;
      
      public var floorPos:*;
      
      public var repairingTime:*;
      
      public var shiftFloor:*;
      
      public var elevatorFloor:*;
      
      public var dx:*;
      
      public var salary:*;
      
      public var ancestor:MovieClip;
      
      public var hasALegend:*;
      
      public var elevatorChecked:*;
      
      public var cLevel:*;
      
      public var speedX:*;
      
      public var goHome:*;
      
      public function CrewTechnicianlv3()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3);
      }
      
      public function BackToWork(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < myParent.gameSpeed)
         {
            if(goHome)
            {
               dx = 0;
               --backDelay;
               if(backDelay <= 0)
               {
                  backDelay = 50;
                  if(myParent.dayTime >= 8)
                  {
                     if(myParent.dayTime >= 9)
                     {
                        goHome = false;
                     }
                     else
                     {
                        _loc3_ = Math.random() * 100;
                        if(_loc3_ < 60)
                        {
                           goHome = false;
                        }
                     }
                  }
               }
            }
            else
            {
               if(worldX < myParent.mallLeft)
               {
                  dx = speedX;
               }
               if(worldX > myParent.mallLeft + myParent.mallWidth)
               {
                  dx = -speedX;
               }
               worldX += dx;
            }
            if(worldX > myParent.mallLeft && worldX < myParent.mallLeft + myParent.mallWidth)
            {
               _loc2_ = myParent.gameSpeed;
               removeEventListener(Event.ENTER_FRAME,BackToWork);
               addEventListener(Event.ENTER_FRAME,Behavior);
            }
            _loc2_++;
         }
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      public function minValue(param1:Array) : Number
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = Math.floor(Math.random() * param1.length);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc2_] > param1[_loc3_])
            {
               _loc2_ = _loc3_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      public function Animation(param1:Event) : void
      {
         if(dx == 0)
         {
            if(this.currentFrame != 2)
            {
               gotoAndPlay(2);
            }
         }
         else if(this.currentFrame != 3)
         {
            gotoAndPlay(3);
         }
         if(dx > 0)
         {
            dirrection = 1;
            this.scaleX = 1;
         }
         else if(dx < 0)
         {
            dirrection = -1;
            this.scaleX = -1;
         }
      }
      
      public function scanTarget() : MovieClip
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < myParent.tenantParent.numChildren)
         {
            _loc3_ = myParent.tenantParent.getChildAt(_loc2_);
            if(!(_loc3_ is SupportElevator) && !(_loc3_ is SupportRestroom) && _loc3_.isBroken && !_loc3_.isClose)
            {
               if(_loc1_ == null)
               {
                  if(shiftFloor < 0 || myParent.floorList[shiftFloor] == _loc3_.ground)
                  {
                     _loc1_ = _loc3_;
                  }
               }
               else if(_loc3_.hitTestObject(this))
               {
                  if(shiftFloor < 0 || myParent.floorList[shiftFloor] == _loc3_.ground)
                  {
                     _loc1_ = _loc3_;
                  }
               }
               else if(_loc3_.ground == floorPos)
               {
                  if(_loc1_.ground != floorPos)
                  {
                     if(shiftFloor < 0 || myParent.floorList[shiftFloor] == _loc3_.ground)
                     {
                        _loc1_ = _loc3_;
                     }
                  }
                  else if(Math.abs(_loc3_.worldX - this.worldX) < Math.abs(_loc1_.worldX - this.worldX))
                  {
                     if(shiftFloor < 0 || myParent.floorList[shiftFloor] == _loc3_.ground)
                     {
                        _loc1_ = _loc3_;
                     }
                  }
               }
            }
            _loc2_++;
         }
         if(_loc1_ != null)
         {
            if(_loc1_.worker == null)
            {
               _loc1_.worker = this;
            }
            else if(!_loc1_.worker.isRepairing)
            {
               if(_loc1_.ground == floorPos)
               {
                  if(_loc1_.worker.floorPos != _loc1_.ground)
                  {
                     _loc1_.worker.destination = null;
                     _loc1_.worker = this;
                  }
                  else if(Math.abs(_loc1_.worker.worldX - _loc1_.worldX) > Math.abs(worldX - _loc1_.worldX))
                  {
                     _loc1_.worker.destination = null;
                     _loc1_.worker = this;
                  }
                  else
                  {
                     _loc1_ = null;
                  }
               }
               else
               {
                  _loc1_ = null;
               }
            }
            else
            {
               _loc1_ = null;
            }
         }
         return _loc1_;
      }
      
      public function getElevator() : MovieClip
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         _loc1_ = myParent.tenantParent;
         _loc2_ = "btnElevator";
         _loc3_ = new Array();
         _loc4_ = null;
         if(_loc1_.getChildByName(_loc2_) != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc1_.numChildren)
            {
               if((_loc10_ = _loc1_.getChildAt(_loc5_)) is SupportElevator && _loc10_ != elevatorChecked)
               {
                  _loc3_.push(_loc10_);
               }
               _loc5_++;
            }
            _loc6_ = new Array();
            _loc7_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               if((_loc11_ = _loc3_[_loc5_].floorList.indexOf(floorPos)) >= 0)
               {
                  _loc6_.push(_loc3_[_loc5_]);
                  _loc7_.push(_loc3_[_loc5_].elevatorList[_loc11_]);
               }
               _loc5_++;
            }
            _loc8_ = new Array();
            _loc9_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               if(!goHome)
               {
                  if(toiletTarget == null)
                  {
                     if(destination != null)
                     {
                        _loc11_ = _loc6_[_loc5_].floorList.indexOf(destination.ground);
                     }
                     else
                     {
                        _loc11_ = -1;
                     }
                  }
                  else
                  {
                     _loc11_ = _loc6_[_loc5_].floorList.indexOf(toiletTarget.ground);
                  }
               }
               else
               {
                  _loc11_ = _loc6_[_loc5_].floorList.indexOf(myParent.ground);
               }
               if(_loc11_ >= 0)
               {
                  _loc8_.push(_loc6_[_loc5_]);
                  _loc12_ = _loc6_[_loc5_].floorList.indexOf(floorPos);
                  _loc9_.push(_loc6_[_loc5_].elevatorList[_loc12_]);
               }
               _loc5_++;
            }
            if(_loc8_.length > 0)
            {
               _loc13_ = new Array(_loc8_.length);
               _loc5_ = 0;
               while(_loc5_ < _loc8_.length)
               {
                  _loc13_[_loc5_] = 0;
                  _loc14_ = 0;
                  while(_loc14_ < _loc8_[_loc5_].visitorWaiting.length)
                  {
                     if(_loc8_[_loc5_].visitorWaiting[_loc14_].floorPos == this.floorPos)
                     {
                        ++_loc13_[_loc5_];
                     }
                     _loc14_++;
                  }
                  _loc5_++;
               }
               _loc11_ = minValue(_loc13_);
               _loc4_ = _loc8_[_loc11_];
               elevatorFloor = _loc9_[_loc11_];
            }
            else if(_loc6_.length > 0)
            {
               _loc11_ = Math.floor(Math.random() * _loc6_.length);
               _loc4_ = _loc6_[_loc11_];
               elevatorFloor = _loc7_[_loc11_];
            }
            else
            {
               elevatorChecked = null;
            }
         }
         return _loc4_;
      }
      
      internal function frame1() : *
      {
         nameType = "Technician";
         cLevel = 3;
         shiftFloor = ancestor.shiftFloor;
         salary = ancestor.upgradeSalary;
         crewNote = ancestor.crewNote;
         worldX = ancestor.worldX;
         worldY = ancestor.worldY;
         dx = ancestor.dx;
         speedX = 3;
         dirrection = ancestor.dirrection;
         floorPos = ancestor.floorPos;
         myParent = root;
         isRepairing = ancestor.isRepairing;
         elevatorChecked = ancestor.elevatorChecked;
         elevatorTarget = ancestor.elevatorTarget;
         elevatorFloor = ancestor.elevatorFloor;
         toiletTarget = ancestor.toiletTarget;
         destination = ancestor.destination;
         goHome = ancestor.goHome;
         hasALegend = ancestor.hasALegend;
         homePos = ancestor.homePos;
         rideElevator = ancestor.rideElevator;
         waiting = ancestor.waiting;
         delay = ancestor.delay;
         repairingTime = ancestor.repairingTime;
         backDelay = ancestor.backDelay;
         if(this.parent != null)
         {
            Initialize();
         }
      }
      
      public function Behavior(param1:Event) : void
      {
         var sp:* = undefined;
         var indexFloor:* = undefined;
         var legend:* = undefined;
         var tFloor:* = undefined;
         var des:* = undefined;
         var ci:* = undefined;
         var event:Event = param1;
         sp = 0;
         while(sp < myParent.gameSpeed)
         {
            if(isRepairing)
            {
               if(!hasALegend)
               {
                  legend = new Legend();
                  legend.moodType = false;
                  legend.visitor = this;
                  legend.typeCode = "REPAIR";
                  myParent.legendParent.addChild(legend);
               }
               dx = 0;
               if(destination != null)
               {
                  if(repairingTime > 0)
                  {
                     --repairingTime;
                  }
                  else if(destination.isBroken)
                  {
                     destination.brokenLevel = 0;
                     destination.isBroken = false;
                  }
                  else
                  {
                     if(!(destination is TenantSupermarket) && !destination.isOpen)
                     {
                        destination.isOpen = true;
                     }
                     if(destination != null)
                     {
                        destination.FinishRepaired(this);
                     }
                  }
                  if(destination != null)
                  {
                     try
                     {
                        myParent.tenantParent.getChildIndex(destination);
                     }
                     catch(e:Error)
                     {
                        destination.FinishRepaired(this);
                     }
                  }
               }
            }
            if(myParent.dayTime < 8)
            {
               goHome = true;
            }
            else
            {
               goHome = false;
            }
            indexFloor = myParent.floorList.indexOf(floorPos);
            if(indexFloor + 1 >= myParent.floorList.length)
            {
               if(floorPos is Floor)
               {
                  if(this.worldX < floorPos.worldX)
                  {
                     this.worldX = floorPos.worldX;
                     dx = speedX;
                  }
                  if(this.worldX > floorPos.worldX + floorPos.width)
                  {
                     this.worldX = floorPos.worldX + floorPos.width;
                     dx = -speedX;
                  }
               }
               else if(!goHome)
               {
                  if(myParent.mallWidth > 10)
                  {
                     if(this.worldX < myParent.mallLeft)
                     {
                        dx = speedX;
                     }
                     if(this.worldX > myParent.mallLeft + myParent.mallWidth)
                     {
                        dx = -speedX;
                     }
                  }
               }
            }
            else
            {
               tFloor = myParent.floorList[indexFloor + 1];
               if(this.worldX < tFloor.worldX)
               {
                  dx = speedX;
               }
               if(this.worldX > tFloor.worldX + tFloor.width)
               {
                  dx = -speedX;
               }
            }
            if(!isRepairing && elevatorTarget == null && destination == null && !goHome)
            {
               destination = scanTarget();
               if(dx == 0 && elevatorTarget == null)
               {
                  dx = speedX * (Math.floor(Math.random() * 2) * 2 - 1);
               }
               --delay;
               if(delay <= 0)
               {
                  if(shiftFloor < 0)
                  {
                     des = Math.floor(Math.random() * 4);
                     switch(des)
                     {
                        case 1:
                           dx = -speedX;
                           break;
                        case 2:
                           dx = speedX;
                           break;
                        case 3:
                           elevatorTarget = getElevator();
                           break;
                        default:
                           dx = -dx;
                     }
                  }
                  else if(floorPos != myParent.floorList[shiftFloor])
                  {
                     elevatorTarget = getElevator();
                  }
                  else
                  {
                     des = Math.floor(Math.random() * 3);
                     switch(des)
                     {
                        case 1:
                           dx = -speedX;
                           break;
                        case 2:
                           dx = speedX;
                           break;
                        default:
                           dx = -dx;
                     }
                  }
                  delay = 100;
               }
            }
            if(destination != null && !goHome)
            {
               if(destination.isClosed)
               {
                  destination.isOpen = false;
                  destination.worker = null;
                  destination = null;
               }
               if(!isRepairing)
               {
                  if(destination.ground != floorPos)
                  {
                     if(elevatorTarget == null)
                     {
                        elevatorTarget = getElevator();
                     }
                  }
                  else
                  {
                     if(worldX < destination.worldX + destination.door.x)
                     {
                        dx = speedX;
                     }
                     else if(worldX > destination.worldX + destination.door.x + destination.door.width)
                     {
                        dx = -speedX;
                     }
                     if(destination.door != null)
                     {
                        if(destination.door.hitTestObject(this))
                        {
                           if(destination.Visited(this))
                           {
                              dx = 0;
                              if(!destination.isOpen)
                              {
                                 destination.isOpen = true;
                              }
                              destination.RepairShop(this);
                              if(isRepairing)
                              {
                                 repairingTime = destination.brokenLevel;
                              }
                           }
                        }
                        else
                        {
                           try
                           {
                              destination.pass = false;
                           }
                           catch(e:Error)
                           {
                           }
                        }
                     }
                  }
               }
            }
            if(elevatorTarget != null)
            {
               if(elevatorFloor.door != null)
               {
                  if(elevatorFloor.door.hitTestObject(this))
                  {
                     elevatorTarget.Visited(this);
                  }
                  else if(worldX > elevatorTarget.worldX + elevatorTarget.width - (elevatorFloor.door.x + elevatorFloor.door.width))
                  {
                     dx = -speedX;
                  }
                  else if(worldX < elevatorTarget.worldX + elevatorFloor.door.x)
                  {
                     dx = speedX;
                  }
                  else
                  {
                     dx = 0;
                  }
               }
               if(shiftFloor >= 0 && floorPos == myParent.floorList[shiftFloor] && !rideElevator && !goHome)
               {
                  ci = elevatorTarget.visitorWaiting.indexOf(this);
                  if(ci >= 0)
                  {
                     elevatorTarget.visitorWaiting.splice(ci,1);
                  }
                  elevatorTarget = null;
               }
               if(elevatorTarget != null)
               {
                  try
                  {
                     myParent.tenantParent.getChildIndex(elevatorTarget);
                  }
                  catch(e:Error)
                  {
                     elevatorTarget = null;
                  }
                  continue;
               }
            }
            if(rideElevator)
            {
               dx = 0;
            }
            if(floorPos != null)
            {
               this.worldY = floorPos.worldY;
               if(!(floorPos is Floor))
               {
                  this.worldY -= floorPos.height;
               }
            }
            if(goHome && !isRepairing)
            {
               if(destination != null)
               {
                  destination.worker = null;
                  destination = null;
               }
               if(floorPos == myParent.ground)
               {
                  if(elevatorTarget != null)
                  {
                     elevatorFloor = null;
                     ci = elevatorTarget.visitorWaiting.indexOf(this);
                     if(ci >= 0)
                     {
                        elevatorTarget.visitorWaiting.splice(ci,1);
                     }
                     elevatorTarget = null;
                  }
                  if(worldX < homePos + 16 && homePos > 0)
                  {
                     dx = speedX;
                  }
                  else if(worldX > homePos - 16 && homePos <= 0)
                  {
                     dx = -speedX;
                  }
               }
               else if(elevatorTarget == null)
               {
                  elevatorTarget = getElevator();
               }
            }
            this.worldX += dx;
            if(this.worldX < -15 || this.worldX > myParent.MAX_WIDTH + 15)
            {
               sp = myParent.gameSpeed;
               removeEventListener(Event.ENTER_FRAME,Behavior);
               addEventListener(Event.ENTER_FRAME,BackToWork);
            }
            sp++;
         }
      }
      
      public function Initialize() : void
      {
         addEventListener(Event.ENTER_FRAME,Animation);
         addEventListener(Event.ENTER_FRAME,Behavior);
      }
   }
}
