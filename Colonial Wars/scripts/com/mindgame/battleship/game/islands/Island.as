package com.mindgame.battleship.game.islands
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.CPUv2;
   import com.mindgame.battleship.game.islands.flags.Flag;
   import com.mindgame.battleship.game.ship.ShipBase;
   import com.mindgame.framework.*;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   
   public class Island extends MovieClip
   {
      
      public static var firstStep:Boolean = true;
      
      public static var X:int;
      
      public static var Y:int;
      
      public static var haveSelect:Boolean = false;
      
      public static var targetIsl:Island;
      
      protected static var _world:WorldComp = WorldComp.returnWorld;
      
      public static var _shipBase:ShipBase;
      
      public static var _islandBase:IslandBase;
      
      protected static var getColor:GetColor = GetColor.returnGetColor;
       
      
      public var people:Number;
      
      private var peopleForReturn:int;
      
      public var maxPeople:int;
      
      public var type:int = 1;
      
      protected var race:int = 0;
      
      public var speedRegeneration:Number = 1;
      
      public var plusArmy:int = 10;
      
      public var number:int;
      
      public var belong:Boolean = false;
      
      public var clip:MovieClip;
      
      protected var txt:TextField;
      
      public var attackEnemy:int;
      
      public var cpu:CPUv2;
      
      protected var upFrame:Sprite;
      
      protected var bottomFrame:Sprite;
      
      protected var playerRace:int;
      
      public var selected:Boolean = false;
      
      public var beCaptured:Boolean = false;
      
      protected var timeForShowFlag:int = 105;
      
      protected var timeForShowFlagHelp:int;
      
      public var showFlag:Boolean = true;
      
      public var cantHideFlag:Boolean = false;
      
      public var flag:Flag;
      
      private var textSize:int;
      
      private var firstPlay:Boolean = true;
      
      public function Island()
      {
         this.playerRace = _world.playerRace;
         this.timeForShowFlagHelp = this.timeForShowFlag;
         this.textSize = _world.valueStock.size2;
         super();
      }
      
      public function destroyIsland() : void
      {
         this.clip = null;
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.select);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.select);
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.selectEffect);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.unSelectEffect);
         this.cpu = null;
         if(this.flag)
         {
            this.flag.remove();
         }
         _world.islands.removeChild(this);
      }
      
      protected function init() : void
      {
         this.clip.gotoAndStop(int(Math.random() * this.clip.totalFrames + 1));
         this.clip.island.border.visible = false;
         addChild(this.clip);
         _shipBase = _world.shipBase;
         _islandBase = _world.islandBase;
         _world.islands.addChild(this);
         this.createText();
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.select,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,this.select,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.selectEffect,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.unSelectEffect,false,0,true);
      }
      
      private function createText() : void
      {
         this.txt = new TextField();
         this.txt.defaultTextFormat = new TextFormat("Tahoma Regular",this.textSize,0);
         this.txt.height = 10;
         this.txt.x -= this.txt.width * 0.5;
         this.txt.y -= this.txt.height;
         this.txt.background = true;
         this.txt.autoSize = TextFieldAutoSize.CENTER;
         this.txt.selectable = false;
         this.txt.mouseEnabled = false;
         addChild(this.txt);
         this.txt.filters = [new DropShadowFilter(3,45,819,0.6,4,4)];
         this.upFrame = new Frame_mc();
         this.bottomFrame = new Frame_mc();
         this.upFrame.mouseChildren = false;
         this.upFrame.mouseEnabled = false;
         this.bottomFrame.mouseChildren = false;
         this.bottomFrame.mouseEnabled = false;
         this.upFrame.y = this.txt.y;
         addChild(this.upFrame);
         addChild(this.bottomFrame);
      }
      
      public function changeRace(param1:int = 0) : void
      {
         if(this.firstPlay)
         {
            if(this.flag != null)
            {
               this.flag.visible = true;
            }
            this.timeForShowFlagHelp = 0;
            this.firstPlay = false;
         }
         else
         {
            if(this.flag != null)
            {
               this.flag.visibleOff();
            }
            this.timeForShowFlagHelp = this.timeForShowFlag;
         }
         this.showFlag = false;
         this.race = param1;
         this.txt.backgroundColor = getColor.getRaceColor(this.race);
         if(this.race != this.playerRace)
         {
            this.setStroke();
            _world.stopDrawLine();
         }
      }
      
      public function minusShowFlagTime() : Boolean
      {
         if(this.timeForShowFlagHelp - 1 < 0)
         {
            return true;
         }
         --this.timeForShowFlagHelp;
         return false;
      }
      
      public function get getRace() : int
      {
         return this.race;
      }
      
      public function setSetup(param1:int = 0, param2:int = 0, param3:int = 0, param4:Number = 1, param5:int = 10) : void
      {
         this.changeRace(param3);
         this.people = param1;
         this.maxPeople = param2;
         this.speedRegeneration = param4;
         this.plusArmy = param5;
         this.editText();
      }
      
      private function editText() : void
      {
         if(this.txt == null)
         {
            this.createText();
         }
         this.txt.text = String(int(this.people));
         this.bottomFrame.y = this.txt.y + this.txt.height;
         this.upFrame.width = this.txt.width + 4;
         this.bottomFrame.width = this.txt.width + 4;
      }
      
      public function deffPeople(param1:int, param2:int) : void
      {
         if(this.race == param2)
         {
            this.plusPeople = param1;
         }
         else
         {
            this.minusPeople(param1,param2);
         }
         this.editText();
      }
      
      public function get getPeoples() : int
      {
         if(this.race == this.playerRace)
         {
            this.peopleForReturn = this.people * (0.5 + _world.upgradeCapacityCarUp);
         }
         else
         {
            this.peopleForReturn = this.people * 0.5;
         }
         this.people -= this.peopleForReturn;
         this.editText();
         if(this.race == this.playerRace)
         {
            this.setStroke();
         }
         return int(this.peopleForReturn);
      }
      
      public function minusPeople(param1:int, param2:int) : void
      {
         if(this.people - param1 >= 0)
         {
            this.people -= param1;
         }
         else
         {
            _islandBase.checkRaceIsland(this,param1,param2);
         }
         if(this.race == this.playerRace)
         {
            this.setStroke();
         }
      }
      
      public function set plusPeople(param1:int) : void
      {
         this.people += param1;
         if(this.race == this.playerRace)
         {
            this.setStroke();
         }
      }
      
      public function get getStringRegen() : String
      {
         if(this.getRace == this.playerRace)
         {
            return String(this.speedRegeneration + "+" + _world.upgradeRegenUp);
         }
         return String(this.speedRegeneration);
      }
      
      public function get getRegen() : int
      {
         if(this.getRace == this.playerRace)
         {
            return this.speedRegeneration + _world.upgradeRegenUp;
         }
         return this.speedRegeneration;
      }
      
      public function set timerPlusPeople(param1:int) : void
      {
         if(this.race == this.playerRace)
         {
            if(this.people < this.maxPeople * _world.upgradeCapacityUp)
            {
               if(this.people + param1 >= this.maxPeople * _world.upgradeCapacityUp)
               {
                  this.people = this.maxPeople * _world.upgradeCapacityUp;
                  this.setStroke();
               }
               else
               {
                  this.people += param1;
               }
               this.editText();
            }
            else if(this.people > this.maxPeople * _world.upgradeCapacityUp)
            {
               --this.people;
               this.editText();
            }
         }
         else if(this.people < this.maxPeople)
         {
            if(this.people + param1 == this.maxPeople)
            {
               this.people = this.maxPeople;
            }
            else
            {
               this.people += param1;
            }
            this.editText();
         }
         else if(this.people > this.maxPeople)
         {
            --this.people;
            this.editText();
         }
      }
      
      public function alarm(param1:int) : void
      {
         if(this.cpu != null)
         {
            this.cpu.protectedIsland(param1,this);
         }
      }
      
      private function selectEffect(param1:MouseEvent) : void
      {
         _world.tooltip.showTooltip(x,y,(width + height) * 0.2,this);
         _world.checkColorLine(true);
         if(haveSelect && !this.selected && this.getRace == this.playerRace)
         {
            _world.checkIslandForAttack(this);
         }
      }
      
      private function unSelectEffect(param1:MouseEvent) : void
      {
         _world.tooltip.hideTooltip();
         if(!DottedLine.inEnd)
         {
            _world.checkColorLine();
         }
      }
      
      public function setStroke() : void
      {
         if(this.getRace == this.playerRace)
         {
            if(this.people >= this.maxPeople)
            {
               if(!this.selected)
               {
                  this.filters = [new GlowFilter(16711680,1,6,6,3,5,false,false)];
               }
            }
            else if(!this.selected)
            {
               this.filters = [];
            }
         }
         else
         {
            this.filters = [];
         }
      }
      
      public function setSelectEffect() : void
      {
         targetIsl = this;
         this.clip.island.border.visible = true;
      }
      
      public function removeSelectEffect() : void
      {
         if(targetIsl)
         {
            targetIsl.clip.island.border.visible = false;
            targetIsl.selected = false;
         }
      }
      
      public function removeSelected() : void
      {
         _world.stopDrawLine();
         this.selected = false;
         haveSelect = false;
         this.setStroke();
         this.removeSelectEffect();
      }
      
      public function select(param1:MouseEvent = null) : void
      {
         var _loc2_:int = 0;
         if(this.buttonMode)
         {
            if(!_world.pause)
            {
               if(this.selected && _world.allIslandForAttack[0] == this)
               {
                  DottedLine.active = false;
                  this.removeSelected();
               }
               else if(!haveSelect)
               {
                  X = x;
                  Y = y;
                  DottedLine.active = true;
                  DottedLine.inEnd = false;
                  _world.startDrawLine();
                  _world.checkIslandForAttack(this);
                  this.setSelectEffect();
                  haveSelect = true;
                  this.selected = true;
                  _world.waitUp(this);
               }
               else
               {
                  DottedLine.inEnd = true;
                  _world.stopDrawLine();
                  this.removeSelectEffect();
                  _loc2_ = 0;
                  while(_loc2_ < _world.allIslandForAttack.length)
                  {
                     if(_world.allIslandForAttack[_loc2_] != this)
                     {
                        _shipBase.setStartIslandPl = _world.allIslandForAttack[_loc2_] as Island;
                        _shipBase.setFinalIslandPl = this;
                        _shipBase.startShipMove(1,true);
                     }
                     _loc2_++;
                  }
                  _world.startCpuSteps();
                  haveSelect = false;
                  if(firstStep)
                  {
                     _world.startGameTimer();
                     firstStep = false;
                     _world.startLevel = true;
                  }
               }
               _islandBase.changeButtonMode(haveSelect);
            }
         }
      }
   }
}
