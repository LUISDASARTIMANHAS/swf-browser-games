package
{
   import hud.cTutorialHud;
   import org.flixel.FlxPoint;
   
   public class cTutorialData
   {
      
      public static const MAX_TUTORIALS:int = 21;
      
      public static var map:cMap;
       
      
      public var init:Array;
      
      public var gfx:Class;
      
      public var gfxPos:FlxPoint;
      
      public var level:int;
      
      public var text:String;
      
      public var next:int;
      
      public var prev:int;
      
      public var successText:String;
      
      public var checkCallback:Function;
      
      public var interactive:Boolean;
      
      public var done:Boolean;
      
      public var viewed:Boolean = false;
      
      public var cutting:Boolean = true;
      
      public var connecting:Boolean = true;
      
      public var upgrading:Boolean = true;
      
      public var scale:Boolean = false;
      
      public var speed:Boolean = false;
      
      public function cTutorialData()
      {
         super();
         map = cObjectManager.getInstance().map;
         this.init = [this.TUT0,this.TUT1,this.TUT2,this.TUT3,this.TUT4,this.TUT5,this.TUT6,this.TUT7,this.TUT8,this.TUT9,this.TUT10,this.TUT11,this.TUT12,this.TUT13,this.TUT14,this.TUT15,this.TUT16,this.TUT17,this.TUT18,this.TUT19,this.TUT20];
      }
      
      public function TUT0() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = map.mapOffsetX + map.mapSlotSizeX * 2;
         this.gfxPos.y = map.mapOffsetY + map.mapSlotSizeY;
         this.level = 0;
         this.prev = -1;
         this.next = 1;
         this.interactive = false;
         this.text = "The aim of the game is to conquer ALL nodes on the playfield! All BLUE nodes are yours!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial0;
         this.scale = true;
      }
      
      public function TUT1() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial06;
         this.level = -1;
         this.prev = 0;
         this.next = 2;
         this.interactive = true;
         this.cutting = false;
         do
         {
            this.connecting = true;
            this.upgrading = false;
         }
         while(false);
         
         var _loc1_:cMap = cObjectManager.getInstance().map;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = _loc1_.mapOffsetX + _loc1_.mapSlotSizeX * 2;
         this.gfxPos.y = _loc1_.mapOffsetY + _loc1_.mapSlotSizeY;
         if(NeoCircuit.mobileRelease)
         {
            this.text = "Touch and drag from the blue CPU to grey CPU to start an ATTACK!";
         }
         else
         {
            this.text = "Click and drag from the blue CPU to grey CPU to start an ATTACK!";
         }
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial1;
      }
      
      public function TUT2() : void
      {
         this.interactive = true;
         this.cutting = false;
         this.connecting = false;
         this.upgrading = false;
         this.speed = true;
         this.level = -1;
         this.prev = 1;
         this.next = 3;
         this.gfxPos = new FlxPoint();
         if(NeoCircuit.mobileRelease)
         {
            this.text = "Great! Want to speed up the moving powers! Hit the speed button!";
         }
         else
         {
            this.text = "Want to speed up the moving powers! Just press SPACE or hit the speed button!";
         }
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial11;
      }
      
      public function TUT3() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial05;
         var _loc1_:cMap = cObjectManager.getInstance().map;
         this.interactive = true;
         this.cutting = true;
         this.connecting = false;
         this.upgrading = false;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = _loc1_.mapOffsetX + _loc1_.mapSlotSizeX * 1.5;
         this.gfxPos.y = _loc1_.mapOffsetY + _loc1_.mapSlotSizeY * 2.5;
         this.level = -1;
         this.prev = 2;
         this.next = 4;
         this.text = "Perfect! You can also cut connections. Just drag a line across them!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial5;
      }
      
      public function TUT4() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = map.mapOffsetX + map.mapSlotSizeX * 5;
         this.gfxPos.y = map.mapOffsetY + map.mapSlotSizeY * 3;
         this.gfx = null;
         this.level = -1;
         this.prev = 3;
         this.next = -1;
         this.interactive = false;
         this.text = "Good! Now conquer the rest of the nodes to win this round!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
      
      public function TUT5() : void
      {
      }
      
      public function TUT6() : void
      {
      }
      
      public function TUT7() : void
      {
      }
      
      public function TUT8() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = map.mapOffsetX + map.mapSlotSizeX * 6;
         this.gfxPos.y = map.mapOffsetY + map.mapSlotSizeY * 2;
         this.scale = true;
         this.interactive = false;
         this.level = 1;
         this.prev = -1;
         this.next = 9;
         this.text = "Your first encounter, but don\'t worry! The orange node is controlled by a weak enemy AI!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
      
      public function TUT9() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         this.interactive = true;
         this.cutting = false;
         this.connecting = false;
         this.upgrading = true;
         this.scale = true;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = map.mapOffsetX;
         this.gfxPos.y = map.mapOffsetY + map.mapSlotSizeY * 2;
         this.level = -1;
         this.prev = 8;
         this.next = 10;
         if(NeoCircuit.mobileRelease)
         {
            this.text = "To conquer nodes faster upgrade the CPU, by TOUCHING it!";
         }
         else
         {
            this.text = "To conquer nodes faster upgrade the CPU, by CLICKING and HOLDING DOWN the BUTTON!";
         }
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial8;
      }
      
      public function TUT10() : void
      {
         this.gfx = null;
         this.interactive = false;
         this.level = -1;
         this.prev = 9;
         this.next = 11;
         this.text = "Great! CPU is upgraded: 2 outgoing connections, 60 capacity and faster production!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
      
      public function TUT11() : void
      {
         this.gfx = null;
         this.interactive = false;
         this.level = -1;
         this.prev = 10;
         this.next = -1;
         this.text = "Don\'t forget to speed up the game if its too slow for you!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
      
      public function TUT12() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         var _loc1_:cMap = cObjectManager.getInstance().map;
         this.interactive = false;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = _loc1_.mapOffsetX + _loc1_.mapSlotSizeX * 2;
         this.gfxPos.y = _loc1_.mapOffsetY + _loc1_.mapSlotSizeY * 2;
         this.scale = true;
         this.level = 3;
         this.prev = -1;
         this.next = 13;
         this.text = "New Node! HUBS can distribute POWERS very fast to other nodes, but they do not produce POWERS!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
      
      public function TUT13() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         var _loc1_:cMap = cObjectManager.getInstance().map;
         this.interactive = false;
         this.gfxPos = new FlxPoint();
         this.scale = true;
         this.gfxPos.x = _loc1_.mapOffsetX + _loc1_.mapSlotSizeX * 2;
         this.gfxPos.y = _loc1_.mapOffsetY + _loc1_.mapSlotSizeY * 2;
         this.level = -1;
         this.prev = 12;
         this.next = -1;
         this.text = "HUBs can handle 4 outgoing CONNECTIONS! Thats awesome for complex playfields!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
      
      public function TUT14() : void
      {
      }
      
      public function TUT15() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = map.mapOffsetX + map.mapSlotSizeX;
         this.gfxPos.y = map.mapOffsetY + map.mapSlotSizeY * 3;
         this.interactive = false;
         this.scale = true;
         this.level = 5;
         this.prev = -1;
         this.next = 16;
         this.text = "New Node! The GPU capacity is low, but the node is a very strong attacker!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
      
      public function TUT16() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = map.mapOffsetX + map.mapSlotSizeX;
         this.gfxPos.y = map.mapOffsetY + map.mapSlotSizeY * 3;
         this.interactive = false;
         this.scale = true;
         this.level = -1;
         this.prev = 15;
         this.next = -1;
         this.text = "Outgoing powers of GPU nodes have double the size of normal nodes!";
         this.successText = "The drawback of GPUs is their defence, so always support them when attacked!";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
      
      public function TUT17() : void
      {
      }
      
      public function TUT18() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = map.mapOffsetX + map.mapSlotSizeX * 3;
         this.gfxPos.y = map.mapOffsetY + map.mapSlotSizeY;
         this.interactive = false;
         this.scale = true;
         this.level = 7;
         this.prev = -1;
         this.next = 19;
         this.text = "New Node! The RAM can store lots of powers, up to 300 at level 3!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial8;
      }
      
      public function TUT19() : void
      {
         this.gfx = NeoCircuit.GFX.ImgTutorial00;
         this.gfxPos = new FlxPoint();
         this.gfxPos.x = map.mapOffsetX + map.mapSlotSizeX * 3;
         this.gfxPos.y = map.mapOffsetY + map.mapSlotSizeY;
         this.interactive = false;
         this.scale = true;
         this.level = -1;
         this.prev = 18;
         this.next = 20;
         this.text = "It is also a strong defender but but a weak attacker!";
         this.successText = "RAM is mainly a support node, try to upgrade early!";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
      
      public function TUT20() : void
      {
         this.gfx = null;
         this.interactive = false;
         this.level = -1;
         this.prev = 19;
         this.next = -1;
         this.text = "Tip for this level: Avoid wasting powers, transport production of CPUs to the RAM!";
         this.successText = "";
         this.checkCallback = cTutorialHud.checkTutorial0;
      }
   }
}
