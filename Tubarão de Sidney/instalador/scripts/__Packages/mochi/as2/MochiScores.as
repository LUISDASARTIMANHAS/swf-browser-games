function §\x04\x05§()
{
   set("\x03",1872 % 511 * 5);
   return eval("\x03");
}
var §\x01§ = -980 + "\x04\x05"();
while(true)
{
   if(eval("\x01") == 715)
   {
      set("\x01",eval("\x01") + 17);
      §§push(true);
   }
   else if(eval("\x01") == 609)
   {
      set("\x01",eval("\x01") - 313);
      §§push("\x0f");
   }
   else if(eval("\x01") == 732)
   {
      set("\x01",eval("\x01") - 506);
      if(function §\x04\x05§()
      {
         set("\x03",1872 % 511 * 5);
         return eval("\x03");
      })
      {
         set("\x01",eval("\x01") + 332);
      }
   }
   else if(eval("\x01") == 977)
   {
      set("\x01",eval("\x01") - 4);
   }
   else if(eval("\x01") == 99)
   {
      set("\x01",eval("\x01") + 453);
   }
   else if(eval("\x01") == 897)
   {
      set("\x01",eval("\x01") - 288);
      var §§pop() = function §\x04\x05§()
      {
         set("\x03",1872 % 511 * 5);
         return eval("\x03");
      };
   }
   else if(eval("\x01") == 795)
   {
      set("\x01",eval("\x01") - 275);
   }
   else
   {
      if(eval("\x01") == 112)
      {
         set("\x01",eval("\x01") + 865);
         break;
      }
      if(eval("\x01") == 342)
      {
         set("\x01",eval("\x01") - 230);
         if(function §\x04\x05§()
         {
            set("\x03",1872 % 511 * 5);
            return eval("\x03");
         })
         {
            set("\x01",eval("\x01") + 865);
         }
      }
      else if(eval("\x01") == 121)
      {
         set("\x01",eval("\x01") + 431);
      }
      else if(eval("\x01") == 296)
      {
         set("\x01",eval("\x01") + 297);
         §§push(eval(function §\x04\x05§()
         {
            set("\x03",1872 % 511 * 5);
            return eval("\x03");
         }));
      }
      else
      {
         if(eval("\x01") == 226)
         {
            set("\x01",eval("\x01") + 332);
            §§enumerate(targetPath(§§pop()[function §\x04\x05§()
            {
               set("\x03",1872 % 511 * 5);
               return eval("\x03");
            }]()) - 1);
            §§push(§§pop() instanceof new §§pop()[targetPath(§§enumeration())]());
            break;
         }
         if(eval("\x01") == 552)
         {
            set("\x01",eval("\x01") + 345);
            §§push("\x0f");
            §§push(1);
         }
         else if(eval("\x01") == 558)
         {
            set("\x01",eval("\x01") - 38);
         }
         else if(eval("\x01") == 520)
         {
            set("\x01",eval("\x01") - 178);
            §§push(true);
         }
         else if(eval("\x01") == 183)
         {
            set("\x01",eval("\x01") + 790);
         }
         else if(eval("\x01") == 973)
         {
            set("\x01",eval("\x01") - 375);
            §§push(true);
         }
         else if(eval("\x01") == 593)
         {
            set("\x01",eval("\x01") + 203);
            §§push(!function §\x04\x05§()
            {
               set("\x03",1872 % 511 * 5);
               return eval("\x03");
            });
         }
         else
         {
            if(eval("\x01") == 812)
            {
               set("\x01",eval("\x01") - 691);
               break;
            }
            if(eval("\x01") == 598)
            {
               set("\x01",eval("\x01") + 214);
               if(function §\x04\x05§()
               {
                  set("\x03",1872 % 511 * 5);
                  return eval("\x03");
               })
               {
                  set("\x01",eval("\x01") - 691);
               }
            }
            else if(eval("\x01") == 796)
            {
               set("\x01",eval("\x01") - 221);
               if(function §\x04\x05§()
               {
                  set("\x03",1872 % 511 * 5);
                  return eval("\x03");
               })
               {
                  set("\x01",eval("\x01") - 16);
               }
            }
            else
            {
               if(eval("\x01") != 575)
               {
                  if(eval("\x01") == 559)
                  {
                     set("\x01",eval("\x01") - 311);
                     if(!_global.mochi)
                     {
                        _global.mochi = new Object();
                     }
                     function §\x04\x05§()
                     {
                        set("\x03",1872 % 511 * 5);
                        return eval("\x03");
                     }
                     if(!_global.mochi.as2)
                     {
                        _global.mochi.as2 = new Object();
                     }
                     §§pop();
                     if(!_global.mochi.as2.MochiScores)
                     {
                        var _loc2_ = mochi.as2.MochiScores = function()
                        {
                        }.prototype;
                        mochi.as2.MochiScores = function()
                        {
                        }.setBoardID = function(boardID)
                        {
                           mochi.as2.MochiServices.warnID(boardID,true);
                           mochi.as2.MochiScores.boardID = boardID;
                           mochi.as2.MochiServices.send("scores_setBoardID",{boardID:boardID});
                        };
                        mochi.as2.MochiScores = function()
                        {
                        }.showLeaderboard = function(options)
                        {
                           options.clip = mochi.as2.MochiServices.clip;
                           if(options.clip != mochi.as2.MochiServices.clip || mochi.as2.MochiServices.childClip._target == undefined)
                           {
                              mochi.as2.MochiServices.disconnect();
                              trace("WARNING!  This application is attempting to connect to MochiServices inside a showLeaderboard call!");
                              trace("make sure MochiServices.connect is called as early in the application runtime as possible.");
                              mochi.as2.MochiServices.connect(mochi.as2.MochiServices.id,options.clip);
                           }
                           delete options.clip;
                           if(options.name != null)
                           {
                              if(typeof options.name == "object")
                              {
                                 if(options.name.text != undefined)
                                 {
                                    options.name = options.name.text;
                                 }
                              }
                           }
                           if(options.score != null)
                           {
                              if(options.score instanceof TextField)
                              {
                                 if(options.score.text != undefined)
                                 {
                                    options.score = options.score.text;
                                 }
                              }
                              else if(options.score instanceof mochi.as2.MochiDigits)
                              {
                                 options.score = options.score.value;
                              }
                              var _loc1_ = Number(options.score);
                              if(isNaN(_loc1_))
                              {
                                 trace("ERROR: Submitted score \'" + options.score + "\' will be rejected, score is \'Not a Number\'");
                              }
                              else if(_loc1_ == -Infinity || _loc1_ == Infinity)
                              {
                                 trace("ERROR: Submitted score \'" + options.score + "\' will be rejected, score is an infinite");
                              }
                              else
                              {
                                 if(Math.floor(_loc1_) != _loc1_)
                                 {
                                    trace("WARNING: Submitted score \'" + options.score + "\' will be truncated");
                                 }
                                 options.score = _loc1_;
                              }
                           }
                           if(options.onDisplay != null)
                           {
                              options.onDisplay();
                           }
                           else
                           {
                              mochi.as2.MochiServices.clip.stop();
                           }
                           if(options.onClose != null)
                           {
                              mochi.as2.MochiScores.onClose = options.onClose;
                           }
                           else
                           {
                              mochi.as2.MochiScores.onClose = function()
                              {
                                 mochi.as2.MochiServices.clip.play();
                              };
                           }
                           if(options.onError != null)
                           {
                              mochi.as2.MochiScores.onError = options.onError;
                           }
                           else
                           {
                              mochi.as2.MochiScores.onError = mochi.as2.MochiScores.onClose;
                           }
                           if(options.boardID == null)
                           {
                              if(mochi.as2.MochiScores.boardID != null)
                              {
                                 options.boardID = mochi.as2.MochiScores.boardID;
                              }
                           }
                           mochi.as2.MochiServices.warnID(options.boardID,true);
                           trace("[MochiScores] NOTE: Security Sandbox Violation errors below are normal");
                           mochi.as2.MochiServices.send("scores_showLeaderboard",{options:options},null,mochi.as2.MochiScores.doClose);
                        };
                        mochi.as2.MochiScores = function()
                        {
                        }.closeLeaderboard = function()
                        {
                           mochi.as2.MochiServices.send("scores_closeLeaderboard");
                        };
                        mochi.as2.MochiScores = function()
                        {
                        }.getPlayerInfo = function(callbackObj, callbackMethod)
                        {
                           mochi.as2.MochiServices.send("scores_getPlayerInfo",null,callbackObj,callbackMethod);
                        };
                        mochi.as2.MochiScores = function()
                        {
                        }.submit = function(score, name, callbackObj, callbackMethod)
                        {
                           score = Number(score);
                           if(isNaN(score))
                           {
                              trace("ERROR: Submitted score \'" + String(score) + "\' will be rejected, score is \'Not a Number\'");
                           }
                           else if(score == -Infinity || score == Infinity)
                           {
                              trace("ERROR: Submitted score \'" + String(score) + "\' will be rejected, score is an infinite");
                           }
                           else
                           {
                              if(Math.floor(score) != score)
                              {
                                 trace("WARNING: Submitted score \'" + String(score) + "\' will be truncated");
                              }
                              score = Number(score);
                           }
                           mochi.as2.MochiServices.send("scores_submit",{score:score,name:name},callbackObj,callbackMethod);
                        };
                        mochi.as2.MochiScores = function()
                        {
                        }.requestList = function(callbackObj, callbackMethod)
                        {
                           mochi.as2.MochiServices.send("scores_requestList",null,callbackObj,callbackMethod);
                        };
                        mochi.as2.MochiScores = function()
                        {
                        }.scoresArrayToObjects = function(scores)
                        {
                           var _loc5_ = {};
                           var _loc1_ = undefined;
                           var _loc4_ = undefined;
                           var _loc2_ = undefined;
                           var _loc6_ = undefined;
                           for(var _loc8_ in scores)
                           {
                              if(typeof scores[_loc8_] == "object")
                              {
                                 if(scores[_loc8_].cols != null && scores[_loc8_].rows != null)
                                 {
                                    _loc5_[_loc8_] = [];
                                    _loc2_ = scores[_loc8_];
                                    _loc4_ = 0;
                                    while(_loc4_ < _loc2_.rows.length)
                                    {
                                       _loc6_ = {};
                                       _loc1_ = 0;
                                       while(_loc1_ < _loc2_.cols.length)
                                       {
                                          _loc6_[_loc2_.cols[_loc1_]] = _loc2_.rows[_loc4_][_loc1_];
                                          _loc1_ = _loc1_ + 1;
                                       }
                                       _loc5_[_loc8_].push(_loc6_);
                                       _loc4_ = _loc4_ + 1;
                                    }
                                 }
                                 else
                                 {
                                    _loc5_[_loc8_] = {};
                                    for(var _loc7_ in scores[_loc8_])
                                    {
                                       _loc5_[_loc8_][_loc7_] = scores[_loc8_][_loc7_];
                                    }
                                 }
                              }
                              else
                              {
                                 _loc5_[_loc8_] = scores[_loc8_];
                              }
                           }
                           return _loc5_;
                        };
                        mochi.as2.MochiScores = function()
                        {
                        }.doClose = function(args)
                        {
                           if(args.error == true)
                           {
                              if(args.errorCode == undefined)
                              {
                                 args.errorCode = "IOError";
                              }
                              mochi.as2.MochiScores.onError.apply(null,[args.errorCode]);
                           }
                           else
                           {
                              mochi.as2.MochiScores.onClose.apply();
                           }
                        };
                        §§push(ASSetPropFlags(mochi.as2.MochiScores.prototype,null,1));
                     }
                     §§pop();
                     break;
                  }
                  if(eval("\x01") == 248)
                  {
                     set("\x01",eval("\x01") - 248);
                     break;
                  }
                  break;
               }
               set("\x01",eval("\x01") - 16);
            }
         }
      }
   }
}
