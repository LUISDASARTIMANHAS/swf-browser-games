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
   
   [Embed(source="/_assets/assets.swf", symbol="TenantGameCenter")]
   public dynamic class TenantGameCenter extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public const PRICE:Array = [200,220,240];
      
      public var visitorList:Array;
      
      public const UPGRADE_COST:Array = [29000,33000];
      
      public var tLevel:*;
      
      public const TENANT_NOTE:* = "Good entertainment place. Favored by many young people";
      
      public var ground:MovieClip;
      
      public var isBroken:*;
      
      public var visitorCome:Number;
      
      public var outcome:Number;
      
      public var body:MovieClip;
      
      public var isOpen:*;
      
      public const TENANT_TYPE:* = "Entertainment";
      
      public const MAX_LEVEL:* = 3;
      
      public var door:MovieClip;
      
      public var worker:*;
      
      public var brokenLevel:*;
      
      public var income:Number;
      
      public var broken:MovieClip;
      
      public var isClose:*;
      
      public function TenantGameCenter()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Visited(param1:MovieClip) : Boolean
      {
         var _loc2_:* = undefined;
         param1.dx = param1.dirrection;
         return param1.worldX > this.worldX + this.door.x + this.door.width / 2 - 5 && param1.worldX < this.worldX + this.door.x + this.door.width / 2 + 5;
      }
      
      public function stolen(param1:MovieClip) : void
      {
         param1.alpha = 0;
         param1.isStealing = true;
      }
      
      public function getCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 15 + tLevel * 5;
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
                  if(_loc4_ is TenantToyStore)
                  {
                     _loc2_ += 2;
                  }
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function MoodManipulation(param1:Event) : void
      {
         var head:* = undefined;
         var sp:* = undefined;
         var target:* = undefined;
         var moodIncrease:* = undefined;
         var enjoyIncrease:* = undefined;
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
                  enjoyIncrease = moodIncrease * 10 - 10;
                  if(enjoyIncrease < 0)
                  {
                     enjoyIncrease = 0;
                  }
                  else
                  {
                     recive = PRICE[tLevel - 1];
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
         visitorList = new Array();
         addEventListener(Event.ENTER_FRAME,Animate);
         stop();
      }
      
      public function ExitShop(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         param1.alpha = 1;
         param1.visiting = false;
         _loc2_ = visitorList.indexOf(param1);
         visitorList.splice(_loc2_,1);
         param1.removeEventListener(Event.ENTER_FRAME,MoodManipulation);
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
                  if(_loc3_ is TenantToyStore)
                  {
                     _loc1_.popularity -= 2;
                  }
               }
            }
            _loc2_++;
         }
      }
      
      public function getUpgradeCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 15 + tLevel * 5;
      }
      
      public function Animate(param1:Event) : void
      {
         if(isClose)
         {
            broken.visible = true;
            broken.gotoAndPlay(1);
         }
         else
         {
            broken.visible = isBroken;
         }
      }
      
      public function FinishRepaired(param1:MovieClip) : void
      {
         param1.alpha = 1;
         param1.isRepairing = false;
         worker = null;
         param1.destination = null;
      }
      
      public function EnterShop(param1:MovieClip) : void
      {
         param1.alpha = 0;
         param1.visiting = true;
         visitorList.push(param1);
         ++visitorCome;
         if(visitorList.indexOf(param1) < getCapacity())
         {
            param1.otherDelay = Math.round(Math.random() * 10) + 50;
            param1.addEventListener(Event.ENTER_FRAME,MoodManipulation);
         }
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
