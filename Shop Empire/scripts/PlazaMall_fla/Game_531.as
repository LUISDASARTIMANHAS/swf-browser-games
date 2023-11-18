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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_531")]
   public dynamic class Game_531 extends MovieClip
   {
       
      
      public var lvSymbol:*;
      
      public var lv2:MovieClip;
      
      public var lv3:MovieClip;
      
      public var lv1:MovieClip;
      
      public function Game_531()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function updateLevel(param1:Number) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < lvSymbol.length)
         {
            if(_loc2_ < param1)
            {
               lvSymbol[_loc2_].gotoAndStop(2);
            }
            else
            {
               lvSymbol[_loc2_].gotoAndStop(1);
            }
            _loc2_++;
         }
      }
      
      internal function frame1() : *
      {
         lvSymbol = new Array();
         lvSymbol.push(lv1);
         lvSymbol.push(lv2);
         lvSymbol.push(lv3);
      }
   }
}
