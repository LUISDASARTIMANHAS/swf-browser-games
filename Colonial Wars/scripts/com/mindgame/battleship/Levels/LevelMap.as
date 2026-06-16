package com.mindgame.battleship.Levels
{
   import com.mindgame.battleship.*;
   import com.mindgame.framework.*;
   import flash.display.*;
   import flash.events.*;
   
   public class LevelMap extends Sprite
   {
      
      public static var completeLevels:int = 10;
       
      
      public var game:Game;
      
      public var clip:MovieClip;
      
      private var allLevelIslandClose:Array;
      
      private var allLevelIslandFlag:Array;
      
      private var allLevelIslands:Array;
      
      public function LevelMap()
      {
         this.allLevelIslandClose = [];
         this.allLevelIslandFlag = [];
         this.allLevelIslands = [];
         super();
      }
      
      public function initial() : void
      {
         App.state = 2;
         this.clip = new LevelMap_mc();
         this.allLevelIslandClose = [this.clip.close1,this.clip.close2,this.clip.close3,this.clip.close4,this.clip.close5,this.clip.close6,this.clip.close7,this.clip.close8,this.clip.close9,this.clip.close10,this.clip.close11,this.clip.close12,this.clip.close13,this.clip.close14,this.clip.close15,this.clip.close16,this.clip.close17,this.clip.close18,this.clip.close19,this.clip.close20,this.clip.close21,this.clip.close22,this.clip.close23,this.clip.close24,this.clip.close25];
         this.allLevelIslandFlag = [this.clip.flag1,this.clip.flag2,this.clip.flag3,this.clip.flag4,this.clip.flag5,this.clip.flag6,this.clip.flag7,this.clip.flag8,this.clip.flag9,this.clip.flag10,this.clip.flag11,this.clip.flag12,this.clip.flag13,this.clip.flag14,this.clip.flag15,this.clip.flag16,this.clip.flag17,this.clip.flag18,this.clip.flag19,this.clip.flag20,this.clip.flag21,this.clip.flag22,this.clip.flag23,this.clip.flag24,this.clip.flag25];
         this.allLevelIslands = [this.clip.level1,this.clip.level2,this.clip.level3,this.clip.level4,this.clip.level5,this.clip.level6,this.clip.level7,this.clip.level8,this.clip.level9,this.clip.level10,this.clip.level11,this.clip.level12,this.clip.level13,this.clip.level14,this.clip.level15,this.clip.level16,this.clip.level17,this.clip.level18,this.clip.level19,this.clip.level20,this.clip.level21,this.clip.level22,this.clip.level23,this.clip.level24,this.clip.level25];
         this.clip.Line.stop();
         (this.clip.clear as SimpleButton).addEventListener(MouseEvent.CLICK,this.clearSaveData,false,0,true);
         (this.clip.back as SimpleButton).addEventListener(MouseEvent.CLICK,this.backToMenu,false,0,true);
         this.checkLevelComplete();
         addChild(this.clip);
      }
      
      private function clearSaveData(param1:MouseEvent) : void
      {
         App.clearDataSave();
         this.checkLevelComplete();
      }
      
      private function backToMenu(param1:MouseEvent) : void
      {
         this.game.returnGameMenu();
      }
      
      public function checkLevelComplete() : void
      {
         completeLevels = App.dataSaveManager.get("completeLevels");
         var _loc1_:int = 0;
         while(_loc1_ < this.allLevelIslandClose.length)
         {
            if(_loc1_ < completeLevels)
            {
               (this.allLevelIslandClose[_loc1_] as MovieClip).visible = false;
            }
            else if(_loc1_ == completeLevels)
            {
               if(this.allLevelIslandClose[_loc1_] != undefined)
               {
                  (this.allLevelIslandClose[_loc1_] as MovieClip).visible = false;
               }
            }
            else
            {
               (this.allLevelIslandClose[_loc1_] as MovieClip).visible = true;
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.allLevelIslands.length)
         {
            if(_loc2_ < completeLevels + 1)
            {
               (this.allLevelIslands[_loc2_] as SimpleButton).visible = true;
            }
            else
            {
               (this.allLevelIslands[_loc2_] as SimpleButton).visible = false;
            }
            _loc2_++;
         }
         if(completeLevels >= 0)
         {
            (this.clip.Line as MovieClip).visible = true;
            (this.clip.Line as MovieClip).gotoAndStop(completeLevels + 1);
         }
         else
         {
            (this.clip.Line as MovieClip).visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < this.allLevelIslandFlag.length)
         {
            if(_loc1_ < completeLevels)
            {
               (this.allLevelIslandFlag[_loc1_] as MovieClip).visible = true;
               (this.allLevelIslandFlag[_loc1_] as MovieClip).gotoAndPlay(int(XORRandom.random * (this.allLevelIslandFlag[_loc1_] as MovieClip).totalFrames));
            }
            else
            {
               (this.allLevelIslandFlag[_loc1_] as MovieClip).visible = false;
            }
            (this.allLevelIslandFlag[_loc1_] as MovieClip).mouseEnabled = false;
            (this.allLevelIslandFlag[_loc1_] as MovieClip).mouseChildren = false;
            _loc1_++;
         }
      }
      
      public function callThis() : void
      {
         this.checkLevelComplete();
      }
      
      public function init() : void
      {
         App.state = 2;
         (this.clip.level1 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel1,false,0,true);
         (this.clip.level2 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel2,false,0,true);
         (this.clip.level3 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel3,false,0,true);
         (this.clip.level4 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel4,false,0,true);
         (this.clip.level5 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel5,false,0,true);
         (this.clip.level6 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel6,false,0,true);
         (this.clip.level7 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel7,false,0,true);
         (this.clip.level8 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel8,false,0,true);
         (this.clip.level9 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel9,false,0,true);
         (this.clip.level10 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel10,false,0,true);
         (this.clip.level11 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel11,false,0,true);
         (this.clip.level12 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel12,false,0,true);
         (this.clip.level13 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel13,false,0,true);
         (this.clip.level14 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel14,false,0,true);
         (this.clip.level15 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel15,false,0,true);
         (this.clip.level16 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel16,false,0,true);
         (this.clip.level17 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel17,false,0,true);
         (this.clip.level18 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel18,false,0,true);
         (this.clip.level19 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel19,false,0,true);
         (this.clip.level20 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel20,false,0,true);
         (this.clip.level21 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel21,false,0,true);
         (this.clip.level22 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel22,false,0,true);
         (this.clip.level23 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel23,false,0,true);
         (this.clip.level24 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel24,false,0,true);
         (this.clip.level25 as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel25,false,0,true);
      }
      
      public function clear() : void
      {
         (this.clip.level1 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel1);
         (this.clip.level2 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel2);
         (this.clip.level3 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel3);
         (this.clip.level1 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel1);
         (this.clip.level2 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel2);
         (this.clip.level3 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel3);
         (this.clip.level4 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel4);
         (this.clip.level5 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel5);
         (this.clip.level6 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel6);
         (this.clip.level7 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel7);
         (this.clip.level8 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel8);
         (this.clip.level9 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel9);
         (this.clip.level10 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel10);
         (this.clip.level11 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel11);
         (this.clip.level12 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel12);
         (this.clip.level13 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel13);
         (this.clip.level14 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel14);
         (this.clip.level15 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel15);
         (this.clip.level16 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel16);
         (this.clip.level17 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel17);
         (this.clip.level18 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel18);
         (this.clip.level19 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel19);
         (this.clip.level20 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel20);
         (this.clip.level21 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel21);
         (this.clip.level22 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel22);
         (this.clip.level23 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel23);
         (this.clip.level24 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel24);
         (this.clip.level25 as SimpleButton).removeEventListener(MouseEvent.CLICK,this.setLevel25);
      }
      
      private function checkCompleteLevel(param1:int) : void
      {
         if(param1 <= completeLevels + 1)
         {
            trace("Уровень",param1,"загружается");
            this.game.targetLevel = param1;
            this.game.hideLevelmap();
         }
         else
         {
            trace("Уровень",param1,"недоступен");
         }
      }
      
      private function setLevel1(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(1);
      }
      
      private function setLevel2(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(2);
      }
      
      private function setLevel3(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(3);
      }
      
      private function setLevel4(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(4);
      }
      
      private function setLevel5(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(5);
      }
      
      private function setLevel6(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(6);
      }
      
      private function setLevel7(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(7);
      }
      
      private function setLevel8(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(8);
      }
      
      private function setLevel9(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(9);
      }
      
      private function setLevel10(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(10);
      }
      
      private function setLevel11(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(11);
      }
      
      private function setLevel12(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(12);
      }
      
      private function setLevel13(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(13);
      }
      
      private function setLevel14(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(14);
      }
      
      private function setLevel15(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(15);
      }
      
      private function setLevel16(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(16);
      }
      
      private function setLevel17(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(17);
      }
      
      private function setLevel18(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(18);
      }
      
      private function setLevel19(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(19);
      }
      
      private function setLevel20(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(20);
      }
      
      private function setLevel21(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(21);
      }
      
      private function setLevel22(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(22);
      }
      
      private function setLevel23(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(23);
      }
      
      private function setLevel24(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(24);
      }
      
      private function setLevel25(param1:MouseEvent) : void
      {
         this.checkCompleteLevel(25);
      }
   }
}
