package com.newgrounds
{
   public class RC4
   {
      
      private static var sbox:Array = new Array(255);
      
      private static var mykey:Array = new Array(255);
       
      
      public function RC4()
      {
         super();
      }
      
      public static function encrypt(param1:String, param2:String) : String
      {
         var _loc3_:Array = strToChars(param1);
         var _loc4_:Array = strToChars(param2);
         var _loc5_:Array = calculate(_loc3_,_loc4_);
         return charsToHex(_loc5_);
      }
      
      public static function encryptbin(param1:String, param2:String) : Array
      {
         var _loc3_:Array = strToChars(param1);
         var _loc4_:Array = strToChars(param2);
         return calculate(_loc3_,_loc4_);
      }
      
      public static function decrypt(param1:String, param2:String) : String
      {
         var _loc3_:Array = hexToChars(param1);
         var _loc4_:Array = strToChars(param2);
         var _loc5_:Array = calculate(_loc3_,_loc4_);
         return charsToStr(_loc5_);
      }
      
      private static function initialize(param1:Array) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:uint = 0;
         var _loc4_:uint = uint(param1.length);
         var _loc5_:uint = 0;
         while(_loc5_ <= 255)
         {
            mykey[_loc5_] = param1[_loc5_ % _loc4_];
            sbox[_loc5_] = _loc5_;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ <= 255)
         {
            _loc2_ = (_loc2_ + sbox[_loc5_] + mykey[_loc5_]) % 256;
            _loc3_ = uint(sbox[_loc5_]);
            sbox[_loc5_] = sbox[_loc2_];
            sbox[_loc2_] = _loc3_;
            _loc5_++;
         }
      }
      
      private static function calculate(param1:Array, param2:Array) : Array
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         initialize(param2);
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Array = new Array();
         var _loc9_:uint = 0;
         while(_loc9_ < param1.length)
         {
            _loc3_ = (_loc3_ + 1) % 256;
            _loc4_ = (_loc4_ + sbox[_loc3_]) % 256;
            _loc7_ = uint(sbox[_loc3_]);
            sbox[_loc3_] = sbox[_loc4_];
            sbox[_loc4_] = _loc7_;
            _loc10_ = (sbox[_loc3_] + sbox[_loc4_]) % 256;
            _loc6_ = uint(sbox[_loc10_]);
            _loc8_ = uint(param1[_loc9_] ^ _loc6_);
            _loc5_.push(_loc8_);
            _loc9_++;
         }
         return _loc5_;
      }
      
      private static function charsToHex(param1:Array) : String
      {
         var _loc2_:String = String(new String(""));
         var _loc3_:Array = new Array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ += _loc3_[param1[_loc4_] >> 4] + _loc3_[param1[_loc4_] & 15];
            _loc4_++;
         }
         return _loc2_;
      }
      
      private static function hexToChars(param1:String) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:uint = param1.substr(0,2) == "0x" ? 2 : 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(parseInt(param1.substr(_loc3_,2),16));
            _loc3_ += 2;
         }
         return _loc2_;
      }
      
      private static function charsToStr(param1:Array) : String
      {
         var _loc2_:String = String(new String(""));
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += String.fromCharCode(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function strToChars(param1:String) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1.charCodeAt(_loc3_));
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
