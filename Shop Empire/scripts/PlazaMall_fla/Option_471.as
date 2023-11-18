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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Option_471")]
   public dynamic class Option_471 extends MovieClip
   {
       
      
      public var btnBack:SimpleButton;
      
      public function Option_471()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         btnBack.addEventListener(MouseEvent.CLICK,BackToMainMenu);
      }
      
      public function BackToMainMenu(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = this.parent;
         _loc2_.gotoAndPlay("Exit Option");
      }
   }
}
