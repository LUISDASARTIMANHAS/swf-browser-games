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
   
   [Embed(source="/_assets/assets.swf", symbol="TenantSalon")]
   public dynamic class TenantSalon extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public const PRICE:Array = [80,120,160];
      
      public var visitorList:Array;
      
      public var enterance:MovieClip;
      
      public const UPGRADE_COST:Array = [7500,9000];
      
      public var tLevel:*;
      
      public const TENANT_NOTE:* = "Place for people where his or her want to change hair style. Favored by girls";
      
      public var ground:MovieClip;
      
      public var closedDoor:MovieClip;
      
      public var isBroken:*;
      
      public var visitorCome:Number;
      
      public var outcome:Number;
      
      public var body:MovieClip;
      
      public var isOpen:*;
      
      public const TENANT_TYPE:* = "Shop Center";
      
      public const MAX_LEVEL:* = 3;
      
      public var door:MovieClip;
      
      public var worker:*;
      
      public var brokenLevel:*;
      
      public var income:Number;
      
      public var broken:MovieClip;
      
      public var waiter:MovieClip;
      
      public var isClose:*;
      
      public function TenantSalon()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Visited(param1:MovieClip) : Boolean
      {
         var _loc2_:* = undefined;
         if(!isClose)
         {
            _loc2_ = param1.worldX > this.worldX + this.enterance.x + this.enterance.width / 2 - 10 && param1.worldX < this.worldX + this.enterance.x + this.enterance.width / 2 + 20;
         }
         else
         {
            _loc2_ = param1.worldX > this.worldX + this.door.x + 20 && param1.worldX < this.worldX + this.door.x + this.door.width - 20;
         }
         return _loc2_;
      }
      
      public function stolen(param1:MovieClip) : void
      {
         if(closedDoor.currentFrame >= 5 && closedDoor.currentFrame < 15)
         {
            param1.alpha = 0;
            param1.isStealing = true;
            closedDoor.gotoAndPlay(15);
            isOpen = false;
         }
      }
      
      public function getCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 5 + tLevel * 5;
      }
      
      public function RepairShop(param1:MovieClip) : void
      {
         param1.alpha = 0;
         param1.isRepairing = true;
         worker = param1;
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
                     _loc2_ -= 2;
                  }
                  else if(_loc4_ is TenantJewelry)
                  {
                     _loc2_ += 1;
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
                  _loc2_ -= 3;
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
         _loc2_ = Math.round(param1.mood / 10);
         _loc3_ = _loc2_ - 4;
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
         (_loc5_ = root).addCashUpdate(_loc4_,this.worldX + this.door.x + this.door.width / 2,this.worldY + this.door.y,true);
         param1.alpha = 1;
         param1.visiting = false;
         _loc6_ = visitorList.indexOf(param1);
         visitorList.splice(_loc6_,1);
         isOpen = false;
      }
      
      internal function frame1() : *
      {
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
                     _loc1_.popularity += 2;
                  }
                  else if(_loc3_ is TenantJewelry)
                  {
                     --_loc1_.popularity;
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
                  _loc1_.popularity += 3;
               }
            }
            _loc2_++;
         }
      }
      
      public function getUpgradeCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 5 + (tLevel + 1) * 5;
      }
      
      public function Animate(param1:Event) : void
      {
         waiter.visible = !isClose;
         if(isClose)
         {
            if(!isOpen)
            {
               if(closedDoor.currentLabel == "totalOpen" && worker == null)
               {
                  closedDoor.gotoAndPlay("closed");
               }
            }
            else if(closedDoor.currentLabel == "totalClosed")
            {
               closedDoor.gotoAndPlay("open");
            }
            broken.gotoAndPlay(broken.totalFrames);
         }
         else
         {
            if(closedDoor.currentLabel == "totalClosed")
            {
               closedDoor.gotoAndPlay("open");
            }
            if(!isBroken)
            {
               broken.gotoAndPlay(1);
            }
         }
      }
      
      public function FinishRepaired(param1:MovieClip) : void
      {
         param1.alpha = 1;
         param1.isRepairing = false;
         worker = null;
         isOpen = false;
         param1.destination = null;
      }
      
      public function EnterShop(param1:MovieClip) : void
      {
         param1.alpha = 0;
         param1.visiting = true;
         visitorList.push(param1);
         ++visitorCome;
      }
      
      public function finishStealing(param1:MovieClip) : void
      {
         if(closedDoor.currentFrame >= 5 && closedDoor.currentFrame < 15)
         {
            param1.alpha = 1;
            param1.isStealing = false;
            param1.destination = null;
            param1.tryToEnter = false;
            gotoAndPlay(15);
            isOpen = false;
         }
      }
   }
}
