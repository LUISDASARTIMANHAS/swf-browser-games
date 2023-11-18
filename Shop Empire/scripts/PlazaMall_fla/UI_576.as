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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_576")]
   public dynamic class UI_576 extends MovieClip
   {
       
      
      public var hightlighted:MovieClip;
      
      public var Note:TextField;
      
      public var btnTemp:MovieClip;
      
      public var iconSymbol:MovieClip;
      
      public var Amount:TextField;
      
      public function UI_576()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Hightlighted(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         hightlighted.visible = true;
         _loc2_ = root;
         _loc2_.menuOver = true;
      }
      
      public function Unhightlighted(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         hightlighted.visible = false;
         _loc2_ = root;
         _loc2_.menuOver = false;
      }
      
      internal function frame1() : *
      {
         btnTemp.buttonMode = true;
         hightlighted.visible = false;
         addEventListener(MouseEvent.MOUSE_OVER,Hightlighted);
         addEventListener(MouseEvent.MOUSE_OUT,Unhightlighted);
      }
   }
}
