package
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import flash.display.BitmapData;
   import org.flixel.*;
   import utils.cGfxUtils;
   import utils.cHelper;
   
   public class cConnection extends FlxGroup
   {
      
      public static const LINE_COLOR_CUT:int = 8421504;
      
      public static const LINE_COLOR_CONNECT_ENEMY:int = 16716049;
      
      public static const LINE_COLOR_CONNECT_FRIEND:int = 65280;
      
      public static const POWERCOSTPER_DISTANCE:Number = 0.05;
      
      public static const NO_POWER_THRESHOLD:Number = 2;
      
      public static const LINE_COLOR_PLAYER:Array = [8487297,1080818,15893520,8443699,10359026];
      
      public static const LINE_COLOR_PLAYER2:Array = [10526880,1080818,15893520,8443699,10359026];
       
      
      public var startCPU:cCPU;
      
      public var endCPU:cCPU;
      
      public var conLength:Number;
      
      public var conOffset:Number;
      
      public var slot:int;
      
      public var supported:Boolean;
      
      public var counterConnection:cConnection;
      
      public var xStart:Number;
      
      public var yStart:Number;
      
      public var xEnd:Number;
      
      public var yEnd:Number;
      
      public var priority:int;
      
      private var m_power:int;
      
      private var m_lineStrength:int = 4;
      
      private var m_alpha:Number = 1;
      
      private var m_powerList:Array;
      
      private var m_camBuffer:BitmapData = null;
      
      private var m_directionIndicator:FlxSprite;
      
      private var m_noPower:Boolean;
      
      private var m_noPowerTimer:Number = 0;
      
      private var m_noPowerIndLifeTime:Number;
      
      public function cConnection()
      {
         this.m_powerList = [];
         super();
         this.m_directionIndicator = new FlxSprite();
         this.m_directionIndicator.loadGraphic(NeoCircuit.GFX.ImgDirectionIndicator,true,false,9,9);
         this.m_directionIndicator.visible = false;
      }
      
      public static function calulcatePowerCost(param1:cCPU, param2:cCPU) : int
      {
         return 0;
      }
      
      public function init(param1:cCPU, param2:cCPU, param3:int, param4:cConnection) : void
      {
         revive();
         this.startCPU = param1;
         this.endCPU = param2;
         this.conOffset = 0;
         this.conLength = cHelper.distance(param1.x,param1.y,this.endCPU.x,this.endCPU.y);
         this.slot = param3;
         this.endCPU.addForeignConnection(this);
         this.supported = false;
         this.counterConnection = param4;
         this.m_noPower = false;
         if(this.counterConnection == null)
         {
            this.m_noPowerIndLifeTime = this.conLength / 100;
         }
         else
         {
            this.m_noPowerIndLifeTime = this.conLength * 0.5 / 100;
         }
         this.calculatePositions();
         this.m_camBuffer = FlxG.camera.buffer;
      }
      
      public function toggleGameSpeed() : void
      {
         var _loc1_:cPower = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.m_powerList.length)
         {
            _loc1_ = this.m_powerList[_loc2_] as cPower;
            _loc1_.toggleGameSpeed();
            _loc2_++;
         }
      }
      
      override public function destroy() : void
      {
         this.m_directionIndicator.destroy();
         super.destroy();
      }
      
      public function addCounter(param1:cConnection) : void
      {
         this.counterConnection = param1;
         this.calculatePositions();
      }
      
      public function removeCounter() : void
      {
         this.counterConnection = null;
         this.calculatePositions();
         callAll("resetMovement");
      }
      
      public function calculatePositions() : void
      {
         this.xStart = this.startCPU.x + this.startCPU.origin.x + this.conOffset;
         this.yStart = this.startCPU.y + this.startCPU.origin.y;
         this.xEnd = this.endCPU.x + this.endCPU.origin.x;
         this.yEnd = this.endCPU.y + this.endCPU.origin.y;
         if(this.counterConnection != null)
         {
            this.xEnd = (this.xEnd + (this.xStart - this.conOffset)) / 2;
            this.yEnd = (this.yEnd + this.yStart) / 2;
         }
         this.resetNoPowerIndicator();
      }
      
      public function addPower() : void
      {
         var _loc1_:cPower = cObjectManager.getInstance().getFreePower();
         _loc1_.init(this,this.startCPU.data.powerStrength);
         add(_loc1_);
         this.m_powerList.push(_loc1_);
      }
      
      public function killFrontPower() : void
      {
         if(this.m_powerList.length == 0)
         {
            return;
         }
         var _loc1_:cPower = this.m_powerList.shift() as cPower;
         _loc1_.kill();
      }
      
      public function attackFrontPower(param1:Number) : Number
      {
         var _loc2_:cPower = this.m_powerList[0] as cPower;
         var _loc3_:Number = 0;
         if(_loc2_.health <= param1)
         {
            _loc3_ = param1 - _loc2_.health;
            this.killFrontPower();
         }
         else
         {
            _loc2_.health -= param1;
         }
         return _loc3_;
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this.m_powerList.length == 0)
         {
            if(this.m_noPower)
            {
               return;
            }
            this.m_noPowerTimer += FlxG.elapsed;
            if(this.m_noPowerTimer > NO_POWER_THRESHOLD)
            {
               this.m_directionIndicator.frame = this.startCPU.owner - 1;
               this.m_directionIndicator.x = this.xStart - this.m_directionIndicator.width * 0.5;
               this.m_directionIndicator.y = this.yStart - this.m_directionIndicator.height * 0.5;
               this.m_directionIndicator.visible = true;
               _loc1_ = this.xEnd - this.m_directionIndicator.width * 0.5;
               _loc2_ = this.yEnd - this.m_directionIndicator.height * 0.5;
               TweenMax.to(this.m_directionIndicator,this.m_noPowerIndLifeTime,{
                  "x":_loc1_,
                  "y":_loc2_,
                  "repeat":-1
               });
               this.m_noPower = true;
            }
         }
         else
         {
            this.resetNoPowerIndicator();
         }
         super.update();
      }
      
      private function resetNoPowerIndicator() : void
      {
         this.m_noPower = false;
         this.m_noPowerTimer = 0;
         TweenLite.killTweensOf(this.m_directionIndicator);
         this.m_directionIndicator.visible = false;
      }
      
      public function killPower(param1:cPower) : void
      {
         var _loc2_:cPower = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.m_powerList.length)
         {
            _loc2_ = this.m_powerList[_loc3_] as cPower;
            if(param1 == _loc2_)
            {
               this.m_powerList.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         if(this.startCPU.owner == this.endCPU.owner)
         {
            this.endCPU.addPower();
         }
         else
         {
            this.endCPU.attackPower(this.startCPU);
         }
         remove(param1);
      }
      
      public function numPowersAlive() : int
      {
         return this.m_powerList.length;
      }
      
      override public function kill() : void
      {
         if(this.endCPU != null)
         {
            this.endCPU.cutForeignConnection(this);
         }
         if(this.counterConnection != null)
         {
            this.counterConnection.removeCounter();
            this.counterConnection = null;
         }
         if(this.startCPU != null)
         {
            this.startCPU.addPower(this.m_powerList.length);
         }
         this.resetNoPowerIndicator();
         this.supported = false;
         callAll("kill");
         clear();
         this.m_powerList.length = 0;
         super.kill();
      }
      
      override public function draw() : void
      {
         cGfxUtils.drawLine(this.m_camBuffer,this.xStart,this.yStart,this.xEnd,this.yEnd,LINE_COLOR_PLAYER2[this.startCPU.owner],this.m_lineStrength,this.m_alpha);
         super.draw();
         if(this.m_directionIndicator.visible)
         {
            this.m_directionIndicator.draw();
         }
      }
      
      public function drawShadow() : void
      {
         cGfxUtils.drawLine(this.m_camBuffer,this.xStart + 4,this.yStart + 4,this.xEnd + 4,this.yEnd + 4,0,4,0.25);
      }
   }
}
