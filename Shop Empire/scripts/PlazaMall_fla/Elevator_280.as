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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Elevator_280")]
   public dynamic class Elevator_280 extends MovieClip
   {
       
      
      public var myParent:*;
      
      public function Elevator_280()
      {
         super();
         addFrameScript(24,frame25);
      }
      
      internal function frame25() : *
      {
         myParent = this.parent.parent;
         myParent.isOpen = false;
      }
   }
}
