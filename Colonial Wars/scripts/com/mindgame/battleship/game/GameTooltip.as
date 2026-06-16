package com.mindgame.battleship.game
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.tweener.*;
   import flash.display.*;
   import flash.events.*;
   
   public class GameTooltip
   {
       
      
      private var _world:WorldComp;
      
      private var clip:MovieClip;
      
      public function GameTooltip()
      {
         this._world = WorldComp.returnWorld;
         this.clip = new LevelTooltip_mc();
         super();
         this.init();
      }
      
      public function init() : void
      {
         this.clip.visible = false;
      }
      
      private function close(param1:MouseEvent) : void
      {
         MFTween.tween(this.clip.tooltip,1,{"alpha":0});
      }
      
      public function gotoAndPlay() : void
      {
         var del:* = undefined;
         var del2:* = undefined;
         del = function():void
         {
            MFTween.tween(clip.nameLevel,1.3,{"alpha":0}).onComplete(del2);
         };
         del2 = function():void
         {
            clip.nameLevel.visible = false;
            clip.nameLevel.alpha = 0;
         };
         if(WorldComp.targetLevel <= this.clip.totalFrames)
         {
            this.clip.cacheAsBitmap = true;
            this.clip.alpha = 1;
            this.clip.visible = true;
            this.clip.gotoAndStop(WorldComp.targetLevel);
            if(WorldComp.targetLevel == 1 || WorldComp.targetLevel == 2 || WorldComp.targetLevel == 3 || WorldComp.targetLevel == 4)
            {
               if(this.clip.tooltip)
               {
                  this.clip.tooltip.alpha = 1;
                  this.clip.tooltip.visible = true;
               }
               this.clip.tooltip.close.addEventListener(MouseEvent.CLICK,this.close);
            }
            this._world.panelLayer.addChild(this.clip);
            (this.clip.nameLevel as MovieClip).gotoAndStop(WorldComp.targetLevel);
            (this.clip.nameLevel as MovieClip).alpha = 0;
            (this.clip.nameLevel as MovieClip).visible = true;
            MFTween.tween(this.clip.nameLevel,2,{"alpha":1}).onComplete(del);
         }
      }
      
      public function delet() : void
      {
         if(WorldComp.targetLevel == 1 || WorldComp.targetLevel == 2 || WorldComp.targetLevel == 3 || WorldComp.targetLevel == 4)
         {
            this.clip.tooltip.close.removeEventListener(MouseEvent.CLICK,this.close);
         }
         this.clip.visible = false;
         if(this.clip.parent)
         {
            this._world.panelLayer.removeChild(this.clip);
         }
      }
   }
}
