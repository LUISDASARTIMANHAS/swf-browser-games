package org.flixel
{
   import flash.display.BitmapData;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class FlxText extends FlxSprite
   {
       
      
      protected var _textField:TextField;
      
      protected var _regen:Boolean;
      
      protected var _shadow:uint;
      
      public function FlxText(param1:Number, param2:Number, param3:uint, param4:String = null, param5:Boolean = true)
      {
         super(param1,param2);
         makeGraphic(param3,1,0);
         if(param4 == null)
         {
            param4 = "";
         }
         this._textField = new TextField();
         this._textField.width = param3;
         this._textField.embedFonts = param5;
         this._textField.selectable = false;
         this._textField.sharpness = 100;
         this._textField.multiline = true;
         do
         {
            this._textField.wordWrap = true;
            this._textField.text = param4;
         }
         while(false);
         
         var _loc6_:TextFormat = new TextFormat("system",8,16777215);
         this._textField.defaultTextFormat = _loc6_;
         this._textField.setTextFormat(_loc6_);
         if(param4.length <= 0)
         {
            this._textField.height = 1;
         }
         else
         {
            this._textField.height = 10;
         }
         this._regen = true;
         this._shadow = 0;
         allowCollisions = NONE;
         this.calcFrame();
      }
      
      override public function destroy() : void
      {
         this._textField = null;
         super.destroy();
      }
      
      public function setFormat(param1:String = null, param2:Number = 8, param3:uint = 16777215, param4:String = null, param5:uint = 0) : FlxText
      {
         if(param1 == null)
         {
            param1 = "";
         }
         var _loc6_:TextFormat;
         (_loc6_ = this.dtfCopy()).font = param1;
         _loc6_.size = param2;
         _loc6_.color = param3;
         _loc6_.align = param4;
         this._textField.defaultTextFormat = _loc6_;
         this._textField.setTextFormat(_loc6_);
         this._shadow = param5;
         this._regen = true;
         this.calcFrame();
         return this;
      }
      
      public function get text() : String
      {
         return this._textField.text;
      }
      
      public function get textField() : TextField
      {
         return this._textField;
      }
      
      public function set text(param1:String) : void
      {
         var _loc2_:String = this._textField.text;
         this._textField.text = param1;
         if(this._textField.text != _loc2_)
         {
            this._regen = true;
            this.calcFrame();
         }
      }
      
      public function get size() : Number
      {
         return this._textField.defaultTextFormat.size as Number;
      }
      
      public function set size(param1:Number) : void
      {
         var _loc2_:TextFormat = this.dtfCopy();
         _loc2_.size = param1;
         this._textField.defaultTextFormat = _loc2_;
         this._textField.setTextFormat(_loc2_);
         this._regen = true;
         this.calcFrame();
      }
      
      override public function get color() : uint
      {
         return this._textField.defaultTextFormat.color as uint;
      }
      
      override public function set color(param1:uint) : void
      {
         var _loc2_:TextFormat = this.dtfCopy();
         _loc2_.color = param1;
         this._textField.defaultTextFormat = _loc2_;
         this._textField.setTextFormat(_loc2_);
         this._regen = true;
         this.calcFrame();
      }
      
      public function get font() : String
      {
         return this._textField.defaultTextFormat.font;
      }
      
      public function set font(param1:String) : void
      {
         var _loc2_:TextFormat = this.dtfCopy();
         _loc2_.font = param1;
         this._textField.defaultTextFormat = _loc2_;
         this._textField.setTextFormat(_loc2_);
         this._regen = true;
         this.calcFrame();
      }
      
      public function get alignment() : String
      {
         return this._textField.defaultTextFormat.align;
      }
      
      public function set alignment(param1:String) : void
      {
         var _loc2_:TextFormat = this.dtfCopy();
         _loc2_.align = param1;
         this._textField.defaultTextFormat = _loc2_;
         this._textField.setTextFormat(_loc2_);
         this.calcFrame();
      }
      
      public function get shadow() : uint
      {
         return this._shadow;
      }
      
      public function set shadow(param1:uint) : void
      {
         this._shadow = param1;
         this.calcFrame();
      }
      
      override protected function calcFrame() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TextFormat = null;
         var _loc4_:TextFormat = null;
         if(this._regen)
         {
            _loc1_ = 0;
            _loc2_ = uint(this._textField.numLines);
            height = 0;
            while(_loc1_ < _loc2_)
            {
               height += this._textField.getLineMetrics(_loc1_++).height;
            }
            height += 4;
            _pixels = new BitmapData(width,height,true,0);
            frameHeight = height;
            this._textField.height = height * 1.2;
            _flashRect.x = 0;
            _flashRect.y = 0;
            _flashRect.width = width;
            _flashRect.height = height;
            this._regen = false;
         }
         else
         {
            _pixels.fillRect(_flashRect,0);
         }
         while(true)
         {
            §§push(this._textField != null && this._textField.text != null);
            if(!(this._textField != null && this._textField.text != null))
            {
               break;
            }
            §§pop();
            if(true)
            {
               §§push(this._textField.text.length > 0);
               break;
            }
         }
         if(§§pop())
         {
            _loc3_ = this._textField.defaultTextFormat;
            _loc4_ = _loc3_;
            _matrix.identity();
            if(_loc3_.align == "center" && this._textField.numLines == 1)
            {
               _loc4_ = new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,null,null,null,null,null,"left");
               this._textField.setTextFormat(_loc4_);
               _matrix.translate(Math.floor((width - this._textField.getLineMetrics(0).width) / 2),0);
            }
            if(this._shadow > 0)
            {
               this._textField.setTextFormat(new TextFormat(_loc4_.font,_loc4_.size,this._shadow,null,null,null,null,null,_loc4_.align));
               _matrix.translate(1,1);
               _pixels.draw(this._textField,_matrix,_colorTransform);
               _matrix.translate(-1,-1);
               this._textField.setTextFormat(new TextFormat(_loc4_.font,_loc4_.size,_loc4_.color,null,null,null,null,null,_loc4_.align));
               while(true)
               {
                  §§goto(addr264);
               }
            }
            addr264:
            §§goto(addr310);
         }
         addr310:
         while(true)
         {
            _pixels.draw(this._textField,_matrix,_colorTransform);
            this._textField.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,null,null,null,null,null,_loc3_.align));
            if(true)
            {
               break;
            }
            continue loop2;
         }
         if(framePixels == null || framePixels.width != _pixels.width || framePixels.height != _pixels.height)
         {
            framePixels = new BitmapData(_pixels.width,_pixels.height,true,0);
         }
         framePixels.copyPixels(_pixels,_flashRect,_flashPointZero);
      }
      
      protected function dtfCopy() : TextFormat
      {
         var _loc1_:TextFormat = this._textField.defaultTextFormat;
         return new TextFormat(_loc1_.font,_loc1_.size,_loc1_.color,_loc1_.bold,_loc1_.italic,_loc1_.underline,_loc1_.url,_loc1_.target,_loc1_.align);
      }
   }
}
