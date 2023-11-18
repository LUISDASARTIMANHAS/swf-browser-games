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
   
   [Embed(source="/_assets/assets.swf", symbol="BGStreet")]
   public dynamic class BGStreet extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public var light:MovieClip;
      
      public var tree2:MovieClip;
      
      public var tree1:MovieClip;
      
      public var myParent:*;
      
      public var sakura1:MovieClip;
      
      public var sakura2:MovieClip;
      
      public function BGStreet()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         myParent = root;
         addEventListener(Event.ENTER_FRAME,LightChange);
      }
      
      public function LightChange(param1:Event) : void
      {
         light.alpha = myParent.night.alpha;
      }
   }
}
