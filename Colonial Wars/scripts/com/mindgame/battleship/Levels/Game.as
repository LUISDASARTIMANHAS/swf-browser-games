package com.mindgame.battleship.Levels
{
   import com.mindgame.battleship.*;
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.tweener.*;
   import com.mindgame.tweener.easing.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class Game extends Sprite
   {
      
      public static var game:Game;
       
      
      public var _world:WorldBase;
      
      private var thisScreenShot:Bitmap;
      
      public var gameScreenShot:Bitmap;
      
      private var _screen:MovieClip;
      
      public var allScreens:Sprite;
      
      public var allWorlds:Sprite;
      
      public var levelMap:LevelMap;
      
      public var targetLevel:int = 1;
      
      public var app:App;
      
      public function Game()
      {
         this.thisScreenShot = new Bitmap();
         this.gameScreenShot = new Bitmap();
         this._screen = new Change_scr();
         this.levelMap = new LevelMap();
         this.app = App.getApp;
         super();
      }
      
      public static function returnGame() : Game
      {
         return game;
      }
      
      public function init() : void
      {
         App.state = 1;
         game = this;
         this.levelMap.initial();
         this.allWorlds = new Sprite();
         addChild(this.allWorlds);
         this.allScreens = new Sprite();
         addChild(this.allScreens);
         this._screen.credits.visible = false;
         (this._screen.credits.close as SimpleButton).addEventListener(MouseEvent.CLICK,this.openCredits);
         this.allScreens.addChild(this._screen);
         this.levelMap.visible = false;
         this.levelMap.game = this;
         this.levelMap.alpha = 0;
         this.allScreens.addChild(this.levelMap);
         this.doingScreenShot();
         this.allScreens.addChild(this.thisScreenShot);
         (this._screen.body.compaign as SimpleButton).visible = false;
         (this._screen.body.multiplayer as MovieClip).visible = false;
         (this._screen.allPoints as TextField).defaultTextFormat = new TextFormat(null,null,null,true);
         this._screen.allPoints.text = App.dataSaveManager.get("allScores");
         (this._screen.body.close as SimpleButton).visible = false;
         (this._screen.body.pvp_btn as SimpleButton).addEventListener(MouseEvent.CLICK,this.openCredits);
         (this._screen.body.close as SimpleButton).addEventListener(MouseEvent.CLICK,this.switchButton);
         (this._screen.body.pvc_btn as SimpleButton).addEventListener(MouseEvent.CLICK,this.switchButton);
         (this._screen.body.compaign as SimpleButton).addEventListener(MouseEvent.CLICK,this.setLevel);
         this._screen.body.version.text = String("version: " + App.version);
         this.startAnimation();
      }
      
      private function startAnimation() : void
      {
         var del2:* = undefined;
         var del:* = undefined;
         del2 = function():void
         {
            _screen.clouds2.x = -609;
            MFTween.tween(_screen.clouds2,500,{"x":1319}).onComplete(del).ease(Linear.easeNone);
         };
         del = function():void
         {
            _screen.clouds.x = -119;
            MFTween.tween(_screen.clouds,150,{"x":1319}).onComplete(del).ease(Linear.easeNone);
         };
         var oldY:Number = Number(this._screen.body.y);
         var oldY2:Number = Number(this._screen.title.y);
         this._screen.body.y = App.height_stage + 20;
         this._screen.title.y = -this._screen.title.height;
         MFTween.tween(this._screen.body,1.5,{"y":oldY}).ease(Quint.easeInOut);
         MFTween.tween(this._screen.title,1.5,{"y":oldY2}).ease(Quint.easeInOut);
         MFTween.tween(this._screen.clouds,150,{"x":1319}).onComplete(del).ease(Linear.easeNone);
         MFTween.tween(this._screen.clouds2,500,{"x":762}).onComplete(del2).ease(Linear.easeNone);
      }
      
      private function openCredits(param1:MouseEvent = null) : void
      {
         var del:*;
         var oldY:Number = NaN;
         var oldY2:Number = NaN;
         var e:MouseEvent = param1;
         oldY = Number(this._screen.credits.y);
         oldY2 = Number(this._screen.body.y);
         if(this._screen.credits.visible)
         {
            del = function():void
            {
               _screen.body.y = App.height_stage + 20;
               _screen.credits.visible = false;
               _screen.credits.y = oldY;
               _screen.body.visible = true;
               MFTween.tween(_screen.body,1,{"y":oldY2});
            };
            MFTween.tween(this._screen.credits,0.3,{"y":App.height_stage + 20}).onComplete(del).ease(Quint.easeInOut);
         }
         else
         {
            del = function():void
            {
               _screen.credits.y = App.height_stage + 20;
               _screen.credits.visible = true;
               _screen.body.visible = false;
               _screen.body.y = oldY2;
               MFTween.tween(_screen.credits,0.7,{"y":oldY}).ease(Quint.easeInOut);
            };
            MFTween.tween(this._screen.body,0.4,{"y":App.height_stage + 20}).onComplete(del).ease(Quint.easeInOut);
         }
      }
      
      private function switchButton(param1:MouseEvent = null) : void
      {
         var del:*;
         var oldY:Number = NaN;
         var e:MouseEvent = param1;
         oldY = Number(this._screen.body.y);
         if((this._screen.body.pvc_btn as SimpleButton).visible)
         {
            del = function():void
            {
               (_screen.body.close as SimpleButton).visible = true;
               (_screen.body.compaign as SimpleButton).visible = true;
               (_screen.body.multiplayer as MovieClip).visible = true;
               (_screen.body.pvp_btn as SimpleButton).visible = false;
               (_screen.body.pvc_btn as SimpleButton).visible = false;
               MFTween.tween(_screen.body,1,{"y":oldY});
            };
            MFTween.tween(this._screen.body,0.4,{"y":App.height_stage + 20}).onComplete(del).ease(Quint.easeInOut);
         }
         else
         {
            del = function():void
            {
               (_screen.body.close as SimpleButton).visible = false;
               (_screen.body.compaign as SimpleButton).visible = false;
               (_screen.body.multiplayer as MovieClip).visible = false;
               (_screen.body.pvp_btn as SimpleButton).visible = true;
               (_screen.body.pvc_btn as SimpleButton).visible = true;
               MFTween.tween(_screen.body,1,{"y":oldY});
            };
            MFTween.tween(this._screen.body,0.4,{"y":App.height_stage + 20}).onComplete(del).ease(Quint.easeInOut);
         }
      }
      
      public function doingScreenShot() : void
      {
         var _loc1_:Rectangle = new Rectangle();
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = stage.stageWidth;
         _loc1_.height = stage.stageHeight;
         var _loc2_:BitmapData = new BitmapData(_loc1_.width,_loc1_.height,true,0);
         var _loc3_:Matrix = new Matrix();
         _loc3_.translate(-_loc1_.x,-_loc1_.y);
         _loc3_.scale(this.levelMap.scaleX,this.levelMap.scaleY);
         _loc2_.draw(this.levelMap,_loc3_);
         this.thisScreenShot.bitmapData = _loc2_;
         this.thisScreenShot.visible = false;
      }
      
      private function swapBmpScr() : void
      {
         this.thisScreenShot.visible = true;
         this._screen.visible = false;
      }
      
      private function playPvp(param1:MouseEvent) : void
      {
      }
      
      private function setLevel(param1:MouseEvent) : void
      {
         var del:* = undefined;
         var e:MouseEvent = param1;
         del = function():void
         {
            _screen.visible = false;
            allScreens.removeChild(_screen);
         };
         App.state = 2;
         App.gamePanel.checkBtn();
         this.levelMap.init();
         this.levelMap.visible = true;
         this.levelMap.alpha = 0;
         this._screen.alpha = 1;
         MFTween.tween(this.levelMap,1.5,{"alpha":1});
         MFTween.tween(this._screen,1.5,{"alpha":0}).onComplete(del);
      }
      
      public function hideLevelmap() : void
      {
         this.hideLevelMap();
         this.playPvc();
      }
      
      private function hideLevelMap() : void
      {
         this.levelMap.clear();
         this.levelMap.visible = false;
         this.levelMap.alpha = 1;
      }
      
      private function playPvc() : void
      {
         this.swapBmpScr();
         if(this._world == null)
         {
            this._world = new WorldComp();
            WorldComp._world = this._world;
            App.gamePanel._world = this._world;
            this._world._Game = this;
            stage.addEventListener(KeyboardEvent.KEY_DOWN,this.hotKeys);
            stage.addEventListener(KeyboardEvent.KEY_UP,this.hotKeysUp);
         }
         App.state = 3;
         App.gamePanel.checkBtn();
         this.thisScreenShot.alpha = 1;
         WorldComp.targetLevel = this.targetLevel;
         this._world.startGame();
         this._world.visible = true;
         this.allWorlds.addChild(this._world);
         stage.focus = stage;
      }
      
      public function returnLevelMap() : void
      {
         var del:* = undefined;
         del = function():void
         {
            levelMap.checkLevelComplete();
            levelMap.visible = true;
            levelMap.init();
            allScreens.removeChild(gameScreenShot);
            gameScreenShot.x = 0;
            gameScreenShot = null;
            thisScreenShot.visible = false;
         };
         if(!App.handMute && Boolean(this._world.startLevel))
         {
            App.soundManager.muteAllSound();
         }
         App.state = 2;
         App.gamePanel.checkBtn();
         this.thisScreenShot.visible = true;
         this.thisScreenShot.alpha = 1;
         this.thisScreenShot.x = -this.thisScreenShot.width;
         MFTween.tween(this.gameScreenShot,1.5,{"x":this.gameScreenShot.width});
         MFTween.tween(this.thisScreenShot,1.5,{"x":0}).onComplete(del);
      }
      
      public function returnGameMenu() : void
      {
         var del:* = undefined;
         del = function():void
         {
            thisScreenShot.visible = false;
            thisScreenShot.alpha = 1;
            switchButton();
         };
         this.allScreens.addChild(this._screen);
         this._screen.allPoints.text = App.dataSaveManager.get("allScores");
         App.state = 1;
         App.gamePanel.checkBtn();
         this.doingScreenShot();
         this.thisScreenShot.alpha = 1;
         this.thisScreenShot.visible = true;
         this._screen.visible = true;
         this.hideLevelMap();
         MFTween.tween(this.thisScreenShot,1,{"alpha":0});
         MFTween.tween(this._screen,1,{"alpha":1}).onComplete(del);
      }
      
      public function removeThis() : void
      {
         var del:* = undefined;
         del = function():void
         {
            thisScreenShot.visible = false;
            thisScreenShot.x = -thisScreenShot.width;
            thisScreenShot.y = 0;
         };
         MFTween.tween(this.thisScreenShot,1,{"y":-this.thisScreenShot.height}).onComplete(del);
      }
      
      public function hotKeysUp(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case 82:
               if(!App.canRestart)
               {
                  App.canRestart = true;
               }
               break;
            case 80:
               if(!App.canPause)
               {
                  App.canPause = true;
               }
               break;
            case 85:
               if(!App.canShowMenu)
               {
                  App.canShowMenu = true;
               }
               break;
            case 77:
               if(!App.canMute)
               {
                  App.canMute = true;
               }
               break;
            case 17:
               if(!App.canDeleteISland)
               {
                  App.canDeleteISland = true;
               }
         }
      }
      
      public function hotKeys(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case 82:
               if(App.canRestart)
               {
                  App.canRestart = false;
                  if(App.state == 3 && !this._world.gameMenuShow && !this._world.pause)
                  {
                     this._world.buttonRestart();
                  }
               }
               break;
            case 80:
               if(App.canPause)
               {
                  App.canPause = false;
                  if(App.state == 3 && !this._world.gameMenuShow)
                  {
                     this._world.checkPause();
                  }
               }
               break;
            case 85:
               if(App.canShowMenu)
               {
                  App.canShowMenu = false;
                  if(App.state == 3 && !this._world.gameMenuShow && !this._world.upgradeShop.visible)
                  {
                     this._world.buttonMenu();
                  }
               }
               break;
            case 77:
               if(App.canMute)
               {
                  App.canMute = false;
                  App.soundManager.muteAllSound(null,true);
                  if(App.handMute)
                  {
                     handMute = false;
                  }
                  else
                  {
                     handMute = true;
                  }
               }
               break;
            case 17:
               if(App.canDeleteISland)
               {
                  App.canDeleteISland = false;
                  this._world.checkIslandForAttack(null,false);
               }
         }
      }
   }
}
