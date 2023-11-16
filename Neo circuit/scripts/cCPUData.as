package
{
   import patterns.cEnum;
   
   public class cCPUData
   {
      
      public static const CPU:int = cEnum.Enum(0);
      
      public static const GPU:int = cEnum.inc;
      
      public static const HUB:int = cEnum.inc;
      
      public static const RAM:int = cEnum.inc;
      
      public static const BARRIER:int = cEnum.inc;
      
      public static const MAX_CPU_TYPES:int = cEnum.inc;
      
      public static const MAX_UPGRADES:int = 3;
      
      public static const UPGRADE_CPU0:int = cEnum.Enum(0);
      
      public static const UPGRADE_CPU1:int = cEnum.inc;
      
      public static const UPGRADE_CPU2:int = cEnum.inc;
      
      public static const UPGRADE_GPU0:int = cEnum.inc;
      
      public static const UPGRADE_GPU1:int = cEnum.inc;
      
      public static const UPGRADE_GPU2:int = cEnum.inc;
      
      public static const UPGRADE_HUB0:int = cEnum.inc;
      
      public static const UPGRADE_HUB1:int = cEnum.inc;
      
      public static const UPGRADE_HUB2:int = cEnum.inc;
      
      public static const UPGRADE_RAM0:int = cEnum.inc;
      
      public static const UPGRADE_RAM1:int = cEnum.inc;
      
      public static const UPGRADE_RAM2:int = cEnum.inc;
      
      public static const UPGRADE_BARRIER0:int = cEnum.inc;
      
      public static const MAX_CPU_INITS:int = cEnum.inc;
       
      
      public var init:Array;
      
      public var upgradeLevel:int;
      
      public var type:int;
      
      public var gfxList:Array;
      
      public var prodSpeed:Number;
      
      public var powerSpeed:int;
      
      public var sendSpeed:Number;
      
      public var powerStrength:Number;
      
      public var maxConnections:int;
      
      public var pointsToUpgrade:Number;
      
      public var defense:Number;
      
      public var space:int;
      
      public var upgradeType:int;
      
      public function cCPUData()
      {
         super();
         this.init = [this.CPU0,this.CPU1,this.CPU2,this.GPU0,this.GPU1,this.GPU2,this.HUB0,this.HUB1,this.HUB2,this.RAM0,this.RAM1,this.RAM2,this.BARRIER0];
      }
      
      private function CPU0() : void
      {
         this.type = CPU;
         this.upgradeLevel = 0;
         this.prodSpeed = 1.5;
         this.sendSpeed = 0.75;
         this.powerSpeed = 50;
         this.powerStrength = 1;
         this.space = 40;
         this.maxConnections = 1;
         this.gfxList = NeoCircuit.GFX.playerCPU;
         this.pointsToUpgrade = 20;
         this.upgradeType = UPGRADE_CPU1;
         this.defense = 1;
      }
      
      private function CPU1() : void
      {
         this.type = CPU;
         this.upgradeLevel = 1;
         this.prodSpeed = 1;
         this.sendSpeed = 0.75;
         this.powerSpeed = 60;
         this.powerStrength = 1;
         this.maxConnections = 2;
         this.space = 60;
         this.gfxList = NeoCircuit.GFX.playerCPU;
         this.pointsToUpgrade = 30;
         this.upgradeType = UPGRADE_CPU2;
         this.defense = 1;
      }
      
      private function CPU2() : void
      {
         this.type = CPU;
         this.upgradeLevel = 2;
         this.prodSpeed = 0.5;
         this.sendSpeed = 0.75;
         this.powerSpeed = 80;
         this.powerStrength = 1;
         this.maxConnections = 3;
         this.space = 80;
         this.gfxList = NeoCircuit.GFX.playerCPU;
         this.pointsToUpgrade = 0;
         this.upgradeType = -1;
         this.defense = 1;
      }
      
      private function GPU0() : void
      {
         this.type = GPU;
         this.upgradeLevel = 0;
         this.prodSpeed = 3;
         this.sendSpeed = 0.75;
         this.powerSpeed = 50;
         this.powerStrength = 2;
         this.space = 30;
         this.maxConnections = 1;
         this.gfxList = NeoCircuit.GFX.playerGPU;
         this.pointsToUpgrade = 15;
         this.upgradeType = UPGRADE_GPU1;
         this.sendSpeed = 2;
         this.defense = 0.5;
      }
      
      private function GPU1() : void
      {
         this.type = GPU;
         this.upgradeLevel = 1;
         this.prodSpeed = 3;
         this.sendSpeed = 0.75;
         this.powerSpeed = 60;
         this.powerStrength = 3;
         this.maxConnections = 2;
         this.space = 40;
         this.gfxList = NeoCircuit.GFX.playerGPU;
         this.pointsToUpgrade = 20;
         this.upgradeType = UPGRADE_GPU2;
         this.defense = 0.5;
      }
      
      private function GPU2() : void
      {
         this.type = GPU;
         this.upgradeLevel = 2;
         this.prodSpeed = 3;
         this.sendSpeed = 0.75;
         this.powerSpeed = 80;
         this.powerStrength = 4;
         this.maxConnections = 3;
         this.space = 50;
         this.gfxList = NeoCircuit.GFX.playerGPU;
         this.pointsToUpgrade = 0;
         this.upgradeType = -1;
         this.defense = 0.5;
      }
      
      private function HUB0() : void
      {
         this.type = HUB;
         this.upgradeLevel = 0;
         this.prodSpeed = 0;
         this.sendSpeed = 0.3;
         this.powerSpeed = 100;
         this.powerStrength = 1;
         this.maxConnections = 4;
         this.space = 50;
         this.gfxList = NeoCircuit.GFX.playerHUB;
         this.pointsToUpgrade = 25;
         this.upgradeType = UPGRADE_HUB1;
         this.defense = 1;
      }
      
      private function HUB1() : void
      {
         this.type = HUB;
         this.upgradeLevel = 1;
         this.prodSpeed = 0;
         this.sendSpeed = 0.2;
         this.powerSpeed = 150;
         this.powerStrength = 1;
         this.maxConnections = 4;
         this.space = 100;
         this.gfxList = NeoCircuit.GFX.playerHUB;
         this.pointsToUpgrade = 50;
         this.upgradeType = UPGRADE_HUB2;
         this.defense = 1;
      }
      
      private function HUB2() : void
      {
         this.type = HUB;
         this.upgradeLevel = 2;
         this.prodSpeed = 0;
         this.sendSpeed = 0.1;
         this.powerSpeed = 200;
         this.powerStrength = 1;
         this.maxConnections = 4;
         this.space = 150;
         this.gfxList = NeoCircuit.GFX.playerHUB;
         this.pointsToUpgrade = 0;
         this.upgradeType = -1;
         this.defense = 1;
      }
      
      private function RAM0() : void
      {
         this.type = RAM;
         this.upgradeLevel = 0;
         this.prodSpeed = 3;
         this.sendSpeed = 0.5;
         this.powerSpeed = 75;
         this.powerStrength = 1;
         this.maxConnections = 1;
         this.space = 100;
         this.gfxList = NeoCircuit.GFX.playerRAM;
         this.pointsToUpgrade = 25;
         this.upgradeType = UPGRADE_RAM1;
         this.defense = 1.5;
      }
      
      private function RAM1() : void
      {
         this.type = RAM;
         this.upgradeLevel = 1;
         this.prodSpeed = 3;
         this.sendSpeed = 0.4;
         this.powerSpeed = 150;
         this.powerStrength = 1;
         this.maxConnections = 2;
         this.space = 200;
         this.gfxList = NeoCircuit.GFX.playerRAM;
         this.pointsToUpgrade = 50;
         this.upgradeType = UPGRADE_RAM2;
         this.defense = 2;
      }
      
      private function RAM2() : void
      {
         this.type = RAM;
         this.upgradeLevel = 2;
         this.prodSpeed = 3;
         this.sendSpeed = 0.35;
         this.powerSpeed = 200;
         this.powerStrength = 1;
         this.maxConnections = 3;
         this.space = 300;
         this.gfxList = NeoCircuit.GFX.playerRAM;
         this.pointsToUpgrade = 0;
         this.upgradeType = -1;
         this.defense = 3;
      }
      
      private function BARRIER0() : void
      {
         this.type = BARRIER;
         this.upgradeLevel = 0;
         this.prodSpeed = 0;
         this.sendSpeed = 0;
         this.powerSpeed = 0;
         this.powerStrength = 0;
         this.maxConnections = 0;
         this.space = 0;
         this.gfxList = NeoCircuit.GFX.playerBarrier;
         this.pointsToUpgrade = 0;
         this.upgradeType = -1;
      }
   }
}
