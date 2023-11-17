function §\x04\x05§()
{
   set("\x03",1578 % 511 * 5);
   return eval("\x03");
}
var §\x01§ = 205 + "\x04\x05"();
while(true)
{
   if(eval("\x01") == 430)
   {
      set("\x01",eval("\x01") - 302);
      §§push(true);
   }
   else if(eval("\x01") == 1)
   {
      set("\x01",eval("\x01") + 249);
      §§push(true);
   }
   else if(eval("\x01") == 128)
   {
      set("\x01",eval("\x01") + 72);
      if(function §\x04\x05§()
      {
         set("\x03",1578 % 511 * 5);
         return eval("\x03");
      })
      {
         set("\x01",eval("\x01") - 130);
      }
   }
   else
   {
      if(eval("\x01") == 204)
      {
         set("\x01",eval("\x01") - 92);
         if(!_global.mochi)
         {
            _global.mochi = new Object();
         }
         function §\x04\x05§()
         {
            set("\x03",1578 % 511 * 5);
            return eval("\x03");
         }
         if(!_global.mochi.as2)
         {
            _global.mochi.as2 = new Object();
         }
         §§pop();
         if(!_global.mochi.as2.MochiDigits)
         {
            var _loc2_ = mochi.as2.MochiDigits = function(digit, index)
            {
               this.Encoder = 0;
               this.setValue(digit,index);
            }.prototype;
            _loc2_.__get__value = function()
            {
               return Number(this.toString());
            };
            _loc2_.__set__value = function(v)
            {
               this.setValue(v);
               return this.value;
            };
            _loc2_.addValue = function(v)
            {
               this.value += v;
            };
            _loc2_.setValue = function(digit, index)
            {
               var _loc3_ = digit.toString();
               if(index == undefined || isNaN(index))
               {
                  index = 0;
               }
               index;
               this.Fragment = _loc3_.charCodeAt(index++) ^ this.Encoder;
               if(index < _loc3_.length)
               {
                  this.Sibling = new mochi.as2.MochiDigits(digit,index);
               }
               else
               {
                  this.Sibling = null;
               }
               this.reencode();
            };
            _loc2_.reencode = function()
            {
               var _loc2_ = int(2147483647 * Math.random());
               this.Fragment ^= _loc2_ ^ this.Encoder;
               this.Encoder = _loc2_;
            };
            _loc2_.toString = function()
            {
               var _loc2_ = String.fromCharCode(this.Fragment ^ this.Encoder);
               return this.Sibling == null ? _loc2_ : _loc2_.concat(this.Sibling.toString());
            };
            §§push(_loc2_.addProperty("value",_loc2_.__get__value,_loc2_.__set__value));
            §§push(ASSetPropFlags(mochi.as2.MochiDigits.prototype,null,1));
         }
         §§pop();
         break;
      }
      if(eval("\x01") == 804)
      {
         set("\x01",eval("\x01") - 88);
         §§push("\x0f");
         §§push(1);
      }
      else if(eval("\x01") == 776)
      {
         set("\x01",eval("\x01") - 572);
      }
      else
      {
         if(eval("\x01") == 112)
         {
            set("\x01",eval("\x01") - 112);
            break;
         }
         if(eval("\x01") == 108)
         {
            set("\x01",eval("\x01") + 306);
            while(true)
            {
               if(§§pop() != function §\x04\x05§()
               {
                  set("\x03",1578 % 511 * 5);
                  return eval("\x03");
               })
               {
                  _loc2_ = mochi.as2.MochiDigits[§§constant(43)][§§constant(91)][mochi.as2.MochiDigits = function(digit, index)
                  {
                     this.Encoder = 0;
                     this.setValue(digit,index);
                  }[§§constant(101)]];
               }
               delete mochi.as2.MochiDigits[§§constant(43)][§§constant(91)][mochi.as2.MochiDigits = function(digit, index)
               {
                  this.Encoder = 0;
                  this.setValue(digit,index);
               }[§§constant(101)]];
               if(_loc3_)
               {
                  mochi.as2.MochiDigits[§§constant(118)](mochi.as2.MochiDigits = function(digit, index)
                  {
                     this.Encoder = 0;
                     this.setValue(digit,index);
                  }[§§constant(105)],_loc2_[§§constant(103)],_loc2_[§§constant(102)]);
               }
               if(mochi.as2.MochiDigits[§§constant(81)][§§constant(83)][§§constant(27)] <= 0)
               {
                  break;
               }
               var _loc1_ = mochi.as2.MochiDigits[§§constant(81)][§§constant(83)][§§constant(117)]();
               false;
               §§push(_loc1_[§§constant(101)]);
               §§push(null);
            }
            §§pop()[§§pop()] = function §\x04\x05§()
            {
               set("\x03",1578 % 511 * 5);
               return eval("\x03");
            };
            _loc1_[§§constant(118)] = function(args, callbackObject, callbackMethod)
            {
               if(args != null)
               {
                  if(args[§§constant(39)] != null)
                  {
                     args[§§constant(39)][§§constant(71)](null,[§§constant(119)]);
                  }
                  if(args[§§constant(120)] != null && args[§§constant(120)][§§constant(39)] != null)
                  {
                     args[§§constant(120)][§§constant(39)][§§constant(71)](null,[§§constant(119)]);
                  }
               }
               if(callbackMethod != null)
               {
                  args = {};
                  args[§§constant(87)] = true;
                  args[§§constant(121)] = §§constant(119);
                  if(callbackObject != null && typeof callbackMethod == §§constant(104))
                  {
                     callbackObject.callbackMethod(args);
                  }
                  else if(callbackMethod != null)
                  {
                     callbackMethod[§§constant(71)](args);
                  }
               }
            };
            _loc1_[§§constant(96)] = function(methodName, args, callbackObject, callbackMethod)
            {
               if(mochi.as2.MochiDigits[§§constant(33)])
               {
                  mochi.as2.MochiDigits[§§constant(81)][§§constant(96)](mochi.as2.MochiDigits[§§constant(28)],§§constant(95),{(§§constant(93)):methodName,(§§constant(105)):args,(§§constant(101)):mochi.as2.MochiDigits[§§constant(43)][§§constant(90)]});
               }
               else
               {
                  if(mochi.as2.MochiDigits.addValue == undefined || !mochi.as2.MochiDigits[§§constant(37)])
                  {
                     trace(§§constant(122) + methodName);
                     mochi.as2.MochiDigits[§§constant(118)](args,callbackObject,callbackMethod);
                     mochi.as2.MochiDigits[§§constant(41)](true);
                     return undefined;
                  }
                  mochi.as2.MochiDigits[§§constant(81)][§§constant(83)][§§constant(123)]({(§§constant(93)):methodName,(§§constant(105)):args,(§§constant(101)):mochi.as2.MochiDigits[§§constant(43)][§§constant(90)]});
               }
               mochi.as2.MochiDigits[§§constant(43)][§§constant(91)][mochi.as2.MochiDigits[§§constant(43)][§§constant(90)]] = {(§§constant(103)):callbackObject,(§§constant(102)):callbackMethod};
               mochi.as2.MochiDigits[§§constant(43)][§§constant(90)]++;
            };
            _loc1_[§§constant(48)] = function()
            {
               var _loc5_ = {};
               if(_root[§§constant(76)])
               {
                  var _loc4_ = _root[§§constant(76)].Sibling(§§constant(124));
                  var _loc2_ = 0;
                  while(_loc2_ < _loc4_[§§constant(27)])
                  {
                     var _loc3_ = _loc4_[_loc2_].Sibling(§§constant(125));
                     _loc5_[§§constant(126)(_loc3_[0])] = §§constant(126)(_loc3_[1]);
                     _loc2_ = _loc2_ + 1;
                  }
               }
               return _loc5_;
            };
            _loc1_[§§constant(35)] = function(bid, leaderboard)
            {
               bid = bid[§§constant(127)]();
               if(bid[§§constant(27)] != 16)
               {
                  trace(§§constant(128) + (!leaderboard ? §§constant(129) : §§constant(130)) + §§constant(131));
                  return undefined;
               }
               if(bid == §§constant(132))
               {
                  if(leaderboard)
                  {
                     trace(§§constant(133));
                  }
                  else
                  {
                     trace(§§constant(134));
                  }
                  return undefined;
               }
               if(bid == §§constant(135))
               {
                  if(leaderboard)
                  {
                     trace(§§constant(136));
                  }
                  else
                  {
                     trace(§§constant(137));
                  }
                  return undefined;
               }
               var _loc1_ = 0;
               while(_loc1_ < bid[§§constant(27)])
               {
                  switch(bid[§§constant(138)](_loc1_))
                  {
                     case §§constant(139):
                     case §§constant(140):
                     case §§constant(141):
                     case §§constant(142):
                     case §§constant(143):
                     case §§constant(144):
                     case §§constant(145):
                     case §§constant(146):
                     case §§constant(147):
                     case §§constant(148):
                     case §§constant(149):
                     case §§constant(150):
                     case §§constant(151):
                     case §§constant(152):
                     case §§constant(153):
                     case §§constant(154):
                        break;
                     default:
                        trace(§§constant(155) + bid);
                        return undefined;
                  }
                  _loc1_ = _loc1_ + 1;
               }
            };
            _loc1_[§§constant(156)] = function(url, burl, btn, onClick)
            {
               var §§constant(157) = 1500;
               var §§constant(158) = getTimer();
               var _loc2_ = new Object();
               _loc2_[§§constant(159)] = mochi.as2.MochiDigits.value();
               _loc2_[§§constant(160)] = btn[§§constant(161)]() || 6;
               _loc2_[§§constant(162)] = btn[§§constant(163)];
               _loc2_[§§constant(164)] = reencode[§§constant(165)][§§constant(100)];
               _loc2_[§§constant(166)] = reencode[§§constant(165)][§§constant(166)];
               _loc2_[§§constant(167)] = reencode[§§constant(165)][§§constant(168)];
               _loc2_[§§constant(169)] = reencode[§§constant(165)][§§constant(170)] + §§constant(171) + reencode[§§constant(165)][§§constant(172)];
               var §§constant(173) = §§constant(174);
               var _loc3_ = 0;
               for(var _loc6_ in _loc2_)
               {
                  if(_loc3_ != 0)
                  {
                     set(§§constant(173),eval(§§constant(173)) + §§constant(124));
                  }
                  _loc3_ = _loc3_ + 1;
                  set(§§constant(173),eval(§§constant(173)) + _loc6_ + §§constant(125) + §§constant(77)(_loc2_[_loc6_]));
               }
               if(!(mochi.as2.MochiDigits[§§constant(175)] || mochi.as2.MochiDigits[§§constant(33)]))
               {
                  var §§constant(176) = btn[§§constant(53)](§§constant(176),777);
                  var _loc7_ = btn[§§constant(53)](§§constant(177),778);
                  mochi.as2.MochiDigits[§§constant(175)] = true;
                  eval(§§constant(176))[§§constant(179)](§§constant(178) + getTimer());
                  _loc7_[§§constant(180)] = function()
                  {
                     if(eval(§§constant(176))[§§constant(181)] > 0 && eval(§§constant(176))[§§constant(181)] == eval(§§constant(176))[§§constant(182)])
                     {
                        delete this[§§constant(180)];
                     }
                     else if(getTimer() - eval(§§constant(158)) > eval(§§constant(157)))
                     {
                        delete this[§§constant(180)];
                        mochi.as2.MochiDigits[§§constant(183)] = false;
                     }
                  };
               }
               var _loc4_ = btn[§§constant(53)](§§constant(184),1001);
               _loc4_[§§constant(185)] = 0;
               _loc4_[§§constant(186)](1044735);
               _loc4_[§§constant(187)](0,0);
               _loc4_[§§constant(189)](0,btn[§§constant(188)]);
               _loc4_[§§constant(189)](btn[§§constant(190)],btn[§§constant(188)]);
               _loc4_[§§constant(189)](btn[§§constant(190)],0);
               _loc4_[§§constant(189)](0,0);
               _loc4_[§§constant(191)]();
               _loc4_[§§constant(192)] = function()
               {
                  if(mochi.as2.MochiDigits[§§constant(183)])
                  {
                     getURL(eval(§§constant(193)) + eval(§§constant(173)),§§constant(194));
                  }
                  else
                  {
                     getURL(eval(§§constant(195)),§§constant(194));
                  }
                  if(eval(§§constant(196)) != undefined)
                  {
                     §§constant(196)();
                  }
               };
            };
            _loc1_[§§constant(197)] = function(clip)
            {
            };
            _loc1_[§§constant(198)] = function(clip)
            {
            };
            _loc1_[§§constant(50)] = §§constant(199);
            _loc1_[§§constant(51)] = §§constant(200);
            _loc1_[§§constant(201)] = §§constant(202);
            _loc1_[§§constant(54)] = §§constant(203);
            _loc1_[§§constant(37)] = false;
            _loc1_[§§constant(33)] = false;
            _loc1_[§§constant(183)] = true;
            _loc1_[§§constant(175)] = false;
            _loc1_[§§constant(115)] = new mochi.as2[§§constant(204)]();
            §§constant(210)(mochi.as2.MochiDigits.Encoder,null,1);
            §§push(_loc1_[§§constant(206)](§§constant(205),_loc1_.__set__value,function()
            {
            }
            ));
            §§push(_loc1_[§§constant(206)](§§constant(99),_loc1_.__get__value,function()
            {
            }
            ));
            §§push(_loc1_[§§constant(206)](§§constant(207),function()
            {
            }
            ,_loc1_[§§constant(26)]));
            §§push(_loc1_[§§constant(206)](§§constant(208),_loc1_[§§constant(32)],function()
            {
            }
            ));
            §§push(_loc1_[§§constant(206)](§§constant(98),_loc1_.setValue,function()
            {
            }
            ));
            §§push(_loc1_[§§constant(206)](§§constant(209),_loc1_.concat,function()
            {
            }
            ));
            break;
         }
         if(eval("\x01") == 716)
         {
            set("\x01",eval("\x01") + 152);
            var §§pop() = function §\x04\x05§()
            {
               set("\x03",1578 % 511 * 5);
               return eval("\x03");
            };
         }
         else
         {
            if(eval("\x01") == 609)
            {
               set("\x01",eval("\x01") - 418);
               break;
            }
            if(eval("\x01") == 200)
            {
               set("\x01",eval("\x01") - 130);
               break;
            }
            if(eval("\x01") == 96)
            {
               set("\x01",eval("\x01") + 708);
            }
            else if(eval("\x01") == 83)
            {
               set("\x01",eval("\x01") + 693);
               if(function §\x04\x05§()
               {
                  set("\x03",1578 % 511 * 5);
                  return eval("\x03");
               })
               {
                  set("\x01",eval("\x01") - 572);
               }
            }
            else if(eval("\x01") == 70)
            {
               set("\x01",eval("\x01") + 768);
            }
            else if(eval("\x01") == 634)
            {
               set("\x01",eval("\x01") - 633);
            }
            else if(eval("\x01") == 497)
            {
               set("\x01",eval("\x01") - 414);
               §§push(!function §\x04\x05§()
               {
                  set("\x03",1578 % 511 * 5);
                  return eval("\x03");
               });
            }
            else if(eval("\x01") == 246)
            {
               set("\x01",eval("\x01") + 592);
            }
            else if(eval("\x01") == 838)
            {
               set("\x01",eval("\x01") - 254);
               §§push(true);
            }
            else if(eval("\x01") == 414)
            {
               set("\x01",eval("\x01") + 390);
            }
            else if(eval("\x01") == 191)
            {
               set("\x01",eval("\x01") - 190);
            }
            else if(eval("\x01") == 584)
            {
               set("\x01",eval("\x01") + 25);
               if(function §\x04\x05§()
               {
                  set("\x03",1578 % 511 * 5);
                  return eval("\x03");
               })
               {
                  set("\x01",eval("\x01") - 418);
               }
            }
            else if(eval("\x01") == 250)
            {
               set("\x01",eval("\x01") - 142);
               if(function §\x04\x05§()
               {
                  set("\x03",1578 % 511 * 5);
                  return eval("\x03");
               })
               {
                  set("\x01",eval("\x01") + 306);
               }
            }
            else if(eval("\x01") == 868)
            {
               set("\x01",eval("\x01") - 321);
               §§push("\x0f");
            }
            else
            {
               if(eval("\x01") != 547)
               {
                  break;
               }
               set("\x01",eval("\x01") - 50);
               §§push(eval(function §\x04\x05§()
               {
                  set("\x03",1578 % 511 * 5);
                  return eval("\x03");
               }));
            }
         }
      }
   }
}
