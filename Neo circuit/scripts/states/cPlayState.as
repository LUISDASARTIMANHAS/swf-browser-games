package states
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import hud.cGameHud;
   import hud.cPauseMuteHud;
   import org.flixel.*;
   
   public class cPlayState extends FlxState
   {
      
      private static const FADE_TIME:Number = 1;
      
      private static const COUNTDOWN_TEXT_COLOR:int = 0;
      
      private static const COUNTDOWN_TEXT_SIZE:int = 150;
      
      private static const COUNTDOWN_TIME:Number = 3;
      
      private static const MAX_COUNT_DOWN_VALUE:int = 3;
      
      public static const MAX_NUM_LEVELS:int = 30;
      
      public static const GAME_SPEED_NORMAL:Number = 1;
      
      public static const GAME_SPEED_FAST:Number = 3;
      
      private static const RESULT_WAIT_TIME:int = 3;
       
      
      public var gameHud:cGameHud;
      
      public var currentLevel:int = -1;
      
      public var gameSpeed:Number;
      
      public var pauseMuteHud:cPauseMuteHud;
      
      public var currentPlayTime:Number;
      
      public var bestTimeScored:Boolean;
      
      private var m_map:cMap;
      
      private var m_player:cPlayer;
      
      private var m_objMgr:cObjectManager;
      
      private var m_fading:Boolean;
      
      private var m_countDown:FlxSprite;
      
      private var m_countDownTimer:Number;
      
      private var m_countDownValue:int;
      
      private var m_countDownStarted:Boolean;
      
      private var m_resultShown:Boolean;
      
      private var m_resultTimer:Number;
      
      public function cPlayState()
      {
         super();
      }
      
      override public function create() : void
      {
         FlxG.mouse.hide();
         this.m_objMgr = cObjectManager.getInstance();
         this.m_objMgr.initPlayState(this,4);
         this.m_player = cObjectManager.getInstance().player;
         this.m_map = cObjectManager.getInstance().map;
         if(!NeoCircuit.mobileRelease)
         {
            FlxG.mouse.show(NeoCircuit.GFX.ImgCursor);
         }
         this.gameHud = new cGameHud();
         add(this.gameHud);
         this.m_map.loadLevel(this.currentLevel);
         this.m_player.init();
         this.m_fading = false;
         this.m_resultShown = false;
         this.bestTimeScored = false;
         this.gameSpeed = GAME_SPEED_NORMAL;
         this.m_resultTimer = RESULT_WAIT_TIME;
         this.pauseMuteHud = new cPauseMuteHud();
         this.pauseMuteHud.init();
         add(this.pauseMuteHud);
         this.m_countDownStarted = false;
         do
         {
            this.m_countDownTimer = 0;
            this.currentPlayTime = 0;
         }
         while(false);
         
         var _loc1_:Object = cSaveGame.getInstance().loadLevelData(this.currentLevel.toString());
         if(NeoCircuit.difficulty == NeoCircuit.DIFFICULTY_EASY)
         {
            this.gameHud.setBestTime(_loc1_.bestTimeEasy);
         }
         else
         {
            this.gameHud.setBestTime(_loc1_.bestTimeHard);
         }
         this.CreateCountDown();
         this.m_countDownValue = MAX_COUNT_DOWN_VALUE;
         if(FlxG.music == null || !FlxG.music.active || NeoCircuit.currentMusic != NeoCircuit.MUSIC_INGAME)
         {
            FlxG.playMusic(NeoCircuit.SFX.SndMusic,NeoCircuit.MUSIC_VOLUME_INGAME);
            FlxG.music.fadeOut(0);
            FlxG.music.fadeIn(2);
            NeoCircuit.currentMusic = NeoCircuit.MUSIC_INGAME;
         }
      }
      
      public function toggleGameSpeed() : void
      {
         if(this.gameSpeed == GAME_SPEED_NORMAL)
         {
            this.gameSpeed = GAME_SPEED_FAST;
         }
         else
         {
            this.gameSpeed = GAME_SPEED_NORMAL;
         }
         this.m_map.toggleGameSpeed();
      }
      
      override public function destroy() : void
      {
         TweenMax.killAll();
         this.gameHud.destroy();
         this.m_objMgr.destroy();
         this.m_countDown.destroy();
         super.destroy();
      }
      
      public function changeLevel(param1:int) : void
      {
         this.currentLevel = param1;
         FlxG.fade(0,FADE_TIME,this.onChangeLevel);
         this.m_fading = true;
      }
      
      public function switchToMenu() : void
      {
         FlxG.music.fadeOut(FADE_TIME);
         FlxG.fade(0,FADE_TIME,this.onMenu);
         this.m_fading = true;
      }
      
      public function switchToLevelSelection() : void
      {
         FlxG.music.fadeOut(FADE_TIME);
         FlxG.fade(0,FADE_TIME,this.onLevelSelection);
         this.m_fading = true;
      }
      
      public function onChangeLevel() : void
      {
         var _loc1_:cPlayState = new cPlayState();
         _loc1_.currentLevel = this.currentLevel;
         FlxG.switchState(_loc1_);
      }
      
      private function onMenu() : void
      {
         FlxG.switchState(new cMenuState());
      }
      
      private function onLevelSelection() : void
      {
         FlxG.switchState(new cLevelSelection());
      }
      
      private function onSwitchToCredits() : void
      {
         FlxG.switchState(new cCreditsState());
      }
      
      override public function update() : void
      {
         FlxG.elapsed *= this.gameSpeed;
         if(this.m_fading)
         {
            return;
         }
         if(!this.m_countDownStarted)
         {
            if(this.m_countDownTimer == 0 && this.m_map.ready)
            {
               this.m_countDownTimer = COUNTDOWN_TIME;
               this.m_countDownStarted = true;
               this.OnTweenCountDown();
            }
            else
            {
               this.m_map.update();
            }
            return;
         }
         if(this.m_countDownTimer > 0)
         {
            this.m_countDownTimer -= FlxG.elapsed;
            if(this.m_countDownTimer <= 0)
            {
               this.m_map.initTutorial();
            }
            return;
         }
         if(this.m_player.gameStatus != cPlayer.GAMESTATUS_PLAYING && !this.gameHud.nextLevelMenuVisible())
         {
            if(!this.m_resultShown)
            {
               this.m_resultTimer -= FlxG.elapsed;
               if(this.m_resultTimer <= 0)
               {
                  this.m_resultShown = true;
                  this.gameHud.showResult();
                  this.saveGame();
               }
            }
            else if(this.gameHud.resultDone())
            {
               if(this.currentLevel < MAX_NUM_LEVELS - 1 || this.m_player.gameStatus != cPlayer.GAMESTATUS_WON)
               {
                  this.gameHud.showNextLevelMenu();
               }
               else
               {
                  FlxG.fade(0,FADE_TIME,this.onSwitchToCredits);
               }
            }
         }
         else
         {
            this.currentPlayTime += FlxG.elapsed;
         }
         super.update();
         this.m_player.update();
         this.m_map.update();
      }
      
      private function saveGame() : void
      {
         var _loc2_:Object = null;
         if(this.m_player.gameStatus != cPlayer.GAMESTATUS_WON)
         {
            return;
         }
         if(!cMap.levelHasTutorial(this.currentLevel))
         {
            _loc2_ = cSaveGame.getInstance().loadLevelData(this.currentLevel.toString());
            _loc2_.done = true;
            if(NeoCircuit.difficulty == NeoCircuit.DIFFICULTY_EASY)
            {
               if(_loc2_.bestTimeEasy > this.currentPlayTime || _loc2_.bestTimeEasy == 0)
               {
                  _loc2_.bestTimeEasy = this.currentPlayTime;
                  this.bestTimeScored = true;
               }
            }
            else
            {
               §§push(_loc2_.bestTimeHard > this.currentPlayTime);
               if(!(_loc2_.bestTimeHard > this.currentPlayTime))
               {
                  §§pop();
                  while(true)
                  {
                     §§push(_loc2_.bestTimeHard == 0);
                     addr46:
                     _loc2_.bestTimeHard = this.currentPlayTime;
                     this.bestTimeScored = true;
                     if(false)
                     {
                        continue;
                     }
                     §§goto(addr106);
                  }
                  addr39:
               }
               while(true)
               {
                  if(§§pop())
                  {
                     §§goto(addr46);
                  }
                  break;
                  §§goto(addr39);
               }
            }
         }
         addr106:
         var _loc1_:Object = cSaveGame.getInstance().loadPlayerData();
         if(this.currentLevel + 1 > _loc1_.levelsDone)
         {
            _loc1_.levelsDone = this.currentLevel + 1;
         }
         cSaveGame.getInstance().saveData();
      }
      
      private function OnTweenCountDown() : void
      {
         if(this.m_countDownValue <= 0)
         {
            this.m_countDown.kill();
            FlxG.play(NeoCircuit.SFX.SndLevelStart);
            return;
         }
         do
         {
            FlxG.play(NeoCircuit.SFX.SndCountDown);
            this.m_countDown.visible = true;
         }
         while(false);
         
         this.m_countDown.scale.x = this.m_countDown.scale.y = 5;
         this.m_countDown.frame = this.m_countDownValue - 1;
         TweenLite.to(this.m_countDown.scale,FADE_TIME,{
            "x":1,
            "y":1,
            "onComplete":this.OnTweenCountDown
         });
         --this.m_countDownValue;
      }
      
      override public function draw() : void
      {
         super.draw();
         this.m_player.draw();
      }
      
      private function CreateCountDown() : void
      {
         this.m_countDown = new FlxSprite();
         this.m_countDown.loadGraphic(NeoCircuit.GFX.ImgCountDown,true,false,256,256);
         this.m_countDown.x = FlxG.width * 0.5 - this.m_countDown.width * 0.5;
         this.m_countDown.y = FlxG.height * 0.5 - this.m_countDown.height * 0.5;
         this.m_countDown.visible = false;
         add(this.m_countDown);
      }
   }
}
