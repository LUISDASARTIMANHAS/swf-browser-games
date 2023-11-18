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
   
   [Embed(source="/_assets/assets.swf", symbol="TutorialNotification")]
   public dynamic class TutorialNotification extends MovieClip
   {
       
      
      public var lower:MovieClip;
      
      public var left:MovieClip;
      
      public var nextTutor:SimpleButton;
      
      public var right:MovieClip;
      
      public var theText:*;
      
      public var noteText:TextField;
      
      public var tempText:*;
      
      public var hasNextButton:*;
      
      public var upperRight:MovieClip;
      
      public var lowerLeft:MovieClip;
      
      public var body:MovieClip;
      
      public var upper:MovieClip;
      
      public var lowerRight:MovieClip;
      
      public var upperLeft:MovieClip;
      
      public function TutorialNotification()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function NextTutor(param1:MouseEvent) : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,MouseOverEvent);
         removeEventListener(MouseEvent.MOUSE_OUT,MouseOutEvent);
         this.parent.removeChild(this);
      }
      
      internal function frame1() : *
      {
         theText = "";
         noteText.autoSize = TextFieldAutoSize.CENTER;
         noteText.mouseEnabled = false;
         body.width = noteText.width;
         body.height = noteText.height;
         body.x = -body.width / 2;
         body.y = -body.height / 2;
         nextTutor.visible = false;
         if(hasNextButton)
         {
            body.height += nextTutor.height;
            nextTutor.x = body.x + body.width - nextTutor.width;
            nextTutor.y = body.y + body.height - nextTutor.height;
         }
         noteText.x = body.x;
         noteText.y = body.y;
         theText = noteText.htmlText;
         noteText.htmlText = "";
         upper.x = body.x;
         upper.y = body.y - upper.height;
         upper.width = body.width;
         lower.x = body.x;
         lower.y = body.y + body.height;
         lower.width = body.width;
         left.x = body.x - left.width;
         left.y = body.y;
         left.height = body.height;
         right.x = body.x + body.width;
         right.y = body.y;
         right.height = body.height;
         upperLeft.x = body.x - upperLeft.width;
         upperLeft.y = body.y - upperLeft.height;
         upperRight.x = body.x + body.width;
         upperRight.y = body.y - upperRight.height;
         lowerLeft.x = body.x - lowerLeft.width;
         lowerLeft.y = body.y + body.height;
         lowerRight.x = body.x + body.width;
         lowerRight.y = body.y + body.height;
         tempText = "";
         addEventListener(Event.ENTER_FRAME,TextAnimation);
         stage.addEventListener(MouseEvent.CLICK,SkipTextAnimation);
         stage.addEventListener(KeyboardEvent.KEY_UP,SkipTextWithKey);
         addEventListener(MouseEvent.MOUSE_OVER,MouseOverEvent);
         addEventListener(MouseEvent.MOUSE_OUT,MouseOutEvent);
      }
      
      public function MouseOverEvent(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = root;
         _loc2_.mouseInUI = true;
      }
      
      public function SkipTextAnimation(param1:MouseEvent) : void
      {
         tempText += theText;
         theText = "";
      }
      
      public function MouseOutEvent(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = root;
         _loc2_.mouseInUI = false;
      }
      
      public function SkipTextWithKey(param1:KeyboardEvent) : void
      {
         tempText += theText;
         theText = "";
      }
      
      public function TextAnimation(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(theText.charAt(0) == "<")
         {
            _loc2_ = theText.indexOf(">") + 1;
            while(theText.charAt(_loc2_) == "<")
            {
               _loc3_ = theText.indexOf(">",_loc2_);
               _loc2_ = _loc3_ + 1;
            }
         }
         else
         {
            _loc2_ = 1;
         }
         tempText += theText.substr(0,_loc2_);
         theText = theText.substr(_loc2_,theText.length);
         noteText.htmlText = tempText;
         if(theText.length <= 0)
         {
            stage.removeEventListener(MouseEvent.CLICK,SkipTextAnimation);
            stage.removeEventListener(KeyboardEvent.KEY_UP,SkipTextWithKey);
            removeEventListener(Event.ENTER_FRAME,TextAnimation);
            if(hasNextButton)
            {
               nextTutor.visible = true;
               nextTutor.addEventListener(MouseEvent.CLICK,NextTutor);
            }
         }
      }
   }
}
