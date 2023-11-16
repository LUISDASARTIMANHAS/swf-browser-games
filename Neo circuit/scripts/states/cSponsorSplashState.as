package states
{
   import flash.display.MovieClip;
   import org.flixel.FlxG;
   import org.flixel.FlxState;
   import org.flixel.FlxU;
   
   public class cSponsorSplashState extends FlxState
   {
      
      private static const MAX_DISPLAY_TIME:Number = 6.5;
       
      
      private var BigDinoSplashClass:Class;
      
      private var m_fading:Boolean = false;
      
      private var m_splashScreen:MovieClip;
      
      private var m_timer:Number = 6.5;
      
      public function cSponsorSplashState()
      {
         this.BigDinoSplashClass = cSponsorSplashState_BigDinoSplashClass;
         super();
      }
      
      override public function create() : void
      {
         FlxG.mouse.show(NeoCircuit.GFX.ImgCursor);
         super.create();
         this.m_splashScreen = new this.BigDinoSplashClass();
         FlxG.stage.addChildAt(this.m_splashScreen,0);
         FlxG.bgColor = 0;
         this.m_splashScreen.play();
      }
      
      override public function update() : void
      {
         if(this.m_fading)
         {
            return;
         }
         if(FlxG.mouse.justPressed())
         {
            FlxU.openURL("http://www.bigdino.com/clickreg.php?id=309&link=SplashScreen");
         }
         this.m_timer -= FlxG.elapsed;
         if(this.m_timer <= 0)
         {
            this.m_fading = true;
            FlxG.fade(0,1,this.startMenu);
         }
      }
      
      private function startMenu() : void
      {
         FlxG.switchState(new cMenuState());
      }
   }
}
