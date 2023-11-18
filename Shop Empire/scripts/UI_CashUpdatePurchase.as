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
   
   [Embed(source="/_assets/assets.swf", symbol="UI_CashUpdatePurchase")]
   public dynamic class UI_CashUpdatePurchase extends MovieClip
   {
       
      
      public var worldX:*;
      
      public var worldY:*;
      
      public var dyMod:*;
      
      public var beginAlpha:*;
      
      public var clip:MovieClip;
      
      public var scaleMod:*;
      
      public var dy:*;
      
      public var dx:*;
      
      public var alphaMod:*;
      
      public var head:*;
      
      public function UI_CashUpdatePurchase()
      {
         super();
         addFrameScript(0,frame1,24,frame25);
      }
      
      public function UpdatePosition(param1:Event) : void
      {
         this.x = worldX - head.cameraX;
         this.y = worldY - head.cameraY;
         this.visible = head.drawArea.hitTestObject(this);
         clip.x += dx;
         clip.y -= dy;
         clip.scaleX += scaleMod;
         clip.scaleY += scaleMod;
         dy -= dyMod;
         if(this.currentFrame > beginAlpha)
         {
            this.alpha -= alphaMod;
         }
      }
      
      internal function frame1() : *
      {
         dy = 8;
         scaleMod = 0.5 / this.totalFrames;
         dyMod = dy / (this.totalFrames - 10);
         beginAlpha = 20;
         alphaMod = 1 / (this.totalFrames - beginAlpha);
         head = root;
         dx = (Math.floor(Math.random() * 2) * 2 - 1) * 2;
         addEventListener(Event.ENTER_FRAME,UpdatePosition);
      }
      
      internal function frame25() : *
      {
         stop();
         removeEventListener(Event.ENTER_FRAME,UpdatePosition);
         this.parent.removeChild(this);
      }
   }
}
