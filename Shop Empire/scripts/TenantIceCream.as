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
   
   [Embed(source="/_assets/assets.swf", symbol="TenantIceCream")]
   public dynamic class TenantIceCream extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public const PRICE:Array = [30,50,70];
      
      public var visitorList:Array;
      
      public const UPGRADE_COST:Array = [3000,4000];
      
      public var defaultServeTime:*;
      
      public var tLevel:*;
      
      public const TENANT_NOTE:* = "Sell ice cream. Favored when hot wheater";
      
      public var serveTime:*;
      
      public var ground:MovieClip;
      
      public var isBroken:*;
      
      public var visitorCome:Number;
      
      public var outcome:Number;
      
      public var body:MovieClip;
      
      public var isOpen:*;
      
      public const TENANT_TYPE:* = "Food Center";
      
      public const MAX_LEVEL:* = 3;
      
      public var door:MovieClip;
      
      public var worker:*;
      
      public var brokenLevel:*;
      
      public var income:Number;
      
      public var broken:MovieClip;
      
      public var waiter:MovieClip;
      
      public var isClose:*;
      
      public function TenantIceCream()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Visited(param1:MovieClip) : Boolean
      {
         return true;
      }
      
      public function stolen(param1:MovieClip) : void
      {
         param1.alpha = 0;
         param1.isStealing = true;
      }
      
      public function getCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 2 + tLevel * 3;
      }
      
      public function RepairShop(param1:MovieClip) : void
      {
         param1.isRepairing = true;
         worker = param1;
         param1.worldX = this.worldX + this.width / 2;
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
                  if(_loc4_ is TenantCafe)
                  {
                     _loc2_ += 2;
                  }
                  else if(_loc4_ is TenantBurger || _loc4_ is TenantCinema)
                  {
                     _loc2_ += 3;
                  }
                  else if(_loc4_ is TenantBabyShop || _loc4_ is TenantSalon || _loc4_ is TenantBoutiqueA || _loc4_ is TenantBoutiqueB)
                  {
                     _loc2_ -= 2;
                  }
                  else if(_loc4_ is TenantDrugStore)
                  {
                     _loc2_ -= 3;
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
                  _loc2_ -= 2;
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
         param1.visiting = false;
         if(param1.enjoyingTime > 0)
         {
            _loc3_ = Math.round(param1.mood / 10);
            if((_loc4_ = _loc3_ - 3) < 1)
            {
               _loc4_ = 1;
            }
            if(param1.specialVisitor)
            {
               _loc4_ += Math.floor(Math.random() * _loc3_);
            }
            _loc5_ = _loc4_ * PRICE[tLevel - 1];
            income += _loc5_;
            (_loc6_ = root).addCashUpdate(_loc5_,this.worldX + this.width / 2,this.worldY + this.height / 2,true);
            param1.mood += 3;
         }
         else
         {
            param1.mood -= 5;
         }
         _loc2_ = visitorList.indexOf(param1);
         visitorList.splice(_loc2_,1);
      }
      
      internal function frame1() : *
      {
         defaultServeTime = 120;
         visitorList = new Array();
         addEventListener(Event.ENTER_FRAME,Animate);
         stop();
      }
      
      public function VisitorQueue(param1:Event) : void
      {
         var head:* = undefined;
         var sp:* = undefined;
         var firstLine:* = undefined;
         var i:* = undefined;
         var temp:* = undefined;
         var tempPos:* = undefined;
         var event:Event = param1;
         head = root;
         sp = 0;
         while(sp < head.gameSpeed)
         {
            if(visitorList.length <= 0)
            {
               removeEventListener(Event.ENTER_FRAME,VisitorQueue);
               break;
            }
            firstLine = this.worldX + this.waiter.x + 20;
            visitorList[0].enjoyingTime = 100;
            if(visitorList[0].worldX <= firstLine)
            {
               --serveTime;
               if(serveTime <= 0)
               {
                  serveTime = defaultServeTime;
                  temp = visitorList[0];
                  ExitShop(temp);
                  if(visitorList.length > 0)
                  {
                     visitorList[0].enjoyingTime = 100;
                  }
               }
            }
            i = 0;
            while(i < visitorList.length)
            {
               tempPos = this.worldX + this.waiter.x + 20 + 30 * i;
               visitorList[i].dirrection = -1;
               if(visitorList[i].worldX > tempPos)
               {
                  if(visitorList[i].currentFrame != 3)
                  {
                     visitorList[i].gotoAndPlay(3);
                  }
                  visitorList[i].dx = visitorList[i].dirrection;
                  visitorList[i].worldX += visitorList[i].dx;
               }
               else
               {
                  with(visitorList[i])
                  {
                     
                     visitorList[i].dx = 0;
                     scaleX = -1;
                     if(visitorList[i].currentFrame != 2)
                     {
                        gotoAndPlay(2);
                     }
                     worldX = tempPos;
                     if(worldX > floorPos.worldX + floorPos.width)
                     {
                        worldX = floorPos.worldX + floorPos.width - 10;
                     }
                  }
               }
               i++;
            }
            sp++;
         }
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
                  if(_loc3_ is TenantCafe)
                  {
                     _loc1_.popularity -= 2;
                  }
                  else if(_loc3_ is TenantBurger || _loc3_ is TenantCinema)
                  {
                     _loc1_.popularity -= 3;
                  }
                  else if(_loc3_ is TenantBabyShop || _loc3_ is TenantSalon || _loc3_ is TenantBoutiqueA || _loc3_ is TenantBoutiqueB)
                  {
                     _loc1_.popularity += 2;
                  }
                  else if(_loc3_ is TenantDrugStore)
                  {
                     _loc1_.popularity += 3;
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
                  _loc1_.popularity += 2;
               }
            }
            _loc2_++;
         }
      }
      
      public function getUpgradeCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 2 + (tLevel + 1) * 3;
      }
      
      public function Animate(param1:Event) : void
      {
         waiter.visible = !isClose;
         if(isClose)
         {
            broken.gotoAndPlay(broken.totalFrames);
         }
         else if(!isBroken)
         {
            broken.gotoAndPlay(1);
         }
      }
      
      public function FinishRepaired(param1:MovieClip) : void
      {
         param1.isRepairing = false;
         worker = null;
         param1.destination = null;
      }
      
      public function EnterShop(param1:MovieClip) : void
      {
         param1.visiting = true;
         if(visitorList.length <= 0)
         {
            serveTime = defaultServeTime / tLevel;
            addEventListener(Event.ENTER_FRAME,VisitorQueue);
         }
         visitorList.push(param1);
         ++visitorCome;
      }
      
      public function finishStealing(param1:MovieClip) : void
      {
         param1.alpha = 1;
         param1.isStealing = false;
         param1.destination = null;
         param1.tryToEnter = false;
      }
   }
}
