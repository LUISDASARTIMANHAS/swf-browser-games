package com.lib
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class GWidget
   {
       
      
      private var ifRestrict:String = "";
      
      private var align:String = null;
      
      private var fontName:String = "";
      
      private var tf:TextFormat = null;
      
      private var marginRight:int = 0;
      
      private var ifMaxChars:int = 0;
      
      private var antiAlias:Boolean = false;
      
      private var fontWeight:Boolean = false;
      
      private var letterSpacing:int = 0;
      
      private var marginTop:int = 0;
      
      private var embedFont:Boolean = false;
      
      private var condenseWhite:Boolean = false;
      
      private var textField:TextField = null;
      
      private var fontAlpha:Number = 1;
      
      private var inputField:Boolean = false;
      
      private var multiLine:Boolean = false;
      
      private var marginLeft:int = 0;
      
      private var fontColor:* = 0;
      
      private var mouseEnabled:Boolean = false;
      
      private var sheet:StyleSheet = null;
      
      private var widgetStyle:Function = null;
      
      private var fontClass:Font = null;
      
      private var fontSize:int = 0;
      
      private var htmlText:Boolean = true;
      
      private var marginBottom:int = 0;
      
      public function GWidget(param1:Object = null)
      {
         super();
         if(param1 === null)
         {
            this.setFontSize(14);
            return;
         }
         if(param1.font != undefined)
         {
            this.setFontClass(param1.font);
         }
         if(param1.name != undefined)
         {
            this.setFontName(param1.name);
         }
         if(param1.color != undefined)
         {
            this.setFontColor(param1.color,!!param1.alpha ? Number(param1.alpha) : 1);
         }
         if(param1.size != undefined)
         {
            this.setFontSize(param1.size);
         }
         else
         {
            this.setFontSize(14);
         }
         if(param1.weight != undefined)
         {
            this.setFontWeight(param1.weight);
         }
         if(param1.inputField)
         {
            this.setInputField();
         }
         if(param1.inputFieldMaxChars != undefined)
         {
            this.setInputFieldMaxChars(param1.inputFieldMaxChars);
         }
         if(param1.restrictChars != undefined)
         {
            this.setRestrictChars(param1.restrictChars);
         }
         if(param1.align != undefined)
         {
            this.setTextAlign(param1.align);
         }
         if(param1.margin != undefined)
         {
            if(param1.margin is Number)
            {
               this.setTextMargin(param1.margin);
            }
            else if(param1.margin is Array)
            {
               if(param1.margin.length == 1)
               {
                  this.setTextMargin(param1.margin[0]);
               }
               else if(param1.margin.length == 2)
               {
                  this.setTextMargin(param1.margin[0],param1.margin[1]);
               }
               else if(param1.margin.length == 3)
               {
                  this.setTextMargin(param1.margin[0],param1.margin[1],param1.margin[2]);
               }
               else if(param1.margin.length == 4)
               {
                  this.setTextMargin(param1.margin[0],param1.margin[1],param1.margin[2],param1.margin[3]);
               }
            }
         }
         if(param1.multiLine != undefined)
         {
            this.setTextMultiLine(param1.multiLine);
         }
         if(param1.html != undefined)
         {
            this.setTextHTML(param1.html);
         }
         if(param1.mouseEnabled != undefined)
         {
            this.setMouseEnabled(param1.mouseEnabled);
         }
         if(param1.style != undefined)
         {
            this.setStyle(param1.style);
         }
         if(param1.embed)
         {
            this.setEmbedFont(true);
         }
         if(param1.antiAlias)
         {
            this.setTextAdvancedAntiAlias(true);
         }
         if(param1.letterSpacing != undefined)
         {
            this.setTextLetterSpacing(param1.letterSpacing);
         }
      }
      
      public static function alignCenter(param1:*, param2:*, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0) : *
      {
         var _loc7_:* = param2.width - param3 - param5;
         var _loc8_:* = param2.height - param4 - param6;
         param1.x = param3 + (_loc7_ - param1.width) / 2;
         param1.y = param4 + (_loc8_ - param1.height) / 2;
      }
      
      public static function echo(param1:String, param2:Object = null, param3:int = 0, param4:int = 0) : *
      {
         var _loc5_:*;
         return (_loc5_ = new GWidget(param2)).print(param1,param3,param4);
      }
      
      public function setEmbedFont(param1:*) : *
      {
         this.embedFont = param1;
      }
      
      public function setFontColor(param1:*, param2:Number = 1) : *
      {
         this.fontColor = param1;
         this.fontAlpha = param2;
      }
      
      public function getTextField() : *
      {
         return this.textField;
      }
      
      public function setFontSize(param1:int, param2:Boolean = true) : *
      {
         this.fontSize = param1;
         if(param2)
         {
            this.setTextMargin(int(param1 * 0.7));
         }
      }
      
      public function setTextAdvancedAntiAlias(param1:Boolean) : *
      {
         this.antiAlias = param1;
      }
      
      public function setTextAlign(param1:String) : *
      {
         this.align = param1;
      }
      
      public function print(param1:String = "", param2:int = 0, param3:int = 0) : Sprite
      {
         this.textField = this.write(param1,param2,param3);
         var _loc4_:* = !!param2 ? param2 : this.textField.textWidth + this.marginLeft + this.marginRight;
         var _loc5_:* = !!param3 ? param3 : this.textField.textHeight + this.marginTop + this.marginBottom;
         var _loc6_:* = this.widgetStyle != null ? this.widgetStyle(_loc4_,_loc5_) : null;
         var _loc7_:* = new Sprite();
         if(_loc6_)
         {
            _loc7_.addChild(_loc6_);
         }
         _loc7_.addChild(this.textField);
         return _loc7_;
      }
      
      public function setFontClass(param1:*) : *
      {
         this.fontClass = new param1();
      }
      
      private function createTextFormat() : *
      {
         this.tf = new TextFormat();
         if(this.fontClass)
         {
            this.tf.font = this.fontClass.fontName;
         }
         else if(this.fontName)
         {
            this.tf.font = this.fontName;
         }
         if(this.fontSize)
         {
            this.tf.size = this.fontSize;
         }
         if(this.fontColor)
         {
            this.tf.color = this.fontColor;
         }
         if(this.fontWeight)
         {
            this.tf.bold = this.fontWeight;
         }
      }
      
      public function setFontWeight(param1:Boolean) : *
      {
         this.fontWeight = param1;
      }
      
      public function setRestrictChars(param1:String) : *
      {
         this.ifRestrict = param1;
      }
      
      public function updateText(param1:String) : *
      {
         if(this.htmlText)
         {
            this.textField.htmlText = param1;
         }
         else
         {
            this.textField.text = param1;
         }
      }
      
      public function setTextStyleSheet(param1:StyleSheet) : *
      {
         this.sheet = param1;
      }
      
      public function sampleWidgetStyle(param1:int, param2:int) : *
      {
         var _loc3_:* = 3;
         var _loc4_:* = param1 + _loc3_;
         var _loc5_:* = param2 + _loc3_;
         var _loc6_:* = -_loc3_ / 2;
         var _loc7_:* = param1 + _loc3_ / 2;
         var _loc8_:* = param2 + _loc3_ / 2;
         var _loc9_:*;
         (_loc9_ = new Sprite()).graphics.lineStyle(_loc3_,0,1,true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND);
         _loc9_.graphics.moveTo(_loc6_,_loc6_);
         _loc9_.graphics.lineTo(_loc6_,_loc8_);
         _loc9_.graphics.lineTo(_loc7_,_loc8_);
         _loc9_.graphics.lineTo(_loc7_,_loc6_);
         _loc9_.graphics.lineTo(_loc6_,_loc6_);
         var _loc10_:*;
         (_loc10_ = new Sprite()).graphics.beginFill(14708848,0.7);
         _loc10_.graphics.drawRect(0,0,_loc4_ - _loc3_,_loc5_ - _loc3_);
         var _loc11_:*;
         (_loc11_ = new Sprite()).addChild(_loc9_);
         _loc11_.addChild(_loc10_);
         return _loc11_;
      }
      
      public function setInputFieldMaxChars(param1:int) : *
      {
         this.ifMaxChars = param1;
      }
      
      public function setTextMarginBottom(param1:int) : *
      {
         this.marginBottom = param1;
      }
      
      public function setTextMarginTop(param1:int) : *
      {
         this.marginTop = param1;
      }
      
      public function setInputField(param1:Boolean = true) : *
      {
         this.inputField = param1;
      }
      
      public function setTextHTML(param1:Boolean) : *
      {
         this.htmlText = param1;
      }
      
      public function setTextLetterSpacing(param1:int) : *
      {
         this.letterSpacing = param1;
      }
      
      public function setTextMultiLine(param1:Boolean) : *
      {
         this.multiLine = param1;
      }
      
      public function setTextMarginRight(param1:int) : *
      {
         this.marginRight = param1;
      }
      
      public function setTextMargin(param1:int, param2:int = -1, param3:int = -1, param4:int = -1) : *
      {
         if(param2 == -1 && param3 == -1 && param4 == -1)
         {
            this.marginTop = param1;
            this.marginRight = param1;
            this.marginBottom = param1;
            this.marginLeft = param1;
         }
         else if(param2 != -1 && param3 == -1 && param4 == -1)
         {
            this.marginTop = param1;
            this.marginRight = param2;
            this.marginBottom = param1;
            this.marginLeft = param2;
         }
         else if(param2 != -1 && param3 != -1 && param4 == -1)
         {
            this.marginTop = param1;
            this.marginRight = param2;
            this.marginBottom = param3;
            this.marginLeft = param2;
         }
         else
         {
            this.marginTop = param1;
            this.marginRight = param2;
            this.marginBottom = param3;
            this.marginLeft = param4;
         }
      }
      
      public function setTextMarginLeft(param1:int) : *
      {
         this.marginLeft = param1;
      }
      
      public function setTextCondenseWhite(param1:Boolean) : *
      {
         this.condenseWhite = param1;
      }
      
      public function setMouseEnabled(param1:Boolean) : *
      {
         this.mouseEnabled = param1;
      }
      
      private function write(param1:String, param2:int, param3:int) : TextField
      {
         this.createTextFormat();
         if(this.align)
         {
            this.tf.align = this.align;
         }
         if(this.marginLeft)
         {
            this.tf.leftMargin = this.marginLeft;
         }
         if(this.marginRight)
         {
            this.tf.rightMargin = this.marginRight;
         }
         if(this.letterSpacing)
         {
            this.tf.letterSpacing = this.letterSpacing;
         }
         var _loc4_:* = new TextField();
         if(this.marginTop)
         {
            _loc4_.y = this.marginTop;
         }
         if(this.multiLine)
         {
            _loc4_.multiline = true;
            _loc4_.wordWrap = true;
         }
         if(param2)
         {
            _loc4_.width = param2;
         }
         if(param3)
         {
            _loc4_.height = param3;
         }
         if(this.sheet)
         {
            _loc4_.styleSheet = this.sheet;
         }
         else
         {
            _loc4_.defaultTextFormat = this.tf;
         }
         _loc4_.alpha = this.fontAlpha;
         _loc4_.condenseWhite = this.condenseWhite;
         if(this.antiAlias)
         {
            _loc4_.antiAliasType = AntiAliasType.ADVANCED;
         }
         _loc4_.defaultTextFormat = this.tf;
         _loc4_.embedFonts = this.embedFont;
         if(this.htmlText)
         {
            _loc4_.htmlText = param1;
         }
         else
         {
            _loc4_.text = param1;
         }
         if(this.inputField)
         {
            _loc4_.type = TextFieldType.INPUT;
            _loc4_.background = false;
            if(this.ifMaxChars)
            {
               _loc4_.maxChars = this.ifMaxChars;
            }
            if(this.ifRestrict)
            {
               _loc4_.restrict = this.ifRestrict;
            }
         }
         else
         {
            _loc4_.type = TextFieldType.DYNAMIC;
            _loc4_.mouseEnabled = this.mouseEnabled;
            if(param2)
            {
               switch(this.align)
               {
                  case "left":
                     _loc4_.autoSize = TextFieldAutoSize.LEFT;
                     break;
                  case "right":
                     _loc4_.autoSize = TextFieldAutoSize.RIGHT;
                     break;
                  case "center":
                     _loc4_.autoSize = TextFieldAutoSize.CENTER;
                     break;
                  default:
                     _loc4_.autoSize = TextFieldAutoSize.LEFT;
               }
            }
            else
            {
               _loc4_.autoSize = TextFieldAutoSize.LEFT;
            }
         }
         return _loc4_;
      }
      
      public function setStyle(param1:Function) : *
      {
         this.widgetStyle = param1;
      }
      
      public function setFontName(param1:String) : *
      {
         this.fontName = param1;
      }
   }
}
