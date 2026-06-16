package com.mindgame.battleship.Worlds
{
   import com.mindgame.battleship.*;
   import com.mindgame.battleship.Levels.*;
   import com.mindgame.battleship.game.*;
   import com.mindgame.battleship.game.atmosphery.*;
   import com.mindgame.battleship.game.barriers.*;
   import com.mindgame.battleship.game.effect.*;
   import com.mindgame.battleship.game.islands.*;
   import com.mindgame.battleship.game.islands.flags.*;
   import com.mindgame.battleship.game.levels.*;
   import com.mindgame.battleship.game.ship.*;
   import com.mindgame.battleship.game.ui.*;
   import com.mindgame.battleship.game.upgrade.*;
   import com.mindgame.framework.*;
   import com.mindgame.tweener.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import mochi.as3.*;
   
   public class WorldComp extends WorldBase
   {
      
      public static const CELL_SIZE:int = 40;
      
      public static const CELL_HALF_SIZE:int = CELL_SIZE / 2;
      
      public static const Width:int = 640;
      
      public static const Heigth:int = 480;
      
      public static var fps:int = 35;
      
      public static var _world:WorldComp;
      
      public static var targetLevel:int = 1;
      
      public static var money:int = 0;
      
      public static var allScores:int = 0;
      
      public static var diffMoney:int = 0;
       
      
      public var _Game:Game;
      
      public var washoutRate:Number;
      
      public var shiftRate:Number;
      
      private var thisWorld:Bitmap;
      
      public var shipBase:ShipBase;
      
      public var matrixBase:MatrixBase;
      
      public var islandBase:IslandBase;
      
      public var raceCount:int;
      
      public var barriers:Barriers;
      
      public var showTooltip:Boolean = false;
      
      private var lastScreen:MovieClip;
      
      public var atmosphery:Sprite;
      
      public var selectedIsland:Island;
      
      public var inputWindow:SubmitScreen;
      
      public var background:MovieClip;
      
      public var allLive:Sprite;
      
      public var islands:Sprite;
      
      public var txtLayer:Sprite;
      
      public var valuesLayer:Sprite;
      
      public var lineLayer:Sprite;
      
      public var effectLayer:Sprite;
      
      public var bottomLayer:Sprite;
      
      public var panelLayer:Sprite;
      
      private var gameTooltip:GameTooltip;
      
      public var gamePanel:GamePanel;
      
      public var delta:Number = 0.02857142857142857;
      
      public var pauseTime:Number = 0;
      
      public var allPauseTime:Number = 0;
      
      public var startLevel:Boolean = false;
      
      public var gameMenuShow:Boolean = false;
      
      public var animationManager:AnimationManager;
      
      public var pauseScreen:Sprite;
      
      public var pauseBitmap:Animation;
      
      public var pauseDeleteTime:Number = 0;
      
      public var pauseAddTime:Number = 0;
      
      public var playerRace:int = 1;
      
      public var nautralRace:int = 0;
      
      public var cpu1:CPUv2;
      
      public var cpu2:CPUv2;
      
      public var cpu3:CPUv2;
      
      public var cpuArray:Array;
      
      public var allIslandForAttack:Array;
      
      public var allIslandForAttackAta:Array;
      
      public var playerClan:String = "Player";
      
      public var neutralClan:String = "Neutral";
      
      public var cpu1Clan:String = "CPU #1";
      
      public var cpu2Clan:String = "CPU #2";
      
      public var cpu3Clan:String = "CPU #3";
      
      public var upgradeShop:UpgradeShop;
      
      public var upgradeTooltip:UpgradeTooltip;
      
      public var gameMenu:GameMenu;
      
      public var tooltip:Tooltip;
      
      public var killedRace:int = 0;
      
      public var startTimeLevel:int = 0;
      
      public var finalTimeLevel:Number = 0;
      
      public var maxTimeForLevel:Number = 0;
      
      public var mnogSecond:int = 10;
      
      public var allPoints:int = 0;
      
      public var levelPoint:Array;
      
      public var nextLevelBool:Boolean = false;
      
      public var pause:Boolean = false;
      
      public var atmosBase:AtmospheryBase;
      
      public var effectManager:EffectManager;
      
      public var popupValues:PopupValues;
      
      public var getColor:GetColor;
      
      public var flagBase:FlagBase;
      
      public var soundManager:SoundManager;
      
      public var valueStock:ValueStock;
      
      public var thicness:int = 1;
      
      public var colorLine:int = 0;
      
      public var colorTrueLine:int = 0;
      
      public var colorLineHelp:int = 0;
      
      private var startPoint:Point;
      
      private var finalPoint:Point;
      
      public var _shift:Number = 0;
      
      public var shift:Number = 0.3;
      
      public var endLevelNow:Boolean = false;
      
      private var countShowUpgrades:int = 0;
      
      private var showUpgradeTooltip:int = 4;
      
      public var upgradeRegenUp:int = 0;
      
      public var upgradeSpeedUp:Number = 1;
      
      public var upgradeCapacityUp:Number = 1;
      
      public var upgradeCapacityCarUp:Number = 0;
      
      public var upgradeSpeedEnemyRed:Number = 1;
      
      public var upgradeMaxTimeRed:Number = 1;
      
      public var upgradeAllAir:Boolean = false;
      
      public function WorldComp()
      {
         this.thisWorld = new Bitmap();
         this.barriers = new Barriers();
         this.pauseScreen = new Sprite();
         this.cpuArray = [];
         this.allIslandForAttack = [];
         this.allIslandForAttackAta = [];
         this.levelPoint = [];
         this.startPoint = new Point();
         this.finalPoint = new Point();
         super();
      }
      
      public static function get returnWorld() : WorldComp
      {
         return _world;
      }
      
      public function startGame() : void
      {
         this.valueStock = new ValueStock();
         this.valueStock._world = this;
         this.valueStock.setValues();
      }
      
      public function init() : void
      {
         this.endLevelNow = false;
         App.state = 3;
         App.soundManager.stopPlaylist();
         App.soundManager.playPlaylist("game",-1,0);
         diffMoney = App.dataSaveManager.get("diffMoney");
         this.gameMenuShow = false;
         this.levelPoint = App.dataSaveManager.get("levelPoint");
         allScores = App.dataSaveManager.get("allScores");
         this.countShowUpgrades = App.dataSaveManager.get("countShowUpgrades");
         money = allScores - diffMoney;
         this.allPauseTime = 0;
         if(this.pause)
         {
            this.checkPause();
         }
         if(this.background == null)
         {
            this.background = new allBack_mc();
            this.background.mouseChildren = false;
            this.background.mouseEnabled = false;
            addChild(this.background);
         }
         this.background.gotoAndStop(XORRandom.randomRangeInt(1,2));
         if(this.soundManager == null)
         {
            this.soundManager = App.soundManager;
         }
         if(this.bottomLayer == null)
         {
            this.bottomLayer = new Sprite();
            this.bottomLayer.mouseChildren = false;
            this.bottomLayer.mouseEnabled = false;
            this.gameTooltip = new GameTooltip();
            addChild(this.bottomLayer);
         }
         if(this.getColor == null)
         {
            this.getColor = new GetColor();
         }
         if(this.allLive == null)
         {
            this.allLive = new Sprite();
            addChild(this.allLive);
         }
         if(this.atmosphery == null)
         {
            this.atmosphery = new Sprite();
            this.atmosphery.mouseChildren = false;
            this.atmosphery.mouseEnabled = false;
            this.allLive.addChild(this.atmosphery);
         }
         if(this.islands == null)
         {
            this.islands = new Sprite();
            this.allLive.addChild(this.islands);
         }
         if(this.shipBase == null)
         {
            this.shipBase = new ShipBase();
         }
         if(this.matrixBase == null)
         {
            this.matrixBase = new MatrixBase();
         }
         if(this.islandBase == null)
         {
            this.islandBase = new IslandBase();
         }
         if(this.txtLayer == null)
         {
            this.txtLayer = new Sprite();
            this.txtLayer.mouseChildren = false;
            this.txtLayer.mouseEnabled = false;
            addChild(this.txtLayer);
         }
         if(this.popupValues == null)
         {
            this.popupValues = new PopupValues();
            this.valuesLayer = new Sprite();
            this.valuesLayer.mouseChildren = false;
            this.valuesLayer.mouseEnabled = false;
            addChild(this.valuesLayer);
         }
         if(this.effectManager == null)
         {
            this.effectLayer = new Sprite();
            this.effectLayer.mouseChildren = false;
            this.effectLayer.mouseEnabled = false;
            addChild(this.effectLayer);
            this.effectManager = new EffectManager();
         }
         if(this.tooltip == null)
         {
            this.tooltip = new Tooltip();
            this.tooltip.hideTooltip();
            this.tooltip.mouseChildren = false;
            this.tooltip.mouseEnabled = false;
         }
         if(this.lineLayer == null)
         {
            this.lineLayer = new Sprite();
            this.lineLayer.mouseChildren = false;
            this.lineLayer.mouseEnabled = false;
            addChild(this.lineLayer);
         }
         if(this.panelLayer == null)
         {
            this.panelLayer = new Sprite();
            this.gamePanel = App.gamePanel;
            addChild(this.panelLayer);
            addChild(this.tooltip);
         }
         this.shipBase.init();
         this.islandBase.init();
         Island._islandBase = this.islandBase;
         Island._shipBase = this.shipBase;
         this.matrixBase.setRandomLelvel();
         this.islandBase.changeButtonMode(false);
         this.startLevel = false;
         if(this.animationManager == null)
         {
            this.animationManager = new AnimationManager();
            this.setAnimation();
            this.pauseBitmap = this.animationManager.getAnimation("Pause");
            this.pauseBitmap.update();
            this.pauseScreen.addEventListener(MouseEvent.CLICK,this.checkPause);
            this.pauseScreen.visible = false;
            this.pauseScreen.buttonMode = true;
            this.pauseScreen.alpha = 0;
            this.pauseScreen.addChild(this.pauseBitmap);
            addChild(this.pauseScreen);
            this.flagBase = new FlagBase();
         }
         this.flagBase.clear();
         if(_world.barriers.setBarrier)
         {
            _world.setBarrier();
         }
         if(this.atmosBase == null)
         {
            this.atmosBase = new AtmospheryBase();
         }
         if(this.gameMenu == null)
         {
            this.gameMenu = new GameMenu();
            this.gameMenu.visible = false;
            this.gameMenu.alpha = 0;
            addChild(this.gameMenu);
         }
         if(this.upgradeShop == null)
         {
            this.upgradeShop = new UpgradeShop();
            this.upgradeShop.x = (App.width_stage - this.upgradeShop.width) / 2;
            this.upgradeShop.y = (App.height_stage - this.upgradeShop.height) / 2;
            this.upgradeShop.visible = false;
            this.upgradeShop._body.exit.addEventListener(MouseEvent.CLICK,this.showUpgrates,false,0,true);
            this.upgradeShop._body.exit2.addEventListener(MouseEvent.CLICK,this.showUpgrates,false,0,true);
            addChild(this.upgradeShop);
            this.upgradeTooltip = new UpgradeTooltip();
            this.upgradeTooltip.hideTooltip();
            addChild(this.upgradeTooltip);
         }
         if(this.inputWindow == null)
         {
            this.inputWindow = new SubmitScreen();
            this.inputWindow.init();
            this.inputWindow.visible = false;
         }
         if(this.lastScreen == null)
         {
            this.lastScreen = new Lastscreen_mc();
            this.lastScreen.visible = false;
            (this.lastScreen.levelmap as SimpleButton).addEventListener(MouseEvent.CLICK,this.Byebyeworld,false,0,true);
            (this.lastScreen.submit as SimpleButton).addEventListener(MouseEvent.CLICK,this.inputWindow.showWindow,false,0,true);
            addChild(this.lastScreen);
            addChild(this.inputWindow);
         }
         this.checkColorLine();
         this.gamePanel.addListener();
         this.upgradeShop.openShop();
         this.islandBase.flagWrite();
         this._Game.removeThis();
         this.gameTooltip.gotoAndPlay();
         this.addEventListener(Event.ENTER_FRAME,this.update);
      }
      
      public function setAnimation() : void
      {
         this.animationManager.addAnimation("Fish","Whale_mc");
         this.animationManager.addAnimation("Fin","SharkFin_mc");
         this.animationManager.addAnimation("Air1","Air1_mc");
         this.animationManager.addAnimation("Air2","Air2_mc");
         this.animationManager.addAnimation("Air3","Air3_mc");
         this.animationManager.addAnimation("Air4","Air4_mc");
         this.animationManager.addAnimation("Ship1","Ship1_mc");
         this.animationManager.addAnimation("Ship2","Ship2_mc");
         this.animationManager.addAnimation("Ship3","Ship3_mc");
         this.animationManager.addAnimation("Ship4","Ship4_mc");
         this.animationManager.addAnimation("Smoke","Smoke_mc");
         this.animationManager.addAnimation("Water1","Water1_mc");
         this.animationManager.addAnimation("Water2","Water2_mc");
         this.animationManager.addAnimation("Water3","Water3_mc");
         this.animationManager.addAnimation("Water4","Water4_mc");
         this.animationManager.addAnimation("Pause","PauseScreen_mc");
         this.animationManager.addAnimation("Blast","Blast_mc");
         this.animationManager.addAnimation("Blast2","Blast2_mc");
         this.animationManager.addAnimation("Blast3","Blast3_mc");
         this.animationManager.addAnimation("Bird","Birds_mc");
         this.popupValues.createAllValues();
      }
      
      public function startDrawLine() : void
      {
         this.addEventListener(MouseEvent.MOUSE_MOVE,this.drawLine,false,0,true);
      }
      
      public function stopDrawLine() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.drawLine);
         this.lineLayer.graphics.clear();
      }
      
      public function checkColorLine(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.colorLineHelp = this.colorTrueLine;
         }
         else
         {
            this.colorLineHelp = this.colorLine;
         }
      }
      
      private function drawLine(param1:MouseEvent = null) : void
      {
         var _loc2_:int = 0;
         if(!this.pause)
         {
            if(DottedLine.active)
            {
               this.lineLayer.graphics.clear();
               this.lineLayer.graphics.lineStyle(this.thicness,this.colorLineHelp);
               if(Island.haveSelect)
               {
                  this._shift += 0.1 * this.shift;
                  _loc2_ = 0;
                  while(_loc2_ < this.allIslandForAttack.length)
                  {
                     if((this.allIslandForAttack[_loc2_] as Island).getRace == this.playerRace)
                     {
                        this.startPoint.x = (this.allIslandForAttack[_loc2_] as Island).x;
                        this.startPoint.y = (this.allIslandForAttack[_loc2_] as Island).y;
                        this.finalPoint.x = mouseX;
                        this.finalPoint.y = mouseY;
                        DottedLine.dashedLine(this.lineLayer.graphics,this.startPoint,this.finalPoint,this._shift);
                     }
                     _loc2_++;
                  }
               }
               else
               {
                  _loc2_ = 0;
                  while(_loc2_ < DottedLine.allIslands.length)
                  {
                     DottedLine.start.x = (DottedLine.allIslands[_loc2_] as Island).x;
                     DottedLine.start.y = (DottedLine.allIslands[_loc2_] as Island).y;
                     DottedLine.dashedLine(this.lineLayer.graphics,null,null,0,false);
                     _loc2_++;
                  }
               }
            }
         }
      }
      
      private function clearCheckIslandForAttack() : void
      {
         DottedLine.allIslands = [];
         while(this.allIslandForAttack.length > 0)
         {
            DottedLine.allIslands[DottedLine.allIslands.length] = this.allIslandForAttack[0] as Island;
            Island.targetIsl = this.allIslandForAttack[0] as Island;
            this.allIslandForAttack[0].removeSelectEffect();
            this.allIslandForAttack.splice(0,1);
         }
         this.allIslandForAttack = [];
         DottedLine.active = true;
      }
      
      public function checkIslandForAttack(param1:Island = null, param2:Boolean = true) : void
      {
         if(param2)
         {
            this.allIslandForAttack[this.allIslandForAttack.length] = param1;
            param1.selected = true;
            param1.setSelectEffect();
         }
         else if(this.allIslandForAttack.length > 1)
         {
            (this.allIslandForAttack[this.allIslandForAttack.length - 1] as Island).removeSelectEffect();
            this.allIslandForAttack.splice(this.allIslandForAttack.length - 1,1);
         }
         else if(this.allIslandForAttack.length == 1)
         {
            this.removeEventListener(MouseEvent.MOUSE_UP,this.deleteListener);
            (this.allIslandForAttack[0] as Island).removeSelected();
            this.clearCheckIslandForAttack();
         }
      }
      
      public function startGameTimer() : void
      {
         this.startTimeLevel = getTimer();
      }
      
      public function startCpuSteps() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.cpuArray.length)
         {
            (this.cpuArray[_loc1_] as CPUv2).playerStepNow();
            _loc1_++;
         }
      }
      
      public function set setCPUCount(param1:int) : void
      {
         this.raceCount = param1;
         if(param1 == 3)
         {
            this.cpu1 = new CPUv2();
            this.cpu1.cpuRace = 2;
            this.cpuArray = [this.cpu1];
         }
         else if(param1 == 4)
         {
            this.cpu1 = new CPUv2();
            this.cpu1.cpuRace = 2;
            this.cpu2 = new CPUv2();
            this.cpu2.cpuRace = 3;
            this.cpuArray = [this.cpu1,this.cpu2];
         }
         else if(param1 == 5)
         {
            this.cpu1 = new CPUv2();
            this.cpu1.cpuRace = 2;
            this.cpu2 = new CPUv2();
            this.cpu2.cpuRace = 3;
            this.cpu3 = new CPUv2();
            this.cpu3.cpuRace = 4;
            this.cpuArray = [this.cpu1,this.cpu2,this.cpu3];
         }
      }
      
      public function setCpuDifficult(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:int) : void
      {
         var _loc10_:int = 0;
         while(_loc10_ < this.cpuArray.length)
         {
            (this.cpuArray[_loc10_] as CPUv2).iteration = param1;
            (this.cpuArray[_loc10_] as CPUv2).freeIteration = param2;
            (this.cpuArray[_loc10_] as CPUv2).bubbleForPlayer = param3;
            (this.cpuArray[_loc10_] as CPUv2).populControl = param4;
            (this.cpuArray[_loc10_] as CPUv2).helpShip = param5;
            (this.cpuArray[_loc10_] as CPUv2).protectIsland = param6;
            (this.cpuArray[_loc10_] as CPUv2).cpuAttackNeutral = param7;
            (this.cpuArray[_loc10_] as CPUv2).cpuChangeIslandForAttack = param8;
            (this.cpuArray[_loc10_] as CPUv2).playerStepd = param9;
            _loc10_++;
         }
      }
      
      public function getCpu(param1:int) : CPUv2
      {
         param1 -= 2;
         return this.cpuArray[param1] as CPUv2;
      }
      
      public function checkPauseWithoutScreen(param1:MouseEvent = null, param2:Boolean = true) : void
      {
         if(this.startLevel)
         {
            if(!App.handMute && !this.gameMenuShow && param2)
            {
               this.soundManager.muteAllSound();
            }
            if(this.pause)
            {
               if(this.startLevel)
               {
                  this.allPauseTime += this.pauseTime - getTimer();
               }
               this.pause = false;
            }
            else
            {
               if(this.startLevel)
               {
                  this.pauseTime = getTimer();
               }
               this.pause = true;
            }
         }
      }
      
      public function checkPause(param1:MouseEvent = null) : void
      {
         var del:*;
         var e:MouseEvent = param1;
         if(this.startLevel)
         {
            if(!App.handMute && !this.gameMenuShow)
            {
               this.soundManager.muteAllSound();
            }
            if(this.pause)
            {
               del = function():void
               {
                  if(startLevel)
                  {
                     allPauseTime += pauseTime - getTimer();
                  }
                  pauseScreen.visible = false;
                  pause = false;
               };
               MFTween.tween(this.pauseScreen,this.pauseDeleteTime,{"alpha":0}).onComplete(del);
            }
            else
            {
               MFTween.tween(this.pauseScreen,this.pauseAddTime,{"alpha":1});
               if(this.startLevel)
               {
                  this.pauseTime = getTimer();
               }
               this.pauseScreen.visible = true;
               this.pause = true;
            }
         }
      }
      
      private function update(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(!this.pause)
         {
            if(this.nextLevelBool)
            {
               this.nextLevel();
            }
            else
            {
               this.shipBase.update();
               this.islandBase.update();
               this.atmosBase.update();
               this.popupValues.update();
               this.effectManager.update();
               this.tooltip.upgrade();
               this.barriers.update();
               this.flagBase.update();
               this.drawLine();
               _loc2_ = 0;
               while(_loc2_ < this.cpuArray.length)
               {
                  (this.cpuArray[_loc2_] as CPUv2).update();
                  _loc2_++;
               }
            }
         }
         this.upgradeTooltip.upgrade();
      }
      
      private function countingPoints() : void
      {
         this.finalTimeLevel += int((getTimer() - this.startTimeLevel + this.allPauseTime) * 0.001 * this.upgradeMaxTimeRed);
         this.levelPoint = App.dataSaveManager.get("levelPoint");
         if(this.finalTimeLevel <= this.maxTimeForLevel)
         {
            this.writeTime();
            this.checkAllPoints();
            this.checkMoney();
         }
         else
         {
            this.finalTimeLevel = this.maxTimeForLevel;
            this.writeTime();
            this.checkAllPoints();
            this.checkMoney();
         }
      }
      
      private function checkMoney() : void
      {
         money = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.levelPoint.length)
         {
            money += ((this.levelPoint[_loc1_] as Object).maxTime - (this.levelPoint[_loc1_] as Object).minTime) * (this.levelPoint[_loc1_] as Object).mnog;
            _loc1_++;
         }
         money -= diffMoney;
         allScores = money + diffMoney;
         App.dataSaveManager.put("allScores",allScores);
      }
      
      private function checkAllPoints() : void
      {
         this.allPoints = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.levelPoint.length)
         {
            if(this.levelPoint[_loc1_] == undefined)
            {
               this.levelPoint[_loc1_] = {
                  "minTime":0,
                  "maxTime":0,
                  "point":0,
                  "mnog":0
               };
            }
            else
            {
               this.allPoints += (this.levelPoint[_loc1_] as Object).point;
            }
            _loc1_++;
         }
      }
      
      private function writeTime() : void
      {
         if(this.levelPoint[targetLevel - 1] != undefined)
         {
            if((this.levelPoint[targetLevel - 1] as Object).point < int((this.maxTimeForLevel - this.finalTimeLevel) * this.mnogSecond))
            {
               this.levelPoint[targetLevel - 1] = {
                  "minTime":this.finalTimeLevel,
                  "maxTime":this.maxTimeForLevel,
                  "point":int((this.maxTimeForLevel - this.finalTimeLevel) * this.mnogSecond),
                  "mnog":this.mnogSecond
               };
            }
         }
         else
         {
            this.levelPoint[targetLevel - 1] = {
               "minTime":this.finalTimeLevel,
               "maxTime":this.maxTimeForLevel,
               "point":int((this.maxTimeForLevel - this.finalTimeLevel) * this.mnogSecond),
               "mnog":this.mnogSecond
            };
         }
         App.dataSaveManager.put("levelPoint",this.levelPoint);
      }
      
      public function get scoreTargetLevel() : int
      {
         return (this.maxTimeForLevel - this.finalTimeLevel) * this.mnogSecond;
      }
      
      public function showUpgrates(param1:MouseEvent = null) : void
      {
         if(this.upgradeShop.visible)
         {
            if(this.startLevel && !this.gameMenuShow)
            {
               this.checkPause();
            }
            App.dataSaveManager.put("money",money);
            App.dataSaveManager.put("diffMoney",diffMoney);
            this.upgradeShop.visible = false;
         }
         else
         {
            if(this.startLevel && !this.gameMenuShow)
            {
               this.checkPause();
            }
            diffMoney = App.dataSaveManager.get("diffMoney");
            money = App.dataSaveManager.get("money");
            this.upgradeShop.openShop();
            this.upgradeShop.visible = true;
         }
      }
      
      public function showMenu(param1:MouseEvent = null, param2:Boolean = true) : void
      {
         var del:*;
         var e:MouseEvent = param1;
         var endLevel:Boolean = param2;
         if(this.gameMenuShow)
         {
            this.gameMenuShow = false;
         }
         else
         {
            this.gameMenuShow = true;
         }
         if(this.pause)
         {
            if(endLevel)
            {
               this.checkPauseWithoutScreen(null,false);
            }
            else if(this.startLevel)
            {
               this.checkPause();
            }
            else
            {
               this.checkPauseWithoutScreen();
            }
         }
         else
         {
            this.checkPauseWithoutScreen();
         }
         if(this.gameMenu.visible)
         {
            del = function():void
            {
               gameMenuShow = false;
               gameMenu.visible = false;
            };
            if(!App.handMute && !this.startLevel && !endLevel)
            {
               this.soundManager.muteAllSound();
            }
            MFTween.tween(this.gameMenu,this.pauseDeleteTime,{"alpha":0}).onComplete(del);
            if(endLevel)
            {
               this.nextLevelBool = true;
            }
         }
         else
         {
            if(!App.handMute && !endLevel)
            {
               this.soundManager.muteAllSound();
            }
            MFTween.tween(this.gameMenu,this.pauseAddTime,{"alpha":1});
            this.gameMenu.visible = true;
            this.nextLevelBool = false;
            this.gameMenuShow = true;
         }
      }
      
      public function resumeGame(param1:MouseEvent) : void
      {
         this.showMenu(null,false);
      }
      
      public function showSurelyMenu(param1:MouseEvent = null) : void
      {
         if(!_world.upgradeShop.visible)
         {
            this.gameMenu.playerWin(false,false);
            this.showMenu(null,false);
         }
      }
      
      public function playerWin() : void
      {
         this.soundManager.stopPlaylist();
         this.soundManager.playShortSound("victory");
         this.endLevelNow = true;
         this.countingPoints();
         if(LevelMap.completeLevels + 1 == targetLevel)
         {
            ++LevelMap.completeLevels;
         }
         if(targetLevel == App.maxLevel)
         {
            this.showLastScreen();
            this.inputWindow.showWindow();
            App.dataSaveManager.put("completeLevels",LevelMap.completeLevels);
            App.dataSaveManager.put("money",money);
            App.dataSaveManager.put("diffMoney",diffMoney);
            App.dataSaveManager.put("levelPoint",this.levelPoint);
         }
         else
         {
            this.gameMenu.playerWin(true);
            this.showMenu();
            App.dataSaveManager.put("completeLevels",LevelMap.completeLevels);
            App.dataSaveManager.put("money",money);
            App.dataSaveManager.put("diffMoney",diffMoney);
            App.dataSaveManager.put("levelPoint",this.levelPoint);
            this.showUpgradeShop();
         }
      }
      
      private function showUpgradeShop() : void
      {
         var _loc1_:int = 100000;
         switch(this.countShowUpgrades)
         {
            case 0:
               _loc1_ = 200;
               break;
            case 1:
               _loc1_ = 500;
               break;
            case 2:
               _loc1_ = 1000;
               break;
            case 3:
               _loc1_ = 1500;
               break;
            default:
               _loc1_ = 1000000;
         }
         if(money > _loc1_)
         {
            ++this.countShowUpgrades;
            this.showUpgrates();
         }
         if(this.showUpgradeTooltip > 0)
         {
            --this.showUpgradeTooltip;
            this.gameMenu.gamemenus.UpgradeTooltip.visible = false;
         }
         else
         {
            this.gameMenu.gamemenus.UpgradeTooltip.visible = true;
            this.showUpgradeTooltip = 4;
         }
         App.dataSaveManager.put("countShowUpgrades",this.countShowUpgrades);
      }
      
      private function showLastScreen() : void
      {
         var del:*;
         this.removeEventListener(Event.ENTER_FRAME,this.update);
         if(this.lastScreen.visible)
         {
            del = function():void
            {
               lastScreen.visible = false;
            };
            this.lastScreen.alpha = 1;
            MFTween.tween(this.lastScreen,1,{"alpha":0}).onComplete(del);
         }
         else
         {
            this.gameMenuShow = false;
            App.state = 2;
            this.gamePanel.checkBtn();
            (this.lastScreen.allScores as TextField).defaultTextFormat = new TextFormat(null,null,null,true);
            this.lastScreen.allScores.text = String(WorldComp.allScores);
            this.lastScreen.alpha = 0;
            this.lastScreen.visible = true;
            MFTween.tween(this.lastScreen,1,{"alpha":1});
         }
      }
      
      public function playerLose() : void
      {
         this.soundManager.stopPlaylist();
         this.soundManager.playShortSound("lose");
         this.endLevelNow = true;
         this.gameMenu.playerWin(false);
         this.showMenu();
      }
      
      public function restartLevel(param1:MouseEvent = null) : void
      {
         this.showMenu();
         this.endLevel();
      }
      
      public function buttonRestart() : void
      {
         if(!this.pause)
         {
            this.endLevel();
         }
      }
      
      public function buttonMenu() : void
      {
         if(!this.pause)
         {
            this.showUpgrates();
         }
      }
      
      public function nextLevel(param1:MouseEvent = null) : void
      {
         this.gameMenu.deleteListener();
         ++targetLevel;
         this.showMenu();
         this.endLevel();
      }
      
      public function endLevel(param1:MouseEvent = null, param2:Boolean = true) : void
      {
         if(!this.pause)
         {
            this.flagBase.clear();
            this.islandBase.clear();
            this.shipBase.clear();
            this.removeEventListener(Event.ENTER_FRAME,this.update);
            Island.firstStep = true;
            Island.haveSelect = false;
            this.killedRace = 0;
            this.gameTooltip.delet();
            this.lineLayer.graphics.clear();
            this.cpuArray = [];
            this.effectManager.clear();
            this.pause = false;
            this.popupValues.clear();
            this.finalTimeLevel = 0;
            this.nextLevelBool = false;
            this.startLevel = false;
            this.barriers.setBarrier = false;
            this.barriers.clear();
            if(param2)
            {
               this.init();
            }
         }
      }
      
      public function returnStringRace(param1:int) : String
      {
         if(param1 == 0)
         {
            return this.neutralClan;
         }
         if(param1 == 1)
         {
            return this.playerClan;
         }
         if(param1 == 2)
         {
            return this.cpu1Clan;
         }
         if(param1 == 3)
         {
            return this.cpu2Clan;
         }
         if(param1 == 4)
         {
            return this.cpu3Clan;
         }
         return "Unknow";
      }
      
      public function setBarrier() : void
      {
         this.barriers.addBarrier("Whirlpool");
      }
      
      public function waitUp(param1:Island) : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.deleteListener);
         this.selectedIsland = param1;
      }
      
      private function deleteListener(param1:MouseEvent) : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.deleteListener);
         if(this.selectedIsland)
         {
            if(this.selectedIsland.selected)
            {
               (this.selectedIsland as Island).select();
            }
         }
         this.clearCheckIslandForAttack();
      }
      
      public function Byebyeworld(param1:MouseEvent) : void
      {
         if(this.gameMenuShow)
         {
            if(this.gameMenu.visible)
            {
               this.gameMenu.visible = false;
               this.pauseScreen.visible = false;
               this.pauseScreen.alpha = 0;
               this.checkPauseWithoutScreen();
               if(!App.handMute && !this.endLevelNow)
               {
                  App.soundManager.muteAllSound();
               }
            }
         }
         else
         {
            this.showLastScreen();
         }
         var _loc2_:Rectangle = new Rectangle();
         _loc2_.x = 0;
         _loc2_.y = 0;
         _loc2_.width = stage.stageWidth;
         _loc2_.height = stage.stageHeight;
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         var _loc4_:Matrix;
         (_loc4_ = new Matrix()).translate(-_loc2_.x,-_loc2_.y);
         _loc4_.scale(this.scaleX,this.scaleY);
         _loc3_.draw(this,_loc4_);
         this.thisWorld.bitmapData = _loc3_;
         this.thisWorld.visible = true;
         this.startLevel = false;
         this._Game.gameScreenShot = this.thisWorld;
         this._Game.levelMap.checkLevelComplete();
         this._Game.doingScreenShot();
         this._Game.allScreens.addChild(this.thisWorld);
         this.endLevel(null,false);
         this._Game.allWorlds.removeChild(this);
         this.soundManager.stopPlaylist();
         this.soundManager.playPlaylist("menu",0,2);
         this._Game.returnLevelMap();
      }
      
      public function submitScores(param1:MouseEvent = null) : void
      {
         var o:Object = null;
         var boardID:String = null;
         var e:MouseEvent = param1;
         if(String(this.inputWindow.clip.input_name.text).length > 16)
         {
            this.inputWindow.clip.input_name.text = this.inputWindow.clip.input_name.text.substr(0,15);
         }
         if(String(this.inputWindow.clip.input_name.text).length > 3)
         {
            this.inputWindow.visible = false;
            o = {
               "n":[2,7,0,3,4,3,4,14,6,9,12,2,4,7,1,0],
               "f":function(param1:Number, param2:String):String
               {
                  if(param2.length == 16)
                  {
                     return param2;
                  }
                  return this.f(param1 + 1,param2 + this.n[param1].toString(16));
               }
            };
            boardID = String(o.f(0,""));
            MochiScores.showLeaderboard({
               "boardID":boardID,
               "score":allScores,
               "name":this.inputWindow.clip.input_name.text
            });
         }
         else
         {
            this.inputWindow.error();
         }
      }
   }
}
