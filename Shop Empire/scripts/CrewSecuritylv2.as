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
   
   [Embed(source="/_assets/assets.swf", symbol="CrewSecuritylv2")]
   public dynamic class CrewSecuritylv2 extends MovieClip
   {
       
      
      public var isAction:*;
      
      public var rideElevator:*;
      
      public var destination:*;
      
      public var elevatorTarget:*;
      
      public const UPGRADE_COST:* = 1000;
      
      public var action:MovieClip;
      
      public var lastTrigger:*;
      
      public var nameType:*;
      
      public var waiting:*;
      
      public var dirrection:*;
      
      public var dx:*;
      
      public var floorPos:*;
      
      public var shiftFloor:*;
      
      public var upgradeEffect:*;
      
      public var elevatorChecked:*;
      
      public var backDelay:*;
      
      public var cLevel:*;
      
      public var speedX:*;
      
      public var crewNote:*;
      
      public var homePos:*;
      
      public var upgradeSalary:*;
      
      public var worldX:*;
      
      public var worldY:*;
      
      public var myParent:*;
      
      public var delay:*;
      
      public const nextUpgrade:* = CrewSecuritylv3;
      
      public var elevatorFloor:*;
      
      public var salary:*;
      
      public var banditTarget:*;
      
      public var ancestor:*;
      
      public var hasALegend:*;
      
      public var goHome:*;
      
      public var toiletTarget:*;
      
      public function CrewSecuritylv2()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3,3,frame4);
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
                  if(myParent.dayTime >= 21)
                  {
                     if(myParent.dayTime >= 22)
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
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame4() : *
      {
         stop();
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
                     if(myParent.banditTrigger != null && !myParent.rideElevator)
                     {
                        _loc11_ = _loc6_[_loc5_].floorList.indexOf(myParent.banditTrigger.floorPos);
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
      
      public function scanTarget() : MovieClip
      {
         var found:* = undefined;
         var i:* = undefined;
         var temp:* = undefined;
         var legend:* = undefined;
         found = null;
         if(!rideElevator)
         {
            try
            {
               i = 0;
               while(i < myParent.banditList.length)
               {
                  temp = myParent.banditList[i];
                  if(temp.floorPos == floorPos && !temp.rideElevator && !rideElevator && temp.pursuer.length < 3 && !temp.captured && temp.alpha == 1)
                  {
                     if(found == null)
                     {
                        if(myParent.alarmTrigger)
                        {
                           if(temp == myParent.banditTrigger || Math.abs(temp.worldX - worldX) <= 400 && Math.abs(temp.worldX - worldX) < Math.abs(found.worldX - worldX))
                           {
                              found = temp;
                           }
                        }
                        else if(Math.abs(temp.worldX - worldX) <= 250)
                        {
                           if(dirrection > 0)
                           {
                              if(temp.worldX > worldX)
                              {
                                 found = temp;
                              }
                           }
                           else if(temp.worldX < worldX)
                           {
                              found = temp;
                           }
                        }
                     }
                     else if(Math.abs(temp.worldX - worldX) <= Math.abs(found.worldX - worldX))
                     {
                        if(dirrection > 0)
                        {
                           if(temp.worldX > worldX)
                           {
                              found = temp;
                           }
                        }
                        else if(temp.worldX < worldX)
                        {
                           found = temp;
                        }
                     }
                  }
                  i++;
               }
               if(found != null)
               {
                  found.pursuer.push(this);
               }
            }
            catch(e:Error)
            {
            }
         }
         if(found != null)
         {
            if(!hasALegend)
            {
               legend = new Legend();
               legend.moodType = false;
               legend.visitor = this;
               legend.typeCode = "BANDIT";
               myParent.legendParent.addChild(legend);
            }
         }
         return found;
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         nameType = "Security";
         cLevel = 2;
         shiftFloor = ancestor.shiftFloor;
         salary = ancestor.upgradeSalary;
         upgradeSalary = 800;
         crewNote = ancestor.crewNote;
         upgradeEffect = "Increase sight distance\nIncrease movement speed";
         worldX = ancestor.worldX;
         worldY = ancestor.worldY;
         dx = ancestor.dx;
         speedX = 3;
         dirrection = ancestor.dirrection;
         floorPos = ancestor.floorPos;
         myParent = root;
         isAction = ancestor.isAction;
         elevatorChecked = ancestor.elevatorChecked;
         elevatorTarget = ancestor.elevatorTarget;
         elevatorFloor = ancestor.elevatorFloor;
         toiletTarget = ancestor.toiletTarget;
         destination = ancestor.destination;
         goHome = ancestor.goHome;
         homePos = ancestor.homePos;
         rideElevator = ancestor.rideElevator;
         waiting = ancestor.waiting;
         hasALegend = ancestor.hasALegend;
         banditTarget = ancestor.banditTarget;
         lastTrigger = ancestor.lastTrigger;
         if(this.parent != null)
         {
            addEventListener(Event.ENTER_FRAME,Animation);
            addEventListener(Event.ENTER_FRAME,Behavior);
         }
         delay = ancestor.delay;
         backDelay = ancestor.backDelay;
      }
      
      public function Behavior(param1:Event) : void
      {
         var sp:* = undefined;
         var des:* = undefined;
         var bi:* = undefined;
         var si:* = undefined;
         var test:* = undefined;
         var ci:* = undefined;
         var event:Event = param1;
         sp = 0;
         while(sp < myParent.gameSpeed)
         {
            if(floorPos is Floor)
            {
               if(this.worldX < floorPos.worldX)
               {
                  this.worldX = floorPos.worldX;
                  if(myParent.alarmTrigger)
                  {
                     dx = speedX * 2;
                  }
                  else
                  {
                     dx = speedX;
                  }
               }
               if(this.worldX > floorPos.worldX + floorPos.width)
               {
                  this.worldX = floorPos.worldX + floorPos.width;
                  if(myParent.alarmTrigger)
                  {
                     dx = -speedX * 2;
                  }
                  else
                  {
                     dx = -speedX;
                  }
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
            if(banditTarget == null && !myParent.alarmTrigger && myParent.dayTime > 8 && myParent.dayTime < 21)
            {
               goHome = true;
            }
            else
            {
               goHome = false;
            }
            if(banditTarget == null)
            {
               banditTarget = scanTarget();
            }
            if(!isAction && elevatorTarget == null && banditTarget == null && !goHome && myParent.banditTrigger == null)
            {
               if(dx == 0 && elevatorTarget == null)
               {
                  if(myParent.alarmTrigger)
                  {
                     dx = speedX * 2 * (Math.floor(Math.random() * 2) * 2 - 1);
                  }
                  else
                  {
                     dx = speedX * (Math.floor(Math.random() * 2) * 2 - 1);
                  }
               }
               --delay;
               if(delay <= 0)
               {
                  des = Math.floor(Math.random() * 4);
                  delay = 100;
                  if(myParent.alarmTrigger)
                  {
                     switch(des)
                     {
                        case 1:
                           dx = -speedX * 2;
                           break;
                        case 2:
                           dx = speedX * 2;
                           break;
                        case 3:
                           elevatorTarget = getElevator();
                           break;
                        default:
                           dx = -dx;
                     }
                  }
                  else if(shiftFloor < 0)
                  {
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
               }
            }
            if(myParent.banditTrigger != null && banditTarget == null && !isAction)
            {
               if(floorPos != myParent.banditTrigger.floorPos)
               {
                  if(elevatorTarget == null)
                  {
                     elevatorTarget = getElevator();
                  }
               }
               else if(myParent.banditTrigger.worldX + myParent.banditTrigger.width / 2 < worldX - this.width / 2)
               {
                  dx = -speedX * 2;
               }
               else if(myParent.banditTrigger.worldX - myParent.banditTrigger.width / 2 > worldX + this.width / 2)
               {
                  dx = speedX * 2;
               }
               else
               {
                  dx = 0;
                  myParent.banditTrigger.captured = true;
                  isAction = true;
               }
            }
            if(banditTarget != null && !isAction)
            {
               if(!banditTarget.rideElevator && banditTarget.floorPos == floorPos)
               {
                  if(!banditTarget.captured)
                  {
                     if(banditTarget.worldX + banditTarget.width / 2 < worldX - this.width / 2)
                     {
                        dx = -speedX * 2;
                     }
                     else if(banditTarget.worldX - banditTarget.width / 2 > worldX + this.width / 2)
                     {
                        dx = speedX * 2;
                     }
                     else
                     {
                        dx = 0;
                        banditTarget.captured = true;
                        isAction = true;
                     }
                     if(myParent.banditList.indexOf(banditTarget) < 0 || Math.abs(banditTarget.worldX - worldX) >= 500 && !myParent.alarmTrigger || Boolean(banditTarget.rideElevator))
                     {
                        bi = banditTarget.pursuer.indexOf(this);
                        banditTarget.pursuer.splice(bi,1);
                        banditTarget = null;
                     }
                  }
                  else
                  {
                     banditTarget = null;
                  }
               }
               else
               {
                  si = banditTarget.pursuer.indexOf(this);
                  if(si >= 0)
                  {
                     banditTarget.pursuer.splice(si,1);
                  }
                  banditTarget = null;
               }
            }
            banditCollition();
            if(elevatorTarget != null && banditTarget == null && !isAction)
            {
               if(elevatorFloor.door != null)
               {
                  if(elevatorFloor.door.hitTestObject(this))
                  {
                     test = false;
                     if(elevatorFloor.door.currentFrame >= 9)
                     {
                        test = checkAllVisitor(elevatorTarget);
                     }
                     if(!test)
                     {
                        elevatorTarget.Visited(this);
                     }
                  }
                  else if(worldX > elevatorTarget.worldX + elevatorTarget.width - (elevatorFloor.door.x + elevatorFloor.door.width))
                  {
                     if(myParent.alarmTrigger)
                     {
                        dx = -speedX * 2;
                     }
                     else
                     {
                        dx = -speedX;
                     }
                  }
                  else if(worldX < elevatorTarget.worldX + elevatorFloor.door.x)
                  {
                     if(myParent.alarmTrigger)
                     {
                        dx = speedX * 2;
                     }
                     else
                     {
                        dx = speedX;
                     }
                  }
                  else
                  {
                     dx = 0;
                  }
               }
               if(shiftFloor >= 0 && floorPos == myParent.floorList[shiftFloor] && !rideElevator && !myParent.alarmTrigger && !goHome)
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
            if(floorPos != null)
            {
               this.worldY = floorPos.worldY;
               if(!(floorPos is Floor))
               {
                  this.worldY -= floorPos.height;
               }
            }
            if(rideElevator)
            {
               dx = 0;
            }
            if(goHome && !isAction)
            {
               if(floorPos == myParent.ground)
               {
                  if(elevatorTarget != null)
                  {
                     elevatorFloor = null;
                     ci = elevatorTarget.visitorWaiting.indexOf(this);
                     if(ci >= 0)
                     {
                        elevatorTarget.visitorWaiting.splice(ci,1);
                        if(elevatorTarget.visitorWaiting.length <= 0)
                        {
                           elevatorTarget.isStart = false;
                           if(elevatorTarget.visitorWaiting.length <= 0)
                           {
                              elevatorTarget.isStart = false;
                           }
                        }
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
            if(isAction)
            {
               dx = 0;
               if(action != null)
               {
                  if(action.currentFrame >= action.totalFrames)
                  {
                     isAction = false;
                  }
               }
            }
            this.worldX += dx;
            if(lastTrigger != myParent.alarmTrigger)
            {
               delay = 0;
            }
            lastTrigger = myParent.alarmTrigger;
            if(this.worldX < -15 || this.worldX > myParent.MAX_WIDTH + 15)
            {
               sp = myParent.gameSpeed;
               removeEventListener(Event.ENTER_FRAME,Behavior);
               addEventListener(Event.ENTER_FRAME,BackToWork);
            }
            sp++;
         }
      }
      
      public function checkAllVisitor(param1:MovieClip) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc2_ = false;
         _loc3_ = 0;
         while(_loc3_ < param1.visitorList.length)
         {
            if((_loc4_ = param1.visitorList[_loc3_]) is Bandit && _loc4_.alpha == 1)
            {
               _loc4_.worldX = worldX + 10 * _loc4_.dirrection;
               _loc4_.worldY = worldY;
               _loc4_.floorPos = floorPos;
               _loc4_.x = _loc4_.worldX - myParent.cameraX;
               _loc4_.y = _loc4_.worldY - myParent.cameraY;
               _loc4_.elevatorTarget = null;
               _loc4_.elevatorChecked = null;
               _loc4_.captured = true;
               _loc5_ = param1.visitorList.indexOf(_loc4_);
               param1.visitorList.splice(_loc5_,1);
               param1.elevatorTargetList.splice(_loc5_,1);
               this.isAction = true;
               if(elevatorTarget != null)
               {
                  if((_loc6_ = elevatorTarget.visitorWaiting.indexOf(this)) >= 0)
                  {
                     elevatorTarget.visitorWaiting.splice(_loc6_,1);
                     if(elevatorTarget.visitorWaiting.length <= 0)
                     {
                        elevatorTarget.isStart = false;
                     }
                  }
               }
               this.elevatorTarget = null;
               this.parent.addChild(_loc4_);
               _loc2_ = true;
               _loc3_--;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function banditCollition() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < myParent.banditList.length)
         {
            _loc2_ = myParent.banditList[_loc1_];
            if(Boolean(this.hitTestObject(_loc2_)) && _loc2_.alpha >= 1 && _loc2_.rideElevator == rideElevator && !_loc2_.flying)
            {
               this.isAction = true;
               if(_loc2_.worldX < worldX)
               {
                  dirrection = -1;
                  scaleX = dirrection;
               }
               else
               {
                  dirrection = 1;
                  scaleX = dirrection;
               }
               _loc2_.captured = true;
            }
            _loc1_++;
         }
      }
      
      public function Animation(param1:Event) : void
      {
         if(isAction)
         {
            if(this.currentFrame != 4)
            {
               gotoAndPlay(4);
            }
         }
         else if(dx == 0)
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
   }
}
