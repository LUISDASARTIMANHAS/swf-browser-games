package com.mindgame.battleship.game.ui
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.islands.Island;
   import com.mindgame.tweener.*;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.*;
   
   public class Tooltip extends Sprite
   {
      
      private static var stageWidth:int = WorldComp.Width;
      
      private static var stageHeight:int = WorldComp.Heigth;
       
      
      private var clip:MovieClip;
      
      private var _world:WorldComp;
      
      private var can:Boolean = false;
      
      private var time:int;
      
      private var timeHelp:int;
      
      private var time2:int = 35;
      
      private var away:Boolean = false;
      
      private var streng:Number = 1;
      
      private var YY:Number;
      
      private var island:Island;
      
      private var canUpgradeText:Boolean = false;
      
      public function Tooltip()
      {
         this._world = WorldComp.returnWorld;
         this.time = this._world.valueStock.tooltipTime;
         this.timeHelp = this.time;
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.clip = new Tooltip_mc();
         (this.clip.race as TextField).defaultTextFormat = new TextFormat(null,null,null,true);
         addChild(this.clip);
      }
      
      public function showTooltip(param1:int, param2:int, param3:int, param4:Island) : void
      {
         this.island = param4;
         this.away = false;
         if(stageWidth * 0.5 < param1)
         {
            this.x = param1 - param3 - width;
         }
         else
         {
            this.x = param1 + param3;
         }
         this.away = true;
         this.YY = param2;
         this.streng = 1;
         if(param2 - height * 0.5 < 0)
         {
            this.streng = 2;
         }
         else if(param2 + height * 0.5 > stageHeight)
         {
            this.streng = -1;
         }
         this.updateText();
         this.can = true;
      }
      
      private function updateText() : void
      {
         if(this.island.getRace == this._world.playerRace)
         {
            this.clip.max.text = String(int(this.island.maxPeople * this._world.upgradeCapacityUp));
            this.clip.reg.text = String(int(this.island.getRegen));
         }
         else
         {
            this.clip.max.text = String(this.island.maxPeople);
            this.clip.reg.text = String(this.island.getRegen);
         }
         this.clip.army.text = String(this.island.people);
         this.clip.race.text = this._world.returnStringRace(this.island.getRace);
      }
      
      public function hideTooltip() : void
      {
         this.visible = false;
         this.can = false;
         this.time = this.timeHelp;
         this.canUpgradeText = false;
      }
      
      public function upgrade() : void
      {
         if(this.can)
         {
            if(this.time - 1 < 0)
            {
               this.alpha = 0;
               this.y = this.YY - height;
               this.visible = true;
               this.can = false;
               if(this.away)
               {
                  MFTween.tween(this,1,{
                     "y":y + this.streng * height * 0.5,
                     "alpha":1
                  });
               }
               this.away = false;
               this.canUpgradeText = true;
            }
            else
            {
               --this.time;
            }
         }
         if(this.canUpgradeText)
         {
            if(this.time - 1 < 0)
            {
               this.time = this.time2;
               this.updateText();
            }
            else
            {
               --this.time;
            }
         }
      }
   }
}
