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
   
   [Embed(source="/_assets/assets.swf", symbol="BuildJewelry")]
   public dynamic class BuildJewelry extends MovieClip
   {
       
      
      public var price:*;
      
      public var myParent:*;
      
      public var body:MovieClip;
      
      public function BuildJewelry()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         myParent = root;
         price = myParent.GENERAL_PRICE[7];
      }
   }
}
