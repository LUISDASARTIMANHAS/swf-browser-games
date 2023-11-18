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
   
   [Embed(source="/_assets/assets.swf", symbol="TenantSupermarket")]
   public dynamic class TenantSupermarket extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public var exitPoint:*;
      
      public const PRICE:Array = [150,200,250];
      
      public var closedSymbol:MovieClip;
      
      public var visitorList:Array;
      
      public var enterance:MovieClip;
      
      public const UPGRADE_COST:Array = [25000,30000];
      
      public var exitPoint1:MovieClip;
      
      public var exitPoint4:MovieClip;
      
      public var exitPoint3:MovieClip;
      
      public const TENANT_NOTE:* = "Sell fruits, vegetables, snack and many kind of house supplies and needs";
      
      public var tLevel:*;
      
      public var ground:MovieClip;
      
      public var exitPoint2:MovieClip;
      
      public var isBroken:*;
      
      public var visitorCome:Number;
      
      public var body:MovieClip;
      
      public var isOpen:*;
      
      public const TENANT_TYPE:* = "Shop Center";
      
      public const MAX_LEVEL:* = 3;
      
      public var door:MovieClip;
      
      public var worker:*;
      
      public var income:Number;
      
      public var outcome:Number;
      
      public var brokenLevel:*;
      
      public var broken:MovieClip;
      
      public var isClose:*;
      
      public function TenantSupermarket()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Visited(param1:MovieClip) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = root;
         if(_loc2_.banditList.indexOf(param1) < 0)
         {
            param1.dx = param1.dirrection;
            _loc3_ = param1.worldX > this.worldX + this.door.x + this.door.width / 2 - 10 && param1.worldX < this.worldX + this.door.x + this.door.width / 2 + 10;
         }
         else
         {
            _loc3_ = param1.worldX > this.worldX + this.enterance.x + this.enterance.width / 2 - 10 && param1.worldX < this.worldX + this.enterance.x + this.enterance.width / 2 + 10;
         }
         return _loc3_;
      }
      
      public function stolen(param1:MovieClip) : void
      {
         if(closedSymbol.currentFrame >= 5 && closedSymbol.currentFrame < 15)
         {
            param1.alpha = 0;
            param1.isStealing = true;
            isOpen = false;
            closedSymbol.gotoAndPlay(15);
         }
      }
      
      public function getCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 15 + tLevel * 5;
      }
      
      public function RepairShop(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = root;
         if(door.currentFrame >= 10 && door.currentFrame - _loc2_.gameSpeed < 10)
         {
            param1.alpha = 0;
            param1.isRepairing = true;
            worker = param1;
            _loc3_ = Math.floor(Math.random() * exitPoint.length);
            _loc4_ = door.x - exitPoint[_loc3_].x;
            param1.worldX -= _loc4_;
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
                  if(_loc4_ is TenantCake || _loc4_ is TenantIceCream || _loc4_ is TenantBurger || _loc4_ is TenantSteak || _loc4_ is TenantSushi || _loc4_ is TenantCafe)
                  {
                     _loc2_ += 2;
                  }
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
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc2_ = Math.round(param1.mood / 5);
         _loc3_ = _loc2_;
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         if(param1.specialVisitor)
         {
            _loc3_ += Math.floor(Math.random() * _loc2_);
         }
         _loc4_ = _loc3_ * PRICE[tLevel - 1];
         income += _loc4_;
         (_loc5_ = root).addCashUpdate(_loc4_,param1.worldX,param1.worldY - param1.height,true);
         param1.alpha = 1;
         param1.visiting = false;
         _loc6_ = visitorList.indexOf(param1);
         visitorList.splice(_loc6_,1);
      }
      
      internal function frame1() : *
      {
         exitPoint = new Array();
         exitPoint.push(exitPoint1);
         exitPoint.push(exitPoint2);
         exitPoint.push(exitPoint3);
         exitPoint.push(exitPoint4);
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
                  if(_loc3_ is TenantCake || _loc3_ is TenantIceCream || _loc3_ is TenantBurger || _loc3_ is TenantSteak || _loc3_ is TenantSushi || _loc3_ is TenantCafe)
                  {
                     _loc1_.popularity -= 2;
                  }
               }
            }
            _loc2_++;
         }
      }
      
      public function Animate(param1:Event) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = root;
         if(!isOpen || isClose && worker == null)
         {
            door.gotoAndStop(1);
         }
         else if(door.currentFrame + _loc2_.gameSpeed <= door.totalFrames)
         {
            door.gotoAndStop(door.currentFrame + _loc2_.gameSpeed);
         }
         else
         {
            door.gotoAndStop(door.totalFrames);
         }
         if(isClose)
         {
            if(!isOpen)
            {
               if(closedSymbol.currentLabel == "totalOpen" && worker == null)
               {
                  closedSymbol.gotoAndPlay("closed");
               }
            }
            else if(closedSymbol.currentLabel == "totalClosed")
            {
               closedSymbol.gotoAndPlay("open");
            }
            broken.gotoAndPlay(broken.totalFrames);
         }
         else
         {
            if(closedSymbol.currentLabel == "totalClosed")
            {
               closedSymbol.gotoAndPlay("open");
            }
            if(!isBroken)
            {
               broken.gotoAndPlay(1);
            }
         }
         if(isOpen && door.currentFrame >= door.totalFrames)
         {
            isOpen = false;
            door.gotoAndStop(1);
         }
      }
      
      public function FinishRepaired(param1:MovieClip) : void
      {
         param1.alpha = 1;
         param1.isRepairing = false;
         worker = null;
         param1.destination = null;
         isOpen = false;
      }
      
      public function EnterShop(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = root;
         if(door.currentFrame >= 10 && door.currentFrame - _loc2_.gameSpeed < 10)
         {
            param1.alpha = 0;
            param1.visiting = true;
            visitorList.push(param1);
            _loc3_ = Math.floor(Math.random() * exitPoint.length);
            _loc4_ = door.x - exitPoint[_loc3_].x;
            param1.worldX -= _loc4_;
            ++visitorCome;
         }
      }
      
      public function finishStealing(param1:MovieClip) : void
      {
         if(closedSymbol.currentFrame >= 5 && closedSymbol.currentFrame < 15)
         {
            param1.alpha = 1;
            isOpen = false;
            param1.isStealing = false;
            param1.destination = null;
            param1.tryToEnter = false;
            closedSymbol.gotoAndPlay(15);
         }
      }
      
      public function getUpgradeCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 15 + tLevel * 5;
      }
   }
}
