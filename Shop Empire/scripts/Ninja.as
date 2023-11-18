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
   
   [Embed(source="/_assets/assets.swf", symbol="Ninja")]
   public dynamic class Ninja extends MovieClip
   {
       
      
      public var ninjitsu:*;
      
      public var rideElevator:*;
      
      public var pursue:*;
      
      public var destination:*;
      
      public var elevatorTarget:*;
      
      public var stolenProfit:*;
      
      public var waiting:*;
      
      public var dirrection:*;
      
      public var dx:*;
      
      public var floorPos:*;
      
      public var catcher:*;
      
      public var elevatorChecked:*;
      
      public var tryToEnter:*;
      
      public var arrested:MovieClip;
      
      public var ninjitsuTime:*;
      
      public var homePos:*;
      
      public var speedX:*;
      
      public var worldX:*;
      
      public var worldY:*;
      
      public var pursuer:*;
      
      public var arrestDelay:*;
      
      public var swapingDelay:*;
      
      public var myParent:*;
      
      public var isStealing:*;
      
      public var hiding:*;
      
      public var delay:*;
      
      public var blinkDelay:*;
      
      public var lastDestination:*;
      
      public var stealingTime:*;
      
      public var stealingRate:*;
      
      public var elevatorFloor:*;
      
      public var runDelay:*;
      
      public var firstCome:*;
      
      public var ninjitsuCharge:*;
      
      public var captured:*;
      
      public var securityDetected:*;
      
      public var stealSomething:*;
      
      public var openLockDelay:*;
      
      public var initialBlinkDelay:*;
      
      public var toiletTarget:*;
      
      public var goHome:*;
      
      public function Ninja()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3,3,frame4,4,frame5);
      }
      
      public function ninjitsuProgress() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = myParent.floorList.indexOf(floorPos);
         if(!goHome && !myParent.alarmTrigger)
         {
            if(destination != null)
            {
               _loc2_ = myParent.floorList.indexOf(destination.ground);
            }
            else
            {
               _loc2_ = _loc1_;
            }
         }
         else
         {
            _loc2_ = myParent.floorList.indexOf(myParent.ground);
         }
         if(_loc2_ > _loc1_)
         {
            _loc3_ = _loc1_ + 1;
         }
         else if(_loc2_ < _loc1_)
         {
            _loc3_ = _loc1_ - 1;
         }
         else
         {
            _loc3_ = _loc1_;
         }
         if(_loc3_ != _loc1_)
         {
            if(!rideElevator && (myParent.floorList[_loc3_] != myParent.ground && (this.worldX > myParent.floorList[_loc3_].worldX && this.worldX < myParent.floorList[_loc3_].worldX + myParent.floorList[_loc3_].width) || myParent.floorList[_loc3_] == myParent.ground))
            {
               if(ninjitsuCharge <= 0)
               {
                  if(!ninjitsu)
                  {
                     if(pursue)
                     {
                        ninjitsu = true;
                     }
                     else
                     {
                        ninjitsu = Math.random() * 100 < 5;
                     }
                  }
                  else if(ninjitsuTime > 0)
                  {
                     --ninjitsuTime;
                  }
                  else
                  {
                     (_loc4_ = new fx_smoke()).worldX = this.worldX;
                     _loc4_.worldY = this.worldY - this.height / 2;
                     myParent.legendParent.addChild(_loc4_);
                     this.floorPos = myParent.floorList[_loc3_];
                     this.worldY = floorPos.worldY;
                     if(!(floorPos is Floor))
                     {
                        this.worldY -= floorPos.height;
                     }
                     ninjitsu = false;
                     ninjitsuTime = 24;
                     ninjitsuCharge = 96;
                     if(elevatorTarget != null)
                     {
                        if((_loc5_ = elevatorTarget.visitorWaiting.indexOf(this)) >= 0)
                        {
                           elevatorTarget.visitorWaiting.splice(_loc5_,1);
                           if(elevatorTarget.visitorWaiting.length <= 0)
                           {
                              elevatorTarget.isStart = false;
                           }
                        }
                        elevatorTarget = null;
                     }
                  }
               }
            }
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
      
      public function checkSecurity(param1:MovieClip) : MovieClip
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = 0;
         _loc3_ = null;
         while(_loc2_ < param1.visitorList.length && _loc3_ == null)
         {
            if((_loc4_ = param1.visitorList[_loc2_]) is CrewSecuritylv1 || _loc4_ is CrewSecuritylv2 || _loc4_ is CrewSecuritylv3)
            {
               _loc3_ = _loc4_;
            }
            _loc2_++;
         }
         if(_loc3_ != null)
         {
            captured = true;
         }
         return _loc3_;
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
      
      public function scanTarget() : MovieClip
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = new Array();
         _loc2_ = 0;
         while(_loc2_ < myParent.tenantParent.numChildren)
         {
            if(!((_loc5_ = myParent.tenantParent.getChildAt(_loc2_)) is SupportElevator || _loc5_ is SupportRestroom || _loc5_ is TenantHall) && _loc5_.isClose && lastDestination.indexOf(_loc5_) < 0)
            {
               _loc1_.push(_loc5_);
            }
            _loc2_++;
         }
         _loc3_ = Math.floor(Math.random() * _loc1_.length);
         return _loc1_[_loc3_];
      }
      
      internal function frame5() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         dx = 0;
         speedX = 3;
         stealSomething = false;
         hiding = 0;
         myParent = root;
         isStealing = false;
         elevatorChecked = null;
         securityDetected = new Array();
         pursuer = new Array();
         captured = false;
         goHome = false;
         catcher = null;
         rideElevator = false;
         waiting = 0;
         ninjitsu = false;
         ninjitsuTime = 24;
         ninjitsuCharge = 0;
         stolenProfit = 0;
         addEventListener(Event.ENTER_FRAME,Animation);
         delay = 100;
         openLockDelay = 0;
         tryToEnter = false;
         stealingTime = 0;
         stealingRate = 0;
         firstCome = true;
         lastDestination = new Array();
         addEventListener(Event.ENTER_FRAME,Behavior);
         runDelay = 0;
         swapingDelay = 0;
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      public function Behavior(param1:Event) : void
      {
         var sp:* = undefined;
         var rate:* = undefined;
         var rAlrmTrigger:* = undefined;
         var profit:* = undefined;
         var tipsText:* = undefined;
         var temp:* = undefined;
         var glowFilter:* = undefined;
         var rnd:* = undefined;
         var stealArea:* = undefined;
         var test:* = undefined;
         var bi:* = undefined;
         var vi:* = undefined;
         var bonusProfit:* = undefined;
         var event:Event = param1;
         sp = 0;
         while(sp < myParent.gameSpeed)
         {
            if(stealSomething && !pursue)
            {
               if(hiding > 0)
               {
                  --hiding;
               }
               else
               {
                  stealSomething = false;
               }
            }
            if(ninjitsuCharge > 0)
            {
               --ninjitsuCharge;
            }
            if(!captured)
            {
               scanSecurity();
               runAwayFromSecurity();
               if(floorPos is Floor)
               {
                  if(this.worldX + dx < floorPos.worldX)
                  {
                     this.worldX = floorPos.worldX - dx;
                     if(!pursue)
                     {
                        dx = speedX;
                     }
                     else
                     {
                        dx = speedX * 2 - 1;
                        runDelay = 5;
                     }
                  }
                  if(this.worldX + dx > floorPos.worldX + floorPos.width)
                  {
                     this.worldX = floorPos.worldX + floorPos.width - dx;
                     if(!pursue)
                     {
                        dx = -speedX;
                     }
                     else
                     {
                        dx = -(speedX * 2 - 1);
                        runDelay = 5;
                     }
                  }
               }
               if(isStealing)
               {
                  dx = 0;
                  if(destination != null)
                  {
                     if(stealingTime > 0 && !myParent.alarmTrigger)
                     {
                        --stealingTime;
                        --stealingRate;
                        if(stealingRate <= 0)
                        {
                           stealingRate = 20;
                           rate = Math.random() * 10 - 5;
                           if(rate > 0)
                           {
                              rAlrmTrigger = Math.random() * 100;
                              if(rAlrmTrigger < destination.tLevel * 30)
                              {
                                 myParent.banditTrigger = this;
                                 myParent.robedBooth = destination;
                                 myParent.alarmTrigger = true;
                              }
                           }
                           if(!myParent.alarmTrigger)
                           {
                              profit = (Math.floor(Math.random() * 40) + 10) * 10;
                              stolenProfit += profit;
                              myParent.otherOutcome += profit;
                           }
                           stealingTime += rate;
                           stealSomething = true;
                           hiding = 72;
                        }
                     }
                     else
                     {
                        if(!destination.isOpen)
                        {
                           destination.isOpen = true;
                        }
                        if(lastDestination.indexOf(destination) < 0)
                        {
                           lastDestination.push(destination);
                        }
                        destination.finishStealing(this);
                        if(!isStealing)
                        {
                           myParent.addCashUpdate(stolenProfit,worldX,worldY - height,false);
                           if(!myParent.firstBanditStealing)
                           {
                              if(myParent.menuParent.numChildren > 0)
                              {
                                 try
                                 {
                                    temp = myParent.menuParent.getChildAt(0);
                                    temp.closeMenu();
                                 }
                                 catch(e:Error)
                                 {
                                 }
                              }
                              myParent.cameraX = worldX - myParent.CAMERA_WIDTH / 2;
                              myParent.cameraY = worldY - myParent.CAMERA_HEIGHT + 120;
                              tipsText = "If there is a flashing red color on your booths it means there is theft. Try to add more security on your mall, it will prevent theft.";
                              myParent.addTips("Tips:\n" + tipsText);
                              if(myParent.tipsHistory.indexOf(tipsText) < 0)
                              {
                                 myParent.tipsHistory.unshift(tipsText);
                                 myParent.userinterface.tipsHistory.updateText(myParent.tipsHistory);
                                 if(!myParent.userinterface.tipsHistory.visible)
                                 {
                                    glowFilter = new GlowFilter(16746496);
                                    myParent.userinterface.btnMailBox.filters = [glowFilter];
                                    if(myParent.userinterface.currentLabel == "reveal")
                                    {
                                       myParent.userinterface.tipsHistory.checkHeight();
                                    }
                                 }
                              }
                              myParent.firstBanditStealing = true;
                           }
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
                           destination.finishStealing(this);
                        }
                     }
                  }
               }
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
               if(myParent.dayTime >= 5 && myParent.dayTime < 22)
               {
                  goHome = true;
                  if(isStealing)
                  {
                     destination.finishStealing(this);
                  }
               }
               if(!goHome && !myParent.alarmTrigger)
               {
                  if(destination == null || destination is SupportElevator || destination is SupportRestroom)
                  {
                     if(firstCome)
                     {
                        destination = scanTarget();
                        firstCome = false;
                     }
                     else
                     {
                        rnd = Math.random() * 100;
                        if(rnd < 50)
                        {
                           destination = scanTarget();
                           if(destination == null)
                           {
                              goHome = true;
                           }
                        }
                        else
                        {
                           goHome = true;
                        }
                     }
                  }
                  else if(destination.ground != floorPos)
                  {
                     if(!pursue)
                     {
                        if(elevatorTarget == null && !ninjitsu)
                        {
                           elevatorTarget = getElevator();
                        }
                     }
                  }
                  else if(!pursue)
                  {
                     if(!isStealing)
                     {
                        if(destination.enterance != null)
                        {
                           stealArea = destination.enterance;
                        }
                        else
                        {
                           stealArea = destination.door;
                        }
                        if(worldX < destination.worldX + stealArea.x)
                        {
                           dx = speedX;
                        }
                        else if(worldX > destination.worldX + stealArea.x + stealArea.width)
                        {
                           dx = -speedX;
                        }
                        else if(stealArea.hitTestObject(this))
                        {
                           if(destination.Visited(this))
                           {
                              dx = 0;
                              if(!tryToEnter)
                              {
                                 openLockDelay = 50;
                                 tryToEnter = true;
                                 stealingTime = 100;
                                 stealingRate = 20;
                              }
                              else if(openLockDelay > 0)
                              {
                                 --openLockDelay;
                              }
                              else if(!destination.isOpen)
                              {
                                 destination.isOpen = true;
                              }
                              destination.stolen(this);
                           }
                        }
                     }
                  }
               }
               if(elevatorTarget != null && !pursue && !captured)
               {
                  if(elevatorFloor.door != null)
                  {
                     if(elevatorFloor.door.hitTestObject(this))
                     {
                        test = null;
                        if(elevatorFloor.door.currentFrame < 10 && elevatorFloor.door.currentFrame + myParent.gameSpeed >= 10)
                        {
                           test = checkSecurity(elevatorTarget);
                           if(test != null)
                           {
                              catcher = test;
                           }
                        }
                        if(test == null)
                        {
                           elevatorTarget.Visited(this);
                        }
                     }
                     else if(worldX > elevatorTarget.worldX + elevatorTarget.width - (elevatorFloor.door.x + elevatorFloor.door.width))
                     {
                        if(!myParent.alarmTrigger)
                        {
                           dx = -speedX;
                        }
                        else
                        {
                           dx = -(speedX * 2 - 1);
                        }
                     }
                     else if(worldX < elevatorTarget.worldX + elevatorFloor.door.x)
                     {
                        if(!myParent.alarmTrigger)
                        {
                           dx = speedX;
                        }
                        else
                        {
                           dx = speedX * 2 - 1;
                        }
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
                     elevatorTarget = null;
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
               if((goHome || myParent.alarmTrigger) && !isStealing && !pursue)
               {
                  if(destination != null)
                  {
                     destination = null;
                  }
                  if(floorPos == myParent.ground && !rideElevator)
                  {
                     if(elevatorTarget != null)
                     {
                        elevatorFloor = null;
                        vi = elevatorTarget.visitorWaiting.indexOf(this);
                        if(vi >= 0)
                        {
                           elevatorTarget.visitorWaiting.splice(vi,1);
                           if(elevatorTarget.visitorWaiting.length <= 0)
                           {
                              elevatorTarget.isStart = false;
                           }
                        }
                        elevatorTarget = null;
                     }
                     if(worldX < homePos + 11 && homePos > 0)
                     {
                        if(!myParent.alarmTrigger)
                        {
                           dx = speedX;
                        }
                        else
                        {
                           dx = speedX * 2 - 1;
                        }
                     }
                     else if(worldX > homePos - 11 && homePos <= 0)
                     {
                        if(!myParent.alarmTrigger)
                        {
                           dx = -speedX;
                        }
                        else
                        {
                           dx = -(speedX * 2 - 1);
                        }
                     }
                  }
                  else if(!pursue)
                  {
                     if(elevatorTarget == null && !ninjitsu)
                     {
                        elevatorTarget = getElevator();
                     }
                  }
               }
               if(!isStealing && (destination != null && destination.ground != floorPos || goHome && floorPos != myParent.ground))
               {
                  ninjitsuProgress();
               }
               else
               {
                  ninjitsu = false;
               }
               if(ninjitsu)
               {
                  dx = 0;
               }
               this.worldX += dx;
               if(this.worldX < -10 || this.worldX > myParent.MAX_WIDTH + 10)
               {
                  bi = myParent.banditList.indexOf(this);
                  myParent.banditList.splice(bi,1);
                  if(this == myParent.banditTrigger)
                  {
                     myParent.banditTrigger = null;
                  }
                  sp = myParent.gameSpeed;
                  removeEventListener(Event.ENTER_FRAME,Animation);
                  removeEventListener(Event.ENTER_FRAME,Behavior);
                  this.parent.removeChild(this);
                  break;
               }
            }
            else
            {
               dx = 0;
               if(elevatorTarget != null)
               {
                  vi = elevatorTarget.visitorList.indexOf(this);
                  if(vi >= 0)
                  {
                     elevatorTarget.visitorList.splice(vi,1);
                     elevatorTarget.elevatorTargetList.splice(vi,1);
                     myParent.visitorParent.addChild(this);
                  }
                  vi = elevatorTarget.visitorWaiting.indexOf(this);
                  if(vi >= 0)
                  {
                     elevatorTarget.visitorWaiting.splice(vi,1);
                     if(elevatorTarget.visitorWaiting.length <= 0)
                     {
                        elevatorTarget.isStart = false;
                     }
                  }
                  elevatorTarget = null;
               }
               if(this == myParent.banditTrigger)
               {
                  myParent.banditTrigger = null;
               }
               if(catcher != null)
               {
                  if(!catcher.isAction)
                  {
                     catcher.isAction = true;
                     catcher = null;
                  }
               }
               if(arrested != null)
               {
                  if(arrested.currentLabel == "Arrest Label")
                  {
                     sp = myParent.gameSpeed;
                     arrestDelay = 60;
                     initialBlinkDelay = 7;
                     blinkDelay = 7;
                     bi = myParent.banditList.indexOf(this);
                     myParent.banditList.splice(bi,1);
                     if(this == myParent.banditTrigger)
                     {
                        myParent.banditTrigger = null;
                     }
                     bonusProfit = Math.round(stolenProfit * (10 / 100));
                     if(bonusProfit < 35)
                     {
                        bonusProfit = 35;
                     }
                     myParent.otherOutcome -= stolenProfit;
                     if(myParent.otherOutcome < 0)
                     {
                        myParent.otherIncome += Math.abs(myParent.otherOutcome);
                        myParent.otherOutcome = 0;
                     }
                     myParent.otherIncome += bonusProfit;
                     myParent.addCashUpdate(stolenProfit,this.worldX,this.worldY,true,bonusProfit);
                     ++myParent.banditCaptured;
                     stolenProfit = 0;
                     removeEventListener(Event.ENTER_FRAME,Behavior);
                     addEventListener(Event.ENTER_FRAME,Arrested);
                     break;
                  }
                  this.alpha = 1;
               }
            }
            sp++;
         }
      }
      
      public function scanSecurity() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < myParent.crewList.length)
         {
            _loc3_ = myParent.crewList[_loc2_];
            if(_loc3_ is CrewSecuritylv1 || _loc3_ is CrewSecuritylv2 || _loc3_ is CrewSecuritylv3)
            {
               _loc4_ = securityDetected.indexOf(_loc3_);
               if(_loc3_.floorPos == floorPos)
               {
                  if(_loc4_ < 0)
                  {
                     if(Math.abs(_loc3_.worldX - worldX) <= 200)
                     {
                        if(dirrection == 1)
                        {
                           if(_loc3_.worldX > worldX)
                           {
                              _loc1_ = _loc3_;
                           }
                        }
                        else if(_loc3_.worldX < worldX)
                        {
                           _loc1_ = _loc3_;
                        }
                        securityDetected.push(_loc1_);
                     }
                  }
               }
               else if(_loc4_ >= 0)
               {
                  securityDetected.splice(_loc4_,1);
               }
            }
            _loc2_++;
         }
      }
      
      public function Arrested(param1:Event) : void
      {
         --arrestDelay;
         if(arrestDelay < 28)
         {
            --blinkDelay;
            if(blinkDelay <= 0)
            {
               --initialBlinkDelay;
               blinkDelay = initialBlinkDelay;
               if(this.alpha == 1)
               {
                  this.alpha = 0;
               }
               else
               {
                  this.alpha = 1;
               }
            }
         }
         if(arrestDelay <= 0)
         {
            removeEventListener(Event.ENTER_FRAME,Animation);
            removeEventListener(Event.ENTER_FRAME,Arrested);
            this.parent.removeChild(this);
         }
      }
      
      public function Animation(param1:Event) : void
      {
         if(!isStealing)
         {
            if(!stealSomething && !myParent.alarmTrigger && !captured && !rideElevator && !ninjitsu && !pursue)
            {
               if(this.alpha > 0.6)
               {
                  this.alpha -= 0.1;
               }
            }
            else if(!captured)
            {
               this.alpha = 1;
            }
         }
         if(captured)
         {
            if(this.currentFrame != 4)
            {
               gotoAndPlay(4);
            }
         }
         else if(!ninjitsu)
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
         }
         else if(this.currentLabel != "ninjitsu")
         {
            gotoAndPlay("ninjitsu");
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
      
      public function runAwayFromSecurity() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(runDelay > 0)
         {
            --runDelay;
         }
         else
         {
            pursue = pursuer.length > 0 && securityDetected.indexOf(pursuer[0]) >= 0;
            if(pursue)
            {
               if(elevatorTarget != null)
               {
                  _loc2_ = elevatorTarget.visitorWaiting.indexOf(this);
                  if(_loc2_ >= 0)
                  {
                     elevatorTarget.visitorWaiting.splice(_loc2_,1);
                     if(elevatorTarget.visitorWaiting.length <= 0)
                     {
                        elevatorTarget.isStart = false;
                     }
                  }
                  elevatorTarget = null;
               }
               _loc1_ = pursuer[0];
               if(_loc1_.worldX > worldX)
               {
                  dx = -(speedX * 2);
               }
               else if(_loc1_.worldX < worldX)
               {
                  dx = speedX * 2 - 1;
               }
               if(ninjitsu)
               {
                  ninjitsuProgress();
               }
               else if(Math.abs(worldX - _loc1_.worldX) >= 300)
               {
                  ninjitsuProgress();
               }
            }
         }
         if(swapingDelay > 0)
         {
            --swapingDelay;
         }
         else
         {
            if(pursuer.length > 0)
            {
               _loc1_ = pursuer.shift();
               pursuer.push(_loc1_);
            }
            swapingDelay = 5;
         }
      }
   }
}
