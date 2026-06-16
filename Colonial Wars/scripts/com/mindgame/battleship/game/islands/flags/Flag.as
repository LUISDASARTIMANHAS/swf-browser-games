package com.mindgame.battleship.game.islands.flags
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.islands.Island;
   import com.mindgame.tweener.*;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class Flag extends Sprite
   {
       
      
      protected var _world:WorldComp;
      
      public var liveTime:int;
      
      public var showTime:int;
      
      private var showTimeHelp:int;
      
      public var canShow:Boolean;
      
      public var clip:MovieClip;
      
      public var race:int = 0;
      
      public var island:Island;
      
      public function Flag()
      {
         this._world = WorldComp.returnWorld;
         this.liveTime = WorldComp.fps * 4;
         this.showTime = WorldComp.fps * 3;
         this.showTimeHelp = this.showTime;
         super();
      }
      
      public function init() : void
      {
         this.clip.x = -this.clip.width * 0.5;
         this.clip.y = -this.clip.height;
         this.clip.scaleX = 0.5;
         this.clip.scaleY = 0.5;
         addChild(this.clip);
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function remove() : void
      {
         if(this.clip.parent)
         {
            removeChild(this.clip);
            if(parent)
            {
               this._world.txtLayer.removeChild(this);
            }
            delete global[this];
            return;
         }
      }
      
      public function setPosition(param1:int, param2:int, param3:Boolean = false) : void
      {
         this.x = param1;
         this.visible = true;
         if(param2 - this.height < 0)
         {
            param2 += this.height;
            this.x = param1 - 10;
         }
         if(param3)
         {
            this.y = param2 - 10;
            MFTween.tween(this,2,{"y":y + 20});
         }
         else
         {
            this.y = param2;
         }
         this.canShow = true;
         this._world.txtLayer.addChild(this);
      }
      
      public function endShow() : void
      {
         this.island.cantHideFlag = false;
      }
      
      public function visibleOn() : void
      {
         var del:* = undefined;
         del = function():void
         {
            this.visible = true;
         };
         MFTween.tween(this,0.2,{"alpha":1}).onComplete(del);
         this.clip.play();
      }
      
      public function visibleOff() : void
      {
         var del:* = undefined;
         del = function():void
         {
            this.visible = false;
            this.alpha = 1;
         };
         MFTween.tween(this,1,{
            "y":y - 20,
            "alpha":0
         }).onComplete(del);
         this.clip.stop();
      }
      
      public function update() : void
      {
      }
   }
}
