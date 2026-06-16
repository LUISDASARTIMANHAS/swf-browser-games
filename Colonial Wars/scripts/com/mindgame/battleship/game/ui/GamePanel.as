package com.mindgame.battleship.game.ui
{
   import com.mindgame.battleship.*;
   import com.mindgame.battleship.Worlds.WorldComp;
   import flash.display.*;
   import flash.events.*;
   
   public class GamePanel
   {
      
      private static var fist:Boolean = true;
       
      
      private var app:App;
      
      private var _clip:MovieClip;
      
      public var _world:WorldComp;
      
      public function GamePanel()
      {
         this.app = App.getApp;
         super();
      }
      
      public function init() : void
      {
         this._clip = new Gamepanel_mc();
         this._clip.stop();
         this.app.panelLayer.addChild(this._clip);
         this._clip.x = App.width_stage - this._clip.width * 0.9;
         this._clip.y = App.height_stage - this._clip.height * 0.8;
         App.soundManager.muteOnButton = this._clip.muteOn as SimpleButton;
         App.soundManager.muteOffButton = this._clip.muteOff as SimpleButton;
         if(App.soundManager.mute)
         {
            (this._clip.muteOn as SimpleButton).visible = true;
            (this._clip.muteOff as SimpleButton).visible = false;
         }
         else
         {
            (this._clip.muteOn as SimpleButton).visible = false;
            (this._clip.muteOff as SimpleButton).visible = true;
         }
         (this._clip.muteOn as SimpleButton).addEventListener(MouseEvent.CLICK,App.soundManager.muteAllSound,false,0,true);
         (this._clip.muteOff as SimpleButton).addEventListener(MouseEvent.CLICK,App.soundManager.muteAllSound,false,0,true);
      }
      
      public function checkBtn() : void
      {
         switch(App.state)
         {
            case 2:
               this._clip.visible = false;
               break;
            case 0:
            case 1:
               this._clip.menu.visible = false;
               this._clip.restart.visible = false;
               this._clip.pause.visible = false;
               this._clip.bg_mc.visible = false;
               this._clip.visible = true;
               break;
            default:
               this._clip.menu.visible = true;
               this._clip.restart.visible = true;
               this._clip.pause.visible = true;
               this._clip.bg_mc.visible = true;
               this._clip.visible = true;
         }
      }
      
      public function addListener() : void
      {
         if(fist)
         {
            (this._clip.pause as SimpleButton).addEventListener(MouseEvent.CLICK,this.checkPause,false,0,true);
            (this._clip.restart as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.endLevel,false,0,true);
            (this._clip.menu as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.showSurelyMenu,false,0,true);
            (this._clip.muteOn as SimpleButton).addEventListener(MouseEvent.CLICK,App.soundManager.muteAllSound,false,0,true);
            (this._clip.muteOff as SimpleButton).addEventListener(MouseEvent.CLICK,App.soundManager.muteAllSound,false,0,true);
            fist = false;
         }
      }
      
      private function checkPause(param1:MouseEvent) : void
      {
         if(!this._world.gameMenuShow)
         {
            this._world.checkPause();
         }
      }
      
      public function clear() : void
      {
         (this._clip.pause as SimpleButton).removeEventListener(MouseEvent.CLICK,this._world.checkPause);
         (this._clip.restart as SimpleButton).removeEventListener(MouseEvent.CLICK,this._world.endLevel);
         (this._clip.menu as SimpleButton).removeEventListener(MouseEvent.CLICK,this._world.showSurelyMenu);
         fist = true;
      }
   }
}
