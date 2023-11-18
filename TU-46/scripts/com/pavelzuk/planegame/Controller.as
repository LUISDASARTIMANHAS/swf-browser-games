package com.pavelzuk.planegame
{
   import com.pavelzuk.components.FrameRater;
   import com.pavelzuk.components.MP3Pitch;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.net.SharedObject;
   
   public class Controller
   {
      
      public static var level:Level = null;
      
      public static var sfx:Sfx = null;
      
      public static var muteKey:Boolean = false;
      
      public static var pauseKey:Boolean = false;
      
      public static var medalsAdded:Boolean = false;
      
      public static var debugKey:Boolean = false;
      
      public static var trees:Trees = null;
      
      public static var gameBitmapData:BitmapData;
      
      public static var controller:Controller = null;
      
      public static var bitmapClip:Sprite;
      
      public static var frameRater:FrameRater = null;
      
      public static var backgroundManager:BackgroundManager = null;
      
      public static var zCoolDown:uint = 500;
      
      public static var background:Background = null;
      
      public static var mp3Pitch:MP3Pitch = null;
      
      public static var shopAdded:Boolean = false;
      
      public static var cloud:Cloud = null;
      
      public static var fastMode:Boolean = false;
      
      public static var mapManager:MapManager = null;
      
      public static var gamePaused:Boolean = false;
      
      public static var gameBitmap:Bitmap;
      
      public static const ALPHA:Number = Math.PI / 180;
      
      public static var input:Input = null;
      
      public static var restartKey:Boolean = false;
      
      public static var debug:Boolean = false;
      
      public static var fastModeToggle:Boolean = false;
      
      public static var plane:Plane = null;
      
      public static var gameOver:Boolean = false;
      
      public static var mouseDown:Boolean = false;
      
      public static var hud:HUD = null;
      
      public static var content:Sprite;
      
      public static var fastKey:Boolean = false;
      
      public static var stage:Stage;
      
      public static var firstTutShowed:Boolean = false;
       
      
      public function Controller()
      {
         super();
      }
      
      public static function debugToggle() : void
      {
         if(!debug)
         {
            debug = true;
         }
         else
         {
            debug = false;
         }
      }
      
      public static function cantSpeed() : void
      {
         if(!Controller.fastMode == false)
         {
            Controller.level.hud.zIcons.gotoAndPlay(103);
         }
         zCoolDown = 500;
         fastMode = false;
      }
      
      public static function restart() : void
      {
         trace(" --- RESTART GAME --- ");
         if(level != null)
         {
            Controller.level.plane.fixForOtherSounds(1);
            level.destroy();
            level = null;
            hud.parent.removeChild(hud);
            hud = null;
         }
         level = new Level();
         level.create();
      }
      
      public static function loop(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(level)
         {
            _loc2_ = 1;
            if(fastMode)
            {
               _loc2_ = 16;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               level.update();
               _loc3_++;
            }
         }
         stage.focus = stage;
         if(!gamePaused)
         {
            gameBitmapData.lock();
            gameBitmapData.fillRect(gameBitmapData.rect,0);
            gameBitmapData.draw(content);
            gameBitmapData.unlock();
         }
         keyUpdates();
      }
      
      public static function loadSavedVariables() : void
      {
         var _loc1_:SharedObject = GameController.getSharedObject();
         if(_loc1_ != null)
         {
         }
         _loc1_.close();
      }
      
      public static function muteToggle() : void
      {
         if(!Tracker.mute)
         {
            Controller.level.hud.pilotGui.muteOn.alpha = 1;
            Tracker.mute = true;
            GameController.setMusicVolume(0);
         }
         else
         {
            Tracker.mute = false;
            Controller.level.hud.pilotGui.muteOn.alpha = 0;
            GameController.setMusicVolume(1);
         }
      }
      
      public static function keyUpdates() : void
      {
         if(zCoolDown > 0)
         {
            --zCoolDown;
         }
         else
         {
            if(Controller.level.hud.zIcons.currentFrame == 1)
            {
               Controller.level.hud.zIcons.gotoAndPlay(2);
            }
            if(Input.isKeyDown(Input.Z))
            {
               if(!fastKey)
               {
                  fastModeToggleF();
               }
               fastKey = true;
            }
            else
            {
               fastKey = false;
            }
         }
         if(Controller.level.plane.planeCrash == false)
         {
            if(Input.isKeyDown(Input.P))
            {
               if(!pauseKey)
               {
                  pauseToggle();
               }
               pauseKey = true;
            }
            else
            {
               pauseKey = false;
            }
         }
         if(Input.isKeyDown(Input.M))
         {
            if(!muteKey)
            {
               muteToggle();
            }
            muteKey = true;
         }
         else
         {
            muteKey = false;
         }
      }
      
      public static function pauseToggle() : void
      {
         if(!gamePaused)
         {
            Controller.level.plane.fixForOtherSounds(3);
            Controller.level.plane.engineSound.setVolume(0);
            Controller.level.plane.engineSound2.setVolume(0);
            GameController.soundChannel.stop();
            Controller.level.hud.pauseHud();
            gamePaused = true;
            trace("PAUSE");
         }
         else if(gamePaused)
         {
            gamePaused = false;
            Controller.level.hud.unpauseHud();
            trace("NOT PAUSE");
         }
      }
      
      public static function startGame(param1:Stage) : void
      {
         trace("reeeeeeee");
         stage = param1;
         content = new Sprite();
         GameController.timeline.addChildAt(bitmapClip = new Sprite(),0);
         gameBitmapData = new BitmapData(670,550,false,0);
         gameBitmap = new Bitmap(gameBitmapData);
         bitmapClip.addChildAt(gameBitmap,0);
         Input.setup();
         stage.addEventListener(Event.ENTER_FRAME,loop);
         loadSavedVariables();
         restart();
      }
      
      public static function fastModeToggleF() : void
      {
         if(!fastMode)
         {
            fastMode = true;
            Controller.level.hud.pilotGui.zOn.alpha = 1;
         }
         else
         {
            fastMode = false;
            Controller.level.hud.pilotGui.zOn.alpha = 0;
         }
      }
      
      public static function destroy() : void
      {
         trace("Controller Destroyed");
         level.destroy();
         level = null;
         gameBitmap.parent.removeChild(gameBitmap);
         gameBitmapData.dispose();
         bitmapClip.parent.removeChild(bitmapClip);
         stage.removeEventListener(Event.ENTER_FRAME,loop);
         GameController.stopAllSounds();
      }
   }
}
