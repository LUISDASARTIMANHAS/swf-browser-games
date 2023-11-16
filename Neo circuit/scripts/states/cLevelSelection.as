package states
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.Socket;
   import hud.cPauseMuteHud;
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxPoint;
   import org.flixel.FlxSprite;
   import org.flixel.FlxState;
   import org.flixel.FlxText;
   import utils.cHelper;
   
   public class cLevelSelection extends FlxState
   {
      
      private static const LEVEL_SIZEX:Number = 100;
      
      private static const LEVEL_SIZEY:Number = 80;
      
      private static const NUM_LEVELS_IN_ROW:int = 6;
      
      private static const LEVEL_TEXT_SIZE:int = 25;
      
      private static const TIME_TEXT_SIZE:int = 12;
      
      private static const LEVEL_TEXT_COLOR:int = 16777215;
      
      private static const HEADER_SIZE:int = 60;
      
      private static const HEADER_COLOR:int = 16777215;
      
      private static const FADE_TIME:Number = 0.25;
      
      private static const LEVEL_FADE:Number = 1.5;
       
      
      private var LEVEL_STARTPOSX:Number = 0;
      
      private var LEVEL_STARTPOSY:Number = 0;
      
      private var m_background:FlxSprite;
      
      private var m_header:FlxSprite;
      
      private var m_levels:FlxGroup;
      
      private var m_levelTexts:FlxGroup;
      
      private var m_fadeing:Boolean = false;
      
      private var m_pauseMuteHud:cPauseMuteHud;
      
      private var m_selectedLevelIndex:int = -1;
      
      private var m_selectedLevel:FlxSprite = null;
      
      private var m_playerData:Object;
      
      private var m_touchPoint:FlxPoint;
      
      private var m_difficultyDisplay:FlxSprite;
      
      private var m_difficultyText:FlxText;
      
      public function cLevelSelection()
      {
         super();
      }
      
      override public function create() : void
      {
         this.m_playerData = cSaveGame.getInstance().loadPlayerData();
         this.m_background = new FlxSprite(0,0,NeoCircuit.GFX.ImgTitleBackground);
         add(this.m_background);
         this.LEVEL_STARTPOSX = (FlxG.width - LEVEL_SIZEX * NUM_LEVELS_IN_ROW) * 0.5;
         this.LEVEL_STARTPOSY = (FlxG.height - LEVEL_SIZEY * (cPlayState.MAX_NUM_LEVELS / NUM_LEVELS_IN_ROW)) * 0.7;
         this.m_header = new FlxSprite(0,0,NeoCircuit.GFX.ImgLevelSelect);
         this.m_header.y = this.LEVEL_STARTPOSY - this.m_header.height - 30;
         this.m_header.x = FlxG.width * 0.5 - this.m_header.width * 0.5;
         if(!NeoCircuit.mobileRelease)
         {
            FlxG.mouse.show(NeoCircuit.GFX.ImgCursor);
         }
         add(this.m_header);
         this.CreateLevelButtons();
         this.m_pauseMuteHud = new cPauseMuteHud();
         this.m_pauseMuteHud.init();
         add(this.m_pauseMuteHud);
         this.ToggleAdd(true);
         if(FlxG.music == null || !FlxG.music.active || NeoCircuit.currentMusic != NeoCircuit.MUSIC_MENU)
         {
            FlxG.playMusic(NeoCircuit.SFX.SndMenuMusic,NeoCircuit.MUSIC_VOLUME_MENU);
            NeoCircuit.currentMusic = NeoCircuit.MUSIC_MENU;
            FlxG.music.fadeOut(0);
            FlxG.music.fadeIn(2);
         }
         this.CreateDifficultyDisplay();
         super.create();
      }
      
      override public function destroy() : void
      {
         this.m_levelTexts.destroy();
         this.m_background.destroy();
         this.m_header.destroy();
         this.m_pauseMuteHud.destroy();
         super.destroy();
         this.m_levels = null;
         this.m_header = null;
      }
      
      override public function update() : void
      {
         if(this.m_fadeing)
         {
            return;
         }
         this.PickLevel(FlxG.mouse);
         if(FlxG.mouse.justPressed() && this.m_selectedLevelIndex >= 0)
         {
            this.OnEnterLevel();
            return;
         }
         super.update();
      }
      
      override public function draw() : void
      {
         super.draw();
      }
      
      private function CreateLevelButtons() : void
      {
         var _loc1_:FlxSprite = null;
         this.m_levels = new FlxGroup();
         this.m_levelTexts = new FlxGroup();
         var _loc2_:Number = this.LEVEL_STARTPOSX;
         var _loc3_:Number = this.LEVEL_STARTPOSY;
         var _loc4_:int = 0;
         loop0:
         while(_loc4_ < cPlayState.MAX_NUM_LEVELS)
         {
            §§push(_loc4_ > 0);
            if(_loc4_ > 0)
            {
               §§pop();
               while(true)
               {
                  §§push(_loc4_ % NUM_LEVELS_IN_ROW == 0);
                  addr47:
                  _loc2_ = this.LEVEL_STARTPOSX;
                  _loc3_ += LEVEL_SIZEY;
                  if(false)
                  {
                     continue;
                  }
                  addr61:
                  _loc1_ = new FlxSprite(_loc2_,_loc3_);
                  _loc1_.loadGraphic(NeoCircuit.GFX.ImgLevel,true,false,110,82);
                  this.m_levels.add(_loc1_);
                  _loc2_ += LEVEL_SIZEX;
                  this.CreateLevelNumber(_loc4_,_loc1_);
                  this.CreateBestTimeDisplay(_loc4_,_loc1_);
                  if(_loc4_ <= this.m_playerData.levelsDone)
                  {
                     _loc1_.frame = _loc4_ / 3;
                     _loc1_.active = true;
                  }
                  else
                  {
                     _loc1_.frame = _loc1_.frames - 1;
                     while(true)
                     {
                        _loc1_.active = false;
                     }
                     addr72:
                  }
                  while(true)
                  {
                     _loc4_++;
                     if(true)
                     {
                        break;
                     }
                     §§goto(addr72);
                  }
                  continue loop0;
               }
               addr39:
            }
            while(true)
            {
               if(§§pop())
               {
                  §§goto(addr47);
               }
               break;
               §§goto(addr39);
            }
            §§goto(addr61);
         }
         add(this.m_levels);
         add(this.m_levelTexts);
      }
      
      private function CreateLevelNumber(param1:int, param2:FlxSprite) : void
      {
         var _loc3_:Number = param2.y + param2.origin.y - LEVEL_TEXT_SIZE * 0.25;
         var _loc4_:FlxText;
         (_loc4_ = new FlxText(param2.x,_loc3_,param2.width - 10,(param1 + 1).toString())).font = "cpu";
         _loc4_.size = LEVEL_TEXT_SIZE;
         _loc4_.alignment = "center";
         _loc4_.color = LEVEL_TEXT_COLOR;
         this.m_levelTexts.add(_loc4_);
      }
      
      private function CreateBestTimeDisplay(param1:int, param2:FlxSprite) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Number = NaN;
         var _loc3_:Number = param2.y + param2.origin.y - LEVEL_TEXT_SIZE * 0.95;
         var _loc4_:FlxText;
         (_loc4_ = new FlxText(param2.x,_loc3_,param2.width - 10)).font = "cpu";
         _loc4_.size = TIME_TEXT_SIZE;
         _loc4_.alignment = "center";
         _loc4_.color = LEVEL_TEXT_COLOR;
         loop0:
         while(true)
         {
            this.m_levelTexts.add(_loc4_);
            if(cMap.levelHasTutorial(param1))
            {
               _loc4_.text = "Tutorial";
               if(true)
               {
                  break;
               }
               continue;
            }
            _loc5_ = cSaveGame.getInstance().loadLevelData(param1.toString());
            if(NeoCircuit.difficulty == NeoCircuit.DIFFICULTY_EASY)
            {
               _loc6_ = Number(_loc5_.bestTimeEasy);
            }
            else
            {
               _loc6_ = Number(_loc5_.bestTimeHard);
            }
            while(true)
            {
               if(_loc6_ == 0)
               {
                  _loc4_.text = "Not played";
                  break loop0;
               }
               _loc4_.text = "Best: " + cHelper.formatTime(_loc6_);
               if(true)
               {
                  break loop0;
               }
            }
         }
      }
      
      private function PickLevel(param1:FlxPoint) : void
      {
         var _loc3_:FlxSprite = null;
         var _loc2_:Array = this.m_levels.members;
         var _loc4_:int = 0;
         do
         {
            if(_loc4_ >= _loc2_.length)
            {
               if(this.m_selectedLevel != null)
               {
                  TweenLite.killTweensOf(this.m_selectedLevel,true);
                  TweenLite.killTweensOf(this.m_selectedLevel.scale,true);
               }
               this.m_selectedLevel = null;
               this.m_selectedLevelIndex = -1;
               return;
            }
            _loc3_ = _loc2_[_loc4_] as FlxSprite;
            if(_loc3_ != null)
            {
               if(_loc3_.active)
               {
                  if(_loc3_.overlapsPoint(param1))
                  {
                     if(_loc3_ == this.m_selectedLevel)
                     {
                        return;
                     }
                     if(this.m_selectedLevel != null)
                     {
                        TweenLite.killTweensOf(this.m_selectedLevel,true);
                        TweenLite.killTweensOf(this.m_selectedLevel.scale,true);
                     }
                     this.m_selectedLevelIndex = (_loc3_.y - this.LEVEL_STARTPOSY) / LEVEL_SIZEY * NUM_LEVELS_IN_ROW + (_loc3_.x - this.LEVEL_STARTPOSX) / LEVEL_SIZEX;
                     this.m_selectedLevel = _loc3_;
                     this.m_selectedLevel.alpha = 1;
                     TweenMax.to(this.m_selectedLevel,0.5,{
                        "alpha":0.5,
                        "yoyo":true,
                        "repeat":-1
                     });
                     TweenMax.to(this.m_selectedLevel.scale,0.5,{
                        "x":1.25,
                        "y":1.25,
                        "yoyo":true,
                        "repeat":-1
                     });
                     FlxG.play(NeoCircuit.SFX.SndHover,0.5);
                     break;
                  }
               }
            }
            _loc4_++;
         }
         while(true);
         
      }
      
      private function OnEnterLevel() : void
      {
         FlxG.music.fadeOut(LEVEL_FADE);
         FlxG.play(NeoCircuit.SFX.SndClick);
         FlxG.fade(0,LEVEL_FADE,this.OnStartPlaying);
         this.m_fadeing = true;
      }
      
      private function OnStartPlaying() : void
      {
         FlxG.mouse.reset();
         var _loc1_:cPlayState = new cPlayState();
         _loc1_.currentLevel = this.m_selectedLevelIndex;
         FlxG.switchState(_loc1_);
      }
      
      private function CreateDifficultyDisplay() : void
      {
         this.m_difficultyDisplay = new FlxSprite(0,0);
         this.m_difficultyDisplay.loadGraphic(NeoCircuit.GFX.ImgLevelSmall,true,false,55,41);
         this.m_difficultyDisplay.x = FlxG.width - this.m_difficultyDisplay.width;
         do
         {
            this.m_difficultyDisplay.y = 0;
            add(this.m_difficultyDisplay);
         }
         while(false);
         
         var _loc1_:Number = this.m_difficultyDisplay.y + this.m_difficultyDisplay.origin.y - 14 * 0.5 - 3;
         this.m_difficultyText = new FlxText(this.m_difficultyDisplay.x,_loc1_,this.m_difficultyDisplay.width - 5,"");
         if(NeoCircuit.difficulty == NeoCircuit.DIFFICULTY_EASY)
         {
            this.m_difficultyText.text = "NORMAL";
            this.m_difficultyDisplay.frame = 0;
         }
         else
         {
            this.m_difficultyText.text = "HARD";
            this.m_difficultyDisplay.frame = 9;
         }
         this.m_difficultyText.font = "cpu";
         this.m_difficultyText.size = 10;
         this.m_difficultyText.alignment = "center";
         this.m_difficultyText.color = LEVEL_TEXT_COLOR;
         add(this.m_difficultyText);
      }
      
      private function ToggleAdd(param1:Boolean) : void
      {
         var s:Socket;
         var text:String = null;
         var _show:Boolean = param1;
         if(!NeoCircuit.mobileRelease || NeoCircuit.device != NeoCircuit.DEVICEID_ANDROID)
         {
            return;
         }
         text = "on";
         if(_show == false)
         {
            text = "off";
         }
         s = new Socket();
         s.connect("localhost",12345);
         s.addEventListener(Event.CONNECT,function(param1:Event):void
         {
            (param1.currentTarget as Socket).writeInt(1);
            (param1.currentTarget as Socket).writeUTF(text);
            (param1.currentTarget as Socket).flush();
            (param1.currentTarget as Socket).close();
         });
         s.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
         });
         s.addEventListener(ProgressEvent.SOCKET_DATA,function(param1:ProgressEvent):void
         {
         });
      }
   }
}
