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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Tips_592")]
   public dynamic class Tips_592 extends MovieClip
   {
       
      
      public var diff:*;
      
      public var scrollBar:MovieClip;
      
      public var tips:MovieClip;
      
      public var head:*;
      
      public function Tips_592()
      {
         super();
         addFrameScript(0,frame1,1,frame2,10,frame11,11,frame12,22,frame23);
      }
      
      public function UpdatePosition(param1:Event) : void
      {
         if(scrollBar.visible)
         {
            tips.tipsList.y = 5 - diff * scrollBar.getPosition();
         }
      }
      
      internal function frame12() : *
      {
         checkHeight();
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      public function checkHeight() : void
      {
         if(tips.tipsList.height > tips.writeArea.height - 10)
         {
            scrollBar.visible = true;
            diff = tips.tipsList.height - (tips.writeArea.height - 10);
         }
         else
         {
            scrollBar.visible = false;
            diff = 0;
         }
         scrollBar.btnScroll.y = scrollBar.line.y;
      }
      
      internal function frame23() : *
      {
         this.visible = false;
      }
      
      internal function frame2() : *
      {
         this.visible = true;
      }
      
      public function updateText(param1:Array) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(currentLabel == "reveal")
         {
            _loc2_ = "";
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               if(_loc3_ == 0)
               {
                  _loc2_ = "-" + param1[_loc3_];
               }
               else
               {
                  _loc2_ += "\n\n-" + param1[_loc3_];
               }
               _loc3_++;
            }
            if(_loc2_ == "")
            {
               tips.tipsList.text = "Tips not found";
            }
            else
            {
               tips.tipsList.text = _loc2_;
            }
            checkHeight();
         }
      }
      
      internal function frame11() : *
      {
         diff = 0;
         head = root;
         updateText(head.tipsHistory);
         addEventListener(Event.ENTER_FRAME,UpdatePosition);
      }
   }
}
