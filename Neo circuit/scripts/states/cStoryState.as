package states
{
   import com.greensock.TweenLite;
   import org.flixel.*;
   
   public class cStoryState extends FlxState
   {
      
      private static const MAX_DISPLAY_TIME:Number = 30;
      
      private static const FADE_TIME:Number = 1;
       
      
      private var m_currentLevel:int;
      
      private var m_background:FlxSprite;
      
      private var m_gfx:Array;
      
      private var m_text:Array;
      
      private var m_timer:Number = 30;
      
      private var m_fading:Boolean;
      
      private var m_storyData:cStoryData;
      
      public function cStoryState()
      {
         super();
      }
      
      override public function create() : void
      {
         super.create();
         this.m_background = new FlxSprite(0,0,NeoCircuit.GFX.ImgBackground);
         this.m_background.scrollFactor = cObjectManager.ZERO_FLXPOINT;
         this.m_background.solid = false;
         this.m_background.immovable = true;
         add(this.m_background);
         cObjectManager.getInstance().initStoryState(this);
         this.showLevel();
      }
      
      public function setLevel(param1:int) : void
      {
         this.m_currentLevel = param1;
      }
      
      public function showLevel() : void
      {
         switch(this.m_currentLevel)
         {
            case 0:
               this.showLevel0();
         }
      }
      
      public function showLevel0() : void
      {
         var _loc1_:FlxText = null;
         this.m_storyData = cObjectManager.getInstance().storyDataList[0];
         var _loc2_:Number = FlxG.height;
         var _loc3_:int = 0;
         while(_loc3_ < this.m_storyData.storyTexts.length)
         {
            _loc1_ = cObjectManager.getInstance().getFreeStoryText();
            _loc1_.text = this.m_storyData.storyTexts[_loc3_];
            _loc1_.y = _loc2_;
            _loc1_.velocity.y = -50;
            _loc2_ += _loc1_.size + 3;
            _loc1_.alpha = 0;
            do
            {
               TweenLite.to(_loc1_,5,{
                  "delay":_loc3_,
                  "alpha":1
               });
               _loc3_++;
            }
            while(false);
            
         }
      }
      
      override public function update() : void
      {
         if(this.m_fading)
         {
            return;
         }
         this.m_timer -= FlxG.elapsed;
         if(this.m_timer <= 0 || FlxG.keys.any() || FlxG.mouse.pressed())
         {
            this.switchToPlayState();
         }
         super.update();
      }
      
      private function switchToPlayState() : void
      {
         FlxG.music.fadeOut(FADE_TIME);
         FlxG.fade(0,FADE_TIME,this.onPlay);
         this.m_fading = true;
      }
      
      private function onPlay() : void
      {
         var _loc1_:cPlayState = new cPlayState();
         _loc1_.currentLevel = 0;
         FlxG.switchState(_loc1_);
      }
   }
}
