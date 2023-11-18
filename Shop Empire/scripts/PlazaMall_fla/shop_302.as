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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.shop_302")]
   public dynamic class shop_302 extends MovieClip
   {
       
      
      public var tParent:*;
      
      public var pillarLamp2:MovieClip;
      
      public var monitor:MovieClip;
      
      public var i:*;
      
      public var pillarLamp1:MovieClip;
      
      public var objectList:*;
      
      public function shop_302()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function CheckCondition(param1:Event) : void
      {
         var _loc2_:* = undefined;
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
         }
      }
      
      internal function frame1() : *
      {
         tParent = this.parent;
         objectList = new Array();
         objectList.push(pillarLamp1);
         objectList.push(pillarLamp2);
         objectList.push(monitor);
         i = 0;
         while(i < objectList.length)
         {
            objectList[i].visible = false;
            objectList[i].alpha = 0;
            ++i;
         }
         addEventListener(Event.ENTER_FRAME,CheckCondition);
      }
   }
}
