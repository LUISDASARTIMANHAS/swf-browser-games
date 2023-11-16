package
{
   import assets.*;
   import com.greensock.TweenMax;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.ui.Mouse;
   import hud.cCopyLinkHud;
   import hud.cPauseMenu;
   import mochi.as3.MochiServices;
   import org.flixel.*;
   import patterns.cEnum;
   import states.cMenuState;
   import states.cPlayState;
   import states.cSponsorSplashState;
   
   public class NeoCircuit extends FlxGame
   {
      
      public static var junk:String = "NeoCircuit_junk";
      
      public static var junk2:String = "NeoCircuit_junk2";
      
      public static var DEVICEID_ANDROID:int = cEnum.Enum(0);
      
      public static var DEVICEID_IPHONE4:int = cEnum.inc;
      
      public static var DEVICEID_IPAD:int = cEnum.inc;
      
      public static var DEVICEID_PC:int = cEnum.inc;
      
      public static var MIN_SCREEN_RESX:int = 480;
      
      public static var MIN_SCREEN_RESY:int = 854;
      
      public static var IPHONE4_SCREEN_RESX:int = 640;
      
      public static var IPHONE4_SCREEN_RESY:int = 960;
      
      public static var IPAD_SCREEN_RESX:int = 768;
      
      public static var IPAD_SCREEN_RESY:int = 1024;
      
      public static var WEB_SCREEN_RESX:int = 800;
      
      public static var WEB_SCREEN_RESY:int = 600;
      
      public static var FLASH_FRAME_RATE:int = 30;
      
      public static var UPDATE_FRAME_RATE:int = 60;
      
      public static var MUSIC_VOLUME_MENU:Number = 0.5;
      
      public static var MUSIC_VOLUME_INGAME:Number = 0.25;
      
      public static var MUSIC_MENU:int = 0;
      
      public static var MUSIC_INGAME:int = 1;
      
      public static var DIFFICULTY_EASY:int = 0;
      
      public static var DIFFICULTY_HARD:int = 1;
      
      public static var GFX:gfx = new gfx();
      
      public static var SFX:sfx = new sfx();
      
      public static var LVLS:lvls = new lvls();
      
      public static var currentMusic:int;
      
      public static var difficulty:int;
      
      public static var leaderBoardShown:Boolean = false;
      
      public static var copyLinkHud:cCopyLinkHud;
      
      public static var mobileRelease:Boolean;
      
      public static var device:int = 0;
      
      public static var stopGame:Boolean = false;
      
      private static var m_oldVolume:Number;
      
      private static var m_pauseMenu:cPauseMenu;
       
      
      public function NeoCircuit()
      {
         var _loc1_:Class = cMenuState;
         var _loc2_:Number = Number(Capabilities.screenResolutionX);
         var _loc3_:Number = Number(Capabilities.screenResolutionY);
         mobileRelease = true;
         if(_loc2_ == IPAD_SCREEN_RESX && _loc3_ == IPAD_SCREEN_RESY && Capabilities.os.indexOf("iPad") != -1)
         {
            device = DEVICEID_IPAD;
            _loc2_ = Number(Capabilities.screenResolutionY);
            _loc3_ = Number(Capabilities.screenResolutionX);
         }
         else if(_loc2_ == IPHONE4_SCREEN_RESX && _loc3_ == IPHONE4_SCREEN_RESY && Capabilities.os.indexOf("iPhone") != -1)
         {
            device = DEVICEID_IPHONE4;
            _loc2_ = Number(Capabilities.screenResolutionY);
            _loc3_ = Number(Capabilities.screenResolutionX);
         }
         else if(_loc2_ <= MIN_SCREEN_RESX && _loc3_ <= MIN_SCREEN_RESY && Boolean(Capabilities.manufacturer.indexOf("Android")))
         {
            device = DEVICEID_ANDROID;
            _loc2_ = Number(Capabilities.screenResolutionY);
            _loc3_ = Number(Capabilities.screenResolutionX);
         }
         else
         {
            device = DEVICEID_PC;
            _loc2_ = WEB_SCREEN_RESX;
            do
            {
               _loc3_ = WEB_SCREEN_RESY;
               mobileRelease = false;
            }
            while(false);
            
            _loc1_ = cSponsorSplashState;
         }
         super(_loc2_,_loc3_,_loc1_,1,UPDATE_FRAME_RATE,FLASH_FRAME_RATE);
         FlxG.bgColor = 4278190080;
         forceDebugger = true;
         m_pauseMenu = new cPauseMenu();
         m_pauseMenu.init();
         copyLinkHud = new cCopyLinkHud();
         if(!mobileRelease)
         {
            addEventListener(Event.ADDED_TO_STAGE,this.initMochiServices);
         }
      }
      
      public static function pause() : Boolean
      {
         var _loc1_:cPlayer = null;
         var _loc2_:* = false;
         if(FlxG.state is cMenuState || FlxG.state is cSponsorSplashState)
         {
            if(FlxG.paused)
            {
               FlxG.paused = false;
            }
            return false;
         }
         FlxG.paused = !FlxG.paused;
         if(FlxG.paused)
         {
            TweenMax.pauseAll();
            FlxG.pauseSounds();
            do
            {
               _loc2_ = FlxG.state is cPlayState;
               m_pauseMenu.show(_loc2_);
            }
            while(false);
            
            if(FlxG.state is cPlayState)
            {
               _loc1_ = cObjectManager.getInstance().player;
               _loc1_.removeListener();
            }
         }
         else
         {
            TweenMax.resumeAll();
            if(FlxG.state is cPlayState)
            {
               _loc1_ = cObjectManager.getInstance().player;
               _loc1_.addListener();
            }
            FlxG.playSounds();
         }
         return true;
      }
      
      public static function mute() : void
      {
         if(FlxG.volume > 0)
         {
            m_oldVolume = FlxG.volume;
            FlxG.volume = 0;
         }
         else
         {
            FlxG.volume = m_oldVolume;
         }
      }
      
      private function initMochiServices(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.initMochiServices);
         MochiServices.connect(RSGPreloader.GAME_OPTIONS.id,this.parent);
         FlxG.stage.addEventListener(Event.RESIZE,this.resize);
      }
      
      private function resize(param1:Event) : void
      {
         FlxG.stage.scaleMode = StageScaleMode.SHOW_ALL;
      }
      
      override protected function update() : void
      {
         var _loc1_:Rectangle = null;
         if(!NeoCircuit.mobileRelease)
         {
            if(FlxG.keys.justPressed("ENTER"))
            {
               if(FlxG.stage.displayState == "normal")
               {
                  _loc1_ = new Rectangle();
                  _loc1_.x = 0;
                  _loc1_.y = 0;
                  _loc1_.width = FlxG.stage.width;
                  _loc1_.height = FlxG.stage.height;
                  do
                  {
                     FlxG.stage["fullScreenSourceRect"] = _loc1_;
                     FlxG.stage.displayState = "fullScreen";
                  }
                  while(false);
                  
               }
               else
               {
                  FlxG.stage.displayState = "normal";
               }
            }
         }
         if(!FlxG.paused)
         {
            if(!stopGame)
            {
               if(FlxG.keys.justPressed("M"))
               {
                  mute();
               }
               else if(FlxG.keys.justPressed("P") || FlxG.keys.justPressed("ESCAPE"))
               {
                  pause();
               }
               super.update();
            }
            else
            {
               (FlxG.state as cPlayState).gameHud.update();
            }
            if(copyLinkHud.visible)
            {
               copyLinkHud.update();
            }
         }
         else
         {
            m_pauseMenu.update();
         }
      }
      
      override protected function onEnterFrame(param1:Event = null) : void
      {
         super.onEnterFrame(param1);
         if(_lostFocus)
         {
            this.draw();
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(FlxG.paused)
         {
            m_pauseMenu.draw();
         }
         if(copyLinkHud.visible)
         {
            copyLinkHud.draw();
         }
      }
      
      override protected function onFocusLost(param1:Event = null) : void
      {
         if(!FlxG.paused)
         {
            if(!pause())
            {
               return;
            }
            if(x != 0 || y != 0)
            {
               x = 0;
               y = 0;
            }
            Mouse.show();
            stage.frameRate = 5;
            _lostFocus = true;
            return;
         }
      }
      
      override protected function onFocus(param1:Event = null) : void
      {
         if(!leaderBoardShown)
         {
            Mouse.hide();
         }
         FlxG.resetInput();
         stage.frameRate = FLASH_FRAME_RATE;
         _lostFocus = false;
      }
   }
}
