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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_572")]
   public dynamic class UI_572 extends MovieClip
   {
       
      
      public var success:*;
      
      public var objectiveInfo:TextField;
      
      public var maskBar:MovieClip;
      
      public var objectiveMark:MovieClip;
      
      public var declareMission:*;
      
      public var changeMission:*;
      
      public var inPlace:*;
      
      public function UI_572()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Animation(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(!declareMission)
         {
            objectiveInfo.x = maskBar.x - objectiveInfo.width / 2;
         }
         else if(!inPlace)
         {
            if(objectiveInfo.x < maskBar.x + maskBar.width / 2 - objectiveInfo.width / 2)
            {
               objectiveInfo.x += 32;
            }
            else
            {
               objectiveInfo.x = maskBar.x + maskBar.width / 2 - objectiveInfo.width / 2;
               objectiveMark.x = objectiveInfo.x - 10;
               inPlace = true;
            }
         }
         else if(success)
         {
            if(!changeMission)
            {
               if(!objectiveMark.visible)
               {
                  objectiveMark.gotoAndPlay(1);
                  objectiveMark.visible = true;
                  _loc2_ = root;
                  _loc2_.addCashUpdate(1000 * (_loc2_.missionActive + _loc2_.city),_loc2_.userinterface.cashInfo.x + _loc2_.userinterface.cashInfo.width / 2,_loc2_.userinterface.cashInfo.y + _loc2_.userinterface.cashInfo.height / 2,true,0,true);
                  _loc2_.missionReward += 1000 * (_loc2_.missionActive + _loc2_.city);
               }
               else if(objectiveMark.currentLabel == "changeMission")
               {
                  changeMission = true;
               }
               else if(objectiveMark.currentFrame <= 20)
               {
                  if(objectiveMark.currentFrame <= 10)
                  {
                     if(objectiveInfo.alpha > 0)
                     {
                        objectiveInfo.alpha -= 0.1;
                     }
                  }
                  else if(objectiveInfo.alpha < 1)
                  {
                     objectiveInfo.alpha += 0.1;
                  }
               }
            }
            else
            {
               objectiveInfo.x += 32;
               if(objectiveInfo.x > maskBar.x + maskBar.width)
               {
                  declareMission = false;
                  inPlace = false;
                  success = false;
                  changeMission = false;
                  objectiveInfo.x = maskBar.x - objectiveInfo.width / 2;
               }
            }
         }
      }
      
      internal function frame1() : *
      {
         objectiveInfo.autoSize = TextFieldAutoSize.CENTER;
         objectiveMark.visible = false;
         objectiveMark.y = maskBar.height / 2;
         declareMission = false;
         inPlace = false;
         success = false;
         changeMission = false;
         addEventListener(Event.ENTER_FRAME,Animation);
      }
   }
}
