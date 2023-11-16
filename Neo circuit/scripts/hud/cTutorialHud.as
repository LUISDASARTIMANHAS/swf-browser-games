package hud
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import org.flixel.*;
   import states.cPlayState;
   
   public class cTutorialHud extends FlxGroup
   {
      
      private static const FADE_IN_TIME:Number = 0.15;
      
      private static const FADE_OUT_TIME:Number = 0.15;
      
      private static const SUCCESS_SHOW_TIME:Number = 5;
      
      private static const CHECK_TIME:Number = 5;
      
      private static const FRAME_SIZE:int = 30;
      
      private static const FRAME_SIZEX:int = 20;
      
      private static const TUTORIAL_FONT_COLOR:int = 16777215;
      
      private static const TUTORIAL_FONT_SIZE:int = 20;
      
      private static const INTERACTIVE_FONT_COLOR:int = 16776960;
      
      private static const SKIP_BUTTON_SIZEX:int = 200;
      
      private static const SKIP_BUTTON_SIZEY:int = 50;
      
      private static const SKIP_BUTTON_FONTSIZE:int = 26;
      
      private static const SKIP_BUTTON_FONTCOLOR:int = 4294967295;
      
      private static var m_tempCpu:cCPU;
       
      
      public var data:cTutorialData;
      
      private var m_pic:FlxSprite;
      
      private var m_text:FlxText;
      
      private var m_skipButton:cButton;
      
      private var m_doneTimer:Number;
      
      private var m_skipTutorial:Boolean;
      
      private var m_bg:FlxSprite;
      
      private var m_arrowLeft:FlxSprite;
      
      private var m_arrowRight:FlxSprite;
      
      private var m_showSuccess:Boolean;
      
      private var m_startHiding:Boolean;
      
      private var m_hoverArrow:FlxSprite;
      
      public function cTutorialHud()
      {
         super();
         this.m_bg = new FlxSprite(0,0,NeoCircuit.GFX.ImgTutorialGui);
         this.m_bg.alpha = 0;
         add(this.m_bg);
         this.m_pic = new FlxSprite();
         this.m_pic.alpha = 0;
         add(this.m_pic);
         this.m_text = new FlxText(0,0,470,"");
         this.m_text.alpha = 0;
         add(this.m_text);
         this.m_arrowLeft = new FlxSprite(0,0);
         this.m_arrowLeft.loadGraphic(NeoCircuit.GFX.ImgTutorialGuiArrows,true,false,24,40);
         this.m_arrowLeft.frame = 2;
         this.m_arrowLeft.alpha = 0;
         add(this.m_arrowLeft);
         this.m_arrowRight = new FlxSprite(0,0);
         this.m_arrowRight.loadGraphic(NeoCircuit.GFX.ImgTutorialGuiArrows,true,false,24,40);
         this.m_arrowRight.frame = 3;
         this.m_arrowRight.alpha = 0;
         add(this.m_arrowRight);
         this.createSkipButton();
         kill();
         visible = false;
      }
      
      public static function checkTutorial0() : Boolean
      {
         return false;
      }
      
      public static function checkTutorial1() : Boolean
      {
         var _loc2_:cCPU = null;
         var _loc1_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_] as cCPU;
            if(_loc2_.data.type != cCPUData.BARRIER)
            {
               if(_loc2_.owner == cCPU.PLAYER01)
               {
                  return _loc2_.connections.length > 0;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function checkTutorial2() : Boolean
      {
         var _loc2_:cCPU = null;
         var _loc1_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc4_] as cCPU;
            if(_loc2_.data.type != cCPUData.BARRIER)
            {
               if(_loc2_.owner == cCPU.PLAYER01)
               {
                  _loc3_++;
               }
            }
            _loc4_++;
         }
         return _loc3_ > 1;
      }
      
      public static function checkTutorial3() : Boolean
      {
         var _loc2_:cCPU = null;
         var _loc1_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc4_] as cCPU;
            if(_loc2_.data.type != cCPUData.BARRIER)
            {
               if(_loc2_.owner == cCPU.PLAYER01)
               {
                  _loc3_++;
               }
            }
            _loc4_++;
         }
         return _loc3_ > 2;
      }
      
      public static function checkTutorial4() : Boolean
      {
         if(m_tempCpu == null)
         {
            m_tempCpu = getLeftCPU();
         }
         return m_tempCpu.owner == cCPU.PLAYER01;
      }
      
      public static function checkTutorial5() : Boolean
      {
         if(m_tempCpu == null)
         {
            m_tempCpu = getTopCPU();
         }
         return m_tempCpu.connections.length == 0;
      }
      
      public static function checkTutorial6() : Boolean
      {
         if(m_tempCpu == null)
         {
            m_tempCpu = getLeftCPU();
         }
         return m_tempCpu.connections.length == 1;
      }
      
      public static function checkTutorial7() : Boolean
      {
         return cObjectManager.getInstance().player.gameStatus == cPlayer.GAMESTATUS_WON;
      }
      
      public static function checkTutorial8() : Boolean
      {
         if(m_tempCpu == null)
         {
            m_tempCpu = getPlayerCPU();
         }
         return m_tempCpu.data.upgradeLevel != 0;
      }
      
      public static function checkTutorial9() : Boolean
      {
         var _loc1_:cCPU = null;
         var _loc2_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc3_] as cCPU;
            §§push(_loc1_.data.type == cCPUData.GPU);
            if(_loc1_.data.type == cCPUData.GPU)
            {
               §§pop();
               while(true)
               {
                  §§push(_loc1_.owner == cCPU.PLAYER01);
               }
               addr41:
            }
            while(true)
            {
               if(§§pop())
               {
                  return true;
               }
               _loc3_++;
               if(true)
               {
                  break;
               }
               §§goto(addr41);
            }
         }
         return false;
      }
      
      public static function checkTutorial10() : Boolean
      {
         var _loc1_:cCPU = null;
         var _loc2_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc3_] as cCPU;
            §§push(_loc1_.data.type == cCPUData.RAM);
            if(_loc1_.data.type == cCPUData.RAM)
            {
               §§pop();
               while(true)
               {
                  §§push(_loc1_.owner == cCPU.PLAYER01);
               }
               addr41:
            }
            while(true)
            {
               if(§§pop())
               {
                  return true;
               }
               _loc3_++;
               if(true)
               {
                  break;
               }
               §§goto(addr41);
            }
         }
         return false;
      }
      
      public static function checkTutorial11() : Boolean
      {
         return (FlxG.state as cPlayState).gameSpeed != cPlayState.GAME_SPEED_NORMAL;
      }
      
      private static function getLeftCPU() : cCPU
      {
         var _loc2_:cCPU = null;
         var _loc3_:cCPU = null;
         var _loc1_:int = int.MAX_VALUE;
         var _loc4_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc5_] as cCPU;
            if(_loc2_.data.type != cCPUData.BARRIER)
            {
               if(_loc2_.x < _loc1_)
               {
                  _loc1_ = _loc2_.x;
                  _loc3_ = _loc2_;
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private static function getTopCPU() : cCPU
      {
         var _loc2_:cCPU = null;
         var _loc3_:cCPU = null;
         var _loc1_:int = int.MAX_VALUE;
         var _loc4_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc5_] as cCPU;
            if(_loc2_.data.type != cCPUData.BARRIER)
            {
               if(_loc2_.y < _loc1_)
               {
                  _loc1_ = _loc2_.y;
                  _loc3_ = _loc2_;
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private static function getPlayerCPU() : cCPU
      {
         var _loc1_:cCPU = null;
         var _loc2_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc3_] as cCPU;
            if(_loc1_.data.type != cCPUData.BARRIER)
            {
               if(_loc1_.owner == cCPU.PLAYER01)
               {
                  return _loc1_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      public function show(param1:cTutorialData, param2:Boolean = false) : void
      {
         revive();
         this.m_startHiding = false;
         this.m_skipTutorial = false;
         this.data = param1;
         if(this.data.speed)
         {
            (FlxG.state as cPlayState).pauseMuteHud.signalSpeedButton(true);
         }
         else
         {
            (FlxG.state as cPlayState).pauseMuteHud.signalSpeedButton(false);
         }
         if(param2 && this.data.successText != "")
         {
            this.m_showSuccess = param2;
         }
         else
         {
            this.m_showSuccess = false;
         }
         cObjectManager.getInstance().player.actionAllowed(this.data.interactive && !this.data.viewed,this.data);
         cObjectManager.getInstance().map.tutorialActive = true;
         if(param1.gfx != null)
         {
            this.m_pic.loadGraphic(param1.gfx);
         }
         this.m_text.size = TUTORIAL_FONT_SIZE;
         FlxG.play(NeoCircuit.SFX.SndTutorial);
         this.m_text.font = "cpu";
         this.m_text.alignment = "center";
         this.setPositions();
         if(!visible)
         {
            TweenLite.to(this.m_skipButton,FADE_IN_TIME,{"alpha":1});
            TweenLite.to(this.m_bg,FADE_IN_TIME,{"alpha":1});
            TweenLite.to(this.m_arrowLeft,FADE_IN_TIME,{"alpha":1});
            TweenLite.to(this.m_arrowRight,FADE_IN_TIME,{"alpha":1});
         }
         visible = true;
         m_tempCpu = null;
         if(this.m_showSuccess)
         {
            this.showSuccess();
         }
         else
         {
            this.showText();
         }
      }
      
      private function onBlinks() : void
      {
         TweenMax.to(this.m_pic,0.2,{
            "alpha":0.5,
            "repeat":-1,
            "yoyo":true
         });
         if(this.data.scale)
         {
            TweenMax.to(this.m_pic.scale,0.25,{
               "x":1.25,
               "y":1.25,
               "yoyo":true,
               "repeat":-1
            });
         }
      }
      
      private function createSkipButton() : void
      {
         this.m_skipButton = new cButton(FlxG.width - SKIP_BUTTON_SIZEX,FlxG.height - SKIP_BUTTON_SIZEY,this.OnSkipTutorial,null,"SKIP TUTORIAL",SKIP_BUTTON_SIZEX,SKIP_BUTTON_SIZEY,4294967295);
         this.m_skipButton.textNormal.font = "cpu";
         this.m_skipButton.textNormal.color = SKIP_BUTTON_FONTCOLOR;
         this.m_skipButton.textNormal.size = SKIP_BUTTON_FONTSIZE;
         this.m_skipButton.updateInactiveButtonColors([0,0]);
         add(this.m_skipButton);
      }
      
      public function OnSkipTutorial() : void
      {
         this.data.done = true;
         this.m_doneTimer = int.MAX_VALUE;
         this.m_skipTutorial = true;
         this.startHiding();
      }
      
      private function setPositions() : void
      {
         this.m_text.y = FlxG.height * 0.09;
         this.m_text.x = FlxG.width * 0.5 - this.m_text.width * 0.5;
         this.m_bg.x = FlxG.width * 0.5 - this.m_bg.width * 0.5;
         this.m_bg.y = this.m_text.y - 70;
         this.m_arrowLeft.x = this.m_bg.x + this.m_bg.width - this.m_arrowLeft.width * 5;
         this.m_arrowLeft.y = this.m_bg.y + this.m_bg.height - this.m_arrowLeft.height * 1.5;
         this.m_arrowRight.x = this.m_arrowLeft.x + this.m_arrowLeft.width + 1;
         this.m_arrowRight.y = this.m_arrowLeft.y;
         if(this.data.gfx != null)
         {
            this.m_pic.x = this.data.gfxPos.x;
            this.m_pic.y = this.data.gfxPos.y;
         }
      }
      
      override public function destroy() : void
      {
         TweenLite.killTweensOf(this.m_text,true);
         TweenLite.killTweensOf(this.m_pic,true);
         TweenLite.killTweensOf(this.m_pic.scale,true);
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.m_skipButton.textNormal.overlapsPoint(FlxG.mouse))
         {
            super.update();
            return;
         }
         if(this.m_skipTutorial || this.m_startHiding)
         {
            return;
         }
         if(cObjectManager.getInstance().player.gameStatus != cPlayer.GAMESTATUS_PLAYING)
         {
            this.startHiding();
         }
         this.hoverArrowButtons();
         if(this.data.done)
         {
            if(FlxG.mouse.justReleased())
            {
               this.checkArrowButtons();
            }
            if(this.data.interactive && !this.m_showSuccess && !this.data.viewed)
            {
               this.data.viewed = true;
               this.m_showSuccess = true;
               cObjectManager.getInstance().player.actionAllowed(false,null);
               if(this.data.successText != "")
               {
                  this.showSuccess();
               }
               else
               {
                  this.startHiding();
               }
               FlxG.play(NeoCircuit.SFX.SndTutorial);
            }
            return;
         }
         if(this.data.interactive && !this.data.viewed)
         {
            this.data.done = this.data.checkCallback() || cObjectManager.getInstance().player.gameStatus != cPlayer.GAMESTATUS_PLAYING;
         }
         else
         {
            this.data.done = true;
         }
         super.update();
      }
      
      private function checkArrowButtons() : void
      {
         if(this.data.interactive && !this.data.viewed)
         {
            return;
         }
         if(this.m_arrowLeft.overlapsPoint(FlxG.mouse))
         {
            if(this.data.prev != -1 || this.m_showSuccess)
            {
               this.showPrevious();
            }
         }
         else if(this.m_bg.overlapsPoint(FlxG.mouse))
         {
            if(!this.m_showSuccess && this.data.successText != "")
            {
               this.m_showSuccess = true;
               this.showSuccess();
               FlxG.play(NeoCircuit.SFX.SndTutorial);
            }
            else
            {
               this.startHiding();
            }
         }
      }
      
      private function hoverArrowButtons() : void
      {
         var _loc1_:FlxSprite = this.m_hoverArrow;
         this.m_hoverArrow = null;
         if(this.data.interactive && !this.m_showSuccess && !this.data.done)
         {
            if(this.m_arrowRight.frame != 1)
            {
               this.m_arrowRight.frame = 1;
               TweenLite.killTweensOf(this.m_arrowRight.scale,true);
            }
            if(this.m_arrowLeft.frame != 0)
            {
               TweenLite.killTweensOf(this.m_arrowLeft.scale,true);
               this.m_arrowLeft.frame = 0;
            }
            return;
         }
         this.m_arrowRight.frame = 3;
         if(this.m_arrowRight.overlapsPoint(FlxG.mouse))
         {
            if(_loc1_ != this.m_arrowRight)
            {
               TweenMax.to(this.m_arrowRight.scale,0.25,{
                  "x":1.1,
                  "y":1.1,
                  "yoyo":true,
                  "repeat":-1
               });
               FlxG.play(NeoCircuit.SFX.SndHover,0.5);
            }
            this.m_hoverArrow = this.m_arrowRight;
         }
         else
         {
            TweenLite.killTweensOf(this.m_arrowRight.scale,true);
         }
         if(this.data.prev == -1 && !this.m_showSuccess)
         {
            this.m_arrowLeft.frame = 0;
            TweenLite.killTweensOf(this.m_arrowLeft.scale,true);
         }
         else
         {
            this.m_arrowLeft.frame = 2;
            if(this.m_arrowLeft.overlapsPoint(FlxG.mouse))
            {
               if(_loc1_ != this.m_arrowLeft)
               {
                  TweenMax.to(this.m_arrowLeft.scale,0.25,{
                     "x":1.1,
                     "y":1.1,
                     "yoyo":true,
                     "repeat":-1
                  });
                  FlxG.play(NeoCircuit.SFX.SndHover,0.5);
               }
               this.m_hoverArrow = this.m_arrowLeft;
            }
            else
            {
               TweenLite.killTweensOf(this.m_arrowLeft.scale,true);
            }
         }
      }
      
      override public function draw() : void
      {
         super.draw();
         this.m_skipButton.draw();
      }
      
      private function showSuccess() : void
      {
         if(this.data.gfx != null && this.data.interactive)
         {
            TweenLite.to(this.m_pic,FADE_OUT_TIME,{"alpha":0});
         }
         TweenLite.to(this.m_text,FADE_OUT_TIME,{
            "alpha":0,
            "onComplete":this.showSuccessText
         });
      }
      
      private function showPrevious() : void
      {
         if(this.m_showSuccess)
         {
            FlxG.play(NeoCircuit.SFX.SndTutorial);
            this.m_showSuccess = false;
            TweenLite.to(this.m_text,FADE_OUT_TIME,{
               "alpha":0,
               "onComplete":this.showText
            });
         }
         else if(this.data.prev != -1)
         {
            if(this.data.gfx != null)
            {
               TweenLite.to(this.m_pic,FADE_OUT_TIME,{"alpha":0});
            }
            TweenLite.to(this.m_text,FADE_OUT_TIME,{
               "alpha":0,
               "onComplete":this.showPrevTutorial
            });
         }
      }
      
      private function showPrevTutorial() : void
      {
         TweenLite.killTweensOf(this.m_text,true);
         TweenLite.killTweensOf(this.m_pic,true);
         TweenLite.killTweensOf(this.m_pic.scale,true);
         this.show(cObjectManager.getInstance().tutorialDataList[this.data.prev],true);
      }
      
      private function showText() : void
      {
         this.m_text.text = this.data.text;
         if(this.data.interactive && !this.data.done)
         {
            this.m_text.color = INTERACTIVE_FONT_COLOR;
         }
         else
         {
            this.m_text.color = TUTORIAL_FONT_COLOR;
         }
         if(this.data.gfx != null)
         {
            TweenLite.to(this.m_pic,FADE_IN_TIME,{
               "alpha":1,
               "onComplete":this.onBlinks
            });
         }
         TweenLite.to(this.m_text,FADE_IN_TIME,{"alpha":1});
      }
      
      private function showSuccessText() : void
      {
         this.m_text.color = TUTORIAL_FONT_COLOR;
         this.m_text.text = this.data.successText;
         TweenLite.to(this.m_text,FADE_IN_TIME,{"alpha":1});
      }
      
      private function startHiding() : void
      {
         this.m_startHiding = true;
         if(this.data.gfx != null)
         {
            TweenLite.to(this.m_pic,FADE_OUT_TIME,{"alpha":0});
         }
         TweenLite.to(this.m_text,FADE_OUT_TIME,{
            "alpha":0,
            "onComplete":this.hide
         });
         if(this.data.next == -1 || this.m_skipTutorial || cObjectManager.getInstance().player.gameStatus != cPlayer.GAMESTATUS_PLAYING)
         {
            TweenLite.to(this.m_skipButton,FADE_OUT_TIME,{"alpha":0});
            TweenLite.to(this.m_bg,FADE_OUT_TIME,{"alpha":0});
            TweenLite.to(this.m_arrowLeft,FADE_OUT_TIME,{"alpha":0});
            TweenLite.to(this.m_arrowRight,FADE_OUT_TIME,{"alpha":0});
         }
      }
      
      public function hide() : void
      {
         TweenLite.killTweensOf(this.m_text,true);
         TweenLite.killTweensOf(this.m_pic,true);
         TweenLite.killTweensOf(this.m_pic.scale,true);
         if(this.data.next == -1 || this.m_skipTutorial)
         {
            cObjectManager.getInstance().player.actionAllowed(true,null);
            cObjectManager.getInstance().map.tutorialActive = false;
            kill();
            visible = false;
            this.data = null;
         }
         else
         {
            this.show(cObjectManager.getInstance().tutorialDataList[this.data.next]);
         }
      }
   }
}
