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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_607")]
   public dynamic class UI_607 extends MovieClip
   {
       
      
      public var btnHighQuality:SimpleButton;
      
      public var highlightedLow:MovieClip;
      
      public var btnLowQuality:SimpleButton;
      
      public var highlightedHigh:MovieClip;
      
      public var highlightedMedium:MovieClip;
      
      public var btnMediumQuality:SimpleButton;
      
      public function UI_607()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         highlightedHigh.visible = stage.quality.toUpperCase() == StageQuality.HIGH.toUpperCase();
         highlightedMedium.visible = stage.quality.toUpperCase() == StageQuality.MEDIUM.toUpperCase();
         highlightedLow.visible = stage.quality.toUpperCase() == StageQuality.LOW.toUpperCase();
         btnHighQuality.addEventListener(MouseEvent.CLICK,UpdateQuality);
         btnMediumQuality.addEventListener(MouseEvent.CLICK,UpdateQuality);
         btnLowQuality.addEventListener(MouseEvent.CLICK,UpdateQuality);
      }
      
      public function UpdateQuality(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.currentTarget;
         highlightedHigh.visible = _loc2_.name == "btnHighQuality";
         highlightedMedium.visible = _loc2_.name == "btnMediumQuality";
         highlightedLow.visible = _loc2_.name == "btnLowQuality";
         if(highlightedHigh.visible)
         {
            stage.quality = StageQuality.HIGH;
         }
         else if(highlightedMedium.visible)
         {
            stage.quality = StageQuality.MEDIUM;
         }
         else if(highlightedLow.visible)
         {
            stage.quality = StageQuality.LOW;
         }
      }
   }
}
