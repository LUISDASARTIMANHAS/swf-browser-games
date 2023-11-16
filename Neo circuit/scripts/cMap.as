package
{
   import flash.geom.Rectangle;
   import org.flixel.*;
   import states.cPlayState;
   import utils.cFileUtils;
   import utils.cHelper;
   
   public class cMap extends FlxGroup
   {
      
      private static const PLAYFIELD_X:Number = FlxG.width;
      
      private static const PLAYFIELD_Y:Number = FlxG.height;
      
      private static const PLAYFIELD_WIDTH:Number = FlxG.width;
      
      private static const PLAYFIELD_HEIGHT:Number = FlxG.height;
      
      public static const SHOW_DELAY:Number = 0.15;
      
      private static const MAX_NUMTRIES:int = 1000;
      
      public static const STD_CHIP_SIZE:Number = 96;
      
      public static const MIN_SLOT_SIZE:Number = 96;
      
      public static const MAX_SLOT_SIZE:Number = 120;
      
      public static const MAP_SLOT_COUNTX:int = 7;
      
      public static const MAP_SLOT_COUNTY:int = 5;
      
      public static const FRAME:int = 6;
      
      public static const HUD_SIZE:int = 50;
      
      public static const AI_DIFF:Array = [0,0,0,0,0,0,0,0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7];
      
      public static const TUTORIAL:Array = [1,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
       
      
      public var cpuList:Array;
      
      public var numControlableCpus:int;
      
      public var ready:Boolean;
      
      public var mapSlotSizeX:int;
      
      public var mapSlotSizeY:int;
      
      public var mapOffsetX:Number = 0;
      
      public var mapOffsetY:Number = 0;
      
      public var tutorialActive:Boolean;
      
      private var m_cpuArray:Array;
      
      private var m_background:FlxSprite;
      
      private var m_rectangles:Array;
      
      private var m_testRectangle:Rectangle;
      
      private var m_playerAIs:Array;
      
      private var m_currentLevel:int;
      
      private var m_buildMapDelay:Number;
      
      public function cMap(param1:Number, param2:Number)
      {
         this.m_testRectangle = new Rectangle();
         super();
         this.mapSlotSizeX = (param1 - FRAME) / MAP_SLOT_COUNTX;
         if(this.mapSlotSizeX < MIN_SLOT_SIZE)
         {
            this.mapSlotSizeX = MIN_SLOT_SIZE;
         }
         else if(this.mapSlotSizeX > MAX_SLOT_SIZE)
         {
            this.mapSlotSizeX = MAX_SLOT_SIZE;
         }
         this.mapSlotSizeY = (param2 - FRAME - HUD_SIZE) / MAP_SLOT_COUNTY;
         if(this.mapSlotSizeY < MIN_SLOT_SIZE)
         {
            this.mapSlotSizeY = MIN_SLOT_SIZE;
         }
         else if(this.mapSlotSizeY > MAX_SLOT_SIZE)
         {
            this.mapSlotSizeY = MAX_SLOT_SIZE;
         }
         this.tutorialActive = false;
         this.mapOffsetX = FRAME * 0.5 + (param1 - FRAME - this.mapSlotSizeX * MAP_SLOT_COUNTX) * 0.5;
         this.mapOffsetY = FRAME * 0.5 + HUD_SIZE + (param2 - FRAME - HUD_SIZE - this.mapSlotSizeY * MAP_SLOT_COUNTY) * 0.5;
         this.m_background = new FlxSprite(0,0,NeoCircuit.GFX.ImgBackground);
         this.m_background.scrollFactor = cObjectManager.ZERO_FLXPOINT;
         this.m_background.solid = false;
         this.m_background.immovable = true;
      }
      
      public static function levelHasTutorial(param1:int) : Boolean
      {
         return TUTORIAL[param1] != 0;
      }
      
      override public function destroy() : void
      {
         this.cpuList = null;
         this.m_cpuArray = null;
         this.m_rectangles = null;
         this.m_playerAIs = null;
         this.m_background.destroy();
         super.destroy();
      }
      
      override public function draw() : void
      {
         var _loc2_:cConnection = null;
         this.m_background.draw();
         var _loc1_:Array = cObjectManager.getInstance().connectionList.members;
         var _loc3_:int = 0;
         loop0:
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_] as cConnection;
            §§push(_loc2_ != null);
            if(!(_loc2_ != null))
            {
               continue;
            }
            §§pop();
            §§push(_loc2_.exists);
            if(!_loc2_.exists)
            {
               continue;
            }
            §§pop();
            while(true)
            {
               §§push(_loc2_.alive);
               continue loop0;
            }
            while(true)
            {
               if(§§pop())
               {
                  _loc2_.drawShadow();
               }
               _loc3_++;
               if(true)
               {
                  break;
               }
               §§goto(addr44);
            }
         }
         super.draw();
      }
      
      override public function update() : void
      {
         var _loc1_:cPlayerAI = null;
         var _loc2_:int = 0;
         if(this.m_buildMapDelay > 0)
         {
            this.m_buildMapDelay -= FlxG.elapsed;
            if(this.m_buildMapDelay < 0)
            {
               this.ready = true;
            }
            return;
         }
         loop0:
         while(cObjectManager.getInstance().player.gameStatus == cPlayer.GAMESTATUS_PLAYING && !this.tutorialActive)
         {
            _loc2_ = 0;
            if(false)
            {
               continue;
            }
            while(true)
            {
               if(_loc2_ >= this.m_playerAIs.length)
               {
                  break loop0;
               }
               _loc1_ = this.m_playerAIs[_loc2_] as cPlayerAI;
               if(_loc1_.active)
               {
                  _loc1_.update();
               }
               _loc2_++;
            }
         }
         super.update();
      }
      
      public function toggleGameSpeed() : void
      {
         var _loc1_:cCPU = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.cpuList.length)
         {
            _loc1_ = this.cpuList[_loc2_] as cCPU;
            _loc1_.toggleGameSpeed();
            _loc2_++;
         }
      }
      
      public function createRandomPlayfield(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void
      {
         this.numControlableCpus = 0;
         var _loc8_:Number = 40;
         var _loc9_:cCPUData = cObjectManager.getInstance().cpuDataList[cCPUData.UPGRADE_HUB0];
         var _loc10_:cCPUData = cObjectManager.getInstance().cpuDataList[cCPUData.UPGRADE_CPU0];
         var _loc11_:cCPUData = cObjectManager.getInstance().cpuDataList[cCPUData.UPGRADE_GPU0];
         var _loc12_:cCPUData = cObjectManager.getInstance().cpuDataList[cCPUData.UPGRADE_RAM0];
         var _loc13_:cCPUData = cObjectManager.getInstance().cpuDataList[cCPUData.UPGRADE_BARRIER0];
         this.CreateSlots();
         this.m_playerAIs = cObjectManager.getInstance().playerAIs;
         do
         {
            this.m_rectangles = [];
            this.cpuList = [];
         }
         while(false);
         
         var _loc14_:int = 0;
         while(_loc14_ < param1)
         {
            this.CreateSlotCPU(5,_loc10_);
            _loc14_++;
         }
         _loc14_ = 0;
         while(_loc14_ < param2)
         {
            this.CreateSlotCPU(5,_loc9_);
            _loc14_++;
         }
         _loc14_ = 0;
         while(_loc14_ < param3)
         {
            this.CreateSlotCPU(5,_loc11_);
            _loc14_++;
         }
         _loc14_ = 0;
         while(_loc14_ < param4)
         {
            this.CreateSlotCPU(5,_loc12_);
            _loc14_++;
         }
         _loc14_ = 0;
         while(_loc14_ < param5)
         {
            this.CreateSlotCPU(-1,_loc13_);
            _loc14_++;
         }
         this.CreatePlayerCPUs(param6,_loc8_,_loc10_,param7);
      }
      
      private function CreatePlayerCPUs(param1:int, param2:Number, param3:cCPUData, param4:int) : void
      {
         var _loc5_:cCPU;
         (_loc5_ = this.GetLeftCPU()).init(cCPU.PLAYER01,_loc5_.x,_loc5_.y,param2,param3);
         switch(param1)
         {
            case 2:
               this.InitAIPlayer(this.GetRightCPU(),param3,param2,cCPU.PLAYER02,param4);
               break;
            case 3:
               this.InitAIPlayer(this.GetRightCPU(),param3,param2,cCPU.PLAYER02,param4);
               this.InitAIPlayer(this.GetTopCPU(),param3,param2,cCPU.PLAYER03,param4);
               break;
            case 4:
               this.InitAIPlayer(this.GetRightCPU(),param3,param2,cCPU.PLAYER02,param4);
               do
               {
                  this.InitAIPlayer(this.GetTopCPU(),param3,param2,cCPU.PLAYER03,param4);
                  this.InitAIPlayer(this.GetBottomCPU(),param3,param2,cCPU.PLAYER04,param4);
               }
               while(false);
               
         }
      }
      
      private function InitAIPlayer(param1:cCPU, param2:cCPUData, param3:Number, param4:int, param5:int) : void
      {
         param1.init(param4,param1.x,param1.y,param3,param2);
         this.m_playerAIs[param4 - 1].init(param4,param5,cPlayerAiData.ATTACKER_TYPE);
      }
      
      private function CreateCPU(param1:Number, param2:cCPUData) : void
      {
         var _loc6_:Rectangle = null;
         var _loc7_:int = 0;
         var _loc3_:cCPU = cObjectManager.getInstance().getFreeCPU();
         var _loc4_:Boolean = true;
         var _loc5_:int = 0;
         while(_loc4_ && _loc5_ < MAX_NUMTRIES)
         {
            _loc3_.x = cHelper.random_int(PLAYFIELD_X,PLAYFIELD_WIDTH - _loc3_.width);
            _loc3_.y = cHelper.random_int(PLAYFIELD_Y,PLAYFIELD_HEIGHT - _loc3_.height);
            this.m_testRectangle.x = _loc3_.x - _loc3_.width * 0.75;
            this.m_testRectangle.y = _loc3_.y - _loc3_.height * 0.75;
            this.m_testRectangle.width = _loc3_.width * 1.5;
            this.m_testRectangle.height = _loc3_.height * 1.5;
            do
            {
               _loc4_ = false;
               _loc7_ = 0;
            }
            while(false);
            
            while(_loc7_ < this.m_rectangles.length)
            {
               if((_loc6_ = this.m_rectangles[_loc7_] as Rectangle).intersects(this.m_testRectangle))
               {
                  _loc4_ = true;
                  _loc5_++;
                  break;
               }
               _loc7_++;
            }
         }
         if(!_loc4_)
         {
            this.cpuList.push(_loc3_);
            _loc3_.init(0,_loc3_.x,_loc3_.y,param1,param2);
            this.m_rectangles.push(new Rectangle(this.m_testRectangle.x,this.m_testRectangle.y,this.m_testRectangle.width,this.m_testRectangle.height));
         }
      }
      
      public function loadLevel(param1:int) : void
      {
         var _loc2_:cPlayerAI = null;
         var _loc5_:Array = null;
         var _loc6_:cCPUData = null;
         var _loc7_:int = 0;
         var _loc8_:cCPU = null;
         var _loc9_:int = 0;
         this.ready = false;
         this.CreateSlots();
         this.numControlableCpus = 0;
         do
         {
            this.m_currentLevel = param1;
            this.m_playerAIs = cObjectManager.getInstance().playerAIs;
         }
         while(false);
         
         var _loc3_:int = 0;
         while(_loc3_ < this.m_playerAIs.length)
         {
            _loc2_ = this.m_playerAIs[_loc3_] as cPlayerAI;
            _loc2_.active = false;
            _loc3_++;
         }
         this.cpuList = [];
         var _loc4_:Array = cFileUtils.ConvertFileToStringArray(NeoCircuit.LVLS.levelFiles[param1]);
         this.m_buildMapDelay = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if((_loc5_ = _loc4_[_loc3_].split(";"))[0] != "")
            {
               if(int(_loc5_[1]) != -1)
               {
                  _loc7_ = int(_loc5_[1]) * cCPUData.MAX_UPGRADES + int(_loc5_[2]);
                  _loc6_ = cObjectManager.getInstance().cpuDataList[_loc7_];
                  _loc8_ = cObjectManager.getInstance().getFreeCPU();
                  _loc9_ = int(_loc5_[4]);
                  _loc8_.init(_loc9_,this.m_cpuArray[_loc3_].x,this.m_cpuArray[_loc3_].y,int(_loc5_[3]),_loc6_,true);
                  if(_loc9_ > cCPU.PLAYER01)
                  {
                     this.m_playerAIs[_loc9_ - 1].init(_loc9_,AI_DIFF[param1],cPlayerAiData.ATTACKER_TYPE);
                  }
                  do
                  {
                     _loc8_.updateTextPos();
                     this.cpuList.push(_loc8_);
                  }
                  while(false);
                  
                  if(_loc8_.data.type != cCPUData.BARRIER)
                  {
                     ++this.numControlableCpus;
                  }
                  _loc8_.place(this.m_buildMapDelay);
                  this.m_buildMapDelay += SHOW_DELAY;
               }
            }
            _loc3_++;
         }
      }
      
      public function initTutorial() : void
      {
         var _loc2_:cTutorialData = null;
         var _loc1_:Array = cObjectManager.getInstance().tutorialDataList;
         var _loc3_:int = 0;
         do
         {
            if(_loc3_ >= _loc1_.length)
            {
               return;
            }
            _loc2_ = _loc1_[_loc3_] as cTutorialData;
            if(_loc2_.level == this.m_currentLevel)
            {
               (FlxG.state as cPlayState).gameHud.showTutorial(_loc2_);
               break;
            }
            _loc3_++;
         }
         while(true);
         
      }
      
      private function CreateSlotCPU(param1:Number, param2:cCPUData) : void
      {
         var _loc3_:cCPU = cObjectManager.getInstance().getFreeCPU();
         var _loc4_:int = cHelper.random_int(0,this.m_cpuArray.length - 1);
         var _loc5_:Object = this.m_cpuArray[_loc4_];
         this.m_cpuArray.splice(_loc4_,1);
         _loc3_.x = _loc5_.x;
         _loc3_.y = _loc5_.y;
         do
         {
            this.cpuList.push(_loc3_);
            _loc3_.init(0,_loc3_.x,_loc3_.y,param1,param2);
         }
         while(false);
         
         if(_loc3_.data.type != cCPUData.BARRIER)
         {
            ++this.numControlableCpus;
         }
      }
      
      private function CreateSlots() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         this.m_cpuArray = [];
         var _loc3_:int = 0;
         while(_loc3_ < MAP_SLOT_COUNTY)
         {
            _loc4_ = 0;
            while(_loc4_ < MAP_SLOT_COUNTX)
            {
               _loc1_ = {
                  "x":_loc4_ * this.mapSlotSizeX + this.mapOffsetX,
                  "y":_loc3_ * this.mapSlotSizeY + this.mapOffsetY
               };
               this.m_cpuArray.push(_loc1_);
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      private function GetLeftCPU() : cCPU
      {
         var _loc2_:cCPU = null;
         var _loc3_:cCPU = null;
         var _loc1_:int = int.MAX_VALUE;
         var _loc4_:int = 0;
         while(_loc4_ < this.cpuList.length)
         {
            _loc2_ = this.cpuList[_loc4_] as cCPU;
            if(_loc2_.x < _loc1_ && _loc2_.owner == cCPU.NEUTRAL)
            {
               _loc1_ = _loc2_.x;
               _loc3_ = _loc2_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function GetRightCPU() : cCPU
      {
         var _loc2_:cCPU = null;
         var _loc3_:cCPU = null;
         var _loc1_:int = int.MIN_VALUE;
         var _loc4_:int = 0;
         while(_loc4_ < this.cpuList.length)
         {
            _loc2_ = this.cpuList[_loc4_] as cCPU;
            if(_loc2_.x > _loc1_ && _loc2_.owner == cCPU.NEUTRAL)
            {
               _loc1_ = _loc2_.x;
               _loc3_ = _loc2_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function GetTopCPU() : cCPU
      {
         var _loc2_:cCPU = null;
         var _loc3_:cCPU = null;
         var _loc1_:int = int.MAX_VALUE;
         var _loc4_:int = 0;
         while(_loc4_ < this.cpuList.length)
         {
            _loc2_ = this.cpuList[_loc4_] as cCPU;
            if(_loc2_.y < _loc1_ && _loc2_.owner == cCPU.NEUTRAL)
            {
               _loc1_ = _loc2_.y;
               _loc3_ = _loc2_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function GetBottomCPU() : cCPU
      {
         var _loc2_:cCPU = null;
         var _loc3_:cCPU = null;
         var _loc1_:int = int.MIN_VALUE;
         var _loc4_:int = 0;
         while(_loc4_ < this.cpuList.length)
         {
            _loc2_ = this.cpuList[_loc4_] as cCPU;
            if(_loc2_.y > _loc1_ && _loc2_.owner == cCPU.NEUTRAL)
            {
               _loc1_ = _loc2_.y;
               _loc3_ = _loc2_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
