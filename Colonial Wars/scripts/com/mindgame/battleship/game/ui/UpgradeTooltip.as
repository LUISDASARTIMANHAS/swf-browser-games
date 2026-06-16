package com.mindgame.battleship.game.ui
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.upgrade.UpdateTile;
   import flash.display.*;
   import flash.text.*;
   
   public class UpgradeTooltip extends Sprite
   {
      
      private static var stageHeight:int = WorldComp.Heigth;
      
      public static var textSize:int = 11;
       
      
      private var clip:MovieClip;
      
      private var _world:WorldComp;
      
      private var can:Boolean = false;
      
      private var time:int;
      
      private var timeHelp:int;
      
      public function UpgradeTooltip()
      {
         this._world = WorldComp.returnWorld;
         this.time = this._world.valueStock.tooltipTimeUpgrade;
         this.timeHelp = this.time;
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.clip = new UpgradeTooltip_mc();
         (this.clip.text as TextField).wordWrap = true;
         (this.clip.text as TextField).defaultTextFormat = new TextFormat(null,textSize);
         (this.clip.coins as MovieClip).visible = false;
         addChild(this.clip);
      }
      
      public function showTooltip(param1:int, param2:int, param3:int, param4:int, param5:UpdateTile) : void
      {
         this.x = param1 + param4 * 0.5;
         this.y = param2;
         (this.clip.text as TextField).text = param5.text;
         if(param5.active)
         {
            this.clip.price.text = String(param5.getPrice);
            (this.clip.price as TextField).visible = true;
            (this.clip.coins as MovieClip).visible = true;
         }
         else
         {
            (this.clip.price as TextField).visible = false;
            (this.clip.coins as MovieClip).visible = false;
         }
         this.can = true;
      }
      
      public function hideTooltip() : void
      {
         this.visible = false;
         this.can = false;
         this.clip.gotoAndStop(1);
         this.time = this.timeHelp;
      }
      
      public function upgrade() : void
      {
         if(this.can)
         {
            if(this.time - 1 < 0)
            {
               if(this.clip.currentFrame == this.clip.totalFrames)
               {
                  this.clip.stop();
               }
               else if(this.clip.currentFrame == 1)
               {
                  this.clip.play();
               }
               this.visible = true;
            }
            else
            {
               --this.time;
            }
         }
      }
   }
}
