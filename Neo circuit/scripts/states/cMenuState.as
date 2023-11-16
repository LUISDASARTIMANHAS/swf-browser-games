package states
{
   import Playtomic.Log;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import hud.cButton;
   import hud.cPauseMuteHud;
   import hud.cSafetyCheckMenu;
   import org.flixel.*;
   
   public class cMenuState extends FlxState
   {
      
      private static const AUTHOR_LABEL_POS:int = 10;
      
      private static const LOGO_POS:int = 70;
      
      private static const FADE_TIME:Number = 1;
      
      private static const SPONSOR_LOGO_POS_X:int = 10;
       
      
      private var m_newGame:cButton;
      
      private var m_continueGame:cButton;
      
      private var m_moreGames:cButton;
      
      private var m_showCredits:cButton;
      
      private var m_iconUrls:Array;
      
      private var m_icons:FlxGroup;
      
      private var m_gameLogo:FlxSprite;
      
      private var m_pauseMuteHud:cPauseMuteHud;
      
      private var m_sponsorLogo:FlxSprite;
      
      private var m_authorLabel:FlxSprite;
      
      private var m_camera:FlxCamera;
      
      private var m_background:FlxSprite;
      
      private var m_textBg:FlxSprite;
      
      private var m_safetyCheckMenu:cSafetyCheckMenu;
      
      private var m_mobileControls:cMobileControls;
      
      private var m_sponsorLogoAnimated:Boolean = false;
      
      public function cMenuState()
      {
         this.m_iconUrls = ["http://blog.rough-sea.com","http://blog.rough-sea.com","https://plus.google.com/115759205578788214765/posts","http://twitter.com/RoughSeaGames","http://www.youtube.com/user/JoeCoo7","http://facebook.com/RoughSeaGames"];
         super();
      }
      
      override public function create() : void
      {
         var _loc1_:FlxSprite = null;
         super.create();
         this.m_background = new FlxSprite(0,0,NeoCircuit.GFX.ImgTitleBackground);
         add(this.m_background);
         if(!NeoCircuit.mobileRelease)
         {
            FlxG.mouse.show(NeoCircuit.GFX.ImgCursor);
         }
         else
         {
            this.m_mobileControls = new cMobileControls();
         }
         this.CreateIcons();
         this.CreateGameLabel();
         if(!NeoCircuit.mobileRelease)
         {
            this.CreateSponsorLogo();
         }
         this.CreateAuthorLabel();
         this.CreateButtons();
         this.m_safetyCheckMenu = new cSafetyCheckMenu();
         this.m_safetyCheckMenu.init();
         this.m_gameLogo.scale.x = 3;
         add(this.m_safetyCheckMenu);
         this.m_pauseMuteHud = new cPauseMuteHud();
         this.m_pauseMuteHud.init(false);
         add(this.m_pauseMuteHud);
         TweenLite.to(this.m_authorLabel,FADE_TIME,{"alpha":1});
         TweenLite.to(this.m_gameLogo,FADE_TIME,{
            "delay":1,
            "alpha":1
         });
         TweenLite.to(this.m_gameLogo.scale,FADE_TIME + 1,{
            "delay":1,
            "x":1,
            "ease":Elastic.easeOut,
            "onComplete":this.playLogoBam
         });
         TweenLite.to(this.m_textBg,FADE_TIME,{
            "delay":1.4,
            "alpha":1
         });
         TweenLite.to(this.m_newGame,FADE_TIME,{
            "delay":1.5,
            "alpha":1
         });
         TweenLite.to(this.m_continueGame,FADE_TIME,{
            "delay":1.6,
            "alpha":1
         });
         TweenLite.to(this.m_moreGames,FADE_TIME,{
            "delay":1.6,
            "alpha":1
         });
         do
         {
            TweenLite.to(this.m_showCredits,FADE_TIME,{
               "delay":1.7,
               "alpha":1
            });
            if(NeoCircuit.mobileRelease)
            {
               break;
            }
            TweenLite.to(this.m_sponsorLogo,FADE_TIME,{
               "delay":1.8,
               "alpha":1
            });
         }
         while(false);
         
         var _loc2_:int = 0;
         while(_loc2_ < this.m_icons.members.length)
         {
            _loc1_ = this.m_icons.members[_loc2_];
            if(_loc1_ != null)
            {
               TweenLite.to(_loc1_,FADE_TIME,{
                  "delay":2,
                  "alpha":1
               });
            }
            _loc2_++;
         }
         if(FlxG.music == null || !FlxG.music.active || NeoCircuit.currentMusic != NeoCircuit.MUSIC_MENU)
         {
            FlxG.playMusic(NeoCircuit.SFX.SndMenuMusic,NeoCircuit.MUSIC_VOLUME_MENU);
            FlxG.music.fadeOut(0);
            FlxG.music.fadeIn(2);
            NeoCircuit.currentMusic = NeoCircuit.MUSIC_MENU;
         }
      }
      
      private function playLogoBam() : void
      {
      }
      
      override public function destroy() : void
      {
         this.m_gameLogo.destroy();
         this.m_authorLabel.destroy();
         this.m_newGame.destroy();
         this.m_continueGame.destroy();
         this.m_moreGames.destroy();
         this.m_showCredits.destroy();
         this.m_pauseMuteHud.destroy();
         this.m_icons.destroy();
         super.destroy();
      }
      
      private function CreateGameLabel() : void
      {
         this.m_gameLogo = new FlxSprite(0,LOGO_POS,NeoCircuit.GFX.ImgLogo);
         this.m_gameLogo.x = FlxG.width * 0.5 - this.m_gameLogo.width * 0.5;
         this.m_gameLogo.alpha = 0;
         add(this.m_gameLogo);
      }
      
      private function CreateSponsorLogo() : void
      {
         this.m_sponsorLogo = new FlxSprite(SPONSOR_LOGO_POS_X,0,NeoCircuit.GFX.ImgSponsorLogo);
         this.m_sponsorLogo.y = FlxG.height - this.m_sponsorLogo.height - 10;
         this.m_sponsorLogo.antialiasing = true;
         this.m_sponsorLogo.alpha = 0;
         add(this.m_sponsorLogo);
      }
      
      private function CreateAuthorLabel() : void
      {
         this.m_authorLabel = new FlxSprite(0,AUTHOR_LABEL_POS,NeoCircuit.GFX.ImgAuthorTitle);
         this.m_authorLabel.x = FlxG.width * 0.5 - this.m_authorLabel.width * 0.5;
         add(this.m_authorLabel);
      }
      
      private function CreateIcons() : void
      {
         var _loc2_:FlxSprite = null;
         this.m_icons = new FlxGroup();
         add(this.m_icons);
         var _loc1_:int = 0;
         var _loc3_:Number = FlxG.height;
         var _loc4_:Number = 0;
         _loc1_ = 2;
         _loc2_ = new FlxSprite(0,0,NeoCircuit.GFX.ImgGoggle);
         _loc2_.ID = _loc1_++;
         _loc2_.y = _loc3_ = _loc3_ - _loc2_.height - 5;
         _loc4_ = _loc2_.width;
         _loc2_.alpha = 0;
         _loc2_.x = FlxG.width - _loc2_.width * 5;
         this.m_icons.add(_loc2_);
         this.CreateIcon(_loc1_,NeoCircuit.GFX.ImgTwitter,_loc2_.x + _loc4_ + 7,_loc3_);
         _loc1_++;
         this.CreateIcon(_loc1_,NeoCircuit.GFX.ImgYoutube,_loc2_.x + _loc4_ * 2 + 14,_loc3_);
         _loc1_++;
         this.CreateIcon(_loc1_,NeoCircuit.GFX.ImgFacebook,_loc2_.x + _loc4_ * 3 + 21,_loc3_);
         _loc1_++;
      }
      
      private function CreateIcon(param1:int, param2:Class, param3:Number, param4:Number) : void
      {
         var _loc5_:FlxSprite;
         (_loc5_ = new FlxSprite(param3,param4,param2)).ID = param1;
         _loc5_.alpha = 0;
         this.m_icons.add(_loc5_);
      }
      
      override public function update() : void
      {
         var _loc1_:FlxSprite = null;
         var _loc2_:int = 0;
         if(!this.m_safetyCheckMenu.visible)
         {
            if(!NeoCircuit.mobileRelease)
            {
               if(this.m_sponsorLogo.overlapsPoint(FlxG.mouse))
               {
                  if(!this.m_sponsorLogoAnimated)
                  {
                     TweenMax.to(this.m_sponsorLogo.scale,0.25,{
                        "x":1.1,
                        "y":1.1,
                        "yoyo":true,
                        "repeat":-1
                     });
                     FlxG.play(NeoCircuit.SFX.SndHover,0.5);
                     this.m_sponsorLogoAnimated = true;
                  }
               }
               else
               {
                  this.m_sponsorLogoAnimated = false;
                  TweenLite.killTweensOf(this.m_sponsorLogo.scale,true);
               }
            }
            if(FlxG.mouse.justReleased())
            {
               if(this.m_gameLogo.overlapsPoint(FlxG.mouse))
               {
                  if(!FlxU.openURL(this.m_iconUrls[0]))
                  {
                     NeoCircuit.copyLinkHud.show(this.m_iconUrls[0]);
                  }
               }
               do
               {
                  if(this.m_sponsorLogoAnimated)
                  {
                     if(!FlxU.openURL("http://www.bigdino.com/clickreg.php?id=309&link=logoMainMenu"))
                     {
                        NeoCircuit.copyLinkHud.show("http://www.bigdino.com/clickreg.php?id=309&link=logoMainMenu");
                     }
                  }
                  _loc2_ = 0;
               }
               while(false);
               
               while(_loc2_ < this.m_icons.members.length)
               {
                  _loc1_ = this.m_icons.members[_loc2_] as FlxSprite;
                  if(_loc1_ != null)
                  {
                     if(_loc1_.overlapsPoint(FlxG.mouse))
                     {
                        if(!FlxU.openURL(this.m_iconUrls[_loc1_.ID]))
                        {
                           NeoCircuit.copyLinkHud.show(this.m_iconUrls[_loc1_.ID]);
                        }
                     }
                  }
                  _loc2_++;
               }
            }
         }
         super.update();
      }
      
      public function SetButtonStatus(param1:Boolean) : void
      {
         this.m_newGame.activate(param1);
         this.m_continueGame.activate(param1);
         this.m_showCredits.activate(param1);
         this.m_moreGames.activate(param1);
      }
      
      private function CreateButtons() : void
      {
         var _loc1_:Number = 35;
         var _loc2_:Number = 250;
         var _loc3_:Number = FlxG.width * 0.5 - _loc2_ * 0.5;
         var _loc4_:Number = FlxG.height * 0.5;
         this.m_textBg = new FlxSprite(0,0,NeoCircuit.GFX.ImgMainMenuGui);
         this.m_textBg.x = FlxG.width * 0.5 - this.m_textBg.width * 0.5;
         this.m_textBg.y = _loc4_;
         this.m_textBg.alpha = 0;
         add(this.m_textBg);
         _loc4_ += _loc1_ * 0.5;
         this.m_newGame = this.CreateTextButton(_loc3_,_loc4_,this.onNewGame,"NEW GAME",_loc2_,_loc1_);
         this.m_continueGame = this.CreateTextButton(_loc3_,_loc4_ + _loc1_ + 2,this.onPlayGame,"CONTINUE GAME",_loc2_,_loc1_);
         this.m_moreGames = this.CreateTextButton(_loc3_,_loc4_ + _loc1_ * 2 + 4,this.onMoreGames,"MORE GAMES",_loc2_,_loc1_);
         this.m_showCredits = this.CreateTextButton(_loc3_,_loc4_ + _loc1_ * 3 + 6,this.onCredits,"CREDITS",_loc2_,_loc1_);
         this.m_continueGame.active = cSaveGame.getInstance().saveGameAvailable();
         if(!this.m_continueGame.active)
         {
            this.m_continueGame.textNormal.color = 4286611584;
            this.m_continueGame.borderColor = 4286611584;
         }
      }
      
      private function CreateTextButton(param1:Number, param2:Number, param3:Function, param4:String, param5:Number, param6:Number) : cButton
      {
         var _loc7_:cButton;
         (_loc7_ = new cButton(param1,param2,param3,null,param4,param5,param6,0)).textNormal.font = "cpu";
         _loc7_.updateActiveButtonColors([0,0]);
         _loc7_.updateInactiveButtonColors([0,0]);
         _loc7_.textNormal.color = 4294967295;
         _loc7_.textNormal.size = 26;
         _loc7_.borderColor = 4278190320;
         _loc7_.alpha = 0;
         add(_loc7_);
         return _loc7_;
      }
      
      override public function draw() : void
      {
         super.draw();
      }
      
      private function onPlayGame() : void
      {
         TweenMax.killAll();
         FlxG.play(NeoCircuit.SFX.SndClick);
         this.SetButtonStatus(false);
         FlxG.fade(0,1,this.playGame);
      }
      
      private function onNewGame() : void
      {
         if(cSaveGame.getInstance().saveGameAvailable())
         {
            this.SetButtonStatus(false);
            this.m_safetyCheckMenu.show();
         }
         else
         {
            TweenMax.killAll();
            this.onNewGameNoSafetyCheck();
         }
      }
      
      public function onNewGameNoSafetyCheck() : void
      {
         FlxG.play(NeoCircuit.SFX.SndClick);
         this.SetButtonStatus(false);
         FlxG.fade(0,1,this.newGame);
         this.newGame();
      }
      
      private function onCredits() : void
      {
         TweenMax.killAll();
         FlxG.play(NeoCircuit.SFX.SndClick);
         this.SetButtonStatus(false);
         FlxG.fade(0,1,this.credits);
      }
      
      private function credits() : void
      {
         FlxG.switchState(new cCreditsState());
      }
      
      private function onMoreGames() : void
      {
         if(this.m_safetyCheckMenu.visible)
         {
            return;
         }
         FlxG.play(NeoCircuit.SFX.SndClick);
         if(!FlxU.openURL("http://www.bigdino.com/clickreg.php?id=309&link=moreGamesMainMenu"))
         {
            NeoCircuit.copyLinkHud.show("http://www.bigdino.com/clickreg.php?id=309&link=moreGamesMainMenu");
         }
      }
      
      public function playGame() : void
      {
         Log.Play();
         this.SetButtonStatus(false);
         FlxG.switchState(new cLevelSelection());
      }
      
      public function newGame() : void
      {
         Log.Play();
         this.SetButtonStatus(false);
         FlxG.switchState(new cDifficultySelectState());
      }
   }
}
