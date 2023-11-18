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
   
   [Embed(source="/_assets/assets.swf", symbol="UI_CashUpdateRecive")]
   public dynamic class UI_CashUpdateRecive extends MovieClip
   {
       
      
      public var worldX:*;
      
      public var worldY:*;
      
      public var clip:MovieClip;
      
      public var staticPosition:*;
      
      public var head:*;
      
      public function UI_CashUpdateRecive()
      {
         super();
         addFrameScript(0,frame1,30,frame31);
      }
      
      public function UpdatePosition(param1:Event) : void
      {
         if(staticPosition)
         {
            this.x = worldX;
            this.y = worldY;
         }
         else
         {
            this.x = worldX - head.cameraX;
            this.y = worldY - head.cameraY;
         }
         this.visible = head.drawArea.hitTestObject(this);
      }
      
      internal function frame1() : *
      {
         head = root;
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
