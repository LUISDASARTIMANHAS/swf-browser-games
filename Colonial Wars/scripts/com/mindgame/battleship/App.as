package com.mindgame.battleship
{
   import com.mindgame.battleship.Levels.*;
   import com.mindgame.battleship.game.ui.*;
   import com.mindgame.framework.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class App extends MovieClip
   {
      
      public static var _game:Game;
      
      public static var width_stage:int;
      
      public static var height_stage:int;
      
      public static var dataSaveManager:DataSaveManager;
      
      public static var soundManager:SoundManager;
      
      public static var version:Number = 0.8;
      
      public static var gamePanel:GamePanel;
      
      public static var maxLevel:int = 25;
      
      public static var handMute:Boolean = false;
      
      private static var app:App;
      
      public static var state:int = 0;
      
      public static var canRestart:Boolean = true;
      
      public static var canShowMenu:Boolean = true;
      
      public static var canMute:Boolean = true;
      
      public static var canDeleteISland:Boolean = true;
      
      public static var canPause:Boolean = true;
       
      
      public var panelLayer:Sprite;
      
      public function App()
      {
         super();
         if(stage)
         {
            this._slc();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this._slc);
         }
      }
      
      public static function clearDataSave() : void
      {
         dataSaveManager.clear();
         setDataSave();
      }
      
      private static function setDataSave() : void
      {
         if(dataSaveManager.get("completeLevels") == null)
         {
            dataSaveManager.put("completeLevels",0);
         }
         if(dataSaveManager.get("money") == null)
         {
            dataSaveManager.put("money",0);
         }
         if(App.dataSaveManager.get("levelPoint") == null)
         {
            App.dataSaveManager.put("levelPoint",[]);
         }
         if(App.dataSaveManager.get("allUpgrades") == null)
         {
            App.dataSaveManager.put("allUpgrades",null);
         }
         if(App.dataSaveManager.get("diffMoney") == null)
         {
            App.dataSaveManager.put("diffMoney",0);
         }
         if(App.dataSaveManager.get("allScores") == null)
         {
            App.dataSaveManager.put("allScores",0);
         }
         if(App.dataSaveManager.get("clear") == null)
         {
            App.dataSaveManager.put("clear",true);
         }
         if(App.dataSaveManager.get("countShowUpgrades") == null)
         {
            App.dataSaveManager.put("countShowUpgrades",0);
         }
         if(_game)
         {
            if(_game._world)
            {
               _game._world.upgradeShop.checkBlockUpdates();
            }
         }
      }
      
      public static function get getApp() : App
      {
         return app;
      }
      
      private function _slc(param1:Event = null) : void
      {
         if(lock.slc(loaderInfo.url.split("/").slice(0,3).join("/")))
         {
            this.init();
         }
         else
         {
            this.hack();
         }
      }
      
      private function hack() : void
      {
         var _loc1_:MovieClip = new ohno_mc();
         _loc1_.x = stage.stageWidth * 0.5;
         _loc1_.y = stage.stageHeight * 0.5;
         addChild(_loc1_);
      }
      
      public function init() : void
      {
         App.state = 0;
         app = this;
         this.scrollRect = new Rectangle(0,0,640,480);
         width_stage = stage.stageWidth;
         height_stage = stage.stageHeight;
         soundManager = new SoundManager();
         soundManager.addSound("menutheme",MenuTheme_snd,true,"menu",false);
         soundManager.addSound("gametheme1",Gametheme1_snd,true,"game",true);
         soundManager.addSound("gametheme2",Gametheme2_snd,true,"game",true);
         soundManager.addSound("gametheme3",Gametheme3_snd,true,"game",true);
         soundManager.addSound("victory",VictorySound_snd);
         soundManager.addShortSound("birds",Birds_snd);
         soundManager.addShortSound("lose",Lose_snd);
         soundManager.addShortSound("explosion",Explosion_snd);
         soundManager.addShortSound("capture",Capture_snd);
         soundManager.playPlaylist("menu",0);
         dataSaveManager = new DataSaveManager("ColonialWars_FGL_ver.2");
         setDataSave();
         stage.scaleMode = StageScaleMode.NO_SCALE;
         _game = new Game();
         addChild(_game);
         _game.init();
         this.panelLayer = new Sprite();
         addChild(this.panelLayer);
         state = 0;
         gamePanel = new GamePanel();
         gamePanel.init();
         gamePanel.checkBtn();
      }
   }
}
