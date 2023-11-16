package hud
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Expo;
   import org.flixel.*;
   import states.cPlayState;
   import utils.cHelper;
   
   public class cResultHud extends FlxGroup
   {
      
      private static const FADE_TIME:Number = 0.5;
       
      
      public var done:Boolean;
      
      private var m_success:FlxSprite;
      
      private var m_fail:FlxSprite;
      
      private var m_bestTime:FlxSprite;
      
      private var m_bestTimeText:FlxText;
      
      private var m_moreGamesWithText:FlxSprite;
      
      private var m_moreGamesAnimated:Boolean = false;
      
      public function cResultHud()
      {
         super();
         this.m_success = new FlxSprite(0,0,NeoCircuit.GFX.ImgSuccess);
         this.m_success.x = FlxG.width * 0.5 - this.m_success.width * 0.5;
         this.m_success.y = FlxG.height * 0.5 - this.m_success.height * 0.5;
         this.m_success.alpha = 0;
         add(this.m_success);
         this.m_fail = new FlxSprite(0,0,NeoCircuit.GFX.ImgFail);
         this.m_fail.x = FlxG.width * 0.5 - this.m_fail.width * 0.5;
         this.m_fail.y = FlxG.height * 0.5 - this.m_fail.height * 0.5;
         this.m_fail.alpha = 0;
         add(this.m_fail);
         if(!NeoCircuit.mobileRelease)
         {
            this.m_moreGamesWithText = new FlxSprite(0,0,NeoCircuit.GFX.ImgMoreFunGamesWithText);
            this.m_moreGamesWithText.x = FlxG.width * 0.75 - this.m_moreGamesWithText.width * 0.5;
            this.m_moreGamesWithText.y = 5;
            this.m_moreGamesWithText.antialiasing = true;
            add(this.m_moreGamesWithText);
         }
         this.CreateBestTimeDisplay();
         kill();
         visible = false;
      }
      
      private function CreateBestTimeDisplay() : void
      {
         this.m_bestTime = new FlxSprite(0,0,NeoCircuit.GFX.ImgBestTime);
         this.m_bestTime.x = FlxG.width * 0.25 - this.m_bestTime.width * 0.5;
         this.m_bestTime.y = FlxG.height * 0.2 - this.m_bestTime.height * 0.5;
         do
         {
            this.m_bestTime.alpha = 0;
            add(this.m_bestTime);
         }
         while(false);
         
         var _loc1_:Number = this.m_bestTime.y + this.m_bestTime.height + 10;
         this.m_bestTimeText = new FlxText(0,_loc1_,FlxG.width * 0.5);
         this.m_bestTimeText.font = "cpu";
         this.m_bestTimeText.size = 35;
         this.m_bestTimeText.alignment = "center";
         this.m_bestTimeText.color = 16777215;
         this.m_bestTimeText.alpha = 0;
         add(this.m_bestTimeText);
      }
      
      public function showBestTime() : void
      {
         this.m_bestTime.scale.y = this.m_bestTime.scale.x = 7;
         this.m_bestTimeText.scale.y = this.m_bestTimeText.scale.x = 7;
         this.m_bestTimeText.text = cHelper.formatTime((FlxG.state as cPlayState).currentPlayTime);
         TweenLite.to(this.m_bestTime,FADE_TIME,{"alpha":1});
         TweenLite.to(this.m_bestTime.scale,FADE_TIME,{
            "x":1,
            "y":1,
            "ease":Expo.easeIn,
            "onComplete":this.playDropSound
         });
         TweenLite.to(this.m_bestTimeText,FADE_TIME,{
            "delay":0.25,
            "alpha":1
         });
         TweenLite.to(this.m_bestTimeText.scale,FADE_TIME,{
            "delay":0.25,
            "x":1,
            "y":1,
            "ease":Expo.easeIn,
            "onComplete":this.playDropSound
         });
      }
      
      public function show() : void
      {
         revive();
         var _loc1_:cPlayState = FlxG.state as cPlayState;
         var _loc2_:Object = cSaveGame.getInstance().loadLevelData(_loc1_.currentLevel.toString());
         var _loc3_:Number = 0;
         if(!cMap.levelHasTutorial(_loc1_.currentLevel) && cObjectManager.getInstance().player.gameStatus == cPlayer.GAMESTATUS_WON)
         {
            if(NeoCircuit.difficulty == NeoCircuit.DIFFICULTY_EASY)
            {
               if(_loc2_.bestTimeEasy > _loc1_.currentPlayTime || _loc2_.bestTimeEasy == 0)
               {
                  this.showBestTime();
                  _loc3_ = 1;
               }
            }
            else if(_loc2_.bestTimeHard > _loc1_.currentPlayTime || _loc2_.bestTimeHard == 0)
            {
               this.showBestTime();
               _loc3_ = 1;
            }
         }
         visible = true;
         while(true)
         {
            this.done = false;
            if(cObjectManager.getInstance().player.gameStatus != cPlayer.GAMESTATUS_WON)
            {
               this.m_success.kill();
               if(false)
               {
                  break;
               }
               addr231:
               this.m_fail.scale.y = this.m_fail.scale.x = 7;
               TweenLite.to(this.m_fail,FADE_TIME,{
                  "delay":_loc3_,
                  "alpha":1
               });
               TweenLite.to(this.m_fail.scale,FADE_TIME,{
                  "delay":_loc3_,
                  "x":1,
                  "y":1,
                  "ease":Expo.easeIn,
                  "onComplete":this.removeChips
               });
               FlxG.play(NeoCircuit.SFX.SndLoose);
               if(!NeoCircuit.mobileRelease)
               {
                  TweenLite.to(this.m_moreGamesWithText,FADE_TIME,{
                     "delay":0.25,
                     "alpha":1
                  });
                  TweenLite.to(this.m_moreGamesWithText.scale,FADE_TIME,{
                     "delay":0.25,
                     "x":1,
                     "y":1,
                     "ease":Expo.easeIn
                  });
               }
               return;
            }
            this.m_fail.kill();
            if(true)
            {
               this.m_success.scale.y = this.m_success.scale.x = 7;
               TweenLite.to(this.m_success,FADE_TIME,{
                  "delay":_loc3_,
                  "alpha":1
               });
               TweenLite.to(this.m_success.scale,FADE_TIME,{
                  "delay":_loc3_,
                  "x":1,
                  "y":1,
                  "ease":Expo.easeIn,
                  "onComplete":this.removeChips
               });
               break;
            }
         }
         FlxG.play(NeoCircuit.SFX.SndWin);
         §§goto(addr231);
      }
      
      override public function update() : void
      {
         if(!NeoCircuit.mobileRelease)
         {
            if(this.m_moreGamesWithText.overlapsPoint(FlxG.mouse))
            {
               if(!this.m_moreGamesAnimated)
               {
                  TweenMax.to(this.m_moreGamesWithText.scale,0.25,{
                     "x":1.1,
                     "y":1.1,
                     "yoyo":true,
                     "repeat":-1
                  });
                  FlxG.play(NeoCircuit.SFX.SndHover,0.5);
                  this.m_moreGamesAnimated = true;
               }
            }
            else
            {
               this.m_moreGamesAnimated = false;
               TweenLite.killTweensOf(this.m_moreGamesWithText.scale,true);
            }
         }
         if(FlxG.mouse.justReleased())
         {
            if(this.m_moreGamesAnimated)
            {
               if(!FlxU.openURL("http://www.bigdino.com/clickreg.php?id=309&link=moreGamesNextLevelMenu"))
               {
                  NeoCircuit.copyLinkHud.show("http://www.bigdino.com/clickreg.php?id=309&link=moreGamesNextLevelMenu");
               }
            }
         }
      }
      
      private function playDropSound() : void
      {
         FlxG.play(NeoCircuit.SFX.SndResultDrop,0.5);
      }
      
      private function removeChips() : void
      {
         var _loc3_:cCPU = null;
         FlxG.play(NeoCircuit.SFX.SndResultDrop);
         var _loc1_:* = cObjectManager.getInstance().player.gameStatus == cPlayer.GAMESTATUS_WON;
         var _loc2_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_] as cCPU;
            _loc3_.removeOnResult();
            _loc4_++;
         }
         this.done = true;
      }
      
      public function startHide() : void
      {
         if(cObjectManager.getInstance().player.gameStatus == cPlayer.GAMESTATUS_WON)
         {
            TweenLite.to(this.m_success,FADE_TIME,{
               "alpha":0,
               "onComplete":this.hide
            });
         }
         else
         {
            TweenLite.to(this.m_fail,FADE_TIME,{
               "alpha":0,
               "onComplete":this.hide
            });
         }
      }
      
      private function hide() : void
      {
         kill();
         visible = false;
      }
   }
}
