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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.shop_305")]
   public dynamic class shop_305 extends MovieClip
   {
       
      
      public var vocalist:MovieClip;
      
      public var speaker1:MovieClip;
      
      public var speaker6:MovieClip;
      
      public var speaker2:MovieClip;
      
      public var speaker3:MovieClip;
      
      public var speaker4:MovieClip;
      
      public var light:MovieClip;
      
      public var speaker7:MovieClip;
      
      public var speaker5:MovieClip;
      
      public var tParent:*;
      
      public var flipDelay:*;
      
      public var bassist:MovieClip;
      
      public var i:*;
      
      public var drummer:MovieClip;
      
      public var objectList:*;
      
      public var guitarist:MovieClip;
      
      public function shop_305()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function CheckCondition(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(tParent.isClose)
         {
            _loc2_ = 0;
            while(_loc2_ < objectList.length)
            {
               if(objectList[_loc2_].alpha > 0)
               {
                  objectList[_loc2_].alpha -= 0.1;
               }
               else
               {
                  objectList[_loc2_].visible = false;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < objectList.length)
            {
               objectList[_loc2_].visible = true;
               if(objectList[_loc2_].alpha < 1)
               {
                  objectList[_loc2_].alpha += 0.1;
               }
               _loc2_++;
            }
            if(flipDelay > 0)
            {
               --flipDelay;
            }
            else
            {
               _loc3_ = Math.random() * 100;
               if(_loc3_ < 30)
               {
                  vocalist.scaleX = -vocalist.scaleX;
               }
               flipDelay = 50;
            }
         }
      }
      
      internal function frame1() : *
      {
         tParent = this.parent;
         objectList = new Array();
         objectList.push(light);
         objectList.push(speaker1);
         objectList.push(speaker2);
         objectList.push(speaker3);
         objectList.push(speaker4);
         objectList.push(speaker5);
         objectList.push(speaker6);
         objectList.push(speaker7);
         objectList.push(guitarist);
         objectList.push(drummer);
         objectList.push(bassist);
         objectList.push(vocalist);
         i = 0;
         while(i < objectList.length)
         {
            objectList[i].visible = false;
            objectList[i].alpha = 0;
            ++i;
         }
         flipDelay = 0;
         addEventListener(Event.ENTER_FRAME,CheckCondition);
      }
   }
}
