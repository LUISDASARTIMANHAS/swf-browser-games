package utils
{
   public class cStringUtil
   {
       
      
      public function cStringUtil()
      {
         super();
      }
      
      public static function IsStringNullOrEmpty(param1:String) : Boolean
      {
         if(param1 != null && param1.length > 0)
         {
            return false;
         }
         return true;
      }
      
      public static function StipSpaces(param1:String) : String
      {
         return param1.split(" ").join("");
      }
      
      public static function ReplaceCharAt(param1:String, param2:String, param3:int) : String
      {
         var _loc4_:String = String(param1.substring(0,param3));
         var _loc5_:String = String(param1.substring(param3 + 1,param1.length));
         return _loc4_ + param2 + _loc5_;
      }
      
      public static function Replace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function Trim(param1:String, param2:String) : String
      {
         return TrimBack(TrimFront(param1,param2),param2);
      }
      
      public static function TrimFront(param1:String, param2:String) : String
      {
         param2 = StringToCharacter(param2);
         if(param1.charAt(0) == param2)
         {
            param1 = TrimFront(param1.substring(1),param2);
         }
         return param1;
      }
      
      public static function TrimBack(param1:String, param2:String) : String
      {
         param2 = StringToCharacter(param2);
         if(param1.charAt(param1.length - 1) == param2)
         {
            param1 = TrimBack(param1.substring(0,param1.length - 1),param2);
         }
         return param1;
      }
      
      public static function StringToCharacter(param1:String) : String
      {
         if(param1.length == 1)
         {
            return param1;
         }
         return param1.slice(0,1);
      }
      
      public static function StipCarriageReturns(param1:String) : String
      {
         var _loc2_:String = String(param1.replace(/\n/g,""));
         return String(_loc2_.replace(/\r/g,""));
      }
      
      public static function GetCharCount(param1:String, param2:String) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = int(param2.indexOf(param1));
         while(_loc3_ >= 0)
         {
            _loc4_++;
            _loc3_ = int(param2.indexOf(param1,_loc3_ + 1));
         }
         return _loc4_;
      }
      
      public static function sprintf(param1:String, ... rest) : String
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:* = undefined;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:String = null;
         var _loc17_:Boolean = false;
         var _loc18_:String = null;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc22_:* = null;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:String = null;
         var _loc26_:* = 0;
         var _loc27_:uint = 0;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:* = null;
         var _loc31_:String = null;
         var _loc32_:* = null;
         var _loc33_:Number = NaN;
         var _loc34_:String = null;
         var _loc35_:String = null;
         var _loc3_:* = "";
         _loc5_ = rest;
         var _loc6_:int = 0;
         var _loc7_:int = int(param1.length);
         while(_loc6_ < _loc7_)
         {
            if((_loc4_ = String(param1.charAt(_loc6_))) == "%")
            {
               if((_loc4_ = String(param1.charAt(++_loc6_))) == "%")
               {
                  _loc3_ += "%";
               }
               else
               {
                  _loc9_ = null;
                  _loc10_ = false;
                  _loc11_ = false;
                  _loc12_ = false;
                  _loc13_ = false;
                  _loc14_ = false;
                  while(_loc4_ == "-" || _loc4_ == "+" || _loc4_ == " " || _loc4_ == "#" || _loc4_ == "0")
                  {
                     if(_loc4_ == "-")
                     {
                        _loc10_ = true;
                     }
                     else if(_loc4_ == "+")
                     {
                        _loc11_ = true;
                     }
                     else if(_loc4_ == " ")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc4_ == "#")
                     {
                        _loc13_ = true;
                     }
                     else if(_loc4_ == "0")
                     {
                        _loc14_ = true;
                     }
                     _loc4_ = String(param1.charAt(++_loc6_));
                  }
                  _loc15_ = false;
                  _loc16_ = "";
                  if(_loc4_ == "*")
                  {
                     _loc15_ = true;
                     _loc4_ = String(param1.charAt(++_loc6_));
                  }
                  else
                  {
                     while(_loc4_ == "1" || _loc4_ == "2" || _loc4_ == "3" || _loc4_ == "4" || _loc4_ == "5" || _loc4_ == "6" || _loc4_ == "7" || _loc4_ == "8" || _loc4_ == "9" || _loc4_ == "0")
                     {
                        _loc16_ += _loc4_;
                        _loc4_ = String(param1.charAt(++_loc6_));
                     }
                  }
                  _loc17_ = false;
                  _loc18_ = "";
                  if(_loc4_ == ".")
                  {
                     if((_loc4_ = String(param1.charAt(++_loc6_))) == "*")
                     {
                        _loc17_ = true;
                        _loc4_ = String(param1.charAt(++_loc6_));
                     }
                     else
                     {
                        while(_loc4_ == "1" || _loc4_ == "2" || _loc4_ == "3" || _loc4_ == "4" || _loc4_ == "5" || _loc4_ == "6" || _loc4_ == "7" || _loc4_ == "8" || _loc4_ == "9" || _loc4_ == "0")
                        {
                           _loc18_ += _loc4_;
                           _loc4_ = String(param1.charAt(++_loc6_));
                        }
                     }
                  }
                  _loc19_ = false;
                  _loc20_ = false;
                  _loc21_ = false;
                  while(true)
                  {
                     §§push(_loc4_ == "h");
                     if(!(_loc4_ == "h"))
                     {
                        §§pop();
                        while(true)
                        {
                           §§push(_loc4_ == "l");
                        }
                        addr137:
                     }
                     while(!(§§pop() || _loc4_ == "L"))
                     {
                        _loc23_ = int(int(_loc16_));
                        if(false)
                        {
                           §§goto(addr137);
                        }
                        else
                        {
                           _loc24_ = int(int(_loc9_ = _loc18_));
                           _loc25_ = _loc14_ ? "0" : " ";
                           if(_loc17_)
                           {
                              _loc24_ = int(int(_loc9_ = _loc5_.shift()));
                           }
                           if(_loc15_)
                           {
                              _loc23_ = int(int(_loc5_.shift()));
                           }
                           switch(_loc4_)
                           {
                              case "c":
                                 _loc22_ = String(String.fromCharCode(int(_loc5_.shift()) & 255));
                                 if(_loc23_ != 0)
                                 {
                                    _loc22_ = pad(_loc22_,_loc23_,_loc10_,_loc25_);
                                 }
                                 break;
                              case "d":
                              case "i":
                              case "o":
                                 _loc26_ = int(int(_loc5_.shift()));
                                 if(_loc19_)
                                 {
                                    _loc26_ &= 65535;
                                 }
                                 if(_loc4_ == "o")
                                 {
                                    _loc22_ = String(_loc26_.toString(8));
                                 }
                                 else
                                 {
                                    _loc22_ = String(_loc26_.toString());
                                 }
                                 if(_loc24_ != 0)
                                 {
                                    _loc22_ = pad(_loc22_,_loc24_,false,"0");
                                 }
                                 if(_loc26_ > 0)
                                 {
                                    if(_loc11_)
                                    {
                                       _loc22_ = "+" + _loc22_;
                                    }
                                    else if(_loc12_)
                                    {
                                       _loc22_ = " " + _loc22_;
                                    }
                                 }
                                 if(_loc13_ && _loc26_ != 0 && _loc4_ == "o")
                                 {
                                    _loc22_ = "0" + _loc22_;
                                 }
                                 if(_loc23_ != 0)
                                 {
                                    _loc22_ = pad(_loc22_,_loc23_,_loc10_,_loc25_);
                                 }
                                 if(_loc26_ == 0)
                                 {
                                    if(_loc9_ != null && _loc9_ != undefined && _loc9_ != "")
                                    {
                                       if(_loc24_ == 0)
                                       {
                                          _loc22_ = "";
                                       }
                                    }
                                 }
                                 addr650:
                                 break;
                              case "u":
                              case "x":
                              case "X":
                                 _loc27_ = uint(uint(_loc5_.shift()));
                                 if(_loc19_)
                                 {
                                    _loc27_ &= 65535;
                                    if(false)
                                    {
                                       §§goto(addr650);
                                    }
                                 }
                                 _loc9_ = _loc18_;
                                 if(_loc4_ == "x")
                                 {
                                    _loc22_ = String(_loc27_.toString(16));
                                 }
                                 else if(_loc4_ == "X")
                                 {
                                    _loc22_ = String(_loc27_.toString(16).toUpperCase());
                                 }
                                 else
                                 {
                                    _loc22_ = String(_loc27_.toString());
                                 }
                                 if(_loc24_ != 0)
                                 {
                                    _loc22_ = pad(_loc22_,_loc24_,false,"0");
                                 }
                                 if(_loc27_ > 0)
                                 {
                                    if(_loc11_)
                                    {
                                       _loc22_ = "+" + _loc22_;
                                    }
                                    else if(_loc12_)
                                    {
                                       _loc22_ = " " + _loc22_;
                                    }
                                 }
                                 if(_loc27_ != 0)
                                 {
                                    if(_loc13_)
                                    {
                                       if(_loc4_ == "x")
                                       {
                                          _loc22_ = "0x" + _loc22_;
                                       }
                                       else if(_loc4_ == "X")
                                       {
                                          _loc22_ = "0X" + _loc22_;
                                       }
                                    }
                                 }
                                 if(_loc23_ != 0)
                                 {
                                    _loc22_ = pad(_loc22_,_loc23_,_loc10_,_loc25_);
                                 }
                                 if(_loc27_ == 0)
                                 {
                                    if(_loc9_ != null && _loc9_ != undefined && _loc9_ != "")
                                    {
                                       if(_loc24_ == 0)
                                       {
                                          _loc22_ = "";
                                       }
                                    }
                                 }
                                 break;
                              case "e":
                              case "E":
                                 _loc28_ = Number(Number(_loc5_.shift()));
                                 if(_loc24_ != 0)
                                 {
                                    _loc22_ = String(_loc28_.toExponential(Math.min(_loc24_,20)));
                                 }
                                 else
                                 {
                                    _loc22_ = String(_loc28_.toExponential(6));
                                 }
                                 if(_loc13_)
                                 {
                                    if(_loc22_.indexOf(".") == -1)
                                    {
                                       _loc22_ = _loc22_.substring(0,_loc22_.indexOf("e")) + ".000000" + _loc22_.substring(_loc22_.indexOf("e") + 1);
                                    }
                                 }
                                 if(_loc4_ == "E")
                                 {
                                    _loc22_ = String(_loc22_.toUpperCase());
                                 }
                                 if(_loc23_ != 0)
                                 {
                                    _loc22_ = pad(_loc22_,_loc23_,_loc10_,_loc25_);
                                 }
                                 break;
                              case "f":
                                 _loc29_ = Number(Number(_loc5_.shift()));
                                 if(_loc24_ != 0)
                                 {
                                    _loc22_ = String(_loc29_.toPrecision(_loc24_));
                                 }
                                 else
                                 {
                                    _loc22_ = String(_loc29_.toPrecision(6));
                                 }
                                 if(_loc13_)
                                 {
                                    if(_loc22_.indexOf(".") == -1)
                                    {
                                       _loc22_ += ".000000";
                                    }
                                 }
                                 if(_loc23_ != 0)
                                 {
                                    _loc22_ = pad(_loc22_,_loc23_,_loc10_,_loc25_);
                                 }
                                 break;
                              case "g":
                              case "G":
                                 _loc30_ = "";
                                 _loc31_ = "";
                                 _loc32_ = "";
                                 if(_loc10_)
                                 {
                                    _loc30_ += "-";
                                 }
                                 if(_loc11_)
                                 {
                                    _loc30_ += "+";
                                 }
                                 if(_loc12_)
                                 {
                                    _loc30_ += " ";
                                 }
                                 if(_loc13_)
                                 {
                                    _loc30_ += "#";
                                 }
                                 if(_loc14_)
                                 {
                                    _loc30_ += "0";
                                 }
                                 if(_loc9_ != null && _loc9_ != undefined && _loc9_ != "")
                                 {
                                    _loc31_ = "." + _loc24_.toString();
                                 }
                                 if(_loc19_)
                                 {
                                    _loc32_ += "h";
                                 }
                                 if(_loc20_)
                                 {
                                    _loc32_ += "l";
                                 }
                                 if(_loc21_)
                                 {
                                    _loc32_ += "L";
                                 }
                                 _loc33_ = Number(Number(_loc5_.shift()));
                                 _loc34_ = sprintf("%" + _loc30_ + _loc31_ + _loc32_ + "f",_loc33_);
                                 _loc35_ = sprintf("%" + _loc30_ + _loc31_ + _loc32_ + (_loc4_ == "G" ? "E" : "e"),_loc33_);
                                 _loc22_ = _loc34_.length < _loc35_.length ? _loc34_ : _loc35_;
                                 break;
                              case "s":
                                 _loc22_ = String(String(_loc5_.shift()));
                                 if(_loc24_ != 0)
                                 {
                                    _loc22_ = String(_loc22_.substring(0,_loc24_));
                                 }
                                 if(_loc23_ != 0)
                                 {
                                    _loc22_ = pad(_loc22_,_loc23_,_loc10_,_loc25_);
                                 }
                                 break;
                              case "p":
                              case "n":
                                 break;
                              default:
                                 throw new Error("Malformed format string \"" + param1 + "\" at \"" + param1.substring(_loc8_,_loc6_ + 1) + "\"");
                           }
                           _loc3_ += _loc22_;
                        }
                     }
                     if(_loc4_ == "h")
                     {
                        _loc19_ = true;
                     }
                     else if(_loc4_ == "l")
                     {
                        _loc20_ = true;
                     }
                     else if(_loc4_ == "L")
                     {
                        _loc21_ = true;
                     }
                     _loc4_ = String(param1.charAt(++_loc6_));
                  }
               }
            }
            else
            {
               _loc3_ += _loc4_;
            }
            _loc8_ = ++_loc6_;
         }
         return _loc3_;
      }
      
      private static function pad(param1:String, param2:int, param3:Boolean, param4:String) : String
      {
         var _loc5_:int = int(param1.length);
         if(param3)
         {
            while(_loc5_++ < param2)
            {
               param1 += param4;
            }
         }
         else
         {
            while(_loc5_++ < param2)
            {
               param1 = param4 + param1;
            }
         }
         return param1;
      }
   }
}
