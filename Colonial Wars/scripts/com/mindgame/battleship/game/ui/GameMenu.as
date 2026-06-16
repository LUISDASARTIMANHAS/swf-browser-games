package com.mindgame.battleship.game.ui
{
   import com.mindgame.battleship.Worlds.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class GameMenu extends MovieClip
   {
       
      
      public var gamemenus:MovieClip;
      
      private var _world:WorldComp;
      
      public function GameMenu()
      {
         this._world = WorldComp.returnWorld;
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.gamemenus = new Gamemenu_mc();
         this.gamemenus.gotoAndStop(1);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.bold = true;
         (this.gamemenus.body.bestscores as TextField).defaultTextFormat = _loc1_;
         (this.gamemenus.body.scores as TextField).defaultTextFormat = _loc1_;
         addChild(this.gamemenus);
      }
      
      public function playerWin(param1:Boolean = true, param2:Boolean = true) : void
      {
         if(param2)
         {
            if(param1)
            {
               this.gamemenus.gotoAndStop(1);
               (this.gamemenus.body.next as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.nextLevel,false,0,true);
               (this.gamemenus.body.upgrades as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.showUpgrates,false,0,true);
               (this.gamemenus.body.replay as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.restartLevel,false,0,true);
               (this.gamemenus.body.scores as TextField).defaultTextFormat = new TextFormat(null,null,null,true);
               (this.gamemenus.body.bestscores as TextField).defaultTextFormat = new TextFormat(null,null,null,true);
               (this.gamemenus.body.allScores as TextField).defaultTextFormat = new TextFormat(null,null,null,true);
               (this.gamemenus.body.scores as TextField).text = String(this._world.scoreTargetLevel);
               if(this._world.scoreTargetLevel > (this._world.levelPoint[WorldComp.targetLevel - 1] as Object).point)
               {
                  (this.gamemenus.body.bestscores as TextField).text = String(this._world.scoreTargetLevel);
               }
               else
               {
                  (this.gamemenus.body.bestscores as TextField).text = String((this._world.levelPoint[WorldComp.targetLevel - 1] as Object).point);
               }
               (this.gamemenus.body.allScores as TextField).text = String(WorldComp.allScores);
               (this.gamemenus.body.levelmap as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.Byebyeworld,false,0,true);
               (this.gamemenus.body.submit as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.inputWindow.showWindow,false,0,true);
            }
            else
            {
               this.gamemenus.gotoAndStop(2);
               (this.gamemenus.body.upgrades as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.showUpgrates,false,0,true);
               (this.gamemenus.body.replay as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.restartLevel,false,0,true);
               (this.gamemenus.body.levelmap as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.Byebyeworld,false,0,true);
            }
         }
         else
         {
            this.gamemenus.gotoAndStop(3);
            (this.gamemenus.body.upgrades as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.showUpgrates,false,0,true);
            (this.gamemenus.body.levelmap as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.Byebyeworld,false,0,true);
            (this.gamemenus.body.resume as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.resumeGame,false,0,true);
            (this.gamemenus.body.submit as SimpleButton).addEventListener(MouseEvent.CLICK,this._world.inputWindow.showWindow,false,0,true);
            (this.gamemenus.body.allScores as TextField).defaultTextFormat = new TextFormat(null,null,null,true);
            (this.gamemenus.body.allScores as TextField).text = WorldComp.allScores;
         }
      }
      
      public function deleteListener() : void
      {
         (this.gamemenus.body.next as SimpleButton).removeEventListener(MouseEvent.CLICK,this._world.nextLevel);
         (this.gamemenus.body.upgrades as SimpleButton).removeEventListener(MouseEvent.CLICK,this._world.showUpgrates);
         (this.gamemenus.body.replay as SimpleButton).removeEventListener(MouseEvent.CLICK,this._world.restartLevel);
      }
   }
}
