function §\x04\x05§()
{
   set("\x03",423 % 511 * true);
   §§push("\x03");
   if("\x01")
   {
   }
   return eval(§§pop());
}
var §\x01§ = 264 + "\x04\x05"();
while(true)
{
   if(eval("\x01") == 687)
   {
      set("\x01",eval("\x01") - 521);
      §§push(true);
   }
   else if(eval("\x01") == 239)
   {
      set("\x01",eval("\x01") - 183);
   }
   else if(eval("\x01") == 166)
   {
      set("\x01",eval("\x01") - 96);
      if(function §\x04\x05§()
      {
         set("\x03",423 % 511 * true);
         §§push("\x03");
         if("\x01")
         {
         }
         return eval(§§pop());
      })
      {
         set("\x01",eval("\x01") + 343);
      }
   }
   else if(eval("\x01") == 154)
   {
      set("\x01",eval("\x01") - 30);
      if(function §\x04\x05§()
      {
         set("\x03",423 % 511 * true);
         §§push("\x03");
         if("\x01")
         {
         }
         return eval(§§pop());
      })
      {
         set("\x01",eval("\x01") + 21);
      }
   }
   else if(eval("\x01") == 28)
   {
      set("\x01",eval("\x01") + 239);
      §§push(true);
   }
   else if(eval("\x01") == 291)
   {
      set("\x01",eval("\x01") - 52);
      if(function §\x04\x05§()
      {
         set("\x03",423 % 511 * true);
         §§push("\x03");
         if("\x01")
         {
         }
         return eval(§§pop());
      })
      {
         set("\x01",eval("\x01") - 183);
      }
   }
   else
   {
      if(eval("\x01") == 56)
      {
         set("\x01",eval("\x01") + 165);
         if(!_global.com)
         {
            _global.com = new Object();
         }
         function §\x04\x05§()
         {
            set("\x03",423 % 511 * true);
            §§push("\x03");
            if("\x01")
            {
            }
            return eval(§§pop());
         }
         if(!_global.com.newgrounds)
         {
            _global.com.newgrounds = new Object();
         }
         §§pop();
         if(!_global.com.newgrounds.encoders)
         {
            _global.com.newgrounds.encoders = new Object();
         }
         §§pop();
         if(!_global.com.newgrounds.encoders.LZW)
         {
            var _loc2_ = com.newgrounds.encoders.LZW = function()
            {
            }.prototype;
            com.newgrounds.encoders.LZW = function()
            {
            }.setXMLSafe = function(x)
            {
               com.newgrounds.encoders.LZW.xmlsafe = x;
            };
            com.newgrounds.encoders.LZW = function()
            {
            }.compress = function(str, escape_chars)
            {
               var _loc2_ = new Array();
               var _loc11_ = !com.newgrounds.encoders.LZW.xmlsafe ? 0 : 5;
               var _loc5_ = 0;
               while(_loc5_ < 256)
               {
                  _loc2_[String.fromCharCode(_loc5_)] = _loc5_;
                  _loc5_ = _loc5_ + 1;
               }
               if(com.newgrounds.encoders.LZW.xmlsafe)
               {
                  _loc2_["<"] = 256;
                  _loc2_[">"] = 257;
                  _loc2_["&"] = 258;
                  _loc2_["\""] = 259;
                  _loc2_["\'"] = 260;
               }
               var _loc7_ = "";
               var _loc8_ = str.split("");
               var _loc9_ = _loc8_.length;
               var _loc6_ = 256 + _loc11_;
               var _loc1_ = "";
               var _loc4_ = undefined;
               _loc5_ = 0;
               while(_loc5_ <= _loc9_)
               {
                  var _loc3_ = _loc8_[_loc5_];
                  if(_loc2_[_loc1_ + _loc3_] !== undefined)
                  {
                     _loc1_ += _loc3_;
                  }
                  else
                  {
                     _loc4_ = String.fromCharCode(_loc2_[_loc1_]);
                     if(escape_chars and (_loc2_[_loc1_] < 33 or _loc2_[_loc1_] > 126 or _loc4_ == "%"))
                     {
                        _loc4_ = escape(_loc4_);
                     }
                     _loc7_ += _loc4_;
                     _loc2_[_loc1_ + _loc3_] = _loc6_;
                     _loc6_ = _loc6_ + 1;
                     _loc1_ = _loc3_;
                  }
                  _loc5_ = _loc5_ + 1;
               }
               return _loc7_;
            };
            com.newgrounds.encoders.LZW = function()
            {
            }.decompress = function(str)
            {
               var _loc4_ = new Array();
               var _loc10_ = !com.newgrounds.encoders.LZW.xmlsafe ? 0 : 5;
               var _loc6_ = 0;
               while(_loc6_ < 256)
               {
                  var _loc9_ = String.fromCharCode(_loc6_);
                  _loc4_[_loc6_] = _loc9_;
                  _loc6_ = _loc6_ + 1;
               }
               if(com.newgrounds.encoders.LZW.xmlsafe)
               {
                  _loc4_[256] = "<";
                  _loc4_[257] = ">";
                  _loc4_[258] = "&";
                  _loc4_[259] = "\"";
                  _loc4_[260] = "\'";
               }
               var _loc11_ = str;
               var _loc13_ = _loc11_.split("");
               var _loc12_ = _loc13_.length;
               var _loc7_ = 256 + _loc10_;
               var _loc1_ = "";
               var _loc2_ = "";
               var _loc8_ = "";
               _loc6_ = 0;
               while(_loc6_ < _loc12_)
               {
                  var _loc5_ = _loc11_.charCodeAt(_loc6_);
                  var _loc3_ = _loc4_[_loc5_];
                  if(_loc1_ == "")
                  {
                     _loc1_ = _loc3_;
                     _loc8_ += _loc3_;
                  }
                  else if(_loc5_ <= 255 + _loc10_)
                  {
                     _loc8_ += _loc3_;
                     _loc2_ = _loc1_ + _loc3_;
                     _loc4_[_loc7_] = _loc2_;
                     _loc7_ = _loc7_ + 1;
                     _loc1_ = _loc3_;
                  }
                  else
                  {
                     _loc2_ = _loc4_[_loc5_];
                     if(_loc2_ == undefined)
                     {
                        _loc2_ = _loc1_ + _loc1_.slice(0,1);
                     }
                     _loc8_ += _loc2_;
                     _loc4_[_loc7_] = _loc1_ + _loc2_.slice(0,1);
                     _loc7_ = _loc7_ + 1;
                     _loc1_ = _loc2_;
                  }
                  _loc6_ = _loc6_ + 1;
               }
               return _loc8_;
            };
            com.newgrounds.encoders.LZW = function()
            {
            }.compress_fp6 = function(str)
            {
               var _loc3_ = new Array();
               var _loc10_ = !com.newgrounds.encoders.LZW.xmlsafe ? 0 : 5;
               var _loc4_ = 0;
               while(_loc4_ < 256)
               {
                  _loc3_[String(_loc4_)] = _loc4_;
                  _loc4_ = _loc4_ + 1;
               }
               if(com.newgrounds.encoders.LZW.xmlsafe)
               {
                  var _loc14_ = String(new String("<").charCodeAt(0));
                  var _loc11_ = String(new String(">").charCodeAt(0));
                  var _loc13_ = String(new String("&").charCodeAt(0));
                  var _loc15_ = String(new String("\"").charCodeAt(0));
                  var _loc12_ = String(new String("\'").charCodeAt(0));
                  _loc3_[_loc14_] = 256;
                  _loc3_[_loc11_] = 257;
                  _loc3_[_loc13_] = 258;
                  _loc3_[_loc15_] = 259;
                  _loc3_[_loc12_] = 260;
               }
               var _loc7_ = "";
               var _loc16_ = str;
               var _loc8_ = _loc16_.split("");
               var _loc9_ = _loc8_.length;
               var _loc6_ = 256 + _loc10_;
               var _loc1_ = new Array();
               _loc4_ = 0;
               while(_loc4_ <= _loc9_)
               {
                  var _loc2_ = _loc8_[_loc4_];
                  if(_loc1_.length == 0)
                  {
                     var _loc5_ = String(_loc2_.charCodeAt(0));
                  }
                  else
                  {
                     _loc5_ = _loc1_.join("-") + "-" + String(_loc2_.charCodeAt(0));
                  }
                  if(_loc3_[_loc5_] !== undefined)
                  {
                     _loc1_.push(_loc2_.charCodeAt(0));
                  }
                  else
                  {
                     _loc7_ += String.fromCharCode(_loc3_[_loc1_.join("-")]);
                     _loc3_[_loc5_] = _loc6_;
                     _loc6_ = _loc6_ + 1;
                     false;
                     _loc1_ = new Array();
                     _loc1_.push(_loc2_.charCodeAt(0));
                  }
                  _loc4_ = _loc4_ + 1;
               }
               return _loc7_;
            };
            com.newgrounds.encoders.LZW = function()
            {
            }.xmlsafe = false;
            §§push(ASSetPropFlags(com.newgrounds.encoders.LZW.prototype,null,1));
         }
         §§pop();
         break;
      }
      if(eval("\x01") == 755)
      {
         set("\x01",eval("\x01") - 601);
         §§push(true);
      }
      else if(eval("\x01") == 823)
      {
         set("\x01",eval("\x01") - 666);
         §§push("\x0f");
      }
      else
      {
         if(eval("\x01") == 70)
         {
            set("\x01",eval("\x01") + 343);
            break;
         }
         if(eval("\x01") == 962)
         {
            set("\x01",eval("\x01") - 139);
            var §§pop() = function §\x04\x05§()
            {
               set("\x03",423 % 511 * true);
               §§push("\x03");
               if("\x01")
               {
               }
               return eval(§§pop());
            };
         }
         else if(eval("\x01") == 776)
         {
            set("\x01",eval("\x01") - 589);
         }
         else if(eval("\x01") == 187)
         {
            set("\x01",eval("\x01") + 775);
            §§push("\x0f");
            §§push(1);
         }
         else
         {
            if(eval("\x01") == 124)
            {
               set("\x01",eval("\x01") + 21);
               set(§§pop(),§§pop() - function §\x04\x05§()
               {
                  set("\x03",423 % 511 * true);
                  §§push("\x03");
                  if("\x01")
                  {
                  }
                  return eval(§§pop());
               });
               break;
            }
            if(eval("\x01") == 732)
            {
               set("\x01",eval("\x01") + 23);
            }
            else if(eval("\x01") == 413)
            {
               set("\x01",eval("\x01") - 385);
            }
            else if(eval("\x01") == 554)
            {
               set("\x01",eval("\x01") + 201);
            }
            else if(eval("\x01") == 157)
            {
               set("\x01",eval("\x01") + 712);
               §§push(eval(function §\x04\x05§()
               {
                  set("\x03",423 % 511 * true);
                  §§push("\x03");
                  if("\x01")
                  {
                  }
                  return eval(§§pop());
               }));
            }
            else if(eval("\x01") == 860)
            {
               set("\x01",eval("\x01") - 832);
            }
            else if(eval("\x01") == 267)
            {
               set("\x01",eval("\x01") + 2);
               if(function §\x04\x05§()
               {
                  set("\x03",423 % 511 * true);
                  §§push("\x03");
                  if("\x01")
                  {
                  }
                  return eval(§§pop());
               })
               {
                  set("\x01",eval("\x01") + 463);
               }
            }
            else if(eval("\x01") == 145)
            {
               set("\x01",eval("\x01") + 42);
            }
            else
            {
               if(eval("\x01") != 869)
               {
                  if(eval("\x01") == 221)
                  {
                     set("\x01",eval("\x01") - 221);
                     break;
                  }
                  if(eval("\x01") == 269)
                  {
                     set("\x01",eval("\x01") + 463);
                     prevFrame();
                     break;
                  }
                  break;
               }
               set("\x01",eval("\x01") - 578);
               §§push(!function §\x04\x05§()
               {
                  set("\x03",423 % 511 * true);
                  §§push("\x03");
                  if("\x01")
                  {
                  }
                  return eval(§§pop());
               });
            }
         }
      }
   }
}
