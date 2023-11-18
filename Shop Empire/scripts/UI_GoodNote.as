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
   
   [Embed(source="/_assets/assets.swf", symbol="UI_GoodNote")]
   public dynamic class UI_GoodNote extends MovieClip
   {
       
      
      public var worldX:*;
      
      public var worldY:*;
      
      public var clip:MovieClip;
      
      public var largerClip:MovieClip;
      
      public var head:*;
      
      public function UI_GoodNote()
      {
         super();
         addFrameScript(0,frame1,30,frame31);
      }
      
      public function UpdatePosition(param1:Event) : void
      {
         this.x = worldX - head.cameraX;
         this.y = worldY - head.cameraY;
         this.visible = head.drawArea.hitTestObject(this);
      }
      
      internal function frame1() : *
      {
         head = root;
         largerClip.cashList.text = clip.cashList.text;
         addEventListener(Event.ENTER_FRAME,UpdatePosition);
      }
      
      internal function frame31() : *
      {
         stop();
         removeEventListener(Event.ENTER_FRAME,UpdatePosition);
         this.parent.removeChild(this);
      }
   }
}
