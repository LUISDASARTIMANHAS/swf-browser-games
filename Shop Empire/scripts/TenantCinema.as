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
   
   [Embed(source="/_assets/assets.swf", symbol="TenantCinema")]
   public dynamic class TenantCinema extends MovieClip
   {
       
      
      public var pass:*;
      
      public var closedSymbol:MovieClip;
      
      public var visitorList:Array;
      
      public const UPGRADE_COST:Array = [3000,3500];
      
      public var doorImage:MovieClip;
      
      public const TENANT_NOTE:* = "Show movie from any countries. Usually for remove stress. Also sell some snack";
      
      public var i:*;
      
      public var isOpen:*;
      
      public var visitorCome:Number;
      
      public const MAX_LEVEL:* = 3;
      
      public var brokenLevel:*;
      
      public var broken11:MovieClip;
      
      public var broken13:MovieClip;
      
      public var broken14:MovieClip;
      
      public var broken15:MovieClip;
      
      public var doorClosed:MovieClip;
      
      public var broken10:MovieClip;
      
      public var broken12:MovieClip;
      
      public var broken16:MovieClip;
      
      public var broken17:MovieClip;
      
      public var broken18:MovieClip;
      
      public var lightList:*;
      
      public var isClose:*;
      
      public var broken1:MovieClip;
      
      public var broken2:MovieClip;
      
      public var broken3:MovieClip;
      
      public var broken4:MovieClip;
      
      public var broken5:MovieClip;
      
      public var broken6:MovieClip;
      
      public var broken7:MovieClip;
      
      public var broken8:MovieClip;
      
      public var broken9:MovieClip;
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public const PRICE:Array = [300,320,350];
      
      public var outcome:Number;
      
      public var tLevel:*;
      
      public var worker:*;
      
      public var ground:MovieClip;
      
      public var isBroken:*;
      
      public var body:MovieClip;
      
      public var income:Number;
      
      public const TENANT_TYPE:* = "Entertainment";
      
      public var door:MovieClip;
      
      public var broken:MovieClip;
      
      public var justBroken:*;
      
      public const Meal:Array = [30,30,30,50,50,60];
      
      public function TenantCinema()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function getCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 15 + tLevel * 5;
      }
      
      public function RepairShop(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = root;
         if(doorImage.currentFrame >= 10 && doorImage.currentFrame - _loc2_.gameSpeed < 10)
         {
            param1.alpha = 0;
            param1.isRepairing = true;
            worker = param1;
            pass = false;
         }
      }
      
      public function MoodManipulation(param1:Event) : void
      {
         var head:* = undefined;
         var sp:* = undefined;
         var target:* = undefined;
         var moodIncrease:* = undefined;
         var enjoyIncrease:* = undefined;
         var modifier:* = undefined;
         var amountItem:* = undefined;
         var recive:* = undefined;
         var event:Event = param1;
         head = root;
         sp = 0;
         while(sp < head.gameSpeed)
         {
            target = event.currentTarget;
            with(target)
            {
               
               if(otherDelay > 0)
               {
                  --otherDelay;
               }
               else
               {
                  moodIncrease = Math.random() * 3;
                  if(isBroken)
                  {
                     moodIncrease = -(moodIncrease / 2);
                  }
                  mood += moodIncrease;
                  enjoyIncrease = moodIncrease * 5 - 10;
                  if(enjoyIncrease < 0)
                  {
                     enjoyIncrease = 0;
                  }
                  else
                  {
                     modifier = Math.round(target.mood / 10);
                     amountItem = modifier - 3;
                     if(amountItem < 0)
                     {
                        amountItem = 0;
                     }
                     if(target.specialVisitor)
                     {
                        amountItem += Math.floor(Math.random() * modifier);
                     }
                     recive = Meal[Math.floor(Math.random() * Meal.length)] * amountItem;
                     income += recive;
                     head.addCashUpdate(recive,this.worldX + this.door.x + this.door.width / 2,this.worldY + this.door.y,true);
                  }
                  enjoyingTime += enjoyIncrease;
                  otherDelay += Math.round(Math.random() * 20) + 40;
               }
            }
            sp++;
         }
      }
      
      internal function frame1() : *
      {
         justBroken = true;
         lightList = new Array();
         lightList.push(broken1);
         lightList.push(broken2);
         lightList.push(broken3);
         lightList.push(broken4);
         lightList.push(broken5);
         lightList.push(broken6);
         lightList.push(broken7);
         lightList.push(broken8);
         lightList.push(broken9);
         lightList.push(broken10);
         lightList.push(broken11);
         lightList.push(broken12);
         lightList.push(broken13);
         lightList.push(broken14);
         lightList.push(broken15);
         lightList.push(broken16);
         lightList.push(broken17);
         lightList.push(broken18);
         i = 0;
         while(i < lightList.length)
         {
            lightList[i].isBroken = false;
            ++i;
         }
         visitorList = new Array();
         addEventListener(Event.ENTER_FRAME,Animate);
         stop();
      }
      
      public function restoreRelation() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = root;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.tenantList.length)
         {
            _loc3_ = _loc1_.tenantList[_loc2_];
            if(_loc3_ != this && _loc3_.ground == ground)
            {
               _loc4_ = worldX - (_loc3_.worldX + _loc3_.width);
               _loc5_ = _loc3_.worldX - (this.worldX + this.width);
               if(_loc4_ >= 0 && _loc4_ <= 48 || _loc5_ >= 0 && _loc5_ <= 48)
               {
                  if(_loc3_ is TenantBurger)
                  {
                     _loc1_.popularity -= 4;
                  }
                  else if(_loc3_ is TenantIceCream)
                  {
                     _loc1_.popularity -= 3;
                  }
                  else if(_loc3_ is TenantCake)
                  {
                     _loc1_.popularity -= 2;
                  }
               }
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_.restroomList.length)
         {
            _loc3_ = _loc1_.restroomList[_loc2_];
            if(_loc3_ != this && _loc3_.ground == ground)
            {
               _loc4_ = worldX - (_loc3_.worldX + _loc3_.width);
               _loc5_ = _loc3_.worldX - (this.worldX + this.width);
               if(_loc4_ >= 0 && _loc4_ <= 48 || _loc5_ >= 0 && _loc5_ <= 48)
               {
                  _loc1_.popularity -= 2;
               }
            }
            _loc2_++;
         }
      }
      
      public function FinishRepaired(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = root;
         if(doorImage.currentFrame >= 10 && doorImage.currentFrame - _loc2_.gameSpeed < 10)
         {
            param1.alpha = 1;
            param1.isRepairing = false;
            worker = null;
            param1.destination = null;
         }
      }
      
      public function getUpgradeCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 15 + tLevel * 5;
      }
      
      public function Animate(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = root;
         if(!isOpen && !pass)
         {
            doorImage.gotoAndStop(1);
            doorClosed.gotoAndStop(1);
         }
         else if(pass && doorImage.currentFrame > 10)
         {
            doorImage.gotoAndStop(10);
            doorClosed.gotoAndStop(10);
         }
         else if(doorImage.currentFrame + _loc2_.gameSpeed <= doorImage.totalFrames)
         {
            doorImage.gotoAndStop(doorImage.currentFrame + _loc2_.gameSpeed);
            doorClosed.gotoAndStop(doorClosed.currentFrame + _loc2_.gameSpeed);
         }
         else
         {
            doorImage.gotoAndStop(doorImage.totalFrames);
            doorClosed.gotoAndStop(doorClosed.totalFrames);
         }
         _loc3_ = 0;
         while(_loc3_ < lightList.length)
         {
            if(isClose)
            {
               lightList[_loc3_].gotoAndPlay(lightList[_loc3_].totalFrames);
            }
            else if(!lightList[_loc3_].isBroken)
            {
               lightList[_loc3_].gotoAndPlay(1);
            }
            _loc3_++;
         }
         closedSymbol.visible = isClose;
         doorClosed.visible = isClose;
         if(isClose)
         {
            pass = false;
            broken.gotoAndPlay(broken.totalFrames);
         }
         else if(isBroken)
         {
            if(justBroken)
            {
               _loc4_ = Math.ceil(Math.random() * lightList.length - 5) + 5;
               _loc3_ = 0;
               while(_loc3_ < lightList.length)
               {
                  if(lightList.length - _loc3_ > _loc4_)
                  {
                     if((_loc5_ = Math.random() * 100) < 50)
                     {
                        lightList[_loc3_].isBroken = true;
                        _loc4_--;
                     }
                  }
                  else
                  {
                     lightList[_loc3_].isBroken = true;
                     _loc4_--;
                  }
                  _loc3_++;
               }
               justBroken = false;
            }
         }
         else
         {
            if(!justBroken)
            {
               _loc3_ = 0;
               while(_loc3_ < lightList.length)
               {
                  lightList[_loc3_].isBroken = false;
                  _loc3_++;
               }
               justBroken = true;
            }
            broken.gotoAndPlay(1);
         }
         if(isOpen && doorImage.currentFrame >= doorImage.totalFrames)
         {
            isOpen = false;
            doorImage.gotoAndStop(1);
         }
         if(isOpen && doorClosed.currentFrame >= doorClosed.totalFrames)
         {
            isOpen = false;
            doorClosed.gotoAndStop(1);
         }
      }
      
      public function Visited(param1:MovieClip) : Boolean
      {
         var _loc2_:* = undefined;
         pass = !isClose;
         param1.dx = param1.dirrection;
         return param1.worldX > this.worldX + this.door.x + this.door.width / 2 - 5 && param1.worldX < this.worldX + this.door.x + this.door.width / 2 + 5;
      }
      
      public function stolen(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = root;
         if(doorImage.currentFrame >= 10 && doorImage.currentFrame - _loc2_.gameSpeed < 10)
         {
            param1.alpha = 0;
            param1.isStealing = true;
         }
      }
      
      public function testBuildRelation() : Number
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc1_ = root;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.tenantList.length)
         {
            if((_loc4_ = _loc1_.tenantList[_loc3_]) != this && _loc4_.ground == ground)
            {
               _loc5_ = worldX - (_loc4_.worldX + _loc4_.width);
               _loc6_ = _loc4_.worldX - (this.worldX + this.width);
               if(_loc5_ >= 0 && _loc5_ <= 48 || _loc6_ >= 0 && _loc6_ <= 48)
               {
                  if(_loc4_ is TenantBurger)
                  {
                     _loc2_ += 4;
                  }
                  else if(_loc4_ is TenantIceCream)
                  {
                     _loc2_ += 3;
                  }
                  else if(_loc4_ is TenantCake)
                  {
                     _loc2_ += 2;
                  }
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.restroomList.length)
         {
            if((_loc4_ = _loc1_.restroomList[_loc3_]) != this && _loc4_.ground == ground)
            {
               _loc5_ = worldX - (_loc4_.worldX + _loc4_.width);
               _loc6_ = _loc4_.worldX - (this.worldX + this.width);
               if(_loc5_ >= 0 && _loc5_ <= 48 || _loc6_ >= 0 && _loc6_ <= 48)
               {
                  _loc2_ += 2;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function ExitShop(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = root;
         if(doorImage.currentFrame >= 10 && doorImage.currentFrame - _loc2_.gameSpeed < 10)
         {
            param1.alpha = 1;
            param1.visiting = false;
            _loc3_ = visitorList.indexOf(param1);
            visitorList.splice(_loc3_,1);
            param1.removeEventListener(Event.ENTER_FRAME,MoodManipulation);
         }
      }
      
      public function EnterShop(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = root;
         if(doorImage.currentFrame >= 10 && doorImage.currentFrame - _loc2_.gameSpeed < 10)
         {
            param1.alpha = 0;
            param1.visiting = true;
            visitorList.push(param1);
            pass = false;
            ++visitorCome;
            if(visitorList.indexOf(param1) < getCapacity())
            {
               _loc3_ = PRICE[tLevel - 1];
               income += _loc3_;
               _loc2_.addCashUpdate(_loc3_,this.worldX + this.door.x + this.door.width / 2,this.worldY + this.door.y,true);
               param1.otherDelay = Math.round(Math.random() * 10) + 50;
               param1.addEventListener(Event.ENTER_FRAME,MoodManipulation);
            }
         }
      }
      
      public function finishStealing(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = root;
         if(doorImage.currentFrame >= 10 && doorImage.currentFrame - _loc2_.gameSpeed < 10)
         {
            param1.alpha = 1;
            param1.isStealing = false;
            param1.destination = null;
            param1.tryToEnter = false;
         }
      }
   }
}
