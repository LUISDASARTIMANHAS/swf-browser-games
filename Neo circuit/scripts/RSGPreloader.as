package
{
   import Playtomic.Log;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.display.StageScaleMode;
   import flash.media.Sound;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import org.flixel.system.FlxPreloader;
   
   public class RSGPreloader extends FlxPreloader
   {
      
      public static var GAME_OPTIONS:Object = {
         "id":"38cb6ea51c54cccd",
         "res":"800x600",
         "background":0,
         "color":1114367,
         "outline":1461127,
         "no_bg":false
      };
       
      
      public var ChipImage:Class;
      
      public var ProgressImage:Class;
      
      private var m_assetLoader:Loader;
      
      private var m_chip:Bitmap;
      
      private var m_sound:Sound;
      
      private var m_buffer:Sprite;
      
      private var m_progess:Array;
      
      private var m_showNumBar:int;
      
      private var m_text:TextField;
      
      public function RSGPreloader()
      {
         var _loc2_:String = null;
         this.ChipImage = RSGPreloader_ChipImage;
         this.ProgressImage = RSGPreloader_ProgressImage;
         this.m_progess = [];
         do
         {
            className = "NeoCircuit";
            super();
         }
         while(false);
         
         var _loc1_:Object = {};
         for(_loc2_ in GAME_OPTIONS)
         {
            _loc1_[_loc2_] = GAME_OPTIONS[_loc2_];
         }
         Log.View(5733,"bacc546bfa054f54","d1398d1d1dac40ada502f646bd9a5e",root.loaderInfo.loaderURL);
      }
      
      override protected function create() : void
      {
         var _loc3_:Bitmap = null;
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         _min = 3000;
         _width = stage.stageWidth;
         _height = stage.stageHeight;
         this.m_buffer = new Sprite();
         this.m_chip = new this.ChipImage();
         this.m_chip.smoothing = true;
         this.m_chip.blendMode = "screen";
         this.m_chip.scaleX = 0;
         this.m_chip.scaleY = 0;
         this.m_buffer.addChild(this.m_chip);
         this.m_chip.alpha = 1;
         this.m_chip.scaleX = 1;
         this.m_chip.scaleY = 1;
         this.m_chip.x = stage.stageWidth * 0.5 - this.m_chip.width * 0.5;
         this.m_chip.y = stage.stageHeight * 0.5 - this.m_chip.height * 0.5;
         this.m_text = new TextField();
         this.m_text.defaultTextFormat = new TextFormat("system",10,16743432);
         this.m_text.defaultTextFormat.align = "center";
         this.m_text.antiAliasType = AntiAliasType.ADVANCED;
         this.m_text.embedFonts = true;
         this.m_text.selectable = false;
         this.m_text.x = this.m_chip.x;
         this.m_text.y = this.m_chip.y + this.m_chip.height + 10;
         this.m_text.width = this.m_chip.width * 2;
         do
         {
            this.m_text.text = "Booting up system";
            this.m_buffer.addChild(this.m_text);
         }
         while(false);
         
         var _loc1_:Number = this.m_chip.x + 37;
         var _loc2_:Number = this.m_chip.y + 30;
         var _loc4_:int = 0;
         while(_loc4_ < 7)
         {
            _loc3_ = new this.ProgressImage();
            _loc3_.x = _loc1_;
            _loc3_.y = _loc2_;
            _loc3_.alpha = 0;
            this.m_buffer.addChild(_loc3_);
            _loc1_ += 9;
            _loc3_.visible = false;
            do
            {
               this.m_progess.push(_loc3_);
               _loc4_++;
            }
            while(false);
            
         }
         addChild(this.m_buffer);
         TweenMax.to(this.m_chip,0.5,{
            "alpha":0.5,
            "yoyo":true,
            "repeat":-1
         });
         TweenMax.to(this.m_text,0.5,{
            "alpha":0.5,
            "yoyo":true,
            "repeat":-1
         });
      }
      
      override protected function destroy() : void
      {
         removeChild(this.m_buffer);
         this.m_buffer = null;
         this.m_progess = null;
         this.m_chip = null;
      }
      
      override protected function update(param1:Number) : void
      {
         this.m_showNumBar = param1 * 7;
         if(this.m_showNumBar <= 0)
         {
            return;
         }
         var _loc2_:Bitmap = this.m_progess[this.m_showNumBar - 1];
         if(_loc2_.visible)
         {
            return;
         }
         _loc2_.visible = true;
         TweenLite.to(_loc2_,0.25,{
            "alpha":1,
            "onComplete":this.onCompleteFade
         });
         this.m_text.appendText(".");
      }
      
      private function onCompleteFade() : void
      {
      }
   }
}
