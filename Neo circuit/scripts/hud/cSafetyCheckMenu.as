package hud
{
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   import org.flixel.FlxText;
   import states.cMenuState;
   
   public class cSafetyCheckMenu extends FlxGroup
   {
      
      private static const FADE_TIME:Number = 0.25;
      
      private static const SIZEX:Number = 250;
      
      private static const SIZEY:Number = 40;
      
      private static const TEXT_POSY:Number = FlxG.height * 0.4;
      
      private static const CONTINUE_BUTTON_POSY:Number = TEXT_POSY + SIZEY;
      
      private static const MAINMENU_BUTTON_POSY:Number = TEXT_POSY + SIZEY * 2;
       
      
      private var m_darkBG:FlxSprite;
      
      private var m_text:FlxText;
      
      private var m_continueButton:cButton;
      
      private var m_mainMenuButton:cButton;
      
      private var m_time:FlxText;
      
      public function cSafetyCheckMenu()
      {
         super();
      }
      
      public function init() : void
      {
         this.m_darkBG = new FlxSprite();
         this.m_darkBG.makeGraphic(FlxG.width,FlxG.height,3489660928);
         this.m_darkBG.scrollFactor = cObjectManager.ZERO_FLXPOINT;
         add(this.m_darkBG);
         this.m_text = new FlxText(0,TEXT_POSY,FlxG.width);
         this.m_text.alignment = "center";
         this.m_text.text = "ALL PROGRESS WILL BE LOST!";
         this.m_text.size = 28;
         this.m_text.color = 16711680;
         this.m_text.font = "cpu";
         this.m_text.scrollFactor = cObjectManager.ZERO_FLXPOINT;
         do
         {
            add(this.m_text);
            visible = false;
         }
         while(false);
         
         var _loc1_:Number = FlxG.width * 0.5 - SIZEX * 0.5;
         this.m_continueButton = this.CreateTextButton(_loc1_,CONTINUE_BUTTON_POSY,this.onContinueButton,"YES, GO AHEAD",SIZEX,SIZEY);
         this.m_mainMenuButton = this.CreateTextButton(_loc1_,MAINMENU_BUTTON_POSY,this.onMainMenuButton,"NO THANKS",SIZEX,SIZEY);
         this.HideButtons();
      }
      
      public function show() : void
      {
         visible = true;
         FlxG.mouse.reset();
         this.m_darkBG.revive();
         this.m_continueButton.revive();
         do
         {
            this.m_mainMenuButton.revive();
            this.m_text.revive();
         }
         while(false);
         
         this.m_darkBG.visible = this.m_continueButton.visible = this.m_mainMenuButton.visible = this.m_text.visible = true;
         this.m_continueButton.active = this.m_mainMenuButton.active = true;
      }
      
      private function OnHide() : void
      {
         this.HideButtons();
      }
      
      private function HideButtons() : void
      {
         FlxG.mouse.reset();
         visible = false;
         this.m_continueButton.kill();
         this.m_text.kill();
         do
         {
            this.m_mainMenuButton.kill();
            this.m_darkBG.kill();
         }
         while(false);
         
         this.m_darkBG.visible = this.m_mainMenuButton.visible = this.m_text.visible = this.m_continueButton.visible = false;
         this.m_continueButton.active = this.m_mainMenuButton.active = false;
         this.m_continueButton.reset();
         this.m_mainMenuButton.reset();
      }
      
      private function CreateTextButton(param1:Number, param2:Number, param3:Function, param4:String, param5:Number, param6:Number) : cButton
      {
         var _loc7_:cButton;
         (_loc7_ = new cButton(param1,param2,param3,null,param4,param5,param6,0)).textNormal.font = "cpu";
         _loc7_.updateActiveButtonColors([4279270898,4279270898]);
         _loc7_.updateInactiveButtonColors([0,0]);
         _loc7_.textNormal.color = 4294967295;
         _loc7_.textNormal.size = 28;
         _loc7_.pauseProof = true;
         add(_loc7_);
         return _loc7_;
      }
      
      private function onContinueButton() : void
      {
         this.HideButtons();
         (FlxG.state as cMenuState).onNewGameNoSafetyCheck();
      }
      
      private function onMainMenuButton() : void
      {
         this.HideButtons();
         (FlxG.state as cMenuState).SetButtonStatus(true);
      }
   }
}
