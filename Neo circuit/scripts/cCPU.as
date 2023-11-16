package
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Expo;
   import hud.cEnergyBar;
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   import org.flixel.FlxText;
   import patterns.cEnum;
   import utils.cVector2;
   
   public class cCPU extends FlxSprite
   {
      
      public static const FADE_TIME:Number = 0.5;
      
      private static const MAX_CONNECTIONS:int = 3;
      
      private static const START_POWER:int = 5;
      
      private static const USED_CONNECTION_POSY:int = 51;
      
      private static const CPU_SIZEX:int = 96;
      
      private static const CPU_SIZEY:int = 96;
      
      private static const POWERBAR_POSX:int = 24;
      
      private static const POWERBAR_POSY:Array = [20,18,34,20];
      
      private static const POWERBAR_SIZEX:int = 48;
      
      private static const POWERBAR_SIZEY:int = 24;
      
      private static const NUMPOWER_COUNTERS:int = 8;
      
      private static const REMOVE_VELOCITY:int = FlxG.width * 1.25;
      
      private static const UPGRADE_DELAY:Number = 0.1;
      
      public static const NEUTRAL:int = cEnum.Enum(0);
      
      public static const PLAYER01:int = cEnum.inc;
      
      public static const PLAYER02:int = cEnum.inc;
      
      public static const PLAYER03:int = cEnum.inc;
      
      public static const PLAYER04:int = cEnum.inc;
      
      private static const UPGRADEBAR_WIDTH:Number = 48;
      
      private static const UPGRADEBAR_HEIGHT:Number = 4;
      
      private static const UPGRADEBAR_BGCOLORS:Array = [4278190080,4278190080];
      
      private static const UPGRADEBAR_COLORS:Array = [4294901760,4294967040];
       
      
      public var owner:int;
      
      public var power:Number;
      
      public var connectionSlots:Array;
      
      public var connections:Array;
      
      public var foreignConnections:Array;
      
      public var aiData:cCpuAiData;
      
      public var data:cCPUData;
      
      public var underAttack:Boolean;
      
      public var justUpgraded:Boolean;
      
      private var m_effectCopy:FlxSprite;
      
      private var m_text:FlxText;
      
      private var m_productionTime:Number;
      
      private var m_sendTimer:Number;
      
      private var m_upgradeBar:cEnergyBar;
      
      private var m_upgradPoints:Number = 0;
      
      private var m_produce:Boolean;
      
      private var m_usedConnections:FlxSprite;
      
      private var m_powerBar:FlxSprite;
      
      private var m_upgradePoints:Number;
      
      private var m_selection:FlxSprite;
      
      private var m_upgradeStarted:Boolean;
      
      private var m_upgradeTime:Number;
      
      public function cCPU()
      {
         this.connectionSlots = [null,null,null];
         this.aiData = new cCpuAiData();
         super(0,0);
         loadGraphic(NeoCircuit.GFX.playerCPU[0],true,false,CPU_SIZEX,CPU_SIZEY);
         addAnimation("0",[0]);
         addAnimation("1",[1]);
         addAnimation("2",[2]);
         this.m_upgradePoints = 0;
      }
      
      override public function destroy() : void
      {
         if(this.m_powerBar != null)
         {
            this.m_powerBar.destroy();
         }
         super.destroy();
      }
      
      public function init(param1:int, param2:Number, param3:Number, param4:Number, param5:cCPUData, param6:Boolean = true) : void
      {
         this.data = param5;
         this.owner = param1;
         this.power = param4;
         reset(param2,param3);
         this.createUsedConnectionGfx();
         loadGraphic(this.data.gfxList[param1],true,false,CPU_SIZEX,CPU_SIZEY);
         play(this.data.upgradeLevel.toString(),true);
         this.connections = [];
         this.foreignConnections = [];
         this.m_productionTime = this.data.prodSpeed;
         this.m_sendTimer = this.data.sendSpeed;
         this.m_upgradeStarted = false;
         this.m_produce = param6;
         this.m_upgradeTime = 0;
         this.justUpgraded = false;
      }
      
      public function place(param1:Number) : void
      {
         if(this.m_text != null)
         {
            this.m_text.visible = false;
         }
         alpha = 0;
         scale.x = scale.y = 10;
         TweenLite.to(this,cMap.SHOW_DELAY,{
            "delay":param1,
            "alpha":1
         });
         TweenLite.to(scale,cMap.SHOW_DELAY,{
            "delay":param1,
            "x":1,
            "y":1,
            "onComplete":this.shake
         });
      }
      
      private function shake() : void
      {
         if(this.m_text != null)
         {
            this.m_text.visible = true;
         }
         this.createPowerText();
         FlxG.play(NeoCircuit.SFX.SndPlaceChip,0.5);
         FlxG.shake(0.005,cMap.SHOW_DELAY);
      }
      
      public function removeOnResult() : void
      {
         if(this.m_selection != null)
         {
            this.m_selection.kill();
         }
         if(this.m_text != null)
         {
            this.m_text.kill();
         }
         if(this.m_usedConnections != null)
         {
            this.m_usedConnections.kill();
         }
         do
         {
            if(this.m_powerBar != null)
            {
               this.m_powerBar.kill();
            }
            this.cutAllConnections();
         }
         while(false);
         
         var _loc1_:Number = FlxG.width * 0.5 - (x + origin.x);
         var _loc2_:Number = FlxG.height * 0.5 - (y + origin.y);
         var _loc3_:cVector2 = new cVector2(_loc1_,_loc2_);
         _loc3_.normalize();
         _loc1_ = x + _loc3_.x * REMOVE_VELOCITY;
         _loc2_ = y + _loc3_.y * REMOVE_VELOCITY;
         TweenLite.to(this,1,{
            "x":_loc1_,
            "y":_loc2_,
            "ease":Expo.easeOut
         });
      }
      
      public function updateTextPos() : void
      {
         if(this.m_text == null)
         {
            return;
         }
         this.m_text.reset(x - 2,y + POWERBAR_POSY[this.data.type]);
         this.m_powerBar.x = x + POWERBAR_POSX;
         this.m_powerBar.y = y + POWERBAR_POSY[this.data.type];
      }
      
      public function addPower(param1:Number = 1) : void
      {
         this.power += param1;
         if(this.data.space < this.power)
         {
            this.power = this.data.space;
         }
         this.setPowerText();
      }
      
      public function tryUpgrading(param1:Number = 0) : void
      {
         var _loc2_:int = 0;
         if(this.power <= 0)
         {
            if(this.m_upgradeStarted)
            {
               TweenMax.killTweensOf(scale,true);
               this.m_upgradeStarted = false;
            }
            return;
         }
         if(this.m_upgradeTime > 0)
         {
            if(this.owner == PLAYER01)
            {
               this.m_upgradeTime -= FlxG.elapsed;
            }
            else
            {
               this.m_upgradeTime -= param1;
            }
            if(this.m_upgradeTime > 0 || this.owner == PLAYER01)
            {
               return;
            }
         }
         if(!this.m_upgradeStarted && this.owner == PLAYER01)
         {
            TweenMax.killTweensOf(scale,true);
            TweenMax.to(scale,0.15,{
               "x":0.9,
               "y":0.9,
               "yoyo":true,
               "repeat":-1
            });
         }
         this.m_upgradeStarted = true;
         this.justUpgraded = false;
         if(this.data.pointsToUpgrade > 0)
         {
            _loc2_ = this.m_upgradePoints * (NeoCircuit.SFX.upgrade.length / this.data.pointsToUpgrade);
            FlxG.play(NeoCircuit.SFX.upgrade[_loc2_],0.5);
            this.m_upgradePoints += 1;
            this.removePower(1);
            this.m_upgradeTime = UPGRADE_DELAY;
            if(this.m_upgradePoints >= this.data.pointsToUpgrade)
            {
               this.upgrade();
               this.m_upgradeTime = 0;
               this.m_upgradePoints = 0;
               this.m_upgradeStarted = false;
               this.justUpgraded = true;
               return;
            }
         }
      }
      
      public function removePower(param1:Number = 1) : void
      {
         this.power -= param1;
         if(this.power < 0)
         {
            this.power = 0;
         }
         this.setPowerText();
      }
      
      public function hasFreeConnection() : Boolean
      {
         return this.data.maxConnections > this.connections.length;
      }
      
      public function attackPower(param1:cCPU) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Number = param1.data.powerStrength;
         var _loc3_:cConnection = this.getCounterConnection(param1);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.numPowersAlive();
            while(_loc4_ > 0 && _loc2_ > 0)
            {
               _loc2_ = _loc3_.attackFrontPower(_loc2_);
               _loc4_ = _loc3_.numPowersAlive();
            }
         }
         _loc2_ /= this.data.defense;
         this.power -= _loc2_;
         if(this.power <= 0)
         {
            this.setNewOwner(param1.owner);
         }
         this.setPowerText();
      }
      
      public function setNewOwner(param1:int) : void
      {
         this.owner = param1;
         loadGraphic(this.data.gfxList[this.owner],true,false,CPU_SIZEX,CPU_SIZEY);
         play(this.data.upgradeLevel.toString(),true);
         TweenMax.killTweensOf(scale,true);
         this.cutAllConnections();
         this.power = START_POWER;
         this.underAttack = this.checkUnderAttack();
      }
      
      public function hasConnectionTo(param1:cCPU) : Boolean
      {
         var _loc2_:cConnection = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.connections.length)
         {
            _loc2_ = this.connections[_loc3_] as cConnection;
            if(_loc2_.endCPU == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      override public function update() : void
      {
         if(this.m_upgradeBar != null)
         {
            this.m_upgradeBar.update();
         }
         this.produce();
         this.sendPower();
         super.update();
      }
      
      override public function draw() : void
      {
         super.draw();
         if(this.m_powerBar != null && this.m_powerBar.alive)
         {
            this.m_powerBar.draw();
         }
         if(this.connections.length > 0 && this.m_usedConnections.alive)
         {
            this.m_usedConnections.draw();
         }
      }
      
      override public function kill() : void
      {
         if(this.m_text != null)
         {
            this.m_text.kill();
            this.m_text = null;
         }
         if(this.m_upgradeBar != null)
         {
            this.m_upgradeBar.kill();
         }
         super.kill();
      }
      
      public function select(param1:Boolean, param2:int = 1) : void
      {
         if(param1)
         {
            if(this.m_selection == null)
            {
               TweenLite.killTweensOf(scale,true);
               this.m_selection = cObjectManager.getInstance().getFreeSelection();
               this.m_selection.x = x - 4;
               this.m_selection.y = y;
               this.m_selection.frame = param2;
               TweenMax.to(scale,0.5,{
                  "x":1.05,
                  "y":1.05,
                  "yoyo":true,
                  "repeat":-1
               });
               if(param2 == 0)
               {
                  FlxG.play(NeoCircuit.SFX.SndHover2,0.5);
               }
            }
         }
         else if(this.m_selection)
         {
            TweenLite.killTweensOf(scale,true);
            this.m_selection.kill();
            this.m_selection = null;
         }
      }
      
      private function createUsedConnectionGfx() : void
      {
         if(this.data.type != cCPUData.BARRIER && this.data.type != cCPUData.HUB)
         {
            this.m_usedConnections = new FlxSprite();
            this.m_usedConnections.loadGraphic(NeoCircuit.GFX.ImgUsedConnections,true,false,96,5);
            this.m_usedConnections.addAnimation("01",[0]);
            this.m_usedConnections.addAnimation("11",[1]);
            this.m_usedConnections.addAnimation("12",[2]);
            this.m_usedConnections.addAnimation("21",[1]);
            this.m_usedConnections.addAnimation("22",[3]);
            this.m_usedConnections.addAnimation("23",[4]);
            this.m_usedConnections.x = x;
            this.m_usedConnections.y = y + USED_CONNECTION_POSY;
         }
         else if(this.data.type == cCPUData.HUB)
         {
            this.m_usedConnections = new FlxSprite();
            this.m_usedConnections.loadGraphic(NeoCircuit.GFX.ImgUsedConnections2,true,false,96,96);
            this.m_usedConnections.addAnimation("01",[0]);
            this.m_usedConnections.addAnimation("02",[1]);
            this.m_usedConnections.addAnimation("03",[2]);
            this.m_usedConnections.addAnimation("04",[3]);
            this.m_usedConnections.addAnimation("11",[0]);
            this.m_usedConnections.addAnimation("12",[1]);
            this.m_usedConnections.addAnimation("13",[2]);
            this.m_usedConnections.addAnimation("14",[3]);
            this.m_usedConnections.addAnimation("21",[0]);
            this.m_usedConnections.addAnimation("22",[1]);
            this.m_usedConnections.addAnimation("23",[2]);
            this.m_usedConnections.addAnimation("24",[3]);
            this.m_usedConnections.x = x;
            this.m_usedConnections.y = y;
         }
      }
      
      public function createPowerText() : void
      {
         this.createPowerBar();
         if(this.m_text != null)
         {
            this.m_text.kill();
            this.m_text = null;
         }
         if(this.data.type != cCPUData.BARRIER)
         {
            this.m_text = cObjectManager.getInstance().getFreeCPUText(this);
            this.m_text.size = cObjectManager.TEXT_SIZES[this.data.upgradeLevel];
            this.updateTextPos();
            this.setPowerText();
         }
      }
      
      public function toggleGameSpeed() : void
      {
         var _loc1_:cConnection = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.connections.length)
         {
            _loc1_ = this.connections[_loc2_] as cConnection;
            _loc1_.toggleGameSpeed();
            _loc2_++;
         }
      }
      
      public function setPowerText() : void
      {
         if(this.m_text == null)
         {
            return;
         }
         if(this.power < 0)
         {
            return;
         }
         var _loc1_:int = this.power;
         this.m_text.text = _loc1_.toString();
         if(!this.m_upgradeStarted)
         {
            this.m_powerBar.frame = this.power * (NUMPOWER_COUNTERS / this.data.space) - 1;
         }
         else
         {
            this.m_powerBar.frame = this.m_upgradePoints * (NUMPOWER_COUNTERS / this.data.pointsToUpgrade) - 1 + NUMPOWER_COUNTERS;
         }
      }
      
      private function upgrade() : void
      {
         var _loc1_:Number = width;
         var _loc2_:Number = height;
         this.data = cObjectManager.getInstance().cpuDataList[this.data.upgradeType];
         var _loc3_:Number = x - (width - _loc1_) * 0.5;
         var _loc4_:Number = y - (height - _loc2_) * 0.5;
         reset(_loc3_,_loc4_);
         this.m_productionTime = this.data.prodSpeed;
         this.m_sendTimer = this.data.sendSpeed;
         do
         {
            play(this.data.upgradeLevel.toString(),true);
            this.m_usedConnections.play(this.data.upgradeLevel.toString() + this.connections.length.toString());
         }
         while(false);
         
         scale.x = scale.y = 1;
         TweenMax.killTweensOf(scale,true);
         TweenMax.to(scale,0.5,{
            "x":1.25,
            "y":1.25,
            "yoyo":true,
            "repeat":3
         });
         if(this.owner == cCPU.PLAYER01)
         {
            FlxG.play(NeoCircuit.SFX.SndUpgrade);
         }
      }
      
      private function createPowerBar() : void
      {
         if(this.data.type == cCPUData.BARRIER)
         {
            return;
         }
         this.m_powerBar = new FlxSprite(x + POWERBAR_POSX,y + POWERBAR_POSY[this.data.type]);
         this.m_powerBar.loadGraphic(NeoCircuit.GFX.ImgPowerBar,true,false,POWERBAR_SIZEX,POWERBAR_SIZEY,false);
      }
      
      public function sendPower() : void
      {
         var _loc2_:cConnection = null;
         var _loc3_:int = 0;
         if(this.connections.length == 0)
         {
            return;
         }
         this.m_sendTimer -= FlxG.elapsed;
         var _loc1_:int = 0;
         if(this.m_sendTimer <= 0)
         {
            _loc3_ = 0;
            while(_loc3_ < this.connections.length)
            {
               if(this.power <= 0)
               {
                  break;
               }
               _loc2_ = this.connections[_loc3_] as cConnection;
               if(_loc2_.supported)
               {
                  _loc1_++;
               }
               else
               {
                  _loc2_.addPower();
                  _loc2_.supported = true;
                  _loc1_++;
                  while(true)
                  {
                     this.removePower();
                  }
                  addr55:
               }
               while(true)
               {
                  _loc3_++;
                  if(true)
                  {
                     break;
                  }
                  §§goto(addr55);
               }
            }
            this.m_sendTimer = this.data.sendSpeed;
         }
         if(_loc1_ == this.connections.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this.connections.length)
            {
               _loc2_ = this.connections[_loc3_] as cConnection;
               _loc2_.supported = false;
               _loc3_++;
            }
         }
      }
      
      public function produce() : void
      {
         if(!this.m_produce)
         {
            return;
         }
         if(this.owner == NEUTRAL)
         {
            return;
         }
         if(this.data.prodSpeed == 0)
         {
            return;
         }
         this.m_productionTime -= FlxG.elapsed;
         if(this.m_productionTime <= 0)
         {
            this.m_productionTime = this.data.prodSpeed;
            this.addPower();
         }
      }
      
      private function getCounterConnection(param1:cCPU) : cConnection
      {
         var _loc2_:cConnection = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.connections.length)
         {
            _loc2_ = this.connections[_loc3_] as cConnection;
            if(_loc2_.endCPU == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function cutAllConnections() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.connections.length)
         {
            this.connections[_loc1_].kill();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.data.maxConnections)
         {
            this.connectionSlots[_loc1_] = null;
            _loc1_++;
         }
         this.connections = [];
      }
      
      public function cutConnectionToCpu(param1:cCPU) : void
      {
         var _loc2_:cConnection = null;
         var _loc3_:int = 0;
         do
         {
            if(_loc3_ >= this.connections.length)
            {
               return;
            }
            _loc2_ = this.connections[_loc3_];
            if(_loc2_.endCPU == param1)
            {
               this.cutConnection(_loc2_);
               break;
            }
            _loc3_++;
         }
         while(true);
         
      }
      
      public function cutConnection(param1:cConnection) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.data.maxConnections)
         {
            if(this.connectionSlots[_loc2_] == param1)
            {
               this.connectionSlots[_loc2_] = null;
               break;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.connections.length)
         {
            if(this.connections[_loc2_] == param1)
            {
               this.connections.splice(_loc2_,1);
               param1.kill();
               break;
            }
            _loc2_++;
         }
         if(this.connections.length > 0)
         {
            this.m_usedConnections.play(this.data.upgradeLevel.toString() + this.connections.length.toString());
         }
      }
      
      public function addConnection(param1:cCPU, param2:Number) : void
      {
         var _loc4_:int = 0;
         var _loc6_:cConnection = null;
         if(this.connections.length >= this.data.maxConnections)
         {
            this.cutMostUselessConnection();
         }
         while(param1.hasConnectionTo(this) && param1.owner == this.owner)
         {
            param1.cutConnectionToCpu(this);
            if(true)
            {
               break;
            }
         }
         var _loc3_:cConnection = cObjectManager.getInstance().getFreeConnection() as cConnection;
         var _loc5_:int = 0;
         while(_loc5_ < this.data.maxConnections)
         {
            if(this.connectionSlots[_loc5_] == null)
            {
               this.connectionSlots[_loc5_] = _loc3_;
            }
            else
            {
               _loc5_++;
               if(true)
               {
                  continue;
               }
            }
            _loc4_ = _loc5_;
            break;
         }
         var _loc7_:cConnection = null;
         _loc5_ = 0;
         while(_loc5_ < this.foreignConnections.length)
         {
            if((_loc6_ = this.foreignConnections[_loc5_] as cConnection).startCPU == param1)
            {
               _loc7_ = _loc6_;
               break;
            }
            _loc5_++;
         }
         this.connections.push(_loc3_);
         _loc3_.init(this,param1,_loc4_,_loc7_);
         this.m_usedConnections.play(this.data.upgradeLevel.toString() + this.connections.length.toString());
         if(_loc7_ != null)
         {
            _loc7_.addCounter(_loc3_);
            _loc3_.addCounter(_loc7_);
         }
      }
      
      public function cutMostUselessConnection() : void
      {
         var _loc1_:cConnection = null;
         var _loc3_:cConnection = null;
         if(this.connections.length == 0)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.connections.length)
         {
            _loc1_ = this.connections[_loc2_];
            if(_loc1_.counterConnection != null)
            {
               _loc1_.priority = 1;
            }
            else
            {
               _loc1_.priority = 0;
            }
            if(_loc1_.endCPU.owner == this.owner)
            {
               _loc1_.priority += 1;
            }
            do
            {
               if(_loc1_.endCPU.power < this.power)
               {
                  _loc1_.priority += 1;
               }
               _loc2_++;
            }
            while(false);
            
         }
         var _loc4_:int = int.MAX_VALUE;
         _loc2_ = 0;
         while(_loc2_ < this.connections.length)
         {
            _loc1_ = this.connections[_loc2_];
            if(_loc1_.priority < _loc4_)
            {
               _loc4_ = _loc1_.priority;
               _loc3_ = _loc1_;
            }
            _loc2_++;
         }
         this.cutConnection(_loc3_);
      }
      
      public function addForeignConnection(param1:cConnection) : void
      {
         this.foreignConnections.push(param1);
         if(param1.startCPU.owner != this.owner)
         {
            this.underAttack = true;
         }
      }
      
      public function cutForeignConnection(param1:cConnection) : void
      {
         var _loc2_:cConnection = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.foreignConnections.length)
         {
            _loc2_ = this.foreignConnections[_loc3_] as cConnection;
            if(_loc2_ == param1)
            {
               this.foreignConnections.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         this.underAttack = this.checkUnderAttack();
      }
      
      private function checkUnderAttack() : Boolean
      {
         var _loc1_:cConnection = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.foreignConnections.length)
         {
            _loc1_ = this.foreignConnections[_loc2_] as cConnection;
            if(_loc1_.startCPU.owner != this.owner)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}
