package states
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import org.flixel.*;
   
   public class cDifficultySelectState extends FlxState
   {
      
      private static const MAX_DISPLAY_TIME:int = 3;
       
      
      private var m_bg:FlxSprite;
      
      private var m_fading:Boolean = false;
      
      private var m_headerText:FlxText;
      
      private var m_diffEasy:FlxSprite;
      
      private var m_diffHard:FlxSprite;
      
      private var m_diffEasyText:FlxText;
      
      private var m_diffHardText:FlxText;
      
      private var m_selectedDiff:FlxSprite;
      
      public function cDifficultySelectState()
      {
         super();
      }
      
      override public function create() : void
      {
         super.create();
         this.m_bg = new FlxSprite(0,0,NeoCircuit.GFX.ImgTitleBackground);
         this.m_bg.alpha = 0;
         add(this.m_bg);
         this.m_headerText = new FlxText(0,FlxG.height * 0.35,FlxG.width);
         this.m_headerText.alignment = "center";
         this.m_headerText.text = "PLEASE CHOOSE A DIFFICULTY LEVEL!";
         this.m_headerText.size = 32;
         this.m_headerText.color = 16777215;
         this.m_headerText.font = "cpu";
         this.m_headerText.scrollFactor = cObjectManager.ZERO_FLXPOINT;
         add(this.m_headerText);
         this.CreateDifficultyDisplay();
         FlxG.mouse.show(NeoCircuit.GFX.ImgCursor);
         TweenLite.to(this.m_bg,0.25,{"alpha":1});
      }
      
      override public function update() : void
      {
         if(this.m_fading)
         {
            return;
         }
         this.PickDifficulty();
         if(this.m_selectedDiff != null && FlxG.mouse.justReleased())
         {
            this.m_fading = true;
            FlxG.fade(0,1,this.startNewGame);
         }
      }
      
      private function CreateDifficultyDisplay() : void
      {
         this.m_diffEasy = new FlxSprite(0,0);
         this.m_diffEasy.loadGraphic(NeoCircuit.GFX.ImgLevel,true,false,110,82);
         this.m_diffEasy.frame = 0;
         this.m_diffEasy.x = FlxG.width * 0.5 - this.m_diffEasy.width;
         this.m_diffEasy.y = FlxG.height * 0.5 - this.m_diffEasy.height * 0.5;
         this.m_diffHard = new FlxSprite(0,0);
         this.m_diffHard.loadGraphic(NeoCircuit.GFX.ImgLevel,true,false,110,82);
         this.m_diffHard.frame = 9;
         this.m_diffHard.x = FlxG.width * 0.5;
         this.m_diffHard.y = this.m_diffEasy.y;
         do
         {
            add(this.m_diffEasy);
            add(this.m_diffHard);
         }
         while(false);
         
         var _loc1_:Number = this.m_diffEasy.y + this.m_diffEasy.origin.y - 24 * 0.5 - 6;
         this.m_diffEasyText = new FlxText(this.m_diffEasy.x,_loc1_,this.m_diffEasy.width - 10,"NORMAL");
         this.m_diffHardText = new FlxText(this.m_diffHard.x,_loc1_,this.m_diffHard.width - 10,"HARD");
         this.m_diffEasyText.font = "cpu";
         this.m_diffEasyText.size = 20;
         this.m_diffEasyText.alignment = "center";
         this.m_diffEasyText.color = 16777215;
         add(this.m_diffEasyText);
         this.m_diffHardText.font = "cpu";
         this.m_diffHardText.size = 20;
         this.m_diffHardText.alignment = "center";
         this.m_diffHardText.color = 16777215;
         add(this.m_diffHardText);
      }
      
      private function PickDifficulty() : void
      {
         var _loc1_:FlxSprite = null;
         if(this.m_diffEasy.overlapsPoint(FlxG.mouse))
         {
            _loc1_ = this.m_diffEasy;
         }
         else if(this.m_diffHard.overlapsPoint(FlxG.mouse))
         {
            _loc1_ = this.m_diffHard;
         }
         else if(this.m_selectedDiff != null)
         {
            TweenLite.killTweensOf(this.m_selectedDiff,true);
            TweenLite.killTweensOf(this.m_selectedDiff.scale,true);
            _loc1_ = null;
            return;
         }
         if(_loc1_ == this.m_selectedDiff)
         {
            return;
         }
         if(this.m_selectedDiff != null)
         {
            TweenLite.killTweensOf(this.m_selectedDiff,true);
            TweenLite.killTweensOf(this.m_selectedDiff.scale,true);
         }
         this.m_selectedDiff = _loc1_;
         this.m_selectedDiff.alpha = 1;
         TweenMax.to(this.m_selectedDiff,0.5,{
            "alpha":0.5,
            "yoyo":true,
            "repeat":-1
         });
         TweenMax.to(this.m_selectedDiff.scale,0.5,{
            "x":1.25,
            "y":1.25,
            "yoyo":true,
            "repeat":-1
         });
         FlxG.play(NeoCircuit.SFX.SndHover,0.5);
      }
      
      private function startNewGame() : void
      {
         if(this.m_selectedDiff == this.m_diffEasy)
         {
            NeoCircuit.difficulty = NeoCircuit.DIFFICULTY_EASY;
         }
         else
         {
            NeoCircuit.difficulty = NeoCircuit.DIFFICULTY_HARD;
         }
         cSaveGame.getInstance().eraseData();
         do
         {
            cSaveGame.getInstance().loadPlayerData().difficulty = NeoCircuit.difficulty;
            cSaveGame.getInstance().saveData();
         }
         while(false);
         
         var _loc1_:cStoryState = new cStoryState();
         _loc1_.setLevel(0);
         FlxG.switchState(_loc1_);
      }
   }
}
