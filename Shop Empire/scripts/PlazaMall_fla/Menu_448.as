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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Menu_448")]
   public dynamic class Menu_448 extends MovieClip
   {
       
      
      public var loadSlot:*;
      
      public var btnAchive:SimpleButton;
      
      public var btnCredit:SimpleButton;
      
      public var emptySlot1:MovieClip;
      
      public var emptySlot2:MovieClip;
      
      public var emptySlot3:MovieClip;
      
      public var loadSlot1:MovieClip;
      
      public var loadSlot2:MovieClip;
      
      public var loadSlot3:MovieClip;
      
      public var saveDate:*;
      
      public var bgm:*;
      
      public var yearText:*;
      
      public var btnContinue:SimpleButton;
      
      public var ampm:*;
      
      public var hourText:*;
      
      public var subMenuLoad:*;
      
      public var btnLoad:SimpleButton;
      
      public var btnLoadBack:SimpleButton;
      
      public var btnBack:SimpleButton;
      
      public var enterOption:*;
      
      public var btnMoreGames:SimpleButton;
      
      public var inputName:MovieClip;
      
      public var myParent:*;
      
      public var minuteText:*;
      
      public var buttonClick:*;
      
      public var subMenuPlay:*;
      
      public var backgroundMenu:MovieClip;
      
      public var btnPlay:SimpleButton;
      
      public var btnNewGame:SimpleButton;
      
      public var monthText:*;
      
      public var btnOption:SimpleButton;
      
      public var dateText:*;
      
      public function Menu_448()
      {
         super();
         addFrameScript(0,frame1,40,frame41,51,frame52,59,frame60,60,frame61,68,frame69,69,frame70,70,frame71,71,frame72,72,frame73,78,frame79,79,frame80,87,frame88,92,frame93,96,frame97,101,frame102,105,frame106,117,frame118);
      }
      
      public function btnBackOnClick(param1:MouseEvent) : void
      {
         removeAllSubPlayButtonListener();
         gotoAndPlay("Sub Play Out");
         subMenuPlay = 3;
      }
      
      public function LoadGame(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = param1.currentTarget;
         _loc3_ = loadSlot.indexOf(_loc2_);
         myParent.gameLoaded = _loc3_;
         subMenuLoad = 1;
         gotoAndPlay("Load Game Out");
      }
      
      public function removeAllSubPlayButtonListener() : void
      {
         this.btnNewGame.removeEventListener(MouseEvent.CLICK,btnNewGameOnClick);
         this.btnLoad.removeEventListener(MouseEvent.CLICK,btnLoadOnClick);
         this.btnBack.removeEventListener(MouseEvent.CLICK,btnBackOnClick);
      }
      
      public function btnNewGameOnClick(param1:MouseEvent) : void
      {
         inputName.visible = true;
         inputName.nameInput.text = myParent.playerName;
         stage.focus = inputName.nameInput;
         inputName.nameInput.setSelection(0,myParent.playerName.length);
         btnNewGame.visible = false;
         btnLoad.visible = false;
         btnBack.visible = false;
      }
      
      public function removeLoadListener() : *
      {
         var _loc1_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < loadSlot.length)
         {
            if(myParent.SaveGameData[_loc1_].data.playerName)
            {
               loadSlot[_loc1_].removeEventListener(MouseEvent.CLICK,LoadGame);
            }
            _loc1_++;
         }
      }
      
      internal function frame1() : *
      {
         inputName.visible = false;
         myParent = root;
      }
      
      public function removeAllSubLoadButtonListener() : void
      {
         this.btnLoadBack.removeEventListener(MouseEvent.CLICK,BacktoPlayMenu);
      }
      
      public function BacktoPlayMenu(param1:MouseEvent) : void
      {
         removeAllSubLoadButtonListener();
         gotoAndPlay("Load Game Out");
      }
      
      internal function frame41() : *
      {
         this.btnMoreGames.addEventListener(MouseEvent.CLICK,btnMoreGamesOnClick);
         this.btnCredit.addEventListener(MouseEvent.CLICK,btnCreditOnClick);
         this.btnOption.addEventListener(MouseEvent.CLICK,btnOptionOnClick);
         this.btnAchive.addEventListener(MouseEvent.CLICK,btnAchiveOnClick);
         this.btnPlay.addEventListener(MouseEvent.CLICK,btnPlayOnClick);
         stop();
         buttonClick = 0;
      }
      
      public function btnCreditOnClick(param1:MouseEvent) : void
      {
         removeAllMainButtonListener();
         gotoAndPlay("Main Button Out");
         buttonClick = 4;
      }
      
      internal function frame52() : *
      {
         stop();
         if(buttonClick == 1)
         {
            gotoAndPlay("Play Button Enter");
         }
         else if(buttonClick == 2)
         {
            gotoAndPlay("Play Game");
         }
         else if(buttonClick == 3)
         {
            gotoAndPlay("Option");
         }
         else if(buttonClick == 4)
         {
            gotoAndPlay("Credit Frame");
         }
      }
      
      internal function frame60() : *
      {
         this.btnBack.addEventListener(MouseEvent.CLICK,btnBackOnClick);
         this.btnLoad.addEventListener(MouseEvent.CLICK,btnLoadOnClick);
         this.btnNewGame.addEventListener(MouseEvent.CLICK,btnNewGameOnClick);
         stop();
         subMenuPlay = 0;
      }
      
      internal function frame61() : *
      {
         this.btnNewGame.removeEventListener(MouseEvent.CLICK,btnNewGameOnClick);
         this.btnLoad.removeEventListener(MouseEvent.CLICK,btnLoadOnClick);
         this.btnBack.removeEventListener(MouseEvent.CLICK,btnBackOnClick);
      }
      
      internal function frame69() : *
      {
         stop();
         switch(subMenuPlay)
         {
            case 1:
               gotoAndPlay("Play Game");
               break;
            case 2:
               gotoAndPlay("Load Game");
               break;
            default:
               gotoAndPlay("Main Button Back");
         }
      }
      
      public function addLoadListener() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < loadSlot.length)
         {
            if(myParent.SaveGameData[_loc1_].data.playerName)
            {
               loadSlot[_loc1_].addEventListener(MouseEvent.CLICK,LoadGame);
            }
            _loc1_++;
         }
      }
      
      internal function frame70() : *
      {
         if(myParent.AutoSaveGame.data.playerName)
         {
            btnContinue.visible = true;
         }
         else
         {
            btnContinue.visible = false;
         }
      }
      
      internal function frame72() : *
      {
         if(myParent.SaveGameData[1].data.playerName)
         {
            loadSlot2.body.playerName.text = myParent.SaveGameData[1].data.playerName;
            saveDate = myParent.SaveGameData[1].data.saveDate;
            monthText = saveDate.month + 1;
            if(saveDate.month < 10)
            {
               monthText = "0" + monthText;
            }
            dateText = saveDate.date;
            if(saveDate.date < 10)
            {
               dateText = "0" + dateText;
            }
            yearText = saveDate.fullYear % 100;
            if(saveDate.fullYear % 100 < 10)
            {
               yearText = "0" + dateText;
            }
            loadSlot2.body.dateSave.text = monthText + "/" + dateText + "/" + yearText;
            ampm = "am";
            hourText = saveDate.hours + "";
            if(saveDate.hours > 12)
            {
               hourText = saveDate.hours - 12 + "";
               ampm = "pm";
            }
            if(hourText.length <= 1)
            {
               hourText = "0" + hourText;
            }
            minuteText = saveDate.minutes;
            if(saveDate.minutes < 10)
            {
               minuteText = "0" + minuteText;
            }
            loadSlot2.body.timeSave.text = hourText + ":" + minuteText + ampm;
            loadSlot2.visible = true;
            emptySlot2.visible = false;
         }
         else
         {
            loadSlot2.visible = false;
            emptySlot2.visible = true;
         }
      }
      
      internal function frame73() : *
      {
         if(myParent.SaveGameData[2].data.playerName)
         {
            loadSlot3.body.playerName.text = myParent.SaveGameData[2].data.playerName;
            saveDate = myParent.SaveGameData[2].data.saveDate;
            monthText = saveDate.month + 1;
            if(saveDate.month < 10)
            {
               monthText = "0" + monthText;
            }
            dateText = saveDate.date;
            if(saveDate.date < 10)
            {
               dateText = "0" + dateText;
            }
            yearText = saveDate.fullYear % 100;
            if(saveDate.fullYear % 100 < 10)
            {
               yearText = "0" + dateText;
            }
            loadSlot3.body.dateSave.text = monthText + "/" + dateText + "/" + yearText;
            ampm = "am";
            hourText = saveDate.hours + "";
            if(saveDate.hours > 12)
            {
               hourText = saveDate.hours - 12 + "";
               ampm = "pm";
            }
            if(hourText.length <= 1)
            {
               hourText = "0" + hourText;
            }
            minuteText = saveDate.minutes;
            if(saveDate.minutes < 10)
            {
               minuteText = "0" + minuteText;
            }
            loadSlot3.body.timeSave.text = hourText + ":" + minuteText + ampm;
            loadSlot3.visible = true;
            emptySlot3.visible = false;
         }
         else
         {
            loadSlot3.visible = false;
            emptySlot3.visible = true;
         }
      }
      
      internal function frame71() : *
      {
         if(myParent.SaveGameData[0].data.playerName)
         {
            loadSlot1.body.playerName.text = myParent.SaveGameData[0].data.playerName;
            saveDate = myParent.SaveGameData[0].data.saveDate;
            monthText = saveDate.month + 1;
            if(saveDate.month < 10)
            {
               monthText = "0" + monthText;
            }
            dateText = saveDate.date;
            if(saveDate.date < 10)
            {
               dateText = "0" + dateText;
            }
            yearText = saveDate.fullYear % 100;
            if(saveDate.fullYear % 100 < 10)
            {
               yearText = "0" + dateText;
            }
            loadSlot1.body.dateSave.text = monthText + "/" + dateText + "/" + yearText;
            ampm = "am";
            hourText = saveDate.hours + "";
            if(saveDate.hours > 12)
            {
               hourText = saveDate.hours - 12 + "";
               ampm = "pm";
            }
            if(hourText.length <= 1)
            {
               hourText = "0" + hourText;
            }
            minuteText = saveDate.minutes;
            if(saveDate.minutes < 10)
            {
               minuteText = "0" + minuteText;
            }
            loadSlot1.body.timeSave.text = hourText + ":" + minuteText + ampm;
            loadSlot1.visible = true;
            emptySlot1.visible = false;
         }
         else
         {
            loadSlot1.visible = false;
            emptySlot1.visible = true;
         }
      }
      
      public function btnAchiveOnClick(param1:MouseEvent) : void
      {
         removeAllMainButtonListener();
         gotoAndPlay("Main Button Out");
         buttonClick = 2;
      }
      
      internal function frame79() : *
      {
         btnLoadBack.addEventListener(MouseEvent.CLICK,BacktoPlayMenu);
         loadSlot = new Array();
         loadSlot.push(loadSlot1);
         loadSlot.push(loadSlot2);
         loadSlot.push(loadSlot3);
         addLoadListener();
         if(myParent.AutoSaveGame.data.playerName)
         {
            btnContinue.addEventListener(MouseEvent.CLICK,ContinueGame);
         }
         stop();
         subMenuLoad = 0;
      }
      
      public function btnPlayOnClick(param1:MouseEvent) : void
      {
         removeAllMainButtonListener();
         gotoAndPlay("Main Button Out");
         buttonClick = 1;
      }
      
      internal function frame80() : *
      {
         removeLoadListener();
         btnContinue.removeEventListener(MouseEvent.CLICK,ContinueGame);
      }
      
      internal function frame88() : *
      {
         stop();
         switch(subMenuLoad)
         {
            case 1:
               gotoAndPlay("Play Game");
               break;
            default:
               gotoAndPlay("Play Button Enter");
         }
      }
      
      public function btnLoadOnClick(param1:MouseEvent) : void
      {
         removeAllSubPlayButtonListener();
         gotoAndPlay("Sub Play Out");
         subMenuPlay = 2;
      }
      
      internal function frame93() : *
      {
         enterOption = true;
         stop();
      }
      
      internal function frame97() : *
      {
         gotoAndPlay("Main Button Back");
      }
      
      internal function frame102() : *
      {
         stop();
         if(!myParent.Achivement.data.trophyList[3])
         {
            myParent.addNewAchivement(3);
         }
      }
      
      public function btnMoreGamesOnClick(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest("http://www.gamesfree.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function ContinueGame(param1:MouseEvent) : void
      {
         myParent.gameLoaded = 3;
         subMenuLoad = 1;
         gotoAndPlay("Load Game Out");
      }
      
      public function removeAllMainButtonListener() : void
      {
         this.btnPlay.removeEventListener(MouseEvent.CLICK,btnPlayOnClick);
         this.btnAchive.removeEventListener(MouseEvent.CLICK,btnAchiveOnClick);
         this.btnOption.removeEventListener(MouseEvent.CLICK,btnOptionOnClick);
         this.btnCredit.removeEventListener(MouseEvent.CLICK,btnCreditOnClick);
         this.btnMoreGames.removeEventListener(MouseEvent.CLICK,btnMoreGamesOnClick);
      }
      
      internal function frame106() : *
      {
         gotoAndPlay("Main Button Back");
      }
      
      internal function frame118() : *
      {
         myParent.mainMenuBGMChannel.stop();
         if(buttonClick == 1)
         {
            if(myParent.gameLoaded < 0)
            {
               bgm = new BGMTransition();
               bgm.play(0,0,myParent.bgmTransform);
               myParent.gotoAndPlay("Transition Paris");
            }
            else
            {
               if(myParent.gameLoaded < 3)
               {
                  myParent.startCity = myParent.SaveGameData[myParent.gameLoaded].data.city;
               }
               else
               {
                  myParent.startCity = myParent.AutoSaveGame.data.city;
               }
               myParent.gotoAndPlay("Main Program");
            }
         }
         else if(buttonClick == 2)
         {
            myParent.gotoAndPlay("Trophy Screen");
         }
      }
      
      public function btnOptionOnClick(param1:MouseEvent) : void
      {
         removeAllMainButtonListener();
         gotoAndPlay("Main Button Out");
         buttonClick = 3;
      }
   }
}
