package hud
{
   import com.greensock.TweenLite;
   import flash.ui.Mouse;
   import mochi.as3.*;
   import org.flixel.FlxBasic;
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   import org.flixel.FlxU;
   import states.cPlayState;
   
   public class cNextLevelHud extends FlxGroup
   {
      
      private static const FADE_TIME:Number = 0.5;
      
      private static const SIZEX:Number = 250;
      
      private static const SIZEY:Number = 35;
      
      private static const FONT_SIZE:int = 26;
      
      private static const GAP:int = 5;
      
      private static const FONT_COLOR_HIGHLIGHT:int = 4294967295;
      
      private static const FONT_COLOR_NORMAL:int = 4294967295;
      
      private static var m_easyLeaderBoardIds:Array = ["0","0","42947d9b6a795dd6","0","234dbf11975e6c84","0","07711d78aeb61456","0","7ee111588d18ece6","65f634474b68ffd7","f2c03d47bc2ff294","f799a6509b491a12","554a25181e369b88","19a18c51efd55d8d","70135f478caceaa3","57e19c557831d260","7d52defb5e7c062c","cb67e54ff4c912d2","a6329e63205e9df0","9b4a8ea29b6a31af","0758de1c5f65a07f","c0305ca81960115a","54d443de21603719","d5eff35c033e85f0","eed3ca971a6efdf3","43b48b15bba830cf","17675540ecb4dc03","820f87a965ff7416","925bb34e9d423370","f483f4cc2b1845bf"];
      
      private static var m_hardLeaderBoardIds:Array = ["0","0","bdbb767e9b3876da","0,","de3f4c9c887f9756","0","a37521609cda8c9f","0","13a6a8548c4e959e","36ee3707d076eb6d","e5c27da3cfac20d3","5522e8b6c335a222","01622323b7c84e82","460ab994631c5e4c","1950b7f8258f6611","7959ca236e14a65e","8007cd3b1a6495e0","f860c6a927b3ed5d","b2d893d4a22b99a8","b4a049e538f06d8b","aa77baab63a4182f","7d44695bcb5c816f","b383186e172bb2c6","ceff2e6e3f544378","0730cfa0123c22bb","6a576726511cce6e","ffcdf02722b48ddb","c48c8df6f4cf1e68","dc0f7828a0a79a89","43d163daf55ab976"];
      
      private static const STARTBUTTON_POSX:Number = FlxG.width * 0.5 - SIZEX * 0.5;
      
      private static const TRY_AGAIN_TEXT:String = "TRY AGAIN";
       
      
      private var BUTTON_TEXTS:Array;
      
      private var BUTTON_CALLBACKS:Array;
      
      private var m_darkBG:FlxSprite;
      
      private var m_buttonBG:FlxSprite;
      
      private var m_buttons:Array;
      
      private var m_submit:Boolean;
      
      private var m_buttonCallback:Function;
      
      public function cNextLevelHud()
      {
         var _loc3_:cButton = null;
         this.BUTTON_TEXTS = ["SUBMIT","NEXT LEVEL","SELECT LEVEL","MAIN MENU"];
         this.BUTTON_CALLBACKS = [this.onSubmitTime,this.onNextLevel,this.onLevelSelection,this.onMainMenu];
         super();
         this.m_darkBG = new FlxSprite();
         this.m_darkBG.makeGraphic(FlxG.width,FlxG.height,536870912);
         add(this.m_darkBG);
         this.m_buttonBG = new FlxSprite(0,0,NeoCircuit.GFX.ImgMainMenuGui);
         this.m_buttonBG.x = FlxG.width * 0.5 - this.m_buttonBG.width * 0.5;
         this.m_buttonBG.y = FlxG.height * 0.75 - this.m_buttonBG.height * 0.5;
         add(this.m_buttonBG);
         do
         {
            this.hideElement(this.m_buttonBG);
            this.hideElement(this.m_darkBG);
         }
         while(false);
         
         var _loc1_:Number = STARTBUTTON_POSX;
         var _loc2_:Number = this.m_buttonBG.y + 12;
         this.m_buttons = [];
         var _loc4_:int = 0;
         while(_loc4_ < this.BUTTON_TEXTS.length)
         {
            _loc3_ = this.createTextButton(_loc4_,_loc1_,_loc2_,this.onButtonClicked,this.BUTTON_TEXTS[_loc4_],SIZEX,SIZEY);
            this.hideElement(_loc3_);
            this.m_buttons.push(_loc3_);
            do
            {
               _loc2_ += SIZEY + GAP;
               _loc4_++;
            }
            while(false);
            
         }
         kill();
         visible = false;
      }
      
      public function show() : void
      {
         var _loc6_:cButton = null;
         FlxG.mouse.reset();
         visible = true;
         do
         {
            revive();
            NeoCircuit.stopGame = true;
         }
         while(false);
         
         var _loc1_:cPlayState = FlxG.state as cPlayState;
         this.m_submit = cObjectManager.getInstance().player.gameStatus == cPlayer.GAMESTATUS_WON && _loc1_.bestTimeScored && !NeoCircuit.mobileRelease;
         var _loc2_:cButton = this.m_buttons[0] as cButton;
         if(this.m_submit)
         {
            _loc2_.textNormal.text = this.BUTTON_TEXTS[0];
         }
         else
         {
            _loc2_.textNormal.text = TRY_AGAIN_TEXT;
         }
         var _loc3_:cButton = this.m_buttons[1] as cButton;
         var _loc4_:Object = cSaveGame.getInstance().loadPlayerData();
         _loc3_.active = _loc4_.levelsDone > _loc1_.currentLevel;
         while(!_loc3_.active)
         {
            _loc3_.textNormal.color = 4286611584;
            _loc3_.borderColor = 4286611584;
            if(true)
            {
               break;
            }
         }
         var _loc5_:Number = FlxG.width * 0.5 - 125;
         this.showElement(this.m_darkBG);
         this.showElement(this.m_buttonBG);
         for each(_loc6_ in this.m_buttons)
         {
            this.showElement(_loc6_);
         }
         FlxG.mouse.show(NeoCircuit.GFX.ImgCursor);
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      private function createTextButton(param1:int, param2:Number, param3:Number, param4:Function, param5:String, param6:Number, param7:Number) : cButton
      {
         var _loc8_:cButton;
         (_loc8_ = new cButton(param2,param3,param4,[param1],param5,param6,param7,4278190320)).textNormal.font = "cpu";
         _loc8_.updateActiveButtonColors([4279270898,4279270898]);
         _loc8_.updateInactiveButtonColors([0,0]);
         _loc8_.textNormal.color = FONT_COLOR_NORMAL;
         _loc8_.textNormal.size = FONT_SIZE;
         _loc8_.pauseProof = true;
         add(_loc8_);
         return _loc8_;
      }
      
      private function showElement(param1:FlxBasic) : void
      {
         param1.active = true;
         param1.visible = true;
         TweenLite.to(param1,FADE_TIME,{"alpha":1});
      }
      
      private function hideElement(param1:FlxBasic) : void
      {
         param1.active = false;
         param1.visible = false;
      }
      
      private function StartHiding() : void
      {
         var _loc1_:cButton = null;
         for each(_loc1_ in this.m_buttons)
         {
            TweenLite.to(_loc1_,FADE_TIME,{"alpha":0});
         }
         TweenLite.to(this.m_darkBG,FADE_TIME,{
            "alpha":0,
            "onComplete":this.OnChangeStatus
         });
         TweenLite.to(this.m_buttonBG,FADE_TIME,{"alpha":0});
      }
      
      private function onButtonClicked(param1:int) : void
      {
         FlxG.play(NeoCircuit.SFX.SndClick);
         this.m_buttonCallback = this.BUTTON_CALLBACKS[param1];
         this.StartHiding();
      }
      
      private function OnChangeStatus() : void
      {
         visible = false;
         kill();
         NeoCircuit.stopGame = false;
         this.m_buttonCallback.call();
      }
      
      private function onMoreGames() : void
      {
         if(!FlxU.openURL("http://www.bigdino.com/clickreg.php?id=309&link=moreGamesNextLevelMenu"))
         {
            NeoCircuit.copyLinkHud.show("http://www.bigdino.com/clickreg.php?id=309&link=moreGamesNextLevelMenu");
         }
      }
      
      private function onNextLevel() : void
      {
         var _loc1_:int = (FlxG.state as cPlayState).currentLevel + 1;
         (FlxG.state as cPlayState).changeLevel(_loc1_);
      }
      
      private function onSubmitTime() : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:cPlayState = FlxG.state as cPlayState;
         var _loc2_:int = _loc1_.currentLevel;
         if(!this.m_submit)
         {
            _loc1_.changeLevel(_loc2_);
         }
         else
         {
            if(NeoCircuit.difficulty == NeoCircuit.DIFFICULTY_EASY)
            {
               _loc3_ = String(m_easyLeaderBoardIds[_loc1_.currentLevel]);
            }
            else
            {
               _loc3_ = String(m_hardLeaderBoardIds[_loc1_.currentLevel]);
            }
            _loc4_ = _loc1_.currentPlayTime * 1000;
            _loc5_ = FlxG.width * 0.25;
            _loc6_ = FlxG.height * 0.25;
            MochiScores.showLeaderboard({
               "width":FlxG.width,
               "height":FlxG.height,
               "boardID":_loc3_,
               "score":_loc4_,
               "onDisplay":this.onDisplayMochiScore,
               "onClose":this.onCloseMochiScore
            });
         }
      }
      
      private function onDisplayMochiScore() : void
      {
         NeoCircuit.leaderBoardShown = true;
         Mouse.show();
      }
      
      private function onCloseMochiScore() : void
      {
         var _loc1_:cButton = this.m_buttons[0] as cButton;
         _loc1_.textNormal.text = TRY_AGAIN_TEXT;
         this.m_submit = false;
         NeoCircuit.leaderBoardShown = false;
         Mouse.hide();
      }
      
      private function onMainMenu() : void
      {
         (FlxG.state as cPlayState).switchToMenu();
      }
      
      private function onLevelSelection() : void
      {
         (FlxG.state as cPlayState).switchToLevelSelection();
      }
   }
}
