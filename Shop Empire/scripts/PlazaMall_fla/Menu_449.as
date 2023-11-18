package PlazaMall_fla
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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Menu_449")]
   public dynamic class Menu_449 extends MovieClip
   {
       
      
      public var peopleParent:*;
      
      public var stair:MovieClip;
      
      public var road:MovieClip;
      
      public var i:*;
      
      public var a:*;
      
      public var cloudList:*;
      
      public var cloud2:MovieClip;
      
      public var cloud4:MovieClip;
      
      public var cloud5:MovieClip;
      
      public var cloud1:MovieClip;
      
      public var temp:*;
      
      public var cloud3:MovieClip;
      
      public var gamesfreeLogo:SimpleButton;
      
      public function Menu_449()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function cloudMoving(param1:Event) : void
      {
         var i:* = undefined;
         var event:Event = param1;
         i = 0;
         while(i < cloudList.length)
         {
            with(cloudList[i])
            {
               
               x -= speed;
               if(x < -width)
               {
                  gotoAndPlay(Math.ceil(Math.random() * 5));
                  x = stage.stageWidth + width;
                  y = Math.random() * stage.stageHeight / 3;
                  speed = Math.random() * 2;
               }
            }
            i++;
         }
      }
      
      internal function frame1() : *
      {
         peopleParent = new MovieClip();
         addChild(peopleParent);
         a = 0;
         while(a < 10)
         {
            temp = new MenuAccPeople();
            temp.x = Math.random() * road.width;
            temp.y = road.y;
            temp.dx = Math.floor(Math.random() * 2) * 2 - 1;
            temp.enterMall = false;
            temp.exitMall = false;
            peopleParent.addChild(temp);
            ++a;
         }
         addEventListener(Event.ENTER_FRAME,peopleAnimation);
         addEventListener(Event.ENTER_FRAME,createPeople);
         addEventListener(Event.ENTER_FRAME,MallEntering);
         this.gamesfreeLogo.addEventListener(MouseEvent.CLICK,gamesfreeURL);
         cloudList = new Array();
         cloudList.unshift(cloud1);
         cloudList.unshift(cloud2);
         cloudList.unshift(cloud3);
         cloudList.unshift(cloud4);
         cloudList.unshift(cloud5);
         i = 0;
         while(i < cloudList.length)
         {
            cloudList[i].x = Math.random() * stage.stageWidth;
            cloudList[i].y = Math.random() * (stage.stageHeight / 3);
            cloudList[i].gotoAndPlay(Math.ceil(Math.random() * 5));
            cloudList[i].speed = Math.random() * 2;
            ++i;
         }
         addEventListener(Event.ENTER_FRAME,cloudMoving);
      }
      
      public function MallEntering(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < peopleParent.numChildren)
         {
            _loc3_ = peopleParent.getChildAt(_loc2_);
            if(!_loc3_.enterMall)
            {
               if(_loc3_.hitTestObject(stair))
               {
                  if((_loc4_ = Math.random() * 100) > 90)
                  {
                     _loc3_.enterMall = true;
                  }
               }
            }
            _loc2_++;
         }
      }
      
      public function gamesfreeURL(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest("http://www.gamesfree.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function peopleAnimation(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < peopleParent.numChildren)
         {
            _loc3_ = peopleParent.getChildAt(_loc2_);
            if(!_loc3_.exitMall)
            {
               if(!_loc3_.enterMall)
               {
                  _loc3_.x += _loc3_.dx;
                  if(_loc3_.x < 0 || _loc3_.x > stage.stageWidth)
                  {
                     peopleParent.removeChild(_loc3_);
                     _loc2_--;
                  }
               }
               else
               {
                  --_loc3_.y;
                  if(!_loc3_.hitTestObject(stair))
                  {
                     peopleParent.removeChild(_loc3_);
                     _loc2_--;
                  }
               }
            }
            else if(_loc3_.hitTestObject(road))
            {
               _loc3_.x += _loc3_.dx;
               if(_loc3_.x < 0 || _loc3_.x > stage.stageWidth)
               {
                  peopleParent.removeChild(_loc3_);
                  _loc2_--;
               }
            }
            else
            {
               ++_loc3_.y;
            }
            _loc2_++;
         }
      }
      
      public function createPeople(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(peopleParent.numChildren < 50)
         {
            _loc2_ = Math.random() * 100;
            if(_loc2_ > 90)
            {
               _loc3_ = new MenuAccPeople();
               _loc3_.exitMall = Math.random() * 10 > 5;
               if(_loc3_.exitMall)
               {
                  _loc3_.x = Math.random() * stair.width + stair.x;
                  _loc3_.y = stair.y;
                  _loc3_.dx = Math.floor(Math.random() * 2) * 2 - 1;
                  _loc3_.enterMall = false;
               }
               else
               {
                  _loc3_.x = Math.floor(Math.random() * 2) * stage.stageWidth;
                  _loc3_.y = road.y;
                  if(_loc3_.x >= stage.stageWidth)
                  {
                     _loc3_.dx = -1;
                  }
                  else
                  {
                     _loc3_.dx = 1;
                  }
               }
               peopleParent.addChild(_loc3_);
            }
         }
      }
   }
}
