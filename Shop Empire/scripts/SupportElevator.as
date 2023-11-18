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
   
   [Embed(source="/_assets/assets.swf", symbol="SupportElevator")]
   public dynamic class SupportElevator extends MovieClip
   {
       
      
      public var legend:*;
      
      public var minHeight:Number;
      
      public var visitorList:*;
      
      public const UPGRADE_COST:Array = [3500,4000,4500];
      
      public const speedModifier:Array = [1,1,2,3];
      
      public const UPGRADE_FLOOR_COST:* = 2750;
      
      public const TENANT_NOTE:* = "Transport between floors";
      
      public var wire:MovieClip;
      
      public var canExpand:Boolean;
      
      public var isOpen:Boolean;
      
      public const MAX_LEVEL:* = 4;
      
      public var elevatorList:Array;
      
      public const capacity:Array = [10,15,15,20];
      
      public var floorList:Array;
      
      public var expandSymbol:MovieClip;
      
      public var room:MovieClip;
      
      public var eRoom:MovieClip;
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public var isUP:Boolean;
      
      public var elevatorTargetList:*;
      
      public var isStart:Boolean;
      
      public var expandMode:MovieClip;
      
      public var tLevel:*;
      
      public var myParent:*;
      
      public var body:ElevatorBody;
      
      public const TENANT_TYPE:* = "Support Building";
      
      public var maxHeight:Number;
      
      public var targetIndex:*;
      
      public var isActivated:Boolean;
      
      public var expandBuild:MovieClip;
      
      public var visitorWaiting:*;
      
      public function SupportElevator()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function checkCloseFloor() : MovieClip
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < elevatorList.length)
         {
            if(_loc2_ == 0)
            {
               _loc1_ = 0;
            }
            else if(Math.abs(elevatorList[_loc2_].y + elevatorList[_loc2_].height - (eRoom.y + eRoom.height)) < Math.abs(elevatorList[_loc1_].y + elevatorList[_loc1_].height - (eRoom.y + eRoom.height)))
            {
               _loc1_ = _loc2_;
            }
            _loc2_++;
         }
         return floorList[_loc1_];
      }
      
      public function NoticeToExpand(param1:MouseEvent) : void
      {
         legend = new LegendWideBox();
         legend.alignment = "Center";
         legend.commentText = "Drag elevator to expand floor. Each floor cost $" + UPGRADE_FLOOR_COST;
         myParent.noticeParent.addChild(legend);
      }
      
      public function getTopPosition() : Number
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < elevatorList.length)
         {
            if(!_loc1_)
            {
               _loc1_ = elevatorList[_loc2_].y;
            }
            else if(_loc1_ > elevatorList[_loc2_].y)
            {
               _loc1_ = elevatorList[_loc2_].y;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function removeAllListener() : void
      {
         removeEventListener(Event.ENTER_FRAME,Animate);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,HoldElevator);
      }
      
      internal function frame1() : *
      {
         isOpen = false;
         isUP = true;
         isActivated = false;
         isStart = false;
         myParent = root;
         visitorWaiting = new Array();
         updateWire();
         addEventListener(Event.ENTER_FRAME,Animate);
         visitorList = new Array();
         elevatorTargetList = new Array();
         targetIndex = Number;
         this.addEventListener(MouseEvent.MOUSE_DOWN,HoldElevator);
         addEventListener(MouseEvent.MOUSE_OVER,NoticeToExpand);
         addEventListener(MouseEvent.MOUSE_OUT,NoticeDisappear);
      }
      
      public function replaceBody(param1:Number) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         _loc2_ = elevatorList[param1];
         _loc3_ = new ElevatorUpgrade();
         _loc3_.y = _loc2_.y;
         _loc3_.door.gotoAndStop(_loc2_.door.currentFrame);
         _loc2_.door.stop();
         _loc4_ = 0;
         while(_loc4_ < myParent.visitorParent.numChildren)
         {
            if((_loc8_ = myParent.visitorParent.getChildAt(_loc4_)).elevatorTarget == this && _loc8_.elevatorFloor == _loc2_)
            {
               _loc8_.elevatorFloor = _loc3_;
            }
            _loc4_++;
         }
         _loc5_ = getChildIndex(_loc2_);
         if((_loc6_ = _loc2_.getChildByName("upgrade")) != null)
         {
            _loc3_.addChild(_loc6_);
         }
         _loc7_ = elevatorTargetList.indexOf(_loc2_);
         while(_loc7_ >= 0)
         {
            elevatorTargetList[_loc7_] = _loc3_;
            _loc7_ = elevatorTargetList.indexOf(_loc2_);
         }
         removeChild(_loc2_);
         addChildAt(_loc3_,_loc5_);
         elevatorList[param1] = _loc3_;
      }
      
      public function checkAllVisitorTarget() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc1_ = true;
         _loc2_ = true;
         _loc3_ = 0;
         while(_loc3_ < elevatorTargetList.length && (_loc1_ || _loc2_))
         {
            if((_loc4_ = elevatorTargetList[_loc3_]).y + _loc4_.height < eRoom.y + eRoom.height)
            {
               _loc2_ = false;
            }
            else if(_loc4_.y + _loc4_.height > eRoom.y + eRoom.height)
            {
               _loc1_ = false;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < visitorWaiting.length && (_loc1_ || _loc2_))
         {
            if((_loc4_ = visitorWaiting[_loc3_]).worldY < this.worldY + eRoom.y + eRoom.height)
            {
               _loc2_ = false;
            }
            else if(_loc4_.worldY > this.worldY + eRoom.y + eRoom.height)
            {
               _loc1_ = false;
            }
            _loc3_++;
         }
         if(_loc1_ && !_loc2_)
         {
            isUP = true;
         }
         else if(_loc2_ && !_loc1_)
         {
            isUP = false;
         }
      }
      
      public function Animate(param1:Event) : void
      {
         var detect:* = undefined;
         var i:* = undefined;
         var loop:* = undefined;
         var temp:* = undefined;
         var exitVisitorList:* = undefined;
         var exitFloor:* = undefined;
         var exitElevator:* = undefined;
         var indexFloor:* = undefined;
         var index:* = undefined;
         var closeFloor:* = undefined;
         var closeY:* = undefined;
         var event:Event = param1;
         detect = false;
         i = 0;
         while(i < elevatorList.length)
         {
            temp = elevatorList[i];
            if(!detect)
            {
               minHeight = temp.y + temp.height - 2;
               maxHeight = temp.y + temp.height - 2;
               detect = true;
            }
            else
            {
               if(minHeight < temp.y + temp.height - 2)
               {
                  minHeight = temp.y + temp.height - 2;
               }
               if(maxHeight > temp.y + temp.height - 2)
               {
                  maxHeight = temp.y + temp.height - 2;
               }
            }
            if(eRoom.y + eRoom.height == temp.y + temp.height - 2)
            {
               if(!isOpen)
               {
                  temp.door.gotoAndStop(1);
               }
               else
               {
                  temp.door.gotoAndStop(temp.door.currentFrame + myParent.gameSpeed);
                  if(temp.door.currentFrame >= temp.door.totalFrames)
                  {
                     isOpen = false;
                     temp.door.gotoAndStop(1);
                  }
               }
            }
            else
            {
               temp.door.gotoAndStop(1);
            }
            i++;
         }
         loop = 0;
         while(loop < myParent.gameSpeed * speedModifier[tLevel - 1])
         {
            room.x = eRoom.x;
            room.y = eRoom.y;
            if(visitorWaiting.length <= 0)
            {
               isStart = false;
            }
            isActivated = visitorList.length > 0 || isStart;
            exitVisitorList = new Array();
            exitFloor = new Array();
            exitElevator = null;
            i = 0;
            while(i < elevatorTargetList.length)
            {
               if(eRoom.y + eRoom.height == elevatorTargetList[i].y + elevatorTargetList[i].height - 2)
               {
                  exitVisitorList.push(visitorList[i]);
                  indexFloor = elevatorList.indexOf(elevatorTargetList[i]);
                  exitFloor.push(floorList[indexFloor]);
                  exitElevator = elevatorList[indexFloor];
                  isOpen = true;
               }
               i++;
            }
            if(!isOpen)
            {
               i = 0;
               while(i < visitorWaiting.length)
               {
                  temp = visitorWaiting[i].elevatorFloor;
                  if(eRoom.y + eRoom.height == temp.y + temp.height - 2 && visitorList.length < capacity[tLevel - 1])
                  {
                     isOpen = true;
                     break;
                  }
                  i++;
               }
            }
            if(isOpen)
            {
               if(exitElevator != null && (exitElevator.door.currentFrame >= 10 && exitElevator.door.currentFrame - myParent.gameSpeed < 10))
               {
                  i = 0;
                  while(i < exitVisitorList.length)
                  {
                     exitVisitorList[i].floorPos = exitFloor[i];
                     exitVisitorList[i].worldX = this.worldX + this.width / 2;
                     exitVisitorList[i].worldY = exitFloor[i].worldY;
                     exitVisitorList[i].elevatorTarget = null;
                     exitVisitorList[i].elevatorChecked = this;
                     exitVisitorList[i].rideElevator = false;
                     if(!(exitFloor[i] is Floor))
                     {
                        exitVisitorList[i].worldY -= exitFloor[i].height;
                     }
                     exitVisitorList[i].x = exitVisitorList[i].worldX - myParent.cameraX;
                     exitVisitorList[i].y = exitVisitorList[i].worldY - myParent.cameraY;
                     myParent.visitorParent.addChild(exitVisitorList[i]);
                     i++;
                  }
                  i = 0;
                  while(i < exitVisitorList.length)
                  {
                     index = visitorList.indexOf(exitVisitorList[i]);
                     visitorList.splice(index,1);
                     elevatorTargetList.splice(index,1);
                     i++;
                  }
                  checkAllVisitorTarget();
               }
            }
            else if(isActivated)
            {
               if(isUP)
               {
                  if(eRoom.y + eRoom.height > maxHeight)
                  {
                     eRoom.y -= 2;
                  }
                  else
                  {
                     isUP = false;
                  }
               }
               else if(eRoom.y + eRoom.height < minHeight)
               {
                  eRoom.y += 2;
               }
               else
               {
                  isUP = true;
               }
            }
            try
            {
               myParent.tenantParent.getChildIndex(this);
            }
            catch(e:Error)
            {
               closeFloor = checkCloseFloor();
               closeY = closeFloor.worldY;
               if(!(closeFloor is Floor))
               {
                  closeY -= closeFloor.height;
               }
               i = 0;
               while(i < visitorList.length)
               {
                  visitorList[i].floorPos = closeFloor;
                  visitorList[i].worldX = this.worldX + this.width / 2;
                  visitorList[i].worldY = closeY;
                  visitorList[i].elevatorTarget = null;
                  visitorList[i].elevatorChecked = this;
                  visitorList[i].rideElevator = false;
                  visitorList[i].x = visitorList[i].worldX - myParent.cameraX;
                  visitorList[i].y = visitorList[i].worldY - myParent.cameraY;
                  myParent.visitorParent.addChild(visitorList[i]);
                  i++;
               }
               loop = myParent.gameSpeed * speedModifier[tLevel - 1];
               removeAllListener();
            }
            loop++;
         }
      }
      
      public function HoldElevator(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         if(myParent.userinterface.getButtonActive() != 0)
         {
            expandMode = new MovieClip();
            expandBuild = new MovieClip();
            expandSymbol = new MovieClip();
            this.parent.parent.addChild(expandMode);
            this.parent.parent.addChild(expandBuild);
            this.parent.parent.addChild(expandSymbol);
            _loc2_ = new HelpExpandElevator();
            _loc2_.x = this.x + this.width / 2;
            _loc2_.y = this.y + maxHeight - 82;
            expandSymbol.addChild(_loc2_);
            _loc2_ = new HelpExpandElevator();
            _loc2_.x = this.x + this.width / 2;
            _loc2_.y = this.y + minHeight;
            _loc2_.scaleY = -1;
            expandSymbol.addChild(_loc2_);
            addEventListener(Event.ENTER_FRAME,ExpandSymbol);
            stage.addEventListener(MouseEvent.MOUSE_MOVE,ExpandElevator);
            stage.addEventListener(MouseEvent.MOUSE_UP,ReleaseElevator);
         }
      }
      
      public function updateWire() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < elevatorList.length)
         {
            if(_loc1_ == 0)
            {
               wire.y = elevatorList[_loc1_].y;
            }
            else if(elevatorList[_loc1_].y < wire.y)
            {
               wire.y = elevatorList[_loc1_].y;
            }
            _loc1_++;
         }
         wire.height = height - 2;
      }
      
      public function ExpandSymbol(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         expandMode.x = this.x;
         expandBuild.x = this.x;
         expandMode.y = this.y + 2;
         expandBuild.y = this.y + 2;
         _loc2_ = expandSymbol.getChildAt(0);
         _loc2_.x = this.x + this.width / 2;
         _loc2_.y = this.y + maxHeight - 82;
         _loc3_ = expandSymbol.getChildAt(1);
         _loc3_.x = this.x + this.width / 2;
         _loc3_.y = this.y + minHeight;
      }
      
      public function Visited(param1:MovieClip) : void
      {
         var temp:* = undefined;
         var tWidth:* = undefined;
         var vIndex:* = undefined;
         var wIndex:* = undefined;
         var indexList:* = undefined;
         var visitor:MovieClip = param1;
         if(visitor.waiting > 0)
         {
            --visitor.waiting;
         }
         if(visitorWaiting.indexOf(visitor) < 0 && visitorList.indexOf(visitor) < 0)
         {
            visitorWaiting.push(visitor);
         }
         if(visitorList.indexOf(visitor) < 0 && visitor.waiting <= 0)
         {
            temp = visitor.elevatorFloor;
            visitor.dx = visitor.dirrection;
            tWidth = visitor.width / 2;
            if(visitor.worldX - tWidth >= this.worldX + temp.door.x && visitor.worldX + tWidth <= this.worldX + temp.door.x + temp.door.width)
            {
               visitor.dx = 0;
               if(!isActivated)
               {
                  if(visitor.worldY < worldY + eRoom.y + eRoom.height)
                  {
                     isUP = true;
                  }
                  else if(visitor.worldY > worldY + eRoom.y + eRoom.height)
                  {
                     isUP = false;
                  }
               }
               isStart = true;
               if(isOpen)
               {
                  if(temp.door.currentFrame >= 10 && temp.door.currentFrame - myParent.gameSpeed < 10)
                  {
                     visitorList.push(visitor);
                     vIndex = visitorList.indexOf(visitor);
                     if(vIndex < capacity[tLevel - 1])
                     {
                        visitor.rideElevator = true;
                        visitor.x = eRoom.width / 2;
                        visitor.y = eRoom.height;
                        room.addChild(visitor);
                        wIndex = visitorWaiting.indexOf(visitor);
                        if(wIndex >= 0)
                        {
                           visitorWaiting.splice(wIndex,1);
                        }
                        if(!visitor.goHome)
                        {
                           if(visitor.toiletTarget == null)
                           {
                              if(!(visitor is CrewSecuritylv1 || visitor is CrewSecuritylv2 || visitor is CrewSecuritylv3))
                              {
                                 if(visitor.destination != null)
                                 {
                                    targetIndex = floorList.indexOf(visitor.destination.ground);
                                    if(myParent.visitorList.indexOf(visitor) >= 0 && visitor.destination == visitor.lastDestination)
                                    {
                                       targetIndex = -1;
                                    }
                                 }
                                 else
                                 {
                                    targetIndex = -1;
                                 }
                              }
                              else if(myParent.banditTrigger != null)
                              {
                                 targetIndex = floorList.indexOf(myParent.banditTrigger.floorPos);
                              }
                              else
                              {
                                 targetIndex = -1;
                              }
                           }
                           else
                           {
                              targetIndex = floorList.indexOf(visitor.toiletTarget.ground);
                           }
                        }
                        else
                        {
                           targetIndex = floorList.indexOf(myParent.ground);
                        }
                        if(targetIndex >= 0)
                        {
                           elevatorTargetList.push(elevatorList[targetIndex]);
                        }
                        else if(!visitor.goHome)
                        {
                           try
                           {
                              indexList = visitor.shiftFloor;
                              if(indexList < 0)
                              {
                                 elevatorTargetList.push(randomTargetElevator(visitor));
                              }
                              else
                              {
                                 targetIndex = floorList.indexOf(myParent.floorList[indexList]);
                                 if(targetIndex >= 0)
                                 {
                                    elevatorTargetList.push(elevatorList[targetIndex]);
                                 }
                                 else
                                 {
                                    elevatorTargetList.push(randomTargetElevator(visitor));
                                 }
                              }
                           }
                           catch(e:Error)
                           {
                              elevatorTargetList.push(randomTargetElevator(visitor));
                           }
                        }
                        else
                        {
                           elevatorTargetList.push(randomTargetElevator(visitor));
                        }
                        checkAllVisitorTarget();
                     }
                     else
                     {
                        visitorList.splice(vIndex,1);
                        visitor.waiting = 12;
                     }
                  }
               }
            }
         }
         else
         {
            visitor.visible = true;
         }
      }
      
      public function randomTargetElevator(param1:MovieClip) : MovieClip
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = new Array();
         _loc3_ = 0;
         while(_loc3_ < floorList.length)
         {
            if(floorList[_loc3_] != param1.floorPos)
            {
               _loc2_.push(elevatorList[_loc3_]);
            }
            _loc3_++;
         }
         if(_loc2_.length > 0)
         {
            _loc4_ = Math.floor(Math.random() * _loc2_.length);
            return _loc2_[_loc4_];
         }
         return param1.floorPos;
      }
      
      public function addNewElevator() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < expandBuild.numChildren)
         {
            _loc2_ = expandBuild.getChildAt(_loc1_);
            if(_loc2_.canBuild)
            {
               if(myParent.cash - myParent.purchase + myParent.recive < UPGRADE_FLOOR_COST)
               {
                  myParent.addNotification("Not enough cash");
                  break;
               }
               if(tLevel < 3)
               {
                  _loc4_ = new ElevatorBody();
               }
               else
               {
                  _loc4_ = new ElevatorUpgrade();
               }
               _loc4_.y = _loc2_.y;
               myParent.addCashUpdate(UPGRADE_FLOOR_COST,worldX + this.width / 2,worldY + _loc2_.y + _loc2_.height / 2,false);
               addChild(_loc4_);
               _loc3_ = 0;
               while(_loc3_ < myParent.pillarParent.numChildren)
               {
                  if(!((_loc5_ = myParent.pillarParent.getChildAt(_loc3_)) is Floor))
                  {
                     if(_loc2_.body.hitTestObject(_loc5_))
                     {
                        _loc5_.parent.removeChild(_loc5_);
                        _loc3_--;
                     }
                  }
                  _loc3_++;
               }
               _loc3_ = 0;
               while(_loc3_ < myParent.emptyParent.numChildren)
               {
                  _loc5_ = myParent.emptyParent.getChildAt(_loc3_);
                  if(_loc2_.body.hitTestObject(_loc5_))
                  {
                     _loc5_.parent.removeChild(_loc5_);
                     _loc3_--;
                  }
                  _loc3_++;
               }
               _loc3_ = 0;
               while(_loc3_ < myParent.floorList.length)
               {
                  if((_loc5_ = myParent.floorList[_loc3_]) is Floor)
                  {
                     if(Boolean(_loc2_.hitTestObject(_loc5_)) && this.y + _loc2_.y <= _loc5_.y)
                     {
                        floorList.push(_loc5_);
                        elevatorList.push(_loc4_);
                     }
                  }
                  else if(Boolean(_loc2_.hitTestObject(_loc5_)) && this.y + _loc2_.y <= _loc5_.y - _loc5_.height)
                  {
                     floorList.push(_loc5_);
                     elevatorList.push(_loc4_);
                  }
                  _loc3_++;
               }
               myParent.createPillar(worldX - 12,worldY + (_loc4_.y - 2));
               myParent.createPillar(worldX + (this.width - this.width % 12),worldY + (_loc4_.y - 2));
               myParent.createFloor(worldX - 12,worldY + _loc4_.y - 12,this.width - this.width % 12 + 24);
            }
            _loc1_++;
         }
         updateWire();
      }
      
      public function getBottomPosition() : Number
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < elevatorList.length)
         {
            if(!_loc1_)
            {
               _loc1_ = elevatorList[_loc2_].y + 72;
            }
            else if(_loc1_ < elevatorList[_loc2_].y + 72)
            {
               _loc1_ = elevatorList[_loc2_].y + 72;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function NoticeDisappear(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         try
         {
            myParent.noticeParent.removeChild(legend);
         }
         catch(e:Error)
         {
         }
      }
      
      public function ExpandElevator(param1:MouseEvent) : void
      {
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
         if(myParent.userinterface.getButtonActive() != 0)
         {
            _loc2_ = param1.stageY + myParent.cameraY;
            _loc3_ = getTopPosition();
            _loc4_ = getBottomPosition();
            if(_loc2_ < worldY + _loc3_ - 12)
            {
               _loc2_ = Math.round(_loc2_ / 12) * 12;
               _loc5_ = worldY + _loc3_ - _loc2_;
               if(expandMode.numChildren <= 0)
               {
                  (_loc6_ = new ElevatorExpand()).y = _loc3_ - _loc5_;
                  _loc6_.scaleY = _loc5_ / 74;
                  expandMode.addChild(_loc6_);
               }
               else
               {
                  (_loc6_ = expandMode.getChildAt(0)).y = _loc3_ - _loc5_;
                  _loc6_.scaleY = _loc5_ / 74;
                  _loc7_ = Math.floor((_loc5_ + 12) / 86);
                  if(expandBuild.numChildren < _loc7_)
                  {
                     if(tLevel < 3)
                     {
                        _loc8_ = new ExpandElevatorSymbol();
                     }
                     else
                     {
                        _loc8_ = new ExpandElevatorUpgraded();
                     }
                     _loc8_.y = _loc3_ - 84 * (expandBuild.numChildren + 1);
                     _loc8_.alpha = 0.3;
                     expandBuild.addChild(_loc8_);
                  }
                  else if(expandBuild.numChildren > _loc7_)
                  {
                     expandBuild.removeChild(expandBuild.getChildAt(expandBuild.numChildren - 1));
                  }
                  if(_loc7_ > 0)
                  {
                     _loc9_ = false;
                     _loc10_ = 0;
                     while(_loc10_ < expandBuild.numChildren)
                     {
                        if((_loc11_ = expandBuild.getChildAt(_loc10_)).hitTestObject(myParent.sky))
                        {
                           _loc9_ = true;
                        }
                        _loc12_ = 0;
                        while(_loc12_ < myParent.tenantParent.numChildren && !_loc9_)
                        {
                           if((_loc13_ = myParent.tenantParent.getChildAt(_loc12_)) != this && Boolean(_loc11_.body.hitTestObject(_loc13_)))
                           {
                              _loc9_ = true;
                           }
                           _loc12_++;
                        }
                        _loc11_.canBuild = !_loc9_;
                        _loc10_++;
                     }
                     canExpand = true;
                  }
                  else
                  {
                     canExpand = false;
                  }
                  if(canExpand)
                  {
                     _loc6_.transform.colorTransform = new ColorTransform(1,1,1,0.7,0,0,0,0);
                  }
                  else
                  {
                     _loc6_.transform.colorTransform = new ColorTransform(1,0,0,0.7,0,0,0,0);
                  }
               }
            }
            else if(_loc2_ > worldY + _loc4_ + 12)
            {
               _loc2_ = Math.round(_loc2_ / 12) * 12;
               _loc5_ = worldY + _loc4_ - _loc2_;
               if(expandMode.numChildren <= 0)
               {
                  (_loc6_ = new ElevatorExpand()).y = _loc4_ - _loc5_;
                  _loc6_.scaleY = _loc5_ / 74;
                  expandMode.addChild(_loc6_);
               }
               else
               {
                  (_loc6_ = expandMode.getChildAt(0)).y = _loc4_ - _loc5_;
                  _loc6_.scaleY = _loc5_ / 74;
                  _loc7_ = Math.abs(Math.ceil((_loc5_ + 12) / 74));
                  if(expandBuild.numChildren < _loc7_)
                  {
                     if(tLevel < 3)
                     {
                        _loc8_ = new ExpandElevatorSymbol();
                     }
                     else
                     {
                        _loc8_ = new ExpandElevatorUpgraded();
                     }
                     _loc8_.y = _loc4_ + 12 + 84 * expandBuild.numChildren;
                     _loc8_.alpha = 0.3;
                     expandBuild.addChild(_loc8_);
                  }
                  else if(expandBuild.numChildren > _loc7_)
                  {
                     expandBuild.removeChild(expandBuild.getChildAt(expandBuild.numChildren - 1));
                  }
                  if(_loc7_ > 0)
                  {
                     _loc9_ = false;
                     _loc10_ = 0;
                     while(_loc10_ < expandBuild.numChildren)
                     {
                        _loc11_ = expandBuild.getChildAt(_loc10_);
                        _loc12_ = 0;
                        while(_loc12_ < myParent.tenantParent.numChildren && !_loc9_)
                        {
                           if((_loc13_ = myParent.tenantParent.getChildAt(_loc12_)) != this && _loc11_.body.hitTestObject(_loc13_) || _loc11_.body.hitTestObject(myParent.ground) && _loc11_.y + this.y + 72 > myParent.ground.y - myParent.ground.height)
                           {
                              _loc9_ = true;
                           }
                           _loc12_++;
                        }
                        _loc11_.canBuild = !_loc9_;
                        _loc10_++;
                     }
                     canExpand = true;
                  }
                  else
                  {
                     canExpand = false;
                  }
                  if(canExpand)
                  {
                     _loc6_.transform.colorTransform = new ColorTransform(1,1,1,0.7,0,0,0,0);
                  }
                  else
                  {
                     _loc6_.transform.colorTransform = new ColorTransform(1,0,0,0.7,0,0,0,0);
                  }
               }
            }
            else if(expandMode.numChildren > 0)
            {
               expandMode.removeChild(expandMode.getChildAt(0));
            }
         }
      }
      
      public function ReleaseElevator(param1:MouseEvent) : void
      {
         addNewElevator();
         this.parent.parent.removeChild(expandMode);
         this.parent.parent.removeChild(expandBuild);
         this.parent.parent.removeChild(expandSymbol);
         removeEventListener(Event.ENTER_FRAME,ExpandSymbol);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,ExpandElevator);
         stage.removeEventListener(MouseEvent.MOUSE_UP,ReleaseElevator);
      }
   }
}
