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
   
   [Embed(source="/_assets/assets.swf", symbol="accArrow")]
   public dynamic class accArrow extends MovieClip
   {
       
      
      public var worldX:*;
      
      public var worldY:*;
      
      public var visitor:*;
      
      public function accArrow()
      {
         super();
         addFrameScript(0,frame1,56,frame57);
      }
      
      public function ChangePosition(param1:Event) : void
      {
         if(visitor != null)
         {
            worldX = visitor.worldX;
            worldY = visitor.worldY - visitor.height;
         }
      }
      
      internal function frame1() : *
      {
         addEventListener(Event.ENTER_FRAME,ChangePosition);
      }
      
      internal function frame57() : *
      {
         this.parent.removeChild(this);
         removeEventListener(Event.ENTER_FRAME,ChangePosition);
         stop();
      }
   }
}
