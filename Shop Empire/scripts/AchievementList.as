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
   
   [Embed(source="/_assets/assets.swf", symbol="AchievementList")]
   public dynamic class AchievementList extends MovieClip
   {
       
      
      public var trophy0:MovieClip;
      
      public var trophy1:MovieClip;
      
      public var trophy5:MovieClip;
      
      public var trophy4:MovieClip;
      
      public var trophy6:MovieClip;
      
      public var trophy7:MovieClip;
      
      public var trophy3:MovieClip;
      
      public var trophy8:MovieClip;
      
      public var AchivementNote:TextField;
      
      public var trophy9:MovieClip;
      
      public var trophy2:MovieClip;
      
      public var trophy11:MovieClip;
      
      public var trophy18:MovieClip;
      
      public var trophy15:MovieClip;
      
      public var trophy17:MovieClip;
      
      public var trophy19:MovieClip;
      
      public var btnBack:SimpleButton;
      
      public var trophy12:MovieClip;
      
      public var trophy13:MovieClip;
      
      public var trophy14:MovieClip;
      
      public var trophy16:MovieClip;
      
      public var trophy10:MovieClip;
      
      public var trophy20:MovieClip;
      
      public var NoticeList:*;
      
      public var head:*;
      
      public var trophyList:*;
      
      public function AchievementList()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function checkAchivement() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < trophyList.length)
         {
            if(head.Achivement.data.trophyList[_loc1_])
            {
               trophyList[_loc1_].gotoAndStop(2);
            }
            else
            {
               trophyList[_loc1_].gotoAndStop(1);
            }
            trophyList[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,TrophyMouseOver);
            trophyList[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,TrophyMouseOut);
            _loc1_++;
         }
      }
      
      internal function frame1() : *
      {
         head = root;
         trophyList = new Array();
         trophyList.push(trophy0);
         trophyList.push(trophy1);
         trophyList.push(trophy2);
         trophyList.push(trophy3);
         trophyList.push(trophy4);
         trophyList.push(trophy5);
         trophyList.push(trophy6);
         trophyList.push(trophy7);
         trophyList.push(trophy8);
         trophyList.push(trophy9);
         trophyList.push(trophy10);
         trophyList.push(trophy11);
         trophyList.push(trophy12);
         trophyList.push(trophy13);
         trophyList.push(trophy14);
         trophyList.push(trophy15);
         trophyList.push(trophy16);
         trophyList.push(trophy17);
         trophyList.push(trophy18);
         trophyList.push(trophy19);
         trophyList.push(trophy20);
         NoticeList = new Array("25 visitors satisfied","50 visitors satisfied","75 visitors satisfied","Enter the credit","Earn $50,000 profits","Earn $100,000 profits","Earn $200,000 profits","Earn $300,000 profits","Upgrade all buildings (at least 10)","Upgrade all buildings to max (at least 10)","Promote all securities staffs to max (at least 5)","Promote all technicians staffs to max (at least 5)","Promote all cleaning services staffs to max (at least 5)","Promote all staffs to the max (at least 12)","Have 5 general stores in your mall","Have 5 restrooms in your mall","Have 5 restaurants in your mall","Have all kind of booths in your mall","Secret achievement, find it","Lost 10 visitors (They\'re go home unhappy)","3 booths have electricity problems at same time");
         btnBack.addEventListener(MouseEvent.CLICK,BackToMainMenu);
         checkAchivement();
      }
      
      public function UpdateAchievement(param1:Number) : void
      {
         if(head.Achivement.data.trophyList[param1])
         {
            trophyList[param1].gotoAndStop(2);
         }
         else
         {
            trophyList[param1].gotoAndStop(1);
         }
      }
      
      public function BackToMainMenu(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < trophyList.length)
         {
            trophyList[_loc2_].removeEventListener(MouseEvent.MOUSE_OVER,TrophyMouseOver);
            trophyList[_loc2_].removeEventListener(MouseEvent.MOUSE_OUT,TrophyMouseOut);
            _loc2_++;
         }
         btnBack.removeEventListener(MouseEvent.CLICK,BackToMainMenu);
         if(this.parent != head.userinterface)
         {
            head.gotoAndPlay("Main Menu");
         }
         else
         {
            this.parent.removeChild(this);
         }
      }
      
      public function TrophyMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = param1.currentTarget;
         _loc3_ = trophyList.indexOf(_loc2_);
         _loc4_ = NoticeList[_loc3_];
         if(_loc2_.currentFrame == 2)
         {
            if(_loc4_ != "Secret achievement, find it")
            {
               _loc4_ += " (Unlocked)";
            }
            else
            {
               _loc4_ = "I see Eagle One Coming";
            }
         }
         AchivementNote.text = _loc4_;
         _loc2_.transform.colorTransform = new ColorTransform(1,1,1,1,100,50,100,0);
      }
      
      public function TrophyMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.currentTarget;
         AchivementNote.text = "";
         _loc2_.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      }
   }
}
