package org.flixel.plugin.photonstorm
{
   import org.flixel.*;
   
   public class FlxColor
   {
       
      
      public function FlxColor()
      {
         super();
      }
      
      public static function getHSVColorWheel(param1:uint = 255) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ <= 359)
         {
            _loc2_[_loc3_] = HSVtoRGB(_loc3_,1,1,param1);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getComplementHarmony(param1:uint) : uint
      {
         var _loc2_:Object = RGBtoHSV(param1);
         var _loc3_:int = FlxMath.wrapValue(_loc2_.hue,180,359);
         return HSVtoRGB(_loc3_,1,1);
      }
      
      public static function getAnalogousHarmony(param1:uint, param2:int = 30) : Object
      {
         var _loc3_:Object = RGBtoHSV(param1);
         if(param2 > 359 || param2 < 0)
         {
            throw Error("FlxColor Warning: Invalid threshold given to getAnalogousHarmony()");
         }
         var _loc4_:int = FlxMath.wrapValue(_loc3_.hue,359 - param2,359);
         var _loc5_:int = FlxMath.wrapValue(_loc3_.hue,param2,359);
         return {
            "color1":param1,
            "color2":HSVtoRGB(_loc4_,1,1),
            "color3":HSVtoRGB(_loc5_,1,1),
            "hue1":_loc3_.hue,
            "hue2":_loc4_,
            "hue3":_loc5_
         };
      }
      
      public static function getSplitComplementHarmony(param1:uint, param2:int = 30) : Object
      {
         var _loc3_:Object = RGBtoHSV(param1);
         if(param2 >= 359 || param2 <= 0)
         {
            throw Error("FlxColor Warning: Invalid threshold given to getSplitComplementHarmony()");
         }
         var _loc4_:int = FlxMath.wrapValue(_loc3_.hue,180,359);
         var _loc5_:int = FlxMath.wrapValue(_loc3_.hue,_loc4_ - param2,359);
         var _loc6_:int = FlxMath.wrapValue(_loc3_.hue,_loc4_ + param2,359);
         FlxG.log("hue: " + _loc3_.hue + " opposite: " + _loc4_ + " warmer: " + _loc5_ + " colder: " + _loc6_);
         return {
            "color1":param1,
            "color2":HSVtoRGB(_loc5_,_loc3_.saturation,_loc3_.value),
            "color3":HSVtoRGB(_loc6_,_loc3_.saturation,_loc3_.value),
            "hue1":_loc3_.hue,
            "hue2":_loc5_,
            "hue3":_loc6_
         };
      }
      
      public static function getTriadicHarmony(param1:uint) : Object
      {
         var _loc2_:Object = RGBtoHSV(param1);
         var _loc3_:int = FlxMath.wrapValue(_loc2_.hue,120,359);
         var _loc4_:int = FlxMath.wrapValue(_loc3_,120,359);
         return {
            "color1":param1,
            "color2":HSVtoRGB(_loc3_,1,1),
            "color3":HSVtoRGB(_loc4_,1,1)
         };
      }
      
      public static function getColorInfo(param1:uint) : String
      {
         var _loc2_:Object = getRGB(param1);
         var _loc3_:Object = RGBtoHSV(param1);
         var _loc4_:*;
         return String((_loc4_ = (_loc4_ = RGBtoHexString(param1) + "\n").concat("Alpha: " + _loc2_.alpha + " Red: " + _loc2_.red + " Green: " + _loc2_.green + " Blue: " + _loc2_.blue) + "\n").concat("Hue: " + _loc3_.hue + " Saturation: " + _loc3_.saturation + " Lightnes: " + _loc3_.lightness));
      }
      
      public static function RGBtoHexString(param1:uint) : String
      {
         var _loc2_:Object = getRGB(param1);
         return "0x" + colorToHexString(_loc2_.alpha) + colorToHexString(_loc2_.red) + colorToHexString(_loc2_.green) + colorToHexString(_loc2_.blue);
      }
      
      public static function colorToHexString(param1:uint) : String
      {
         var _loc2_:String = "0123456789ABCDEF";
         var _loc3_:Number = param1 % 16;
         var _loc4_:Number = (param1 - _loc3_) / 16;
         return String(_loc2_.charAt(_loc4_) + _loc2_.charAt(_loc3_));
      }
      
      public static function HSVtoRGB(param1:Number, param2:Number, param3:Number, param4:uint = 255) : uint
      {
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(param2 == 0)
         {
            _loc5_ = getColor32(param4,param3 * 255,param3 * 255,param3 * 255);
         }
         else
         {
            param1 /= 60;
            _loc6_ = param1 - int(param1);
            _loc7_ = param3 * (1 - param2);
            _loc8_ = param3 * (1 - param2 * _loc6_);
            _loc9_ = param3 * (1 - param2 * (1 - _loc6_));
            switch(int(param1))
            {
               case 0:
                  _loc5_ = getColor32(param4,param3 * 255,_loc9_ * 255,_loc7_ * 255);
                  break;
               case 1:
                  _loc5_ = getColor32(param4,_loc8_ * 255,param3 * 255,_loc7_ * 255);
                  break;
               case 2:
                  _loc5_ = getColor32(param4,_loc7_ * 255,param3 * 255,_loc9_ * 255);
                  break;
               case 3:
                  _loc5_ = getColor32(param4,_loc7_ * 255,_loc8_ * 255,param3 * 255);
                  break;
               case 4:
                  _loc5_ = getColor32(param4,_loc9_ * 255,_loc7_ * 255,param3 * 255);
                  addr29:
                  break;
               case 5:
                  _loc5_ = getColor32(param4,param3 * 255,_loc7_ * 255,_loc8_ * 255);
                  break;
               default:
                  FlxG.log("FlxColor Error: HSVtoRGB : Unknown color");
                  if(true)
                  {
                     break;
                  }
                  §§goto(addr29);
            }
         }
         return _loc5_;
      }
      
      public static function RGBtoHSV(param1:uint) : Object
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc2_:Object = getRGB(param1);
         var _loc3_:Number = _loc2_.red / 255;
         var _loc4_:Number = _loc2_.green / 255;
         var _loc5_:Number = _loc2_.blue / 255;
         var _loc6_:Number = Number(Math.min(_loc3_,_loc4_,_loc5_));
         var _loc7_:Number;
         var _loc8_:Number = (_loc7_ = Number(Math.max(_loc3_,_loc4_,_loc5_))) - _loc6_;
         var _loc9_:Number = (_loc7_ + _loc6_) / 2;
         if(_loc8_ == 0)
         {
            _loc10_ = 0;
            _loc11_ = 0;
         }
         else
         {
            if(_loc9_ < 0.5)
            {
               _loc11_ = _loc8_ / (_loc7_ + _loc6_);
            }
            else
            {
               _loc11_ = _loc8_ / (2 - _loc7_ - _loc6_);
            }
            _loc12_ = ((_loc7_ - _loc3_) / 6 + _loc8_ / 2) / _loc8_;
            _loc13_ = ((_loc7_ - _loc4_) / 6 + _loc8_ / 2) / _loc8_;
            _loc14_ = ((_loc7_ - _loc5_) / 6 + _loc8_ / 2) / _loc8_;
            if(_loc3_ == _loc7_)
            {
               _loc10_ = _loc14_ - _loc13_;
            }
            else if(_loc4_ == _loc7_)
            {
               _loc10_ = 1 / 3 + _loc12_ - _loc14_;
            }
            else if(_loc5_ == _loc7_)
            {
               _loc10_ = 2 / 3 + _loc13_ - _loc12_;
            }
            if(_loc10_ < 0)
            {
               _loc10_ += 1;
            }
            if(_loc10_ > 1)
            {
               _loc10_--;
            }
         }
         _loc10_ *= 360;
         _loc10_ = Number(Math.round(_loc10_));
         return {
            "hue":_loc10_,
            "saturation":_loc11_,
            "lightness":_loc9_,
            "value":_loc9_
         };
      }
      
      public static function interpolateColor(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint = 255) : uint
      {
         var _loc6_:Object = getRGB(param1);
         var _loc7_:Object;
         var _loc8_:uint = ((_loc7_ = getRGB(param2)).red - _loc6_.red) * param4 / param3 + _loc6_.red;
         var _loc9_:uint = (_loc7_.green - _loc6_.green) * param4 / param3 + _loc6_.green;
         var _loc10_:uint = (_loc7_.blue - _loc6_.blue) * param4 / param3 + _loc6_.blue;
         return getColor32(param5,_loc8_,_loc9_,_loc10_);
      }
      
      public static function interpolateColorWithRGB(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint) : uint
      {
         var _loc7_:Object = getRGB(param1);
         var _loc8_:uint = (param2 - _loc7_.red) * param6 / param5 + _loc7_.red;
         var _loc9_:uint = (param3 - _loc7_.green) * param6 / param5 + _loc7_.green;
         var _loc10_:uint = (param4 - _loc7_.blue) * param6 / param5 + _loc7_.blue;
         return getColor24(_loc8_,_loc9_,_loc10_);
      }
      
      public static function interpolateRGB(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint) : uint
      {
         var _loc9_:uint = (param4 - param1) * param8 / param7 + param1;
         var _loc10_:uint = (param5 - param2) * param8 / param7 + param2;
         var _loc11_:uint = (param6 - param3) * param8 / param7 + param3;
         return getColor24(_loc9_,_loc10_,_loc11_);
      }
      
      public static function getRandomColor(param1:uint = 0, param2:uint = 255, param3:uint = 255) : uint
      {
         if(param2 > 255)
         {
            FlxG.log("FlxColor Warning: getRandomColor - max value too high");
            return getColor24(255,255,255);
         }
         if(param1 > param2)
         {
            FlxG.log("FlxColor Warning: getRandomColor - min value higher than max");
            return getColor24(255,255,255);
         }
         var _loc4_:uint = param1 + int(Math.random() * (param2 - param1));
         var _loc5_:uint = param1 + int(Math.random() * (param2 - param1));
         var _loc6_:uint = param1 + int(Math.random() * (param2 - param1));
         return getColor32(param3,_loc4_,_loc5_,_loc6_);
      }
      
      public static function getColor32(param1:uint, param2:uint, param3:uint, param4:uint) : uint
      {
         return param1 << 24 | param2 << 16 | param3 << 8 | param4;
      }
      
      public static function getColor24(param1:uint, param2:uint, param3:uint) : uint
      {
         return param1 << 16 | param2 << 8 | param3;
      }
      
      public static function getRGB(param1:uint) : Object
      {
         var _loc2_:uint = uint(param1 >>> 24);
         var _loc3_:uint = uint(param1 >> 16 & 255);
         var _loc4_:uint = uint(param1 >> 8 & 255);
         var _loc5_:uint = uint(param1 & 255);
         return {
            "alpha":_loc2_,
            "red":_loc3_,
            "green":_loc4_,
            "blue":_loc5_
         };
      }
      
      public static function getAlpha(param1:uint) : uint
      {
         return param1 >>> 24;
      }
      
      public static function getAlphaFloat(param1:uint) : Number
      {
         var _loc2_:uint = uint(param1 >>> 24);
         return _loc2_ / 255;
      }
      
      public static function getRed(param1:uint) : uint
      {
         return param1 >> 16 & 255;
      }
      
      public static function getGreen(param1:uint) : uint
      {
         return param1 >> 8 & 255;
      }
      
      public static function getBlue(param1:uint) : uint
      {
         return param1 & 255;
      }
   }
}
