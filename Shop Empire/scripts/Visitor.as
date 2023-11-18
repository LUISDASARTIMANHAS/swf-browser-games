package
{
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.ui.*;
   
   public class Visitor extends MovieClip
   {
       
      
      public var rideElevator:* = false;
      
      public var floorChecked:*;
      
      internal var ACCEL_MOOD:* = 0.5;
      
      public var visitorName:*;
      
      public var destination:*;
      
      internal var waitPattiene:* = 0;
      
      public var elevatorTarget:* = null;
      
      internal var changeDestination:* = 0;
      
      public var tenantName:String;
      
      public var otherDelay:*;
      
      internal var lastToiletFill:*;
      
      public var enterWaiting:* = false;
      
      public var waiting:* = 0;
      
      public var dirrection:*;
      
      internal const ENJOY_DELAY_TIME:* = 10;
      
      public var searchTenant:* = false;
      
      public var dx:*;
      
      public var floorPos:*;
      
      internal var lastMood:*;
      
      public var visiting:*;
      
      public var gender:* = true;
      
      internal var moodDelay:* = 24;
      
      public var arrive:*;
      
      public var elevatorChecked:*;
      
      internal var MIN_MOOD:* = 26;
      
      internal var interestList:Array;
      
      public var enjoyingTime:*;
      
      public var speedX:*;
      
      public var homePos:*;
      
      public var mood:*;
      
      public var worldX:*;
      
      internal var backDelay:* = 24;
      
      public var worldY:*;
      
      internal var MAX_MOOD:* = 100;
      
      public var elevatorTrouble:* = false;
      
      public var interest:*;
      
      public var toiletTrouble:* = false;
      
      public var toiletFill:* = 0;
      
      public var specialVisitor:* = false;
      
      public var myParent:*;
      
      internal var toiletIncreaseChance:*;
      
      internal var pattiene:* = 10;
      
      internal var delay:* = 100;
      
      public var lastDestination:*;
      
      public var targetTenant:*;
      
      public var elevatorFloor:* = null;
      
      public var justVisiting:* = true;
      
      public var hasALegend:* = false;
      
      public var enjoyDelay:*;
      
      public var goHome:*;
      
      internal var toiletTarget:* = null;
      
      public function Visitor()
      {
         MAX_MOOD = 100;
         MIN_MOOD = 26;
         pattiene = 10;
         ACCEL_MOOD = 0.5;
         gender = true;
         specialVisitor = false;
         targetTenant = new Array();
         rideElevator = false;
         waiting = 0;
         mood = Math.random() * 10 + 45;
         enterWaiting = false;
         hasALegend = false;
         searchTenant = false;
         justVisiting = true;
         elevatorTarget = null;
         elevatorFloor = null;
         floorChecked = new Array();
         elevatorTrouble = false;
         toiletTrouble = false;
         toiletFill = 0;
         toiletIncreaseChance = Math.random() * 8 + 2;
         toiletTarget = null;
         changeDestination = 0;
         delay = 100;
         backDelay = 24;
         moodDelay = 24;
         waitPattiene = 0;
         super();
         addEventListener(Event.ADDED,Initialize);
      }
      
      internal function VisitingProgress(param1:Event) : void
      {
         var sp:* = undefined;
         var addEnjoy:* = undefined;
         var legend:* = undefined;
         var event:Event = param1;
         sp = 0;
         while(sp < myParent.gameSpeed)
         {
            elevatorTrouble = false;
            --enjoyingTime;
            ++enjoyDelay;
            if(enjoyingTime <= 0)
            {
               mood -= 0.1 * ACCEL_MOOD;
               if(destination.isBroken)
               {
                  mood -= 0.4 * ACCEL_MOOD;
               }
               if(visiting)
               {
                  if(!(destination is TenantSupermarket) && !destination.isOpen)
                  {
                     destination.isOpen = true;
                  }
                  destination.ExitShop(this);
               }
            }
            else if(enjoyDelay > ENJOY_DELAY_TIME)
            {
               enjoyDelay = 0;
               addEnjoy = Math.floor(Math.random() * 20) - 5;
               enjoyingTime += addEnjoy;
               mood += 2 * ACCEL_MOOD;
               if(destination.isBroken)
               {
                  mood -= (destination.brokenLevel - 75) / 10 * ACCEL_MOOD;
               }
            }
            try
            {
               myParent.tenantParent.getChildIndex(destination);
            }
            catch(e:Error)
            {
               if(destination is TenantCinema || destination is TenantGameCenter || destination is TenantHall)
               {
                  removeEventListener(Event.ENTER_FRAME,destination.MoodManipulation);
               }
               mood -= 20 * ACCEL_MOOD;
               visiting = false;
            }
            if(!visiting)
            {
               legend = new Legend();
               legend.moodType = true;
               legend.visitor = this;
               myParent.legendParent.addChild(legend);
               sp = myParent.gameSpeed;
               finishVisiting();
            }
            sp++;
         }
      }
      
      public function removeAllListener() : void
      {
         if(destination is TenantCinema || destination is TenantGameCenter || destination is TenantHall)
         {
            removeEventListener(Event.ENTER_FRAME,destination.MoodManipulation);
         }
         removeEventListener(Event.ENTER_FRAME,Animation);
         removeEventListener(Event.ENTER_FRAME,Behavior);
         removeEventListener(Event.ENTER_FRAME,VisitingProgress);
         removeEventListener(Event.ENTER_FRAME,MoodUpdate);
      }
      
      internal function finishVisiting() : void
      {
         alpha = 1;
         arrive = false;
         lastDestination = destination;
         destination = null;
         delay = 1;
         changeDestination = 0;
         removeEventListener(Event.ENTER_FRAME,VisitingProgress);
         addEventListener(Event.ENTER_FRAME,Behavior);
      }
      
      internal function getElevator() : MovieClip
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
               _loc11_ = Math.floor(Math.random() * _loc8_.length);
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
      
      internal function isInterest() : Boolean
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = myParent.tenantParent;
         _loc2_ = myParent.userinterface.btnArr[interest];
         tenantName = _loc2_;
         return _loc1_.getChildByName(_loc2_) != null;
      }
      
      internal function Behavior(param1:Event) : void
      {
         var sp:* = undefined;
         var rndHome:* = undefined;
         var rnd:* = undefined;
         var homeModifier:* = undefined;
         var des:* = undefined;
         var dstIndex:* = undefined;
         var wIndex:* = undefined;
         var indexFloor:* = undefined;
         var tFloor:* = undefined;
         var vIndex:* = undefined;
         var tMenu:* = undefined;
         var event:Event = param1;
         sp = 0;
         while(sp < myParent.gameSpeed)
         {
            SimulateRestroom();
            if((myParent.dayTime >= 21 || myParent.dayTime < 10) && !goHome)
            {
               if(myParent.dayTime >= 22)
               {
                  goHome = true;
               }
               else if(backDelay > 0)
               {
                  --backDelay;
               }
               else
               {
                  rndHome = Math.random() * 100;
                  if(rndHome < 50)
                  {
                     goHome = true;
                  }
                  backDelay = 24;
               }
            }
            if((destination == null || destination == lastDestination) && !goHome)
            {
               if(delay == 1 && changeDestination <= 0)
               {
                  rnd = Math.random() * 100;
                  homeModifier = 0;
                  if(myParent.dayTime >= 21)
                  {
                     homeModifier = 50;
                  }
                  else if(myParent.dayTime >= 20)
                  {
                     homeModifier = 25;
                  }
                  if(rnd < mood - homeModifier)
                  {
                     decideDestination();
                     if(isInterest())
                     {
                        scanTenant();
                        randomDestination();
                     }
                  }
                  else if(!justVisiting)
                  {
                     goHome = true;
                  }
               }
               else if(isInterest())
               {
                  scanTenant();
                  randomDestination();
               }
               if((destination == null || destination == lastDestination) && elevatorTarget == null && toiletTarget == null && !visiting && !justVisiting)
               {
                  --delay;
                  if(delay <= 0)
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
                           dx = dx;
                     }
                     if(destination == null)
                     {
                        searchTenant = true;
                     }
                     ++changeDestination;
                     if(changeDestination >= 5)
                     {
                        changeDestination = 0;
                        lastDestination = null;
                     }
                     delay = 100;
                  }
                  if(dx == 0)
                  {
                     dx = (Math.floor(Math.random() * 2) * 2 - 1) * speedX;
                  }
               }
            }
            if(destination != null && destination != lastDestination && !goHome && toiletTarget == null)
            {
               if(destination.isClose)
               {
                  destination == null;
               }
               if(!visiting)
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
                           if(!arrive)
                           {
                              arrive = destination.Visited(this);
                           }
                           if(arrive)
                           {
                              if(!visiting)
                              {
                                 if(!destination.isOpen)
                                 {
                                    destination.isOpen = true;
                                 }
                                 dx = 0;
                                 destination.EnterShop(this);
                                 if(visiting)
                                 {
                                    dstIndex = destination.visitorList.indexOf(this);
                                    if(dstIndex >= destination.getCapacity())
                                    {
                                       visiting = false;
                                       lastDestination = destination;
                                       destination = null;
                                       randomDestination();
                                       destination.visitorList.splice(dstIndex,1);
                                       alpha = 1;
                                       searchTenant = true;
                                    }
                                    else
                                    {
                                       elevatorChecked = null;
                                       enjoyingTime = 100;
                                       addEventListener(Event.ENTER_FRAME,VisitingProgress);
                                       removeEventListener(Event.ENTER_FRAME,Behavior);
                                    }
                                 }
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
               try
               {
                  myParent.tenantParent.getChildIndex(destination);
               }
               catch(e:Error)
               {
                  destination = null;
               }
            }
            if(toiletTarget != null && !goHome && !visiting)
            {
               if(toiletTarget.ground != floorPos)
               {
                  if(elevatorTarget == null)
                  {
                     elevatorTarget = getElevator();
                  }
               }
               else
               {
                  if(worldX < toiletTarget.worldX)
                  {
                     if(toiletFill < 90)
                     {
                        dx = speedX;
                     }
                     else
                     {
                        dx = speedX * 2;
                     }
                  }
                  else if(worldX > toiletTarget.worldX + toiletTarget.width)
                  {
                     if(toiletFill < 90)
                     {
                        dx = -speedX;
                     }
                     else
                     {
                        dx = -speedX * 2;
                     }
                  }
                  toiletTarget.Visited(this);
               }
            }
            if(floorPos != null)
            {
               this.worldY = floorPos.worldY;
               if(!(floorPos is Floor))
               {
                  this.worldY -= floorPos.height;
               }
            }
            if(goHome && !visiting)
            {
               if(destination != null)
               {
                  destination = null;
               }
               if(floorPos == myParent.ground)
               {
                  if(elevatorTarget != null)
                  {
                     wIndex = elevatorTarget.visitorWaiting.indexOf(this);
                     if(wIndex >= 0)
                     {
                        elevatorTarget.visitorWaiting.splice(wIndex,1);
                     }
                     elevatorFloor = null;
                     elevatorTarget = null;
                     enterWaiting = false;
                  }
                  if(worldX < homePos + 11 && homePos > 0)
                  {
                     if(toiletFill < 90)
                     {
                        dx = speedX;
                     }
                     else
                     {
                        dx = speedX * 2;
                     }
                  }
                  else if(worldX > homePos - 11 && homePos <= 0)
                  {
                     if(toiletFill < 90)
                     {
                        dx = -speedX;
                     }
                     else
                     {
                        dx = -speedX * 2;
                     }
                  }
               }
               else if(elevatorTarget == null)
               {
                  elevatorTarget = getElevator();
               }
            }
            if(elevatorTarget != null)
            {
               if(elevatorFloor.door != null)
               {
                  if(elevatorFloor.door.hitTestObject(this))
                  {
                     elevatorTarget.Visited(this);
                     if(elevatorTarget.visitorList.indexOf(this) < 0)
                     {
                        if(!enterWaiting)
                        {
                           waitPattiene = pattiene;
                        }
                        enterWaiting = true;
                     }
                     else
                     {
                        elevatorTrouble = false;
                        enterWaiting = false;
                     }
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
               try
               {
                  myParent.tenantParent.getChildIndex(elevatorTarget);
               }
               catch(e:Error)
               {
                  wIndex = elevatorTarget.visitorWaiting.indexOf(this);
                  if(wIndex >= 0)
                  {
                     elevatorTarget.visitorWaiting.splice(wIndex,1);
                  }
                  elevatorTarget = null;
               }
            }
            if(!goHome)
            {
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
            }
            if(justVisiting && !goHome)
            {
               if(worldX > myParent.mallLeft && worldX < myParent.mallLeft + myParent.mallWidth)
               {
                  justVisiting = false;
               }
            }
            if(rideElevator)
            {
               dx = 0;
            }
            this.worldX += dx;
            sp++;
         }
         if(this.worldX < -10 || this.worldX > myParent.MAX_WIDTH + 10)
         {
            myParent.nextDayPopularity += (mood - 50) / 10;
            if(this == myParent.visitorFocus)
            {
               if(myParent.menuParent.numChildren > 0)
               {
                  tMenu = myParent.menuParent.getChildAt(0);
                  tMenu.closeMenu();
               }
            }
            vIndex = myParent.visitorList.indexOf(this);
            if(vIndex >= 0)
            {
               myParent.visitorList.splice(vIndex,1);
            }
            vIndex = myParent.specialVisitor.indexOf(this);
            if(vIndex >= 0)
            {
               myParent.specialVisitor.splice(vIndex,1);
            }
            if(mood < 50 && !justVisiting)
            {
               ++myParent.numberUpset;
            }
            removeEventListener(Event.ENTER_FRAME,Animation);
            removeEventListener(Event.ENTER_FRAME,Behavior);
            removeEventListener(Event.ENTER_FRAME,MoodUpdate);
            this.parent.removeChild(this);
         }
      }
      
      internal function scanElevator() : void
      {
         var wIndex:* = undefined;
         if(elevatorTarget == null)
         {
            elevatorTarget = getElevator();
         }
         else
         {
            try
            {
               myParent.tenantParent.getChildIndex(elevatorTarget);
            }
            catch(e:Error)
            {
               wIndex = elevatorTarget.visitorWaiting.indexOf(this);
               if(wIndex >= 0)
               {
                  elevatorTarget.visitorWaiting.splice(wIndex,1);
               }
               elevatorTarget = null;
            }
         }
      }
      
      internal function MoodUpdate(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < myParent.gameSpeed)
         {
            if(toiletFill >= 75 && lastToiletFill < 75 && !rideElevator)
            {
               _loc3_ = new Legend();
               _loc3_.moodType = false;
               _loc3_.visitor = this;
               _loc3_.typeCode = "TOILET";
               myParent.legendParent.addChild(_loc3_);
               searchTenant = false;
            }
            if(!rideElevator)
            {
               lastToiletFill = toiletFill;
            }
            if(searchTenant && !hasALegend)
            {
               _loc3_ = new Legend();
               _loc3_.moodType = false;
               _loc3_.visitor = this;
               _loc3_.typeCode = "TENANT";
               myParent.legendParent.addChild(_loc3_);
               searchTenant = false;
               mood -= 0.2 * ACCEL_MOOD;
            }
            if(moodDelay > 0)
            {
               --moodDelay;
            }
            else
            {
               if(!visiting)
               {
                  if(!enterWaiting)
                  {
                     if(!goHome)
                     {
                        mood += 0.1 * ACCEL_MOOD;
                     }
                  }
                  else if(waitPattiene > 0)
                  {
                     --waitPattiene;
                  }
                  else
                  {
                     mood -= 2 * ACCEL_MOOD;
                     _loc3_ = new Legend();
                     _loc3_.moodType = false;
                     _loc3_.visitor = this;
                     _loc3_.typeCode = "ELEVATOR";
                     myParent.legendParent.addChild(_loc3_);
                     elevatorTrouble = true;
                     if(elevatorTarget != null)
                     {
                        if((_loc5_ = elevatorTarget.visitorWaiting.indexOf(this)) >= 0)
                        {
                           elevatorTarget.visitorWaiting.splice(_loc5_,1);
                        }
                        elevatorTarget = null;
                     }
                     enterWaiting = false;
                  }
               }
               _loc4_ = 0;
               while(_loc4_ < myParent.dirtyParent.numChildren)
               {
                  if((_loc6_ = myParent.dirtyParent.getChildAt(_loc4_)).bundle && _loc6_.ground == floorPos && Math.abs(_loc6_.worldX - worldX) < 75 && !hasALegend && (!visiting || destination == myParent.hall) && !rideElevator)
                  {
                     if((_loc7_ = Math.random() * 100) < _loc6_.trashLevel)
                     {
                        mood -= _loc6_.trashLevel / 25 * ACCEL_MOOD;
                        _loc3_ = new Legend();
                        _loc3_.moodType = false;
                        _loc3_.visitor = this;
                        _loc3_.typeCode = "DIRTY";
                        myParent.legendParent.addChild(_loc3_);
                     }
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < myParent.tenantList.length)
               {
                  _loc6_ = myParent.tenantList[_loc4_];
                  if(this.hitTestObject(_loc6_) && _loc6_.isBroken && !_loc6_.isClose && !hasALegend && !visiting)
                  {
                     mood -= 0.2 * ACCEL_MOOD;
                     _loc3_ = new Legend();
                     _loc3_.moodType = false;
                     _loc3_.visitor = this;
                     _loc3_.typeCode = "ELECTRICITY";
                     myParent.legendParent.addChild(_loc3_);
                  }
                  _loc4_++;
               }
               moodDelay = 24;
            }
            if(mood > MAX_MOOD)
            {
               mood = MAX_MOOD;
            }
            if(mood < MIN_MOOD)
            {
               mood = MIN_MOOD;
            }
            if(!visiting && !rideElevator)
            {
               if(lastMood > 75 && mood <= 75 || lastMood <= 75 && mood > 75 || lastMood > 50 && mood <= 50 || lastMood <= 50 && mood > 50 || lastMood > 25 && mood <= 25 || lastMood <= 25 && mood > 25)
               {
                  _loc3_ = new Legend();
                  _loc3_.moodType = true;
                  _loc3_.visitor = this;
                  myParent.legendParent.addChild(_loc3_);
               }
            }
            if(!rideElevator)
            {
               lastMood = mood;
            }
            _loc2_++;
         }
      }
      
      internal function scanToilet() : MovieClip
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc1_ = myParent.tenantParent;
         _loc2_ = null;
         _loc3_ = new Array();
         if(_loc1_.getChildByName("btnRestRoom") != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc1_.numChildren)
            {
               if((_loc5_ = _loc1_.getChildAt(_loc4_)) is SupportRestroom)
               {
                  if(_loc5_.ground == floorPos)
                  {
                     if(_loc2_ == null)
                     {
                        _loc2_ = _loc5_;
                     }
                     else if(_loc2_.ground == floorPos)
                     {
                        if(Math.abs(_loc2_.worldX - worldX) > Math.abs(_loc5_.worldX - worldX))
                        {
                           _loc2_ = _loc5_;
                        }
                     }
                     else
                     {
                        _loc2_ = _loc5_;
                     }
                  }
                  else
                  {
                     _loc3_.push(_loc5_);
                  }
               }
               _loc4_++;
            }
            if(_loc2_ == null && _loc3_.length > 0)
            {
               _loc6_ = Math.floor(Math.random() * _loc3_.length);
               _loc2_ = _loc3_[_loc6_];
            }
         }
         if(_loc2_ == null)
         {
            toiletTrouble = true;
         }
         return _loc2_;
      }
      
      internal function SimulateRestroom() : void
      {
         var peeValue:* = undefined;
         var wIndex:* = undefined;
         peeValue = Math.random() * 100;
         if(peeValue < toiletIncreaseChance)
         {
            if(toiletFill < 100)
            {
               ++toiletFill;
            }
         }
         if(toiletFill >= 75)
         {
            if(toiletTarget == null)
            {
               if(!goHome)
               {
                  if(elevatorTarget != null)
                  {
                     wIndex = elevatorTarget.visitorWaiting.indexOf(this);
                     if(wIndex >= 0)
                     {
                        elevatorTarget.visitorWaiting.splice(wIndex,1);
                     }
                     elevatorChecked = null;
                     elevatorTarget = null;
                     enterWaiting = false;
                  }
               }
               toiletTarget = scanToilet();
               if(toiletTarget == null)
               {
                  goHome = true;
               }
            }
            else
            {
               try
               {
                  myParent.tenantParent.getChildIndex(toiletTarget);
               }
               catch(e:Error)
               {
                  toiletTarget = null;
               }
            }
         }
      }
      
      internal function randomDestination() : void
      {
         var _loc1_:* = undefined;
         if(myParent.hall != null && myParent.nowEvent >= 0 && !myParent.hall.isClose && lastDestination != myParent.hall)
         {
            destination = myParent.hall;
         }
         else
         {
            _loc1_ = Math.floor(Math.random() * targetTenant.length);
            destination = targetTenant[_loc1_];
         }
      }
      
      internal function Animation(param1:Event) : void
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
      
      internal function scanTenant() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = myParent.tenantParent;
         targetTenant = new Array();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.numChildren)
         {
            _loc3_ = _loc1_.getChildAt(_loc2_);
            if(_loc3_.name == tenantName)
            {
               targetTenant.push(_loc3_);
            }
            _loc2_++;
         }
      }
      
      internal function decideDestination() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(!specialVisitor)
         {
            _loc1_ = Math.floor(Math.random() * interestList.length);
            _loc2_ = interestList[_loc1_];
            if(_loc2_ != "Other")
            {
               interest = myParent.userinterface.btnArr.indexOf(_loc2_);
            }
            else
            {
               interest = Math.floor(Math.random() * myParent.tenantArr.length);
            }
         }
         else
         {
            _loc3_ = new Array();
            _loc4_ = 0;
            while(_loc4_ < myParent.tenantList.length)
            {
               if((_loc6_ = myParent.tenantList[_loc4_]).name != "Hall" && _loc3_.indexOf(_loc6_.name) < 0)
               {
                  _loc3_.push(_loc6_.name);
               }
               _loc4_++;
            }
            _loc5_ = Math.floor(Math.random() * _loc3_.length);
            interest = myParent.userinterface.btnArr.indexOf(_loc3_[_loc5_]);
         }
      }
      
      internal function Initialize(param1:Event) : void
      {
         myParent = root;
         decideDestination();
         if(isInterest())
         {
            scanTenant();
            randomDestination();
         }
         else
         {
            destination = null;
         }
         arrive = false;
         visiting = false;
         enjoyingTime = 0;
         enjoyDelay = 0;
         addEventListener(Event.ENTER_FRAME,Animation);
         addEventListener(Event.ENTER_FRAME,Behavior);
         addEventListener(Event.ENTER_FRAME,MoodUpdate);
         removeEventListener(Event.ADDED,Initialize);
      }
   }
}
