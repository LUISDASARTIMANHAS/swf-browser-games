package com.mindgame.battleship.Levels
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.tweener.*;
   import flash.display.*;
   import flash.events.*;
   
   public class SubmitScreen extends Sprite
   {
       
      
      private var _world:WorldComp;
      
      public var clip:MovieClip;
      
      public function SubmitScreen()
      {
         this._world = WorldComp.returnWorld;
         super();
      }
      
      public function init() : void
      {
         this.clip = new InputScreen_mc();
         (this.clip.okay as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.submitScores);
         (this.clip.close as SimpleButton).addEventListener(MouseEvent.CLICK,this.hideWindow);
         (this.clip.title as MovieClip).stop();
         addChild(this.clip);
      }
      
      public function showWindow(param1:MouseEvent = null) : void
      {
         this.alpha = 0;
         this.visible = true;
         (this.clip.title as MovieClip).gotoAndStop(1);
         MFTween.tween(this,1,{"alpha":1});
      }
      
      public function error() : void
      {
         (this.clip.title as MovieClip).gotoAndStop(2);
      }
      
      public function hideWindow(param1:MouseEvent = null) : void
      {
         var del:* = undefined;
         var e:MouseEvent = param1;
         del = function():void
         {
            this.visible = false;
         };
         MFTween.tween(this,1,{"alpha":0}).onComplete(del);
      }
   }
}
