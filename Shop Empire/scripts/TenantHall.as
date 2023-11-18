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
   
   [Embed(source="/_assets/assets.swf", symbol="TenantHall")]
   public dynamic class TenantHall extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public var liveConcert:MovieClip;
      
      public const PRICE:Array = [1000,1200,1500];
      
      public var visitorList:Array;
      
      public const UPGRADE_COST:Array = [55000,67500];
      
      public const EVENT_PRICE:Array = [20000,17500,15000];
      
      public var i:*;
      
      public var tLevel:*;
      
      public const TENANT_NOTE:* = "Hold events to attract more visitors";
      
      public var ground:MovieClip;
      
      public var eventList:*;
      
      public var electronicExpo:MovieClip;
      
      public var artExhibition:MovieClip;
      
      public var isBroken:*;
      
      public var visitorCome:Number;
      
      public var body:MovieClip;
      
      public var isOpen:*;
      
      public const TENANT_TYPE:* = "Entertainment";
      
      public const MAX_LEVEL:* = 3;
      
      public var door:MovieClip;
      
      public var income:Number;
      
      public var outcome:Number;
      
      public var myParent:*;
      
      public var lastEvent:*;
      
      public var isClose:*;
      
      public function TenantHall()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Visited(param1:MovieClip) : Boolean
      {
         var _loc2_:* = undefined;
         param1.dx = param1.dirrection;
         return Math.random() * 10 < 0.5;
      }
      
      public function getCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 100;
      }
      
      public function ExitShop(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(param1.mood > 90)
         {
            _loc3_ = new SE_Popularity();
            _loc3_.play(0,0,myParent.seTransform);
            myParent.nextDayPopularity += 0.5;
            myParent.addFlyingText("Popularity\nIncreased",param1.worldX,param1.worldY - param1.height);
         }
         param1.visiting = false;
         param1.removeEventListener(Event.ENTER_FRAME,MoodManipulation);
         _loc2_ = visitorList.indexOf(param1);
         visitorList.splice(_loc2_,1);
      }
      
      internal function frame1() : *
      {
         isBroken = false;
         isClose = true;
         visitorList = new Array();
         myParent = root;
         eventList = new Array();
         eventList.push(artExhibition);
         eventList.push(electronicExpo);
         eventList.push(liveConcert);
         i = 0;
         while(i < eventList.length)
         {
            eventList[i].alpha = 0;
            eventList[i].visible = false;
            ++i;
         }
         addEventListener(Event.ENTER_FRAME,Animate);
         lastEvent = -1;
         stop();
      }
      
      public function MoodManipulation(param1:Event) : void
      {
         var head:* = undefined;
         var sp:* = undefined;
         var target:* = undefined;
         var rnd:* = undefined;
         var addEnjoy:* = undefined;
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
                  rnd = Math.random() * 5;
                  switch(rnd)
                  {
                     case 1:
                        dx = 1;
                        break;
                     case 2:
                        dx = -1;
                        break;
                     default:
                        dx = 0;
                  }
                  addEnjoy = Math.floor(Math.random() * 25) - 3;
                  enjoyingTime += addEnjoy;
                  if(addEnjoy > 16)
                  {
                     mood += 1.2 * ACCEL_MOOD;
                  }
                  else if(addEnjoy > 7)
                  {
                     mood += 0.3 * ACCEL_MOOD;
                  }
                  otherDelay = Math.round(Math.random() * 20) + 40;
               }
            }
            if(target.dx != 0)
            {
               if(target.worldX <= worldX + door.x)
               {
                  target.dx = 1;
               }
               else if(target.worldX >= worldX + door.x + door.width)
               {
                  target.dx = -1;
               }
            }
            target.worldX += target.dx;
            if(isClose)
            {
               ExitShop(target);
               break;
            }
            sp++;
         }
      }
      
      public function Animate(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(myParent.nowEvent >= 0 || myParent.bookedEvent >= 0)
         {
            if(lastEvent < 0)
            {
               _loc2_ = myParent.nowEvent;
               if(_loc2_ < 0)
               {
                  _loc2_ = myParent.bookedEvent;
               }
               _loc3_ = eventList[_loc2_];
               _loc3_.visible = true;
               if(_loc3_.alpha < 1)
               {
                  _loc3_.alpha += 0.1;
               }
               else
               {
                  lastEvent = _loc2_;
               }
            }
         }
         else if(lastEvent >= 0)
         {
            _loc3_ = eventList[lastEvent];
            if(_loc3_.alpha > 0)
            {
               _loc3_.alpha -= 0.1;
            }
            else
            {
               _loc3_.visible = false;
               lastEvent = -1;
            }
         }
         if(myParent.nowEvent >= 0)
         {
            if(myParent.dayTime >= 12 && myParent.dayTime < 22)
            {
               isClose = false;
            }
            else
            {
               isClose = true;
            }
         }
         else
         {
            isClose = true;
         }
      }
      
      public function EnterShop(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         param1.visiting = true;
         visitorList.push(param1);
         ++visitorCome;
         if(visitorList.indexOf(param1) < getCapacity())
         {
            _loc2_ = PRICE[tLevel - 1];
            income += _loc2_;
            myParent.addCashUpdate(_loc2_,param1.worldX,param1.worldY - param1.height,true);
            param1.otherDelay = Math.round(Math.random() * 10) + 50;
            param1.addEventListener(Event.ENTER_FRAME,MoodManipulation);
         }
      }
   }
}
