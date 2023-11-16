package hud
{
   import com.greensock.TweenMax;
   import org.flixel.*;
   import states.cPlayState;
   
   public class cPauseMuteHud extends FlxGroup
   {
      
      private static const SMALL_BUTTON_SIZE:int = 32;
      
      private static const BIG_BUTTON_SIZE:int = 64;
       
      
      private var m_pauseButton:FlxSprite;
      
      private var m_muteButton:FlxSprite;
      
      private var m_replayButton:FlxSprite;
      
      private var m_showPause:Boolean;
      
      private var m_currentButton:FlxSprite;
      
      private var m_speedButton:FlxSprite;
      
      private var m_buttonSize:int;
      
      private var m_buttonIndex:int;
      
      public function cPauseMuteHud()
      {
         super();
      }
      
      public function init(param1:Boolean = true) : void
      {
         if(NeoCircuit.mobileRelease)
         {
            this.m_buttonSize = BIG_BUTTON_SIZE;
            this.m_buttonIndex = 1;
         }
         else
         {
            this.m_buttonSize = SMALL_BUTTON_SIZE;
            this.m_buttonIndex = 0;
         }
         this.m_showPause = param1;
         if(param1)
         {
            this.m_pauseButton = new FlxSprite(0,0,NeoCircuit.GFX.buttonPause[this.m_buttonIndex]);
            this.m_pauseButton.antialiasing = true;
            add(this.m_pauseButton);
         }
         if(param1)
         {
            this.m_muteButton = new FlxSprite(this.m_buttonSize,0);
         }
         else
         {
            this.m_muteButton = new FlxSprite(0,0);
         }
         this.m_muteButton.loadGraphic(NeoCircuit.GFX.buttonMute[this.m_buttonIndex],true,false,this.m_buttonSize,this.m_buttonSize);
         this.m_muteButton.addAnimation("on",[0]);
         this.m_muteButton.addAnimation("off",[1]);
         this.m_muteButton.antialiasing = true;
         this.m_muteButton.play("on");
         do
         {
            add(this.m_muteButton);
            this.m_replayButton = new FlxSprite(this.m_buttonSize * 2,0,NeoCircuit.GFX.buttonReplay[this.m_buttonIndex]);
         }
         while(false);
         
         this.m_replayButton.active = this.m_replayButton.visible = FlxG.state is cPlayState;
         this.m_replayButton.antialiasing = true;
         add(this.m_replayButton);
         this.m_speedButton = new FlxSprite(this.m_buttonSize * 3,0);
         this.m_speedButton.loadGraphic(NeoCircuit.GFX.buttonSpeed[this.m_buttonIndex],true,false,this.m_buttonSize,this.m_buttonSize);
         this.m_speedButton.addAnimation("normal",[0]);
         do
         {
            this.m_speedButton.addAnimation("fast",[1]);
            this.m_speedButton.antialiasing = true;
         }
         while(false);
         
         this.m_speedButton.active = this.m_speedButton.visible = FlxG.state is cPlayState;
         add(this.m_speedButton);
      }
      
      public function signalSpeedButton(param1:Boolean) : void
      {
         if(param1)
         {
            TweenMax.to(this.m_speedButton.scale,0.25,{
               "x":1.25,
               "y":1.25,
               "yoyo":true,
               "repeat":-1
            });
         }
         else
         {
            TweenMax.killTweensOf(this.m_speedButton.scale,true);
         }
      }
      
      override public function update() : void
      {
         this.PickButton();
         if(FlxG.keys.justPressed("SPACE"))
         {
            (FlxG.state as cPlayState).toggleGameSpeed();
            this.setSpeedButton();
         }
         else if(FlxG.keys.justReleased("SPACE"))
         {
            (FlxG.state as cPlayState).toggleGameSpeed();
            this.setSpeedButton();
         }
         if(FlxG.mouse.justPressed())
         {
            this.ExecuteButton();
         }
         if(FlxG.volume <= 0)
         {
            this.m_muteButton.play("off");
         }
         else
         {
            this.m_muteButton.play("on");
         }
      }
      
      private function PickButton() : void
      {
         var _loc1_:FlxSprite = null;
         if(this.m_showPause && this.m_pauseButton.overlapsPoint(FlxG.mouse,true))
         {
            _loc1_ = this.m_pauseButton;
         }
         else if(this.m_muteButton.overlapsPoint(FlxG.mouse,true))
         {
            _loc1_ = this.m_muteButton;
         }
         else if(this.m_replayButton.active)
         {
            if(this.m_replayButton.overlapsPoint(FlxG.mouse,true))
            {
               _loc1_ = this.m_replayButton;
            }
            else if(this.m_speedButton.overlapsPoint(FlxG.mouse,true))
            {
               _loc1_ = this.m_speedButton;
            }
         }
         if(_loc1_ == this.m_currentButton)
         {
            return;
         }
         if(this.m_currentButton != null)
         {
            TweenMax.killTweensOf(this.m_currentButton.scale,true);
         }
         this.m_currentButton = _loc1_;
         if(this.m_currentButton != null)
         {
            TweenMax.to(this.m_currentButton.scale,0.25,{
               "x":1.25,
               "y":1.25,
               "yoyo":true,
               "repeat":-1
            });
            FlxG.play(NeoCircuit.SFX.SndHover,0.5);
         }
      }
      
      private function ExecuteButton() : void
      {
         var _loc1_:cPlayState = FlxG.state as cPlayState;
         if(this.m_currentButton == null)
         {
            return;
         }
         if(this.m_pauseButton == this.m_currentButton)
         {
            NeoCircuit.pause();
         }
         else if(this.m_muteButton == this.m_currentButton)
         {
            NeoCircuit.mute();
         }
         else if(this.m_speedButton == this.m_currentButton)
         {
            _loc1_.toggleGameSpeed();
            this.setSpeedButton();
         }
         else if(this.m_replayButton == this.m_replayButton)
         {
            _loc1_.changeLevel(_loc1_.currentLevel);
         }
      }
      
      private function setSpeedButton() : void
      {
         var _loc1_:cPlayState = FlxG.state as cPlayState;
         if(_loc1_.gameSpeed == cPlayState.GAME_SPEED_NORMAL)
         {
            this.m_speedButton.play("normal");
         }
         else
         {
            this.m_speedButton.play("fast");
         }
      }
   }
}
