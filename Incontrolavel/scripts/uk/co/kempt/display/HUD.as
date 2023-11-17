package uk.co.kempt.display
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import uk.co.kempt.Engine;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.HUD")]
   public class HUD extends Sprite
   {
      
      private static var TIME_SUFFIX:String = "hrs";
      
      private static var HOURS_TO_BUILD:Number = 8.2;
       
      
      public var time_txt:TextField;
      
      public var timebar:TimeBar;
      
      public var money_txt:TextField;
      
      private var _score:int;
      
      public var level_txt:TextField;
      
      public var particles_txt:TextField;
      
      public function HUD()
      {
         super();
         this.reapplyFormatting(this.time_txt);
         this.time_txt.autoSize = TextFieldAutoSize.LEFT;
         this.reapplyFormatting(this.money_txt);
         this.money_txt.autoSize = TextFieldAutoSize.LEFT;
         this.reapplyFormatting(this.level_txt);
         this.level_txt.autoSize = TextFieldAutoSize.LEFT;
         this.reapplyFormatting(this.particles_txt);
         this.particles_txt.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public static function formatMoney2(param1:int) : String
      {
         var _loc2_:* = param1 < 0;
         var _loc3_:int = int(Math.abs(param1));
         var _loc4_:* = String(param1.toString());
         if(_loc3_ >= 1000000)
         {
            _loc4_ = Number(Math.round(_loc3_ / 100000) / 10).toString() + "m";
         }
         else if(_loc3_ >= 1000)
         {
            _loc4_ = Math.round(_loc3_ / 1000).toString() + "k";
         }
         return (_loc2_ ? "-" : "") + _loc4_;
      }
      
      public static function formatMoney(param1:int) : String
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = param1 < 0;
         var _loc3_:String = String(Math.abs(param1).toString());
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ <= _loc3_.length / 3)
         {
            _loc6_ = _loc3_.length - 0 - 3 * (_loc5_ + 1);
            _loc7_ = 3;
            while(_loc6_ < 0)
            {
               _loc7_--;
               _loc6_++;
            }
            if(_loc7_ > 0)
            {
               _loc4_.unshift(_loc3_.substr(_loc6_,_loc7_));
            }
            _loc5_++;
         }
         _loc3_ = "$" + _loc4_.join(",");
         return (_loc2_ ? "-" : "") + _loc3_;
      }
      
      private function reapplyFormatting(param1:TextField) : void
      {
         param1.embedFonts = true;
         param1.multiline = false;
         param1.wordWrap = false;
         param1.selectable = false;
      }
      
      public function set score(param1:int) : void
      {
         this._score = param1;
         this.money_txt.text = formatMoney(param1);
      }
      
      public function update() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:* = null;
         if(Engine.instance.started)
         {
            _loc3_ = Boolean(Engine.instance.trackBuilder) && (Engine.instance.trackBuilder.hasReachedExit || Engine.instance.trackBuilder.reachedCrashPoint) ? 5 : 1;
            this.timebar.update(_loc3_);
            if((_loc4_ = this.timebar.value / _loc3_ / Engine.GAME_FRAMERATE) < 1)
            {
               Engine.instance.earlyWarning();
            }
            _loc5_ = this.timebar.value / this.timebar.total;
            _loc7_ = String((_loc6_ = Math.round(HOURS_TO_BUILD * _loc5_ * 10) / 10).toString());
            if(_loc6_ == Math.floor(_loc6_))
            {
               _loc7_ += ".0";
            }
            _loc7_ += TIME_SUFFIX;
            if(_loc5_ > 0.6)
            {
               this.time_txt.textColor = 16777215;
            }
            else if(_loc5_ > 0.2)
            {
               this.time_txt.textColor = 16777215;
            }
            else
            {
               this.time_txt.textColor = 16724736;
            }
            this.time_txt.text = _loc7_;
            this.score = Engine.instance.levelStatistics.gross;
         }
         var _loc1_:int = 1 + Math.floor((Engine.instance.currentLevelNum - 1) / 5);
         var _loc2_:int = 1 + (Engine.instance.currentLevelNum - 1) % 5;
         this.level_txt.text = _loc1_.toString() + "." + _loc2_;
         this.particles_txt.text = Engine.instance.numParticles.toString();
      }
      
      public function get score() : int
      {
         return this._score;
      }
   }
}
