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
   
   [Embed(source="/_assets/assets.swf", symbol="UI_Notification")]
   public dynamic class UI_Notification extends MovieClip
   {
       
      
      public var tParent:*;
      
      public var note:MovieClip;
      
      public function UI_Notification()
      {
         super();
         addFrameScript(0,frame1,87,frame88);
      }
      
      public function checkOtherNote(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = tParent.getChildIndex(this);
         if(_loc2_ > 0)
         {
            _loc3_ = tParent.getChildAt(_loc2_ - 1);
            _loc3_.y = this.y + this.note.y + (this.note.upperBody.y + 18) - 2;
         }
      }
      
      internal function frame88() : *
      {
         stop();
         this.removeEventListener(Event.ENTER_FRAME,checkOtherNote);
         this.parent.removeChild(this);
      }
      
      internal function frame1() : *
      {
         tParent = this.parent;
         addEventListener(Event.ENTER_FRAME,checkOtherNote);
      }
   }
}
