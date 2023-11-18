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
   
   [Embed(source="/_assets/assets.swf", symbol="SupportRestroom")]
   public dynamic class SupportRestroom extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public var enteranceWomen:MovieClip;
      
      public var femaleList:*;
      
      public var visitorList:*;
      
      public const UPGRADE_COST:Array = [1500,1800,2200];
      
      public var enteranceMen:MovieClip;
      
      public var doorMen:MovieClip;
      
      public var maleList:*;
      
      public var tLevel:*;
      
      public var womenOpen:*;
      
      public const TENANT_NOTE:* = "Visitors don\'t need to leave your mall while they need to go";
      
      public var myParent:*;
      
      public var ground:MovieClip;
      
      public var body:MovieClip;
      
      public const TENANT_TYPE:* = "Support Building";
      
      public const MAX_LEVEL:* = 4;
      
      public var menOpen:*;
      
      public var doorWomen:MovieClip;
      
      public function SupportRestroom()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function getCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 2 + tLevel * 3;
      }
      
      public function Visited(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(param1.gender)
         {
            _loc2_ = enteranceMen;
            _loc3_ = doorMen;
         }
         else
         {
            _loc2_ = enteranceWomen;
            _loc3_ = doorWomen;
         }
         _loc4_ = 0;
         while(_loc4_ < myParent.gameSpeed)
         {
            if(visitorList.indexOf(param1) < 0)
            {
               if(param1.hitTestObject(_loc2_))
               {
                  param1.dx = param1.dirrection;
                  if(param1.worldX > worldX + _loc2_.x + _loc2_.width / 2 - 5 && param1.worldX < worldX + _loc2_.x + _loc2_.width / 2 + 5)
                  {
                     param1.dx = 0;
                     if(param1.gender)
                     {
                        if(maleList.length <= getCapacity())
                        {
                           menOpen = true;
                        }
                     }
                     else if(femaleList.length <= getCapacity())
                     {
                        womenOpen = true;
                     }
                     if(_loc3_.currentFrame >= 10 && _loc3_.currentFrame - myParent.gameSpeed < 10)
                     {
                        if(param1.gender)
                        {
                           maleList.push(param1);
                        }
                        else
                        {
                           femaleList.push(param1);
                        }
                        visitorList.push(param1);
                        param1.alpha = 0;
                        param1.addEventListener(Event.ENTER_FRAME,PeeProgress);
                     }
                  }
               }
            }
            _loc4_++;
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
                     _loc2_ -= 2;
                  }
                  else if(_loc4_ is TenantCinema)
                  {
                     _loc2_ += 2;
                  }
                  else if(_loc4_ is TenantSalon)
                  {
                     _loc2_ -= 3;
                  }
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function PeeProgress(param1:Event) : void
      {
         var sp:* = undefined;
         var temp:* = undefined;
         var imageTemp:* = undefined;
         var index:* = undefined;
         var mi:* = undefined;
         var fi:* = undefined;
         var event:Event = param1;
         sp = 0;
         for(; sp < myParent.gameSpeed; sp++)
         {
            temp = event.currentTarget;
            --temp.toiletFill;
            if(temp.toiletFill > 0)
            {
               try
               {
                  myParent.tenantParent.getChildIndex(this);
               }
               catch(e:Error)
               {
                  temp.alpha = 1;
                  temp.toiletTarget = null;
                  temp.removeEventListener(Event.ENTER_FRAME,PeeProgress);
               }
               continue;
            }
            temp.toiletFill = 0;
            if(temp.gender)
            {
               imageTemp = doorMen;
               menOpen = true;
            }
            else
            {
               imageTemp = doorWomen;
               womenOpen = true;
            }
            if(imageTemp.currentFrame >= 10 && imageTemp.currentFrame - myParent.gameSpeed < 10)
            {
               temp.alpha = 1;
               temp.toiletTarget = null;
               index = visitorList.indexOf(temp);
               visitorList.splice(index,1);
               if(temp.gender)
               {
                  mi = maleList.indexOf(temp);
                  maleList.splice(mi,1);
               }
               else
               {
                  fi = femaleList.indexOf(temp);
                  femaleList.splice(fi,1);
               }
               temp.removeEventListener(Event.ENTER_FRAME,PeeProgress);
            }
         }
      }
      
      internal function frame1() : *
      {
         menOpen = false;
         womenOpen = false;
         myParent = root;
         addEventListener(Event.ENTER_FRAME,Animate);
         visitorList = new Array();
         maleList = new Array();
         femaleList = new Array();
      }
      
      public function Animate(param1:Event) : void
      {
         if(!menOpen)
         {
            doorMen.gotoAndStop(1);
         }
         else
         {
            doorMen.gotoAndStop(doorMen.currentFrame + myParent.gameSpeed);
         }
         if(!womenOpen)
         {
            doorWomen.gotoAndStop(1);
         }
         else
         {
            doorWomen.gotoAndStop(doorWomen.currentFrame + myParent.gameSpeed);
         }
         if(doorMen.currentFrame >= doorMen.totalFrames)
         {
            menOpen = false;
            doorMen.gotoAndStop(1);
         }
         if(doorWomen.currentFrame >= doorWomen.totalFrames)
         {
            womenOpen = false;
            doorWomen.gotoAndStop(1);
         }
      }
      
      public function getUpgradeCapacity() : Number
      {
         var _loc1_:* = undefined;
         return 2 + (tLevel + 1) * 3;
      }
   }
}
