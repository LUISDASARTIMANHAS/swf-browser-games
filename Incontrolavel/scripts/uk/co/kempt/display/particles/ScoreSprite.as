package uk.co.kempt.display.particles
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import uk.co.kempt.display.PlayOnce;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.particles.ScoreSprite")]
   public class ScoreSprite extends PlayOnce
   {
       
      
      private var _value:int;
      
      public var value_txt:TextField;
      
      public function ScoreSprite()
      {
         super();
         this.reapplyFormatting(this.value_txt);
      }
      
      private function reapplyFormatting(param1:TextField) : void
      {
         param1.selectable = false;
         param1.multiline = false;
         param1.wordWrap = false;
         param1.autoSize = TextFieldAutoSize.CENTER;
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      public function set value(param1:int) : void
      {
         this._value = param1;
         if(param1 >= 1000000)
         {
            this.value_txt.textColor = 16724736;
         }
         else if(param1 >= 150000)
         {
            this.value_txt.textColor = 16685312;
         }
         else
         {
            this.value_txt.textColor = 16776960;
         }
         this.value_txt.text = this.formatValue(param1);
      }
      
      private function formatValue(param1:int) : String
      {
         if(param1 >= 1000000)
         {
            return int(param1 / 1000000).toString() + "m";
         }
         if(param1 >= 1000)
         {
            return int(param1 / 1000).toString() + "k";
         }
         return param1.toString();
      }
   }
}
