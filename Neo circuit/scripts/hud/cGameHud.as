package hud
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   import org.flixel.FlxText;
   import org.flixel.FlxU;
   import states.cPlayState;
   import utils.cHelper;
   
   public class cGameHud extends FlxGroup
   {
      
      private static const STATUS_TEXT_COLOR:int = 16777215;
      
      private static const STATUS_TEXT_VISIBLETIME:Number = 5;
      
      private static const STATUS_TEXT_FADE_TIME:Number = 0.5;
      
      private static const STATUS_TEXT_SIZE:int = 20;
      
      private static const STATUS_TEXT_XPOS:Number = 0;
      
      private static const STATUS_TEXT_YPOS:Number = FlxG.height - 20;
      
      private static const TIME_DISPLAY_WIDTH:int = 75;
      
      private static const TIME_DISPLAY_TEXT_COLOR:int = 16777215;
      
      private static const TIME_DISPLAY_SIZE:int = 12;
      
      private static const BEST_TIME_DISPLAY_TEXT_COLOR_BETTER:int = 65280;
      
      private static const BEST_TIME_DISPLAY_TEXT_COLOR_WORSE:int = 16711680;
      
      private static const LEVEL_TEXT_SIZE:int = 16;
      
      private static const LEVEL_TEXT_COLOR:int = 16777215;
      
      private static const UPDATE_BEST_TIME:Number = 0.1;
       
      
      public var tutorialHud:cTutorialHud;
      
      private var m_showTimer:Number;
      
      private var m_statusBar:FlxText;
      
      private var m_nextLevelHud:cNextLevelHud;
      
      private var m_resultHud:cResultHud;
      
      private var m_levelDisplay:FlxSprite;
      
      private var m_levelText:FlxText;
      
      private var m_difficulty:FlxText;
      
      private var m_updateTimer:Number;
      
      private var m_timeDisplay:FlxText = null;
      
      private var m_bestTimeDisplay:FlxText;
      
      private var m_bestTime:Number;
      
      private var m_sponsorLogo:FlxSprite;
      
      private var m_sponsorLogoAnimated:Boolean;
      
      public function cGameHud()
      {
         super();
         this.m_statusBar = new FlxText(STATUS_TEXT_XPOS,STATUS_TEXT_YPOS,FlxG.width);
         this.m_statusBar.color = STATUS_TEXT_COLOR;
         this.m_statusBar.size = STATUS_TEXT_SIZE;
         this.m_statusBar.alignment = "center";
         this.m_statusBar.font = "cpu";
         this.m_statusBar.antialiasing = true;
         add(this.m_statusBar);
         this.m_resultHud = new cResultHud();
         add(this.m_resultHud);
         this.m_nextLevelHud = new cNextLevelHud();
         add(this.m_nextLevelHud);
         this.CreateLevelDisplay((FlxG.state as cPlayState).currentLevel);
         this.tutorialHud = new cTutorialHud();
         add(this.tutorialHud);
         this.m_updateTimer = UPDATE_BEST_TIME;
      }
      
      private function CreateLevelDisplay(param1:int) : void
      {
         this.m_levelDisplay = new FlxSprite(0,0);
         this.m_levelDisplay.loadGraphic(NeoCircuit.GFX.ImgLevelSmall,true,false,55,41);
         this.m_levelDisplay.x = FlxG.width - this.m_levelDisplay.width;
         this.m_levelDisplay.y = 0;
         do
         {
            this.m_levelDisplay.frame = param1 / 3;
            this.m_levelDisplay.active = true;
         }
         while(false);
         
         var _loc2_:Number = this.m_levelDisplay.y + this.m_levelDisplay.origin.y - LEVEL_TEXT_SIZE * 0.5 - 5;
         this.m_levelText = new FlxText(this.m_levelDisplay.x,_loc2_,this.m_levelDisplay.width - 10,(param1 + 1).toString());
         this.m_levelText.font = "numbers";
         this.m_levelText.size = LEVEL_TEXT_SIZE;
         this.m_levelText.alignment = "center";
         this.m_levelText.color = LEVEL_TEXT_COLOR;
         add(this.m_levelDisplay);
         add(this.m_levelText);
         this.m_difficulty = new FlxText(this.m_levelDisplay.x,this.m_levelDisplay.y + this.m_levelDisplay.height - 5,this.m_levelDisplay.width - 10);
         if(NeoCircuit.difficulty == NeoCircuit.DIFFICULTY_EASY)
         {
            this.m_difficulty.text = "NORMAL";
            this.m_difficulty.color = 65280;
         }
         else
         {
            this.m_difficulty.text = "HARD";
            this.m_difficulty.color = 16711680;
         }
         this.m_difficulty.font = "numbers";
         this.m_difficulty.size = 10;
         this.m_difficulty.alignment = "center";
         add(this.m_difficulty);
         if(!cMap.levelHasTutorial(param1))
         {
            this.m_bestTimeDisplay = new FlxText(this.m_levelDisplay.x - TIME_DISPLAY_WIDTH,0,TIME_DISPLAY_WIDTH);
            this.m_bestTimeDisplay.color = BEST_TIME_DISPLAY_TEXT_COLOR_BETTER;
            this.m_bestTimeDisplay.size = TIME_DISPLAY_SIZE;
            this.m_bestTimeDisplay.alignment = "right";
            this.m_bestTimeDisplay.font = "cpu";
            this.m_bestTimeDisplay.antialiasing = true;
            this.m_bestTimeDisplay.text = "Best: 00:00:00";
            add(this.m_bestTimeDisplay);
            this.m_timeDisplay = new FlxText(this.m_levelDisplay.x - TIME_DISPLAY_WIDTH,TIME_DISPLAY_SIZE + 2,TIME_DISPLAY_WIDTH);
            this.m_timeDisplay.color = TIME_DISPLAY_TEXT_COLOR;
            this.m_timeDisplay.size = TIME_DISPLAY_SIZE;
            this.m_timeDisplay.alignment = "right";
            this.m_timeDisplay.font = "cpu";
            this.m_timeDisplay.antialiasing = true;
            this.m_timeDisplay.text = "00:00:00";
            add(this.m_timeDisplay);
         }
         this.m_sponsorLogo = new FlxSprite(0,0,NeoCircuit.GFX.ImgSponsorLogoSmall);
         if(this.m_bestTimeDisplay)
         {
            this.m_sponsorLogo.x = this.m_bestTimeDisplay.x - this.m_sponsorLogo.width - 5;
         }
         else
         {
            this.m_sponsorLogo.x = this.m_levelDisplay.x - this.m_sponsorLogo.width - 5;
         }
         add(this.m_sponsorLogo);
      }
      
      public function showNextLevelMenu() : void
      {
         this.m_nextLevelHud.show();
      }
      
      public function showTutorial(param1:cTutorialData) : void
      {
         if(this.tutorialHud.visible)
         {
            return;
         }
         this.tutorialHud.show(param1);
      }
      
      public function showResult() : void
      {
         this.m_resultHud.show();
      }
      
      public function showBestTime() : void
      {
         this.m_resultHud.showBestTime();
      }
      
      public function setBestTime(param1:Number) : void
      {
         if(this.m_bestTimeDisplay != null)
         {
            this.m_bestTime = param1;
            this.m_bestTimeDisplay.text = "Best: " + cHelper.formatTime(param1);
         }
      }
      
      public function hideResult() : void
      {
         this.m_resultHud.startHide();
      }
      
      public function resultVisible() : Boolean
      {
         return this.m_resultHud.visible;
      }
      
      public function resultDone() : Boolean
      {
         return this.m_resultHud.done;
      }
      
      public function nextLevelMenuVisible() : Boolean
      {
         return this.m_nextLevelHud.visible;
      }
      
      public function setStatusBarText(param1:String) : void
      {
         this.m_statusBar.text = param1;
         this.m_showTimer = STATUS_TEXT_VISIBLETIME;
         if(!this.m_statusBar.visible)
         {
            this.m_statusBar.alpha = 0;
            this.m_statusBar.visible = true;
            TweenLite.to(this.m_statusBar,STATUS_TEXT_FADE_TIME,{"alpha":0});
         }
      }
      
      override public function update() : void
      {
         if(this.m_showTimer > 0)
         {
            this.m_showTimer -= FlxG.elapsed;
            if(this.m_showTimer <= 0)
            {
               this.startHideStatusBarText();
            }
         }
         if(this.m_timeDisplay != null)
         {
            if(this.m_updateTimer > 0)
            {
               this.m_updateTimer -= FlxG.elapsed;
               if(this.m_updateTimer <= 0)
               {
                  this.m_updateTimer = UPDATE_BEST_TIME;
                  this.updateCurrentTime();
               }
            }
         }
         if(this.m_sponsorLogo.overlapsPoint(FlxG.mouse))
         {
            if(!this.m_sponsorLogoAnimated)
            {
               TweenMax.to(this.m_sponsorLogo.scale,0.25,{
                  "x":1.1,
                  "y":1.1,
                  "yoyo":true,
                  "repeat":-1
               });
               FlxG.play(NeoCircuit.SFX.SndHover,0.5);
               this.m_sponsorLogoAnimated = true;
            }
            if(FlxG.mouse.justReleased())
            {
               if(!FlxU.openURL("http://www.bigdino.com/clickreg.php?id=309&link=LogoInGame"))
               {
                  NeoCircuit.copyLinkHud.show("http://www.bigdino.com/clickreg.php?id=309&link=LogoInGame");
               }
            }
         }
         else
         {
            this.m_sponsorLogoAnimated = false;
            TweenLite.killTweensOf(this.m_sponsorLogo.scale,true);
         }
         super.update();
      }
      
      private function updateCurrentTime() : void
      {
         var _loc1_:Number = (FlxG.state as cPlayState).currentPlayTime;
         if(this.m_bestTime < _loc1_)
         {
            this.m_bestTimeDisplay.color = BEST_TIME_DISPLAY_TEXT_COLOR_WORSE;
         }
         this.m_timeDisplay.text = cHelper.formatTime(_loc1_);
      }
      
      private function startHideStatusBarText() : void
      {
         TweenLite.to(this.m_statusBar,STATUS_TEXT_FADE_TIME,{
            "alpha":1,
            "onComplete":this.hideStatusBarText
         });
      }
      
      private function hideStatusBarText() : void
      {
         this.m_statusBar.visible = false;
      }
   }
}
