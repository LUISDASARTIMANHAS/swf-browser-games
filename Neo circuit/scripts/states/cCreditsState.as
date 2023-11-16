package states
{
   import com.greensock.TweenLite;
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   import org.flixel.FlxState;
   import org.flixel.FlxText;
   
   public class cCreditsState extends FlxState
   {
       
      
      private var m_background:FlxSprite;
      
      private var m_textFields:Array;
      
      private var m_texts:Array;
      
      public function cCreditsState()
      {
         this.m_texts = ["For my family,",14,16777215,"Dagmar, Holger, Dad and my departed mother!",14,16777215,"",1,0,"",1,0,"",1,0,"",1,0,"A RoughSea Games Production",30,16777215,"",1,0,"",1,0,"GAME DESIGN, CODE AND SFX",25,1080818,"",1,0,"Matthias \'@_JoeCool_\' Schindler",20,16777215,"",1,0,"",1,0,"GRAPHICS",25,1080818,"",1,0,"Peer Draeger",20,16777215,"",1,0,"",1,0,"MUSIC",25,1080818,"",1,0,"Gavin \'@gridlockeduk\' Harrison",20,16777215,"",1,0,"",1,0,"VERY SPECIAL THANKS",25,1080818,"",1,0,"Martijn from Big Dino - thanks for sponsoring!!!!",20,16777215,"",1,0,"Adam Atomic - for the great flixel framework",20,16777215,"",1,0,"Photonstorm - for the magnificent flixel powertools",20,16777215,"",1,0,"Brian and Aaron from FGL for their very helpful feedback!",20,16777215,"",1,0,"Marcus Lubczyk for always giving me great feedback and testing my games",20,16777215,"",1,0,"Flo \'Izor\' Eisele for playing through the whole game and giving great feedback",20,16777215,"",1,0,"Jens \'knarrenheinz\' Winterstein for always having a helping hand",20,16777215,"",1,0,"Jörg \'Eiswuxe\' Winterstein for inspirations and tips",20,16777215,"",1,0,"Mrs Schmadi the cat for just beeing there...",20,16777215];
         super();
      }
      
      override public function create() : void
      {
         super.create();
         FlxG.bgColor = 4278190080;
         this.m_background = new FlxSprite();
         this.m_background.makeGraphic(FlxG.width,FlxG.height);
         do
         {
            this.m_background.scrollFactor = cObjectManager.ZERO_FLXPOINT;
            FlxG.mouse.show(NeoCircuit.GFX.ImgCursor);
         }
         while(false);
         
         var _loc1_:int = 0;
         while(_loc1_ < this.m_texts.length / 3)
         {
            this.createTextField(_loc1_);
            _loc1_++;
         }
      }
      
      private function createTextField(param1:int) : void
      {
         var _loc2_:FlxText = null;
         if(this.m_texts[param1 * 3] == "")
         {
            return;
         }
         _loc2_ = new FlxText(0,FlxG.height + param1 * 25,FlxG.width);
         _loc2_.alignment = "center";
         _loc2_.text = this.m_texts[param1 * 3];
         _loc2_.size = this.m_texts[param1 * 3 + 1];
         _loc2_.color = this.m_texts[param1 * 3 + 2];
         _loc2_.scrollFactor = cObjectManager.ZERO_FLXPOINT;
         _loc2_.font = "cpu";
         _loc2_.velocity.y = -45;
         add(_loc2_);
         _loc2_.alpha = 0;
         TweenLite.to(_loc2_,10,{
            "delay":param1 * 0.5,
            "alpha":1
         });
      }
      
      override public function update() : void
      {
         super.update();
         if(FlxG.mouse.justReleased())
         {
            FlxG.play(NeoCircuit.SFX.SndClick);
            FlxG.fade(0,1,this.onStartGameState);
         }
      }
      
      override public function draw() : void
      {
         super.draw();
      }
      
      private function onStartGameState() : void
      {
         FlxG.switchState(new cMenuState());
      }
   }
}
