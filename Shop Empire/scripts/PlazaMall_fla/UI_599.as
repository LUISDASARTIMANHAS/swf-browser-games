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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_599")]
   public dynamic class UI_599 extends MovieClip
   {
       
      
      public var emptySlot:*;
      
      public var cancelSave:SimpleButton;
      
      public var saveSlot:*;
      
      public var btnRestart:SimpleButton;
      
      public var border:MovieClip;
      
      public var fillSlot:*;
      
      public var qualityControl:MovieClip;
      
      public var saveSlot1:MovieClip;
      
      public var saveSlot2:MovieClip;
      
      public var saveSlot3:MovieClip;
      
      public var btnExit:SimpleButton;
      
      public var emptySlot1:SimpleButton;
      
      public var emptySlot2:SimpleButton;
      
      public var emptySlot3:SimpleButton;
      
      public var backToMainMenuWarning:MovieClip;
      
      public var restartWarning:MovieClip;
      
      public var btnResume:SimpleButton;
      
      public var saveNotice:MovieClip;
      
      public var menuHeader:TextField;
      
      public var warningIndex:*;
      
      public var warningMessage:MovieClip;
      
      public var btnSave:SimpleButton;
      
      public function UI_599()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function SaveData(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         if(!warningMessage.visible)
         {
            _loc2_ = param1.currentTarget;
            _loc3_ = saveSlot.indexOf(_loc2_);
            if((_loc4_ = root).SaveGameData[_loc3_].data.playerName)
            {
               warningIndex = _loc3_;
               warningMessage.visible = true;
               warningMessage.btnYes.addEventListener(MouseEvent.CLICK,AcceptSave);
               warningMessage.btnNo.addEventListener(MouseEvent.CLICK,DeclineSave);
            }
            else
            {
               _loc4_.saveGame(_loc3_);
               if(_loc4_.SaveGameData[_loc3_].data.playerName)
               {
                  if(saveSlot[_loc3_] == emptySlot[_loc3_])
                  {
                     saveSlot[_loc3_].visible = false;
                  }
                  fillSlot[_loc3_].body.playerName.text = _loc4_.SaveGameData[_loc3_].data.playerName;
                  _loc6_ = (_loc5_ = _loc4_.SaveGameData[_loc3_].data.saveDate).month + 1;
                  if(_loc5_.month < 10)
                  {
                     _loc6_ = "0" + _loc6_;
                  }
                  _loc7_ = _loc5_.date;
                  if(_loc5_.date < 10)
                  {
                     _loc7_ = "0" + _loc7_;
                  }
                  _loc8_ = _loc5_.fullYear % 100;
                  if(_loc5_.fullYear % 100 < 10)
                  {
                     _loc8_ = "0" + _loc7_;
                  }
                  fillSlot[_loc3_].body.dateSave.text = _loc6_ + "/" + _loc7_ + "/" + _loc8_;
                  _loc9_ = "am";
                  _loc10_ = _loc5_.hours + "";
                  if(_loc5_.hours > 12)
                  {
                     _loc10_ = _loc5_.hours - 12 + "";
                     _loc9_ = "pm";
                  }
                  if(_loc10_.length <= 1)
                  {
                     _loc10_ = "0" + _loc10_;
                  }
                  _loc11_ = _loc5_.minutes;
                  if(_loc5_.minutes < 10)
                  {
                     _loc11_ = "0" + _loc11_;
                  }
                  fillSlot[_loc3_].body.timeSave.text = _loc10_ + ":" + _loc11_ + _loc9_;
                  saveSlot[_loc3_] = fillSlot[_loc3_];
                  saveSlot[_loc3_].visible = true;
               }
            }
         }
      }
      
      public function DeclineExit(param1:MouseEvent) : void
      {
         backToMainMenuWarning.visible = false;
         backToMainMenuWarning.btnYes.removeEventListener(MouseEvent.CLICK,AcceptExit);
         backToMainMenuWarning.btnNo.removeEventListener(MouseEvent.CLICK,DeclineExit);
      }
      
      public function SaveGame(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         if(!restartWarning.visible && !backToMainMenuWarning.visible)
         {
            _loc2_ = root;
            btnResume.visible = false;
            btnSave.visible = false;
            btnRestart.visible = false;
            btnExit.visible = false;
            qualityControl.visible = false;
            menuHeader.text = "SAVE GAME";
            _loc3_ = 0;
            while(_loc3_ < emptySlot.length)
            {
               if(_loc2_.SaveGameData[_loc3_].data.playerName)
               {
                  fillSlot[_loc3_].body.playerName.text = _loc2_.SaveGameData[_loc3_].data.playerName;
                  _loc5_ = (_loc4_ = _loc2_.SaveGameData[_loc3_].data.saveDate).month + 1;
                  if(_loc4_.month < 10)
                  {
                     _loc5_ = "0" + _loc5_;
                  }
                  _loc6_ = _loc4_.date;
                  if(_loc4_.date < 10)
                  {
                     _loc6_ = "0" + _loc6_;
                  }
                  _loc7_ = _loc4_.fullYear % 100;
                  if(_loc4_.fullYear % 100 < 10)
                  {
                     _loc7_ = "0" + _loc6_;
                  }
                  fillSlot[_loc3_].body.dateSave.text = _loc5_ + "/" + _loc6_ + "/" + _loc7_;
                  _loc8_ = "am";
                  _loc9_ = _loc4_.hours + "";
                  if(_loc4_.hours > 12)
                  {
                     _loc9_ = _loc4_.hours - 12 + "";
                     _loc8_ = "pm";
                  }
                  if(_loc9_.length <= 1)
                  {
                     _loc9_ = "0" + _loc9_;
                  }
                  _loc10_ = _loc4_.minutes;
                  if(_loc4_.minutes < 10)
                  {
                     _loc10_ = "0" + _loc10_;
                  }
                  fillSlot[_loc3_].body.timeSave.text = _loc9_ + ":" + _loc10_ + _loc8_;
                  saveSlot.push(fillSlot[_loc3_]);
               }
               else
               {
                  saveSlot.push(emptySlot[_loc3_]);
               }
               saveSlot[_loc3_].visible = true;
               saveSlot[_loc3_].addEventListener(MouseEvent.CLICK,SaveData);
               _loc3_++;
            }
            cancelSave.visible = true;
            saveNotice.visible = true;
         }
      }
      
      public function ExitGame(param1:MouseEvent) : void
      {
         if(!restartWarning.visible && !backToMainMenuWarning.visible)
         {
            backToMainMenuWarning.visible = true;
            backToMainMenuWarning.btnYes.addEventListener(MouseEvent.CLICK,AcceptExit);
            backToMainMenuWarning.btnNo.addEventListener(MouseEvent.CLICK,DeclineExit);
         }
      }
      
      public function AcceptExit(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = root;
         _loc2_.BackToMainMenu();
         if(_loc2_.bgmChannel != null)
         {
            _loc2_.bgmChannel.stop();
         }
         if(_loc2_.seChannel != null)
         {
            _loc2_.seChannel.stop();
         }
         backToMainMenuWarning.visible = false;
         backToMainMenuWarning.btnYes.removeEventListener(MouseEvent.CLICK,AcceptExit);
         backToMainMenuWarning.btnNo.removeEventListener(MouseEvent.CLICK,DeclineExit);
      }
      
      internal function frame1() : *
      {
         warningMessage.visible = false;
         backToMainMenuWarning.visible = false;
         restartWarning.visible = false;
         saveSlot = new Array();
         emptySlot = new Array();
         emptySlot.push(emptySlot1);
         emptySlot.push(emptySlot2);
         emptySlot.push(emptySlot3);
         fillSlot = new Array();
         fillSlot.push(saveSlot1);
         fillSlot.push(saveSlot2);
         fillSlot.push(saveSlot3);
         emptySlot1.visible = false;
         emptySlot2.visible = false;
         emptySlot3.visible = false;
         saveSlot1.visible = false;
         saveSlot2.visible = false;
         saveSlot3.visible = false;
         cancelSave.visible = false;
         saveNotice.visible = false;
         btnResume.addEventListener(MouseEvent.CLICK,ResumeGame);
         btnRestart.addEventListener(MouseEvent.CLICK,RestartGame);
         btnExit.addEventListener(MouseEvent.CLICK,ExitGame);
         btnSave.addEventListener(MouseEvent.CLICK,SaveGame);
         cancelSave.addEventListener(MouseEvent.CLICK,CancelSaveGame);
         warningIndex = -1;
      }
      
      public function DeclineRestart(param1:MouseEvent) : void
      {
         restartWarning.visible = false;
         restartWarning.btnYes.removeEventListener(MouseEvent.CLICK,AcceptExit);
         restartWarning.btnNo.removeEventListener(MouseEvent.CLICK,DeclineExit);
      }
      
      public function RestartGame(param1:MouseEvent) : void
      {
         if(!restartWarning.visible && !backToMainMenuWarning.visible)
         {
            restartWarning.visible = true;
            restartWarning.btnYes.addEventListener(MouseEvent.CLICK,AcceptRestart);
            restartWarning.btnNo.addEventListener(MouseEvent.CLICK,DeclineRestart);
         }
      }
      
      public function DeclineSave(param1:MouseEvent) : void
      {
         warningMessage.visible = false;
         warningMessage.btnYes.removeEventListener(MouseEvent.CLICK,AcceptSave);
         warningMessage.btnNo.removeEventListener(MouseEvent.CLICK,DeclineSave);
      }
      
      public function CancelSaveGame(param1:MouseEvent) : void
      {
         if(!warningMessage.visible)
         {
            while(saveSlot.length > 0)
            {
               saveSlot[0].visible = false;
               saveSlot.shift();
            }
            cancelSave.visible = false;
            saveNotice.visible = false;
            btnResume.visible = true;
            btnSave.visible = true;
            btnRestart.visible = true;
            btnExit.visible = true;
            qualityControl.visible = true;
            menuHeader.text = "GAME MENU";
         }
      }
      
      public function AcceptRestart(param1:MouseEvent) : void
      {
         var myParent:* = undefined;
         var event:MouseEvent = param1;
         myParent = root;
         with(myParent)
         {
            cleanAllObject();
            if(city == 0)
            {
               bgm = new BGMTransition();
               bgm.play(0,0,bgmTransform);
               gotoAndPlay("Transition Paris");
            }
            else if(city == 1)
            {
               bgm = new BGMTransition();
               bgm.play(0,0,bgmTransform);
               gotoAndPlay("Transition Tokyo");
            }
            else if(city == 2)
            {
               bgm = new BGMTransition();
               bgm.play(0,0,bgmTransform);
               gotoAndPlay("Transition New York");
            }
         }
         restartWarning.visible = false;
         restartWarning.btnYes.removeEventListener(MouseEvent.CLICK,AcceptExit);
         restartWarning.btnNo.removeEventListener(MouseEvent.CLICK,DeclineExit);
      }
      
      public function AcceptSave(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         _loc2_ = root;
         _loc2_.saveGame(warningIndex);
         fillSlot[warningIndex].body.playerName.text = _loc2_.SaveGameData[warningIndex].data.playerName;
         _loc3_ = _loc2_.SaveGameData[warningIndex].data.saveDate;
         _loc4_ = _loc3_.month + 1;
         if(_loc3_.month < 10)
         {
            _loc4_ = "0" + _loc4_;
         }
         _loc5_ = _loc3_.date;
         if(_loc3_.date < 10)
         {
            _loc5_ = "0" + _loc5_;
         }
         _loc6_ = _loc3_.fullYear % 100;
         if(_loc3_.fullYear % 100 < 10)
         {
            _loc6_ = "0" + _loc5_;
         }
         fillSlot[warningIndex].body.dateSave.text = _loc4_ + "/" + _loc5_ + "/" + _loc6_;
         _loc7_ = "am";
         _loc8_ = _loc3_.hours + "";
         if(_loc3_.hours > 12)
         {
            _loc8_ = _loc3_.hours - 12 + "";
            _loc7_ = "pm";
         }
         if(_loc8_.length <= 1)
         {
            _loc8_ = "0" + _loc8_;
         }
         _loc9_ = _loc3_.minutes;
         if(_loc3_.minutes < 10)
         {
            _loc9_ = "0" + _loc9_;
         }
         fillSlot[warningIndex].body.timeSave.text = _loc8_ + ":" + _loc9_ + _loc7_;
         saveSlot[warningIndex] = fillSlot[warningIndex];
         saveSlot[warningIndex].visible = true;
         warningMessage.visible = false;
         warningIndex = -1;
      }
      
      public function ResumeGame(param1:MouseEvent) : void
      {
         var myParent:* = undefined;
         var oldParent:* = undefined;
         var event:MouseEvent = param1;
         if(!restartWarning.visible && !backToMainMenuWarning.visible)
         {
            myParent = this.parent;
            with(myParent)
            {
               
               oldParent = myParent.parent;
               oldParent.gameSpeed = tempSpeed;
               tempSpeed = -1;
               gameMenu.visible = false;
               activeAllButton();
            }
         }
      }
   }
}
