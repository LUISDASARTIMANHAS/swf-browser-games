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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.PreloaderScreen_2")]
   public dynamic class PreloaderScreen_2 extends MovieClip
   {
       
      
      public var dialog4:MovieClip;
      
      public var dialog3:MovieClip;
      
      public var Mood:*;
      
      public var obj1:MovieClip;
      
      public var obj2:MovieClip;
      
      public var obj3:MovieClip;
      
      public var obj5:MovieClip;
      
      public var legend:*;
      
      public var obj4:MovieClip;
      
      public var i:*;
      
      public var blinkDelay:*;
      
      public var done:*;
      
      public var ObjectArr:*;
      
      public var RealHeight:*;
      
      public var DialogArr:*;
      
      public var dialog1:MovieClip;
      
      public var dialog5:MovieClip;
      
      public var dialog2:MovieClip;
      
      public function PreloaderScreen_2()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Animation(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(blinkDelay > 0)
         {
            --blinkDelay;
         }
         else
         {
            blinkDelay = 24;
         }
         _loc2_ = 0;
         while(_loc2_ < ObjectArr.length)
         {
            DialogArr[_loc2_].y = ObjectArr[_loc2_].y + (RealHeight[_loc2_] - ObjectArr[_loc2_].height) - DialogArr[_loc2_].height;
            if(blinkDelay >= (4 - _loc2_) * 3 && blinkDelay <= (4 - _loc2_) * 3 + 12)
            {
               DialogArr[_loc2_].visible = false;
            }
            else
            {
               DialogArr[_loc2_].visible = true;
            }
            if(!DialogArr[_loc2_].visible)
            {
               if(Math.floor(done / 12.5) > Mood[_loc2_] + _loc2_ + 1)
               {
                  if(!(legend[_loc2_] is legendmoodhappy))
                  {
                     DialogArr[_loc2_].removeChild(legend[_loc2_]);
                     if(legend[_loc2_] is legendmoodveryupset)
                     {
                        legend[_loc2_] = new legendmoodupset();
                     }
                     else if(legend[_loc2_] is legendmoodupset)
                     {
                        legend[_loc2_] = new legendmoodnormal();
                     }
                     else
                     {
                        legend[_loc2_] = new legendmoodhappy();
                     }
                     legend[_loc2_].x = DialogArr[_loc2_].width / 2;
                     legend[_loc2_].y = DialogArr[_loc2_].height / 2;
                     DialogArr[_loc2_].addChild(legend[_loc2_]);
                     ++Mood[_loc2_];
                  }
               }
            }
            _loc2_++;
         }
      }
      
      internal function frame1() : *
      {
         done = 0;
         ObjectArr = new Array();
         ObjectArr.push(obj1);
         ObjectArr.push(obj2);
         ObjectArr.push(obj3);
         ObjectArr.push(obj4);
         ObjectArr.push(obj5);
         DialogArr = new Array();
         DialogArr.push(dialog1);
         DialogArr.push(dialog2);
         DialogArr.push(dialog3);
         DialogArr.push(dialog4);
         DialogArr.push(dialog5);
         RealHeight = new Array(ObjectArr.length);
         legend = new Array(DialogArr.length);
         Mood = new Array(ObjectArr.length);
         i = 0;
         while(i < ObjectArr.length)
         {
            RealHeight[i] = ObjectArr[i].height;
            ObjectArr[i].gotoAndPlay(Math.floor(Math.random() * ObjectArr[i].totalFrames));
            legend[i] = new legendmoodveryupset();
            legend[i].x = DialogArr[i].width / 2;
            legend[i].y = DialogArr[i].height / 2;
            DialogArr[i].addChild(legend[i]);
            Mood[i] = 0;
            ++i;
         }
         blinkDelay = 24;
         addEventListener(Event.ENTER_FRAME,Animation);
      }
   }
}
