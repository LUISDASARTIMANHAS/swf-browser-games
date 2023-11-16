package org.flixel
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class FlxU
   {
       
      
      public function FlxU()
      {
         super();
      }
      
      public static function openURL(param1:String) : Boolean
      {
         var URL:String = param1;
         try
         {
            navigateToURL(new URLRequest(URL),"_blank");
            return true;
         }
         catch(err:SecurityError)
         {
            return false;
         }
      }
      
      public static function abs(param1:Number) : Number
      {
         return param1 > 0 ? param1 : -param1;
      }
      
      public static function floor(param1:Number) : Number
      {
         var _loc2_:Number = Number(int(param1));
         return param1 > 0 ? _loc2_ : (_loc2_ != param1 ? _loc2_ - 1 : _loc2_);
      }
      
      public static function ceil(param1:Number) : Number
      {
         var _loc2_:Number = Number(int(param1));
         return param1 > 0 ? (_loc2_ != param1 ? _loc2_ + 1 : _loc2_) : _loc2_;
      }
      
      public static function round(param1:Number) : Number
      {
         var _loc2_:Number = Number(int(param1 + (param1 > 0 ? 0.5 : -0.5)));
         return param1 > 0 ? _loc2_ : (_loc2_ != param1 ? _loc2_ - 1 : _loc2_);
      }
      
      public static function min(param1:Number, param2:Number) : Number
      {
         return param1 <= param2 ? param1 : param2;
      }
      
      public static function max(param1:Number, param2:Number) : Number
      {
         return param1 >= param2 ? param1 : param2;
      }
      
      public static function bound(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc4_:Number;
         return (_loc4_ = param1 < param2 ? param2 : param1) > param3 ? param3 : _loc4_;
      }
      
      public static function srand(param1:Number) : Number
      {
         return 69621 * int(param1 * 2147483647) % 2147483647 / 2147483647;
      }
      
      public static function shuffle(param1:Array, param2:uint) : Array
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         var _loc3_:uint = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = Math.random() * param1.length;
            _loc5_ = Math.random() * param1.length;
            _loc6_ = param1[_loc5_];
            param1[_loc5_] = param1[_loc4_];
            do
            {
               param1[_loc4_] = _loc6_;
               _loc3_++;
            }
            while(false);
            
         }
         return param1;
      }
      
      public static function getRandom(param1:Array) : Object
      {
         var _loc2_:uint = 0;
         if(param1 != null)
         {
            _loc2_ = uint(param1.length);
            if(_loc2_ > 0)
            {
               return param1[uint(Math.random() * _loc2_)];
            }
         }
         return null;
      }
      
      public static function getTicks() : uint
      {
         return getTimer();
      }
      
      public static function formatTicks(param1:uint, param2:uint) : String
      {
         return (param2 - param1) / 1000 + "s";
      }
      
      public static function makeColor(param1:uint, param2:uint, param3:uint, param4:Number = 1) : uint
      {
         return ((param4 > 1 ? param4 : param4 * 255) & 255) << 24 | (param1 & 255) << 16 | (param2 & 255) << 8 | param3 & 255;
      }
      
      public static function makeColorFromHSB(param1:Number, param2:Number, param3:Number, param4:Number = 1) : uint
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(param2 == 0)
         {
            _loc5_ = param3;
            _loc6_ = param3;
            _loc7_ = param3;
         }
         else
         {
            if(param1 == 360)
            {
               param1 = 0;
            }
            _loc8_ = param1 / 60;
            _loc9_ = param1 / 60 - _loc8_;
            _loc10_ = param3 * (1 - param2);
            _loc11_ = param3 * (1 - param2 * _loc9_);
            _loc12_ = param3 * (1 - param2 * (1 - _loc9_));
            switch(_loc8_)
            {
               case 0:
                  _loc5_ = param3;
                  _loc6_ = _loc12_;
                  _loc7_ = _loc10_;
                  break;
               case 1:
                  _loc5_ = _loc11_;
                  _loc6_ = param3;
                  _loc7_ = _loc10_;
                  break;
               case 2:
                  _loc5_ = _loc10_;
                  _loc6_ = param3;
                  _loc7_ = _loc12_;
                  break;
               case 3:
                  _loc5_ = _loc10_;
                  _loc6_ = _loc11_;
                  _loc7_ = param3;
                  break;
               case 4:
                  _loc5_ = _loc12_;
                  _loc6_ = _loc10_;
                  _loc7_ = param3;
                  break;
               case 5:
                  _loc5_ = param3;
                  _loc6_ = _loc10_;
                  _loc7_ = _loc11_;
                  break;
               default:
                  _loc5_ = 0;
                  do
                  {
                     _loc6_ = 0;
                     _loc7_ = 0;
                  }
                  while(false);
                  
            }
         }
         return ((param4 > 1 ? param4 : param4 * 255) & 255) << 24 | uint(_loc5_ * 255) << 16 | uint(_loc6_ * 255) << 8 | uint(_loc7_ * 255);
      }
      
      public static function getRGBA(param1:uint, param2:Array = null) : Array
      {
         if(param2 == null)
         {
            param2 = new Array();
         }
         param2[0] = param1 >> 16 & 255;
         param2[1] = param1 >> 8 & 255;
         param2[2] = param1 & 255;
         param2[3] = Number(param1 >> 24 & 255) / 255;
         return param2;
      }
      
      public static function getHSB(param1:uint, param2:Array = null) : Array
      {
         if(param2 == null)
         {
            param2 = new Array();
         }
         var _loc3_:Number = Number(param1 >> 16 & 255) / 255;
         var _loc4_:Number = Number(param1 >> 8 & 255) / 255;
         var _loc5_:Number = Number(param1 & 255) / 255;
         var _loc6_:Number;
         var _loc7_:Number = (_loc6_ = _loc3_ > _loc4_ ? _loc3_ : _loc4_) > _loc5_ ? _loc6_ : _loc5_;
         var _loc8_:Number = (_loc6_ = _loc3_ > _loc4_ ? _loc4_ : _loc3_) > _loc5_ ? _loc5_ : _loc6_;
         var _loc9_:Number = _loc7_ - _loc8_;
         param2[2] = _loc7_;
         param2[1] = 0;
         param2[0] = 0;
         if(_loc7_ != 0)
         {
            param2[1] = _loc9_ / _loc7_;
         }
         if(param2[1] != 0)
         {
            if(_loc3_ == _loc7_)
            {
               param2[0] = (_loc4_ - _loc5_) / _loc9_;
            }
            else if(_loc4_ == _loc7_)
            {
               param2[0] = 2 + (_loc5_ - _loc3_) / _loc9_;
            }
            else if(_loc5_ == _loc7_)
            {
               param2[0] = 4 + (_loc3_ - _loc4_) / _loc9_;
            }
            param2[0] *= 60;
            if(param2[0] < 0)
            {
               param2[0] += 360;
            }
         }
         param2[3] = Number(param1 >> 24 & 255) / 255;
         return param2;
      }
      
      public static function formatTime(param1:Number, param2:Boolean = false) : String
      {
         var _loc3_:* = int(param1 / 60) + ":";
         var _loc4_:int;
         if((_loc4_ = int(param1) % 60) < 10)
         {
            _loc3_ += "0";
         }
         _loc3_ += _loc4_;
         if(param2)
         {
            _loc3_ += ".";
            if((_loc4_ = (param1 - int(param1)) * 100) < 10)
            {
               _loc3_ += "0";
            }
            _loc3_ += _loc4_;
         }
         return _loc3_;
      }
      
      public static function formatArray(param1:Array) : String
      {
         if(param1 == null || param1.length <= 0)
         {
            return "";
         }
         var _loc2_:String = String(param1[0].toString());
         var _loc3_:uint = 0;
         var _loc4_:uint = uint(param1.length);
         while(_loc3_ < _loc4_)
         {
            _loc2_ += ", " + param1[_loc3_++].toString();
         }
         return _loc2_;
      }
      
      public static function formatMoney(param1:Number, param2:Boolean = true, param3:Boolean = true) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = param1;
         var _loc6_:* = "";
         var _loc7_:String = "";
         var _loc8_:* = "";
         while(_loc5_ > 0)
         {
            if(_loc6_.length > 0 && _loc7_.length <= 0)
            {
               if(param3)
               {
                  _loc7_ = ",";
               }
               else
               {
                  _loc7_ = ".";
               }
            }
            _loc8_ = "";
            _loc4_ = _loc5_ - int(_loc5_ / 1000) * 1000;
            if((_loc5_ /= 1000) > 0)
            {
               if(_loc4_ < 100)
               {
                  _loc8_ += "0";
               }
               if(_loc4_ < 10)
               {
                  _loc8_ += "0";
               }
            }
            _loc6_ = _loc8_ + _loc4_ + _loc7_ + _loc6_;
         }
         if(param2)
         {
            _loc5_ = int(param1 * 100) - int(param1) * 100;
            _loc6_ += (param3 ? "." : ",") + _loc5_;
            if(_loc5_ < 10)
            {
               _loc6_ += "0";
            }
         }
         return _loc6_;
      }
      
      public static function getClassName(param1:Object, param2:Boolean = false) : String
      {
         var _loc3_:String = String(getQualifiedClassName(param1));
         _loc3_ = String(_loc3_.replace("::","."));
         if(param2)
         {
            _loc3_ = String(_loc3_.substr(_loc3_.lastIndexOf(".") + 1));
         }
         return _loc3_;
      }
      
      public static function getClass(param1:String) : Class
      {
         return getDefinitionByName(param1) as Class;
      }
      
      public static function computeVelocity(param1:Number, param2:Number = 0, param3:Number = 0, param4:Number = 10000) : Number
      {
         var _loc5_:Number = NaN;
         if(param2 != 0)
         {
            param1 += param2 * FlxG.elapsed;
         }
         else if(param3 != 0)
         {
            _loc5_ = param3 * FlxG.elapsed;
            if(param1 - _loc5_ > 0)
            {
               param1 -= _loc5_;
            }
            else if(param1 + _loc5_ < 0)
            {
               param1 += _loc5_;
            }
            else
            {
               param1 = 0;
            }
         }
         if(param1 != 0 && param4 != 10000)
         {
            if(param1 > param4)
            {
               param1 = param4;
            }
            else if(param1 < -param4)
            {
               param1 = -param4;
            }
         }
         return param1;
      }
      
      public static function rotatePoint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:FlxPoint = null) : FlxPoint
      {
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Number = param5 * -0.017453293;
         while(_loc9_ < -3.14159265)
         {
            _loc9_ += 6.28318531;
         }
         while(_loc9_ > 3.14159265)
         {
            _loc9_ -= 6.28318531;
         }
         if(_loc9_ < 0)
         {
            if((_loc7_ = 1.27323954 * _loc9_ + 0.405284735 * _loc9_ * _loc9_) < 0)
            {
               _loc7_ = 0.225 * (_loc7_ * -_loc7_ - _loc7_) + _loc7_;
            }
            else
            {
               _loc7_ = 0.225 * (_loc7_ * _loc7_ - _loc7_) + _loc7_;
            }
         }
         else if((_loc7_ = 1.27323954 * _loc9_ - 0.405284735 * _loc9_ * _loc9_) < 0)
         {
            _loc7_ = 0.225 * (_loc7_ * -_loc7_ - _loc7_) + _loc7_;
         }
         else
         {
            _loc7_ = 0.225 * (_loc7_ * _loc7_ - _loc7_) + _loc7_;
         }
         if((_loc9_ += 1.57079632) > 3.14159265)
         {
            _loc9_ -= 6.28318531;
         }
         if(_loc9_ < 0)
         {
            if((_loc8_ = 1.27323954 * _loc9_ + 0.405284735 * _loc9_ * _loc9_) < 0)
            {
               _loc8_ = 0.225 * (_loc8_ * -_loc8_ - _loc8_) + _loc8_;
            }
            else
            {
               _loc8_ = 0.225 * (_loc8_ * _loc8_ - _loc8_) + _loc8_;
            }
            addr37:
         }
         else if((_loc8_ = 1.27323954 * _loc9_ - 0.405284735 * _loc9_ * _loc9_) < 0)
         {
            _loc8_ = 0.225 * (_loc8_ * -_loc8_ - _loc8_) + _loc8_;
         }
         else
         {
            _loc8_ = 0.225 * (_loc8_ * _loc8_ - _loc8_) + _loc8_;
            if(false)
            {
               §§goto(addr37);
            }
         }
         var _loc10_:Number = param1 - param3;
         var _loc11_:Number = param4 - param2;
         if(param6 == null)
         {
            param6 = new FlxPoint();
         }
         param6.x = param3 + _loc8_ * _loc10_ - _loc7_ * _loc11_;
         param6.y = param4 - _loc7_ * _loc10_ - _loc8_ * _loc11_;
         return param6;
      }
      
      public static function getAngle(param1:FlxPoint, param2:FlxPoint) : Number
      {
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = param2.y - param1.y;
         if(_loc3_ == 0 && _loc4_ == 0)
         {
            return 0;
         }
         var _loc5_:Number = 3.14159265 * 0.25;
         var _loc6_:Number = 3 * _loc5_;
         var _loc7_:Number = _loc4_ < 0 ? -_loc4_ : _loc4_;
         var _loc8_:Number = 0;
         if(_loc3_ >= 0)
         {
            _loc8_ = _loc5_ - _loc5_ * ((_loc3_ - _loc7_) / (_loc3_ + _loc7_));
         }
         else
         {
            _loc8_ = _loc6_ - _loc5_ * ((_loc3_ + _loc7_) / (_loc7_ - _loc3_));
         }
         if((_loc8_ = (_loc4_ < 0 ? -_loc8_ : _loc8_) * 57.2957796) > 90)
         {
            _loc8_ -= 270;
         }
         else
         {
            _loc8_ += 90;
         }
         return _loc8_;
      }
      
      public static function getDistance(param1:FlxPoint, param2:FlxPoint) : Number
      {
         var _loc3_:Number = param1.x - param2.x;
         var _loc4_:Number = param1.y - param2.y;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
   }
}
