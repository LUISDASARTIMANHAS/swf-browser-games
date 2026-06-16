package com.mindgame.battleship.game.upgrade
{
   import com.mindgame.battleship.*;
   import com.mindgame.battleship.Worlds.*;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class UpgradeShop extends Sprite
   {
      
      public static var regenUpText:String = "Нету текста";
      
      public static var maxTimeRedText:String = "Нету текста";
      
      public static var capacityUpText:String = "Нету текста";
      
      public static var speedShipUpText:String = "Нету текста";
      
      public static var capacityCarUpText:String = "Нету текста";
      
      public static var allAirplaneUpText:String = "Нету текста";
      
      public static var speedEnemyRedText:String = "Нету текста";
       
      
      public var _body:MovieClip;
      
      private var _world:WorldComp;
      
      private var regenUp:RegenUp;
      
      private var maxTimeRed:MaxTimeRed;
      
      private var capacityUp:CapacityUp;
      
      private var speedShipUp:SpeedShipUp;
      
      private var capacityCarUp:CapacityCarUp;
      
      private var allAirplaneUp:AllAirplaneUp;
      
      private var speedEnemyRed:SpeedEnemyRed;
      
      private var count:Boolean = true;
      
      private var timer:Timer;
      
      public var allUpgrades:Array;
      
      public function UpgradeShop()
      {
         this._world = WorldComp.returnWorld;
         this.timer = new Timer(100);
         super();
         this.init();
      }
      
      public function init() : void
      {
         if(this._body == null)
         {
            this._body = new Upgradeshop();
            addChild(this._body);
            UpdateTile._upgradesShop = this;
            this.allUpgrades = App.dataSaveManager.get("allUpgrades");
            this.regenUp = new RegenUp();
            this.maxTimeRed = new MaxTimeRed();
            this.capacityUp = new CapacityUp();
            this.speedShipUp = new SpeedShipUp();
            this.capacityCarUp = new CapacityCarUp();
            this.allAirplaneUp = new AllAirplaneUp();
            this.speedEnemyRed = new SpeedEnemyRed();
            this.regenUp._clip = this._body.regenUp;
            this.maxTimeRed._clip = this._body.maxTimeRed;
            this.capacityUp._clip = this._body.capacityUp;
            this.speedShipUp._clip = this._body.speedShipUp;
            this.capacityCarUp._clip = this._body.capacityCarUp;
            this.allAirplaneUp._clip = this._body.allAirplaneUp;
            this.speedEnemyRed._clip = this._body.speedEnemyRed;
            this.regenUp.init();
            this.maxTimeRed.init();
            this.capacityUp.init();
            this.speedShipUp.init();
            this.capacityCarUp.init();
            this.allAirplaneUp.init();
            this.speedEnemyRed.init();
            this.capacityUp.setDepend(this.speedShipUp,this.speedShipUp.maxCountUpgrades - 1);
            this.regenUp.setDepend(this.capacityUp,this.capacityUp.maxCountUpgrades);
            this.allAirplaneUp.setDepend(this.capacityCarUp,this.capacityCarUp.maxCountUpgrades);
            this.capacityCarUp.setDepend(this.speedShipUp,this.speedShipUp.maxCountUpgrades - 1);
            this.speedEnemyRed.setDepend(this.maxTimeRed,this.maxTimeRed.maxCountUpgrades);
            this.speedShipUp.priceUpgrade = [200,600,1000];
            this.maxTimeRed.priceUpgrade = [200,600];
            this.capacityUp.priceUpgrade = [300,600,1000];
            this.regenUp.priceUpgrade = [600,1000];
            this.capacityCarUp.priceUpgrade = [300,600,1000];
            this.allAirplaneUp.priceUpgrade = [1500];
            this.speedEnemyRed.priceUpgrade = [300,600,1000];
            this.speedShipUp.text = speedShipUpText;
            this.maxTimeRed.text = maxTimeRedText;
            this.capacityUp.text = capacityUpText;
            this.regenUp.text = regenUpText;
            this.capacityCarUp.text = capacityCarUpText;
            this.allAirplaneUp.text = allAirplaneUpText;
            this.speedEnemyRed.text = speedEnemyRedText;
         }
         if(this.allUpgrades == null)
         {
            this.allUpgrades = [this.regenUp,this.maxTimeRed,this.capacityUp,this.speedShipUp,this.capacityCarUp,this.allAirplaneUp,this.speedEnemyRed];
         }
         else
         {
            this.allUpgrades = App.dataSaveManager.get("allUpgrades");
            this.regenUp.targetCountUpgrades = this.allUpgrades[0].targetCountUpgrades;
            this.maxTimeRed.targetCountUpgrades = this.allUpgrades[1].targetCountUpgrades;
            this.capacityUp.targetCountUpgrades = this.allUpgrades[2].targetCountUpgrades;
            this.speedShipUp.targetCountUpgrades = this.allUpgrades[3].targetCountUpgrades;
            this.capacityCarUp.targetCountUpgrades = this.allUpgrades[4].targetCountUpgrades;
            this.allAirplaneUp.targetCountUpgrades = this.allUpgrades[5].targetCountUpgrades;
            this.speedEnemyRed.targetCountUpgrades = this.allUpgrades[6].targetCountUpgrades;
            this.allUpgrades = [this.regenUp,this.maxTimeRed,this.capacityUp,this.speedShipUp,this.capacityCarUp,this.allAirplaneUp,this.speedEnemyRed];
         }
         this.checkBlockUpdates();
         this.openShop();
         this._body.clear.addEventListener(MouseEvent.CLICK,this.returnMoney);
         this.timer.addEventListener(TimerEvent.TIMER,this.switchColor);
      }
      
      private function returnMoney(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.allUpgrades.length)
         {
            if(this.allUpgrades[_loc3_].targetCountUpgrades > 0)
            {
               _loc4_ = 1;
               while(_loc4_ <= this.allUpgrades[_loc3_].targetCountUpgrades)
               {
                  _loc2_ += this.allUpgrades[_loc3_].getTargetPrice(_loc4_ - 1);
                  _loc4_++;
               }
            }
            _loc3_++;
         }
         WorldComp.money += _loc2_;
         WorldComp.diffMoney = 0;
         App.dataSaveManager.put("money",WorldComp.money);
         App.dataSaveManager.put("diffMoney",WorldComp.diffMoney);
         this.writeMoney();
         this.clearUpgrade();
         this.checkBlockUpdates();
      }
      
      public function writeMoney() : void
      {
         (this._body.scores as TextField).text = String(WorldComp.money);
      }
      
      private function clearUpgrade() : void
      {
         this.regenUp.targetCountUpgrades = -1;
         this.maxTimeRed.targetCountUpgrades = 0;
         this.maxTimeRed.canUpgrades = true;
         this.capacityUp.targetCountUpgrades = -1;
         this.speedShipUp.targetCountUpgrades = 0;
         this.speedShipUp.canUpgrades = true;
         this.capacityCarUp.targetCountUpgrades = -1;
         this.allAirplaneUp.targetCountUpgrades = -1;
         this.speedEnemyRed.targetCountUpgrades = -1;
         this.allUpgrades = [this.regenUp,this.maxTimeRed,this.capacityUp,this.speedShipUp,this.capacityCarUp,this.allAirplaneUp,this.speedEnemyRed];
      }
      
      public function showLowMoney() : void
      {
         this.timer.repeatCount = 6;
         this.timer.reset();
         this.timer.start();
      }
      
      private function switchColor(param1:TimerEvent) : void
      {
         if(this.count)
         {
            this.count = false;
            (this._body.scores as TextField).textColor = 16711680;
         }
         else
         {
            this.count = true;
            (this._body.scores as TextField).textColor = 14727820;
         }
      }
      
      public function openShop() : void
      {
         this.writeMoney();
         if(App.dataSaveManager.get("clear"))
         {
            this.clearUpgrade();
            App.dataSaveManager.put("clear",false);
            this.checkBlockUpdates();
         }
         App.dataSaveManager.put("allUpgrades",this.allUpgrades);
      }
      
      public function checkBlockUpdates() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.allUpgrades.length)
         {
            (this.allUpgrades[_loc1_] as UpdateTile).checkBlock();
            _loc1_++;
         }
      }
   }
}
