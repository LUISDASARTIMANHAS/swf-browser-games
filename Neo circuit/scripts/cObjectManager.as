package
{
   import flash.geom.Point;
   import org.flixel.*;
   
   public class cObjectManager
   {
      
      public static const ZERO_POINT:Point = new Point();
      
      public static const ZERO_FLXPOINT:FlxPoint = new FlxPoint();
      
      public static const MAX_CPUS:int = 16;
      
      public static const MAX_POWERS:int = 30;
      
      public static const MAX_STORY_TEXTS:int = 8;
      
      public static const MAX_CONNECTIONS:int = 32;
      
      public static const TEXT_COLOR:int = 5197849;
      
      public static const TEXT_SIZES:Array = [18,18,18];
      
      private static const MAX_VALID_CONNECTIONS:int = 10;
      
      private static const STORY_TEXT_COLOR:int = 16777215;
      
      private static const STORY_TEXT_SIZE:int = 28;
      
      private static var m_singleton:cObjectManager = new cObjectManager();
       
      
      public var playerGroup:FlxGroup;
      
      public var camera:FlxCamera;
      
      public var player:cPlayer;
      
      public var playerAIs:Array;
      
      public var map:cMap;
      
      public var cpuDataList:Array;
      
      public var storyDataList:Array;
      
      public var playerAiDataList:Array;
      
      public var tutorialDataList:Array;
      
      public var connectionList:FlxGroup;
      
      public var selections:FlxGroup;
      
      private var m_cpuList:FlxGroup;
      
      private var m_cpuTexts:FlxGroup;
      
      private var m_powerList:FlxGroup;
      
      private var m_storyTexts:FlxGroup;
      
      private var m_state:FlxState;
      
      public function cObjectManager()
      {
         super();
      }
      
      public static function getInstance() : cObjectManager
      {
         if(m_singleton == null)
         {
            m_singleton = new cObjectManager();
         }
         return m_singleton;
      }
      
      public function initStoryState(param1:FlxState) : void
      {
         this.m_state = param1;
         this.playerGroup = new FlxGroup();
         this.m_state.add(this.playerGroup);
         this.CreateStoryData();
         this.CreateStoryTexts();
      }
      
      public function initEditorState(param1:FlxState) : void
      {
         this.m_state = param1;
         this.playerGroup = new FlxGroup();
         this.map = new cMap(1024,768);
         this.m_state.add(this.playerGroup);
         this.CreateCPUData();
         this.CreateCPUs();
         this.CreateCPUTexts();
         this.CreateCamera();
      }
      
      public function initPlayState(param1:FlxState, param2:int) : void
      {
         this.m_state = param1;
         this.playerGroup = new FlxGroup();
         this.CreatePlayer();
         this.CreateCamera();
         this.map = new cMap(FlxG.width,FlxG.height);
         this.m_state.add(this.map);
         this.m_state.add(this.playerGroup);
         this.CreateCPUData();
         this.CreateConnections();
         this.CreateSelections();
         this.CreateCPUs();
         this.CreatePowers();
         this.CreateCPUTexts();
         this.CreatePlayerAIs(param2);
         this.CreatePlayerAiData();
         this.CreateTutorialData();
      }
      
      public function destroy() : void
      {
         if(this.m_cpuList != null)
         {
            this.m_cpuList.destroy();
         }
         if(this.connectionList != null)
         {
            this.connectionList.destroy();
         }
         if(this.m_cpuTexts != null)
         {
            this.m_cpuTexts.destroy();
         }
         if(this.m_storyTexts != null)
         {
            this.m_storyTexts.destroy();
         }
         if(this.m_powerList != null)
         {
            this.m_powerList.destroy();
         }
         if(this.map != null)
         {
            this.map.destroy();
         }
         if(this.player != null)
         {
            this.player.destroy();
         }
         if(this.playerGroup != null)
         {
            this.playerGroup.destroy();
         }
         this.tutorialDataList = null;
         this.playerAiDataList = null;
         this.cpuDataList = null;
         this.storyDataList = null;
         this.playerAIs = null;
      }
      
      private function CreateCPUs() : void
      {
         var _loc1_:cCPU = null;
         this.m_cpuList = new FlxGroup();
         this.playerGroup.add(this.m_cpuList);
         var _loc2_:int = 0;
         while(_loc2_ < MAX_CPUS)
         {
            _loc1_ = new cCPU();
            _loc1_.kill();
            do
            {
               this.m_cpuList.add(_loc1_);
               _loc2_++;
            }
            while(false);
            
         }
      }
      
      private function CreateSelections() : void
      {
         var _loc1_:FlxSprite = null;
         var _loc2_:int = 0;
         this.selections = new FlxGroup();
         this.playerGroup.add(this.selections);
         while(_loc2_ < MAX_VALID_CONNECTIONS)
         {
            _loc1_ = new FlxSprite();
            _loc1_.loadGraphic(NeoCircuit.GFX.ImgCPUSelection,true,false,103,95);
            _loc1_.kill();
            do
            {
               this.selections.add(_loc1_);
               _loc2_++;
            }
            while(false);
            
         }
      }
      
      private function CreateCPUData() : void
      {
         var _loc1_:cCPUData = null;
         this.cpuDataList = [];
         var _loc2_:int = 0;
         while(_loc2_ < cCPUData.MAX_CPU_INITS)
         {
            _loc1_ = new cCPUData();
            _loc1_.init[_loc2_]();
            this.cpuDataList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function CreateStoryData() : void
      {
         var _loc1_:cStoryData = null;
         this.storyDataList = [];
         var _loc2_:int = 0;
         while(_loc2_ < cStoryData.MAX_STORY_DATA)
         {
            _loc1_ = new cStoryData();
            _loc1_.init[_loc2_]();
            this.storyDataList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function CreateTutorialData() : void
      {
         var _loc1_:cTutorialData = null;
         this.tutorialDataList = [];
         var _loc2_:int = 0;
         while(_loc2_ < cTutorialData.MAX_TUTORIALS)
         {
            _loc1_ = new cTutorialData();
            _loc1_.init[_loc2_]();
            this.tutorialDataList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function CreatePlayerAiData() : void
      {
         var _loc1_:cPlayerAiData = null;
         this.playerAiDataList = [];
         var _loc2_:int = 0;
         while(_loc2_ < cPlayerAiData.MAX_PLAYERAI_DATA)
         {
            _loc1_ = new cPlayerAiData();
            _loc1_.init[_loc2_]();
            this.playerAiDataList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function CreatePowers() : void
      {
         var _loc1_:cPower = null;
         this.m_powerList = new FlxGroup();
         var _loc2_:int = 0;
         while(_loc2_ < MAX_POWERS)
         {
            _loc1_ = new cPower();
            _loc1_.kill();
            do
            {
               this.m_powerList.add(_loc1_);
               _loc2_++;
            }
            while(false);
            
         }
      }
      
      private function CreateCPUTexts() : void
      {
         var _loc2_:FlxText = null;
         this.m_cpuTexts = new FlxGroup();
         this.playerGroup.add(this.m_cpuTexts);
         var _loc1_:cCPU = this.getFreeCPU();
         var _loc3_:int = 0;
         while(_loc3_ < MAX_CPUS)
         {
            _loc2_ = this.CreateText(_loc1_);
            this.m_cpuTexts.add(_loc2_);
            _loc3_++;
         }
      }
      
      private function CreateStoryTexts() : void
      {
         var _loc1_:FlxText = null;
         this.m_storyTexts = new FlxGroup();
         this.playerGroup.add(this.m_storyTexts);
         var _loc2_:int = 0;
         while(_loc2_ < MAX_STORY_TEXTS)
         {
            _loc1_ = this.CreateStoryText();
            this.m_storyTexts.add(_loc1_);
            _loc2_++;
         }
      }
      
      private function CreateText(param1:cCPU) : FlxText
      {
         var _loc2_:FlxText = new FlxText(0,0,param1.width);
         _loc2_.color = TEXT_COLOR;
         _loc2_.size = TEXT_SIZES[0];
         _loc2_.alignment = "center";
         _loc2_.textField.backgroundColor = 0;
         _loc2_.font = "numbers";
         _loc2_.antialiasing = true;
         _loc2_.kill();
         return _loc2_;
      }
      
      private function CreateStoryText() : FlxText
      {
         var _loc1_:FlxText = new FlxText(0,0,FlxG.width);
         _loc1_.color = STORY_TEXT_COLOR;
         _loc1_.size = STORY_TEXT_SIZE;
         _loc1_.alignment = "center";
         _loc1_.textField.backgroundColor = 0;
         _loc1_.font = "cpu";
         _loc1_.antialiasing = true;
         _loc1_.kill();
         return _loc1_;
      }
      
      private function CreateConnections() : void
      {
         var _loc1_:cConnection = null;
         this.connectionList = new FlxGroup();
         this.playerGroup.add(this.connectionList);
         var _loc2_:int = 0;
         while(_loc2_ < MAX_CONNECTIONS)
         {
            _loc1_ = new cConnection();
            _loc1_.kill();
            do
            {
               this.connectionList.add(_loc1_);
               _loc2_++;
            }
            while(false);
            
         }
      }
      
      private function CreatePlayerAIs(param1:int) : void
      {
         var _loc2_:cPlayerAI = null;
         this.playerAIs = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = new cPlayerAI();
            this.playerAIs.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function update() : void
      {
      }
      
      private function CreatePlayer() : void
      {
         this.player = new cPlayer();
      }
      
      private function CreateCamera() : void
      {
         this.camera = new FlxCamera(0,0,FlxG.width,FlxG.height);
         FlxG.resetCameras(this.camera);
         this.camera.setBounds(0,0,FlxG.width,FlxG.height);
         FlxG.worldBounds = new FlxRect(0,0,FlxG.width,FlxG.height);
      }
      
      public function getFreeCPU() : cCPU
      {
         var _loc1_:cCPU = this.m_cpuList.getFirstAvailable() as cCPU;
         if(_loc1_ == null)
         {
            _loc1_ = new cCPU();
            _loc1_.kill();
            this.m_cpuList.add(_loc1_);
         }
         return _loc1_;
      }
      
      public function getFreeSelection() : FlxSprite
      {
         var _loc1_:FlxSprite = this.selections.getFirstAvailable() as FlxSprite;
         if(_loc1_ == null)
         {
            _loc1_ = new FlxSprite();
            this.selections.add(_loc1_);
         }
         _loc1_.revive();
         return _loc1_;
      }
      
      public function getFreeConnection() : cConnection
      {
         var _loc1_:cConnection = this.connectionList.getFirstAvailable() as cConnection;
         if(_loc1_ == null)
         {
            _loc1_ = new cConnection();
            _loc1_.kill();
            this.connectionList.add(_loc1_);
         }
         return _loc1_;
      }
      
      public function getFreePower() : cPower
      {
         var _loc1_:cPower = this.m_powerList.getFirstAvailable() as cPower;
         if(_loc1_ == null)
         {
            _loc1_ = new cPower();
            this.m_powerList.add(_loc1_);
         }
         return _loc1_;
      }
      
      public function getFreeCPUText(param1:cCPU) : FlxText
      {
         var _loc2_:FlxText = this.m_cpuTexts.getFirstAvailable() as FlxText;
         if(_loc2_ == null)
         {
            _loc2_ = this.CreateText(param1);
            this.m_cpuTexts.add(_loc2_);
         }
         _loc2_.revive();
         return _loc2_;
      }
      
      public function getFreeStoryText() : FlxText
      {
         var _loc1_:FlxText = this.m_storyTexts.getFirstAvailable() as FlxText;
         if(_loc1_ == null)
         {
            _loc1_ = this.CreateStoryText();
            this.m_storyTexts.add(_loc1_);
         }
         _loc1_.revive();
         return _loc1_;
      }
   }
}
