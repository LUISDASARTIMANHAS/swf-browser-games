package hud
{
   import com.greensock.TweenLite;
   import org.flixel.FlxBasic;
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   import org.flixel.FlxState;
   import org.flixel.FlxU;
   import states.cLevelSelection;
   import states.cMenuState;
   
   public class cPauseMenu extends FlxGroup
   {
      
      private static const FADE_TIME:Number = 0.25;
      
      private static const SIZEX:Number = 250;
      
      private static const SIZEY:Number = 37;
      
      private static const FONT_SIZE:Number = 26;
      
      private static const CONTINUE_BUTTON_POSY:Number = FlxG.height * 0.5 - SIZEY * 2;
      
      private static const MAINMENU_BUTTON_POSY:Number = CONTINUE_BUTTON_POSY + SIZEY;
      
      private static const LEVELSELECT_BUTTON_POSY:Number = MAINMENU_BUTTON_POSY + SIZEY;
      
      private static const MOREGAMES_BUTTON_POSY:Number = LEVELSELECT_BUTTON_POSY + SIZEY;
      
      private static const BUTTON_POSX:Number = FlxG.width * 0.5 - SIZEX * 0.5;
       
      
      private var m_buttonBG:FlxSprite;
      
      private var m_darkBG:FlxSprite;
      
      private var m_continueButton:cButton;
      
      private var m_levelSelectButton:cButton;
      
      private var m_mainMenuButton:cButton;
      
      private var m_moreGamesButton:cButton;
      
      private var m_nextState:FlxState;
      
      public function cPauseMenu()
      {
         super();
      }
      
      public function init() : void
      {
         this.m_nextState = null;
         this.m_darkBG = new FlxSprite();
         this.m_darkBG.makeGraphic(FlxG.width,FlxG.height,3221225472);
         this.m_darkBG.scrollFactor = cObjectManager.ZERO_FLXPOINT;
         add(this.m_darkBG);
         this.m_buttonBG = new FlxSprite(0,0,NeoCircuit.GFX.ImgMainMenuGui);
         this.m_buttonBG.x = FlxG.width * 0.5 - this.m_buttonBG.width * 0.5;
         this.m_buttonBG.y = FlxG.height * 0.5 - this.m_buttonBG.height * 0.5;
         add(this.m_buttonBG);
         this.m_continueButton = this.CreateTextButton(BUTTON_POSX,CONTINUE_BUTTON_POSY,this.onContinueButton,"CONTINUE",SIZEX,SIZEY);
         this.m_mainMenuButton = this.CreateTextButton(BUTTON_POSX,MAINMENU_BUTTON_POSY,this.onMainMenuButton,"MAIN MENU",SIZEX,SIZEY);
         this.m_moreGamesButton = this.CreateTextButton(BUTTON_POSX,MOREGAMES_BUTTON_POSY,this.onMoreGamesButton,"MORE GAMES",SIZEX,SIZEY);
         this.m_levelSelectButton = this.CreateTextButton(BUTTON_POSX,LEVELSELECT_BUTTON_POSY,this.onLevelSelectButton,"LEVEL SELECT",SIZEX,SIZEY);
         kill();
         this.HideButtons();
      }
      
      public function show(param1:Boolean) : void
      {
         revive();
         this.ShowElement(this.m_darkBG);
         this.ShowElement(this.m_buttonBG);
         this.ShowElement(this.m_continueButton);
         this.ShowElement(this.m_mainMenuButton);
         this.ShowElement(this.m_moreGamesButton);
         if(param1)
         {
            this.m_levelSelectButton.y = LEVELSELECT_BUTTON_POSY;
            this.ShowElement(this.m_levelSelectButton);
         }
         else
         {
            this.HideElement(this.m_levelSelectButton);
         }
      }
      
      private function ShowElement(param1:FlxBasic) : void
      {
         param1.visible = true;
         param1.active = true;
         TweenLite.to(param1,FADE_TIME,{"alpha":1});
      }
      
      private function HideElement(param1:FlxBasic) : void
      {
         param1.visible = false;
         param1.active = false;
      }
      
      override public function update() : void
      {
         if(!NeoCircuit.mobileRelease)
         {
            if(FlxG.keys.justPressed("P") || FlxG.keys.justPressed("ESCAPE"))
            {
               this.onContinueButton();
            }
         }
         super.update();
      }
      
      private function OnHide() : void
      {
         this.HideButtons();
         NeoCircuit.pause();
         kill();
         if(this.m_nextState == null || this.m_nextState == FlxG.state)
         {
            return;
         }
         FlxG.switchState(this.m_nextState);
      }
      
      private function HideButtons() : void
      {
         this.HideElement(this.m_darkBG);
         this.HideElement(this.m_buttonBG);
         this.HideElement(this.m_continueButton);
         this.HideElement(this.m_mainMenuButton);
         this.HideElement(this.m_levelSelectButton);
         this.HideElement(this.m_moreGamesButton);
      }
      
      private function CreateTextButton(param1:Number, param2:Number, param3:Function, param4:String, param5:Number, param6:Number) : cButton
      {
         var _loc7_:cButton;
         (_loc7_ = new cButton(param1,param2,param3,null,param4,param5,param6,4294967295)).textNormal.font = "cpu";
         _loc7_.updateActiveButtonColors([4279270898,4279270898]);
         _loc7_.updateInactiveButtonColors([0,0]);
         _loc7_.textNormal.color = 4294967295;
         _loc7_.textNormal.size = FONT_SIZE;
         _loc7_.pauseProof = true;
         add(_loc7_);
         return _loc7_;
      }
      
      private function StartHiding() : void
      {
         TweenLite.to(this.m_darkBG,FADE_TIME,{"alpha":0});
         TweenLite.to(this.m_buttonBG,FADE_TIME,{"alpha":0});
         TweenLite.to(this.m_continueButton,FADE_TIME,{
            "alpha":0,
            "onComplete":this.OnHide
         });
         TweenLite.to(this.m_mainMenuButton,FADE_TIME,{"alpha":0});
         TweenLite.to(this.m_moreGamesButton,FADE_TIME,{"alpha":0});
         TweenLite.to(this.m_levelSelectButton,FADE_TIME,{"alpha":0});
      }
      
      private function onContinueButton() : void
      {
         FlxG.play(NeoCircuit.SFX.SndClick);
         this.m_nextState = FlxG.state;
         this.StartHiding();
      }
      
      private function onLevelSelectButton() : void
      {
         FlxG.play(NeoCircuit.SFX.SndClick);
         this.m_nextState = new cLevelSelection();
         this.StartHiding();
      }
      
      private function onMainMenuButton() : void
      {
         FlxG.play(NeoCircuit.SFX.SndClick);
         this.m_nextState = new cMenuState();
         this.StartHiding();
      }
      
      private function onMoreGamesButton() : void
      {
         FlxG.play(NeoCircuit.SFX.SndClick);
         if(!FlxU.openURL("http://www.bigdino.com/clickreg.php?id=309&link=moreGamesPauseMenu"))
         {
            NeoCircuit.copyLinkHud.show("http://www.bigdino.com/clickreg.php?id=309&link=moreGamesPauseMenu");
         }
      }
   }
}
