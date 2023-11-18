package com.newgrounds
{
   import flash.utils.Dictionary;
   
   public class BaseN
   {
       
      
      private var _hashIndex:String;
      
      private var _hashVal:Dictionary;
      
      private var _base:Number;
      
      public function BaseN(param1:String = null)
      {
         super();
         if(param1)
         {
            this._hashIndex = param1;
         }
         else
         {
            this._hashIndex = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~@#$%^&*()+|;/";
         }
         this._base = this._hashIndex.length;
         this._hashVal = new Dictionary();
         var _loc2_:uint = 0;
         while(_loc2_ < this._base)
         {
            this._hashVal[this._hashIndex.charAt(_loc2_)] = _loc2_;
            _loc2_++;
         }
      }
      
      public function encode(param1:Number, param2:uint = 1) : String
      {
         var _loc3_:String = String(param1.toString());
         var _loc4_:String = "";
         if(_loc3_.charAt(0) == "-")
         {
            _loc4_ = "-";
            _loc3_ = String(_loc3_.substring(1));
         }
         var _loc5_:Array = _loc3_.split(".",2);
         _loc4_ += this.baseNEncoder(_loc5_[0],param2);
         if(_loc5_.length > 1)
         {
            _loc4_ += "." + this.baseNEncoder(_loc5_[1]);
         }
         return _loc4_;
      }
      
      public function decode(param1:String) : Number
      {
         var _loc2_:* = "";
         if(param1.charAt(0) == "-")
         {
            _loc2_ = "-";
            param1 = String(param1.substring(1));
         }
         var _loc3_:Array = param1.split(".",2);
         _loc2_ += this.baseNDecoder(_loc3_[0]);
         if(_loc3_.length > 1)
         {
            _loc2_ += ".";
            _loc2_ += this.baseNDecoder(_loc3_[1]);
         }
         return Number(_loc2_);
      }
      
      private function baseNEncoder(param1:uint, param2:uint = 1) : String
      {
         var _loc3_:String = "";
         var _loc4_:uint = param1;
         while(_loc4_ != 0)
         {
            _loc3_ = this._hashIndex.charAt(_loc4_ % this._base) + _loc3_;
            _loc4_ /= this._base;
         }
         if(param2)
         {
            while(_loc3_.length < param2)
            {
               _loc3_ = this._hashIndex.charAt(0) + _loc3_;
            }
         }
         return _loc3_;
      }
      
      private function baseNDecoder(param1:String) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ *= this._base;
            _loc2_ += this._hashVal[param1.charAt(_loc3_)];
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
