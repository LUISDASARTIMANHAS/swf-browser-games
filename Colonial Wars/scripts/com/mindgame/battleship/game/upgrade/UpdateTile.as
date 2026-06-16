package com.mindgame.battleship.game.upgrade
{
   import com.mindgame.battleship.*;
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.ui.UpgradeTooltip;
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class UpdateTile
   {
      
      public static var _world:WorldComp = WorldComp.returnWorld;
      
      public static var valutes:int = WorldComp.money;
      
      public static var _upgradesShop:UpgradeShop;
      
      protected static var _upgradeTooltip:UpgradeTooltip = _world.upgradeTooltip;
       
      
      public var _clip:MovieClip;
      
      public var maxCountUpgrades:int = 0;
      
      public var targetCountUpgrades:int = -1;
      
      public var canUpgrades:Boolean = true;
      
      public var dependenceOn:UpdateTile;
      
      public var dependenceCount:int;
      
      public var priceUpgrade:Array;
      
      public var active:Boolean = false;
      
      public var text:String = "Нету текста";
      
      public function UpdateTile()
      {
         this.priceUpgrade = [];
         super();
      }
      
      public function init() : void
      {
         _world = WorldComp.returnWorld;
         this._clip.stop();
         this._clip.addEventListener(MouseEvent.MOUSE_OVER,this.selectEffect,false,0,true);
         this._clip.addEventListener(MouseEvent.MOUSE_OUT,this.unSelectEffect,false,0,true);
         this._clip.addEventListener(MouseEvent.CLICK,this.wantUpdate,false,0,true);
      }
      
      private function selectEffect(param1:MouseEvent = null) : void
      {
         if(_upgradeTooltip == null)
         {
            _upgradeTooltip = _world.upgradeTooltip;
         }
         _upgradeTooltip.showTooltip(this._clip.x,this._clip.y,this._clip.height,this._clip.width,this);
      }
      
      private function unSelectEffect(param1:MouseEvent) : void
      {
         _upgradeTooltip.hideTooltip();
      }
      
      public function setDepend(param1:UpdateTile, param2:int) : void
      {
         this.dependenceOn = param1;
         this.dependenceCount = param2;
      }
      
      private function setFrame() : void
      {
         this._clip.gotoAndStop(this.targetCountUpgrades + 2);
         if(this.targetCountUpgrades >= 0 && this.targetCountUpgrades != this.maxCountUpgrades)
         {
            this.active = true;
         }
         else
         {
            this.active = false;
         }
      }
      
      public function checkBlock() : void
      {
         if(this.dependenceOn != null)
         {
            if(this.dependenceOn.targetCountUpgrades >= this.dependenceCount)
            {
               if(this.targetCountUpgrades < 0)
               {
                  this.targetCountUpgrades = 0;
               }
               this.canUpgrades = true;
               this._clip.buttonMode = true;
            }
            else
            {
               this.targetCountUpgrades = -1;
               this._clip.buttonMode = false;
            }
         }
         else
         {
            this.canUpgrades = true;
            if(this.targetCountUpgrades <= 0)
            {
               this.targetCountUpgrades = 0;
            }
            this._clip.buttonMode = true;
         }
         this.setFrame();
         this.upCountSkills();
      }
      
      private function buyUpgrade() : void
      {
         if(this.canUpgrades)
         {
            valutes = WorldComp.money;
            if(valutes >= this.getPrice)
            {
               valutes -= this.getPrice;
               WorldComp.money = valutes;
               WorldComp.diffMoney += this.getPrice;
               this.upSkill();
            }
            else
            {
               _world.upgradeShop.showLowMoney();
            }
         }
         App.dataSaveManager.put("money",WorldComp.money);
         App.dataSaveManager.put("diffMoney",WorldComp.diffMoney);
      }
      
      public function getTargetPrice(param1:int) : int
      {
         return this.priceUpgrade[param1];
      }
      
      public function get getPrice() : int
      {
         return this.priceUpgrade[this.targetCountUpgrades];
      }
      
      protected function upCountSkills() : void
      {
      }
      
      protected function upSkill() : void
      {
         ++this.targetCountUpgrades;
         if(this.targetCountUpgrades >= this.maxCountUpgrades)
         {
            this.canUpgrades = false;
            this._clip.buttonMode = false;
         }
         this.setFrame();
         _upgradesShop.checkBlockUpdates();
         _upgradesShop.writeMoney();
      }
      
      private function wantUpdate(param1:MouseEvent) : void
      {
         this.buyUpgrade();
         this.selectEffect();
      }
   }
}
