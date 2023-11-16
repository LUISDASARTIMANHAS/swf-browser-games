package org.flixel.system.debug
{
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import org.flixel.system.FlxWindow;
   
   public class Log extends FlxWindow
   {
      
      protected static const MAX_LOG_LINES:uint = 200;
       
      
      protected var _text:TextField;
      
      protected var _lines:Array;
      
      public function Log(param1:String, param2:Number, param3:Number, param4:Boolean = true, param5:Rectangle = null, param6:uint = 2139062143, param7:uint = 2130706432)
      {
         super(param1,param2,param3,param4,param5,param6,param7);
         this._text = new TextField();
         this._text.x = 2;
         this._text.y = 15;
         this._text.multiline = true;
         this._text.wordWrap = true;
         this._text.selectable = true;
         this._text.defaultTextFormat = new TextFormat("Courier",12,16777215);
         addChild(this._text);
         this._lines = new Array();
      }
      
      override public function destroy() : void
      {
         removeChild(this._text);
         this._text = null;
         this._lines = null;
         super.destroy();
      }
      
      public function add(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         if(this._lines.length <= 0)
         {
            this._text.text = "";
         }
         this._lines.push(param1);
         if(this._lines.length > MAX_LOG_LINES)
         {
            this._lines.shift();
            _loc2_ = "";
            _loc3_ = 0;
            while(_loc3_ < this._lines.length)
            {
               _loc2_ += this._lines[_loc3_] + "\n";
               _loc3_++;
            }
            this._text.text = _loc2_;
         }
         else
         {
            this._text.appendText(param1 + "\n");
         }
         this._text.scrollV = this._text.height;
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         this._text.width = _width - 10;
         this._text.height = _height - 15;
      }
   }
}
