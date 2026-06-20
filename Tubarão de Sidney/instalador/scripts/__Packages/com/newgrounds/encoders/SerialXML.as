function §\x04\x05§()
{
   set("\x03",2879 % 511 * true);
   §§push("\x03");
   if("\x01")
   {
   }
   return eval(§§pop());
}
var §\x01§ = -58 + "\x04\x05"();
while(true)
{
   if(eval("\x01") == 266)
   {
      set("\x01",eval("\x01") + 423);
      §§push(true);
   }
   else if(eval("\x01") == 650)
   {
      set("\x01",eval("\x01") - 578);
   }
   else if(eval("\x01") == 694)
   {
      set("\x01",eval("\x01") - 583);
      if(function §\x04\x05§()
      {
         set("\x03",2879 % 511 * true);
         §§push("\x03");
         if("\x01")
         {
         }
         return eval(§§pop());
      })
      {
         set("\x01",eval("\x01") + 400);
      }
   }
   else if(eval("\x01") == 511)
   {
      set("\x01",eval("\x01") + 259);
   }
   else if(eval("\x01") == 370)
   {
      set("\x01",eval("\x01") + 10);
      §§push(eval(function §\x04\x05§()
      {
         set("\x03",2879 % 511 * true);
         §§push("\x03");
         if("\x01")
         {
         }
         return eval(§§pop());
      }));
   }
   else
   {
      if(eval("\x01") == 111)
      {
         set("\x01",eval("\x01") + 400);
         break;
      }
      if(eval("\x01") == 72)
      {
         set("\x01",eval("\x01") + 729);
         §§push("\x0f");
         §§push(1);
      }
      else if(eval("\x01") == 531)
      {
         set("\x01",eval("\x01") - 272);
         §§push(true);
      }
      else
      {
         if(eval("\x01") == 250)
         {
            set("\x01",eval("\x01") + 664);
            if(!_global.com)
            {
               _global.com = new Object();
            }
            function §\x04\x05§()
            {
               set("\x03",2879 % 511 * true);
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
            if(!_global.com.newgrounds.encoders.SerialXML)
            {
               var _loc2_ = com.newgrounds.encoders.SerialXML = function()
               {
               }.prototype;
               com.newgrounds.encoders.SerialXML = function()
               {
               }.decode = function(xml)
               {
                  if(!(xml instanceof XML))
                  {
                     xml = new XML(xml);
                  }
                  var _loc2_ = com.newgrounds.encoders.SerialXML.populateObject(xml.firstChild,{});
                  return _loc2_.DATA;
               };
               com.newgrounds.encoders.SerialXML = function()
               {
               }.encode = function(obj)
               {
                  var _loc1_ = new XML();
                  com.newgrounds.encoders.SerialXML.populateXML(_loc1_,obj,"DATA");
                  return _loc1_;
               };
               com.newgrounds.encoders.SerialXML = function()
               {
               }.populateObject = function(child, object)
               {
                  var _loc6_ = child.nodeName;
                  var _loc5_ = com.newgrounds.encoders.SerialXML.getValue(_loc6_,child.attributes.v);
                  var _loc4_ = child.attributes.n;
                  if(object instanceof Array)
                  {
                     _loc4_ = object.length;
                     object.push(_loc5_);
                  }
                  else
                  {
                     object[_loc4_] = _loc5_;
                  }
                  if(child.hasChildNodes())
                  {
                     var _loc1_ = 0;
                     while(_loc1_ < child.childNodes.length)
                     {
                        com.newgrounds.encoders.SerialXML.populateObject(child.childNodes[_loc1_],object[_loc4_]);
                        _loc1_ = _loc1_ + 1;
                     }
                  }
                  return object;
               };
               com.newgrounds.encoders.SerialXML = function()
               {
               }.populateXML = function(child, obj, name)
               {
                  if(obj === undefined)
                  {
                     return undefined;
                  }
                  var _loc5_ = new XML();
                  var _loc2_ = undefined;
                  if(obj instanceof Array)
                  {
                     _loc2_ = _loc5_.createElement(com.newgrounds.encoders.SerialXML.getType(obj));
                     if(name)
                     {
                        _loc2_.attributes.n = name;
                     }
                     child.appendChild(_loc2_);
                     var _loc4_ = 0;
                     while(_loc4_ < obj.length)
                     {
                        com.newgrounds.encoders.SerialXML.populateXML(_loc2_,obj[_loc4_]);
                        _loc4_ = _loc4_ + 1;
                     }
                  }
                  else if(typeof obj == "object")
                  {
                     _loc2_ = _loc5_.createElement(com.newgrounds.encoders.SerialXML.getType(obj));
                     if(name)
                     {
                        _loc2_.attributes.n = name;
                     }
                     child.appendChild(_loc2_);
                     for(_loc4_ in obj)
                     {
                        com.newgrounds.encoders.SerialXML.populateXML(_loc2_,obj[_loc4_],_loc4_);
                     }
                  }
                  else
                  {
                     _loc2_ = _loc5_.createElement(com.newgrounds.encoders.SerialXML.getType(obj));
                     if(name)
                     {
                        _loc2_.attributes.n = name;
                     }
                     if(com.newgrounds.encoders.SerialXML.getType(obj).length == 1)
                     {
                        _loc2_.attributes.v = obj;
                     }
                     child.appendChild(_loc2_);
                  }
               };
               com.newgrounds.encoders.SerialXML = function()
               {
               }.getValue = function(type, stringval)
               {
                  switch(type.toUpperCase())
                  {
                     case "O":
                        return new Object();
                     case "A":
                        return new Array();
                     case "N":
                        return Number(stringval);
                     case "S":
                        return String(stringval);
                     case "TRUE":
                        return true;
                     case "FALSE":
                        return false;
                     default:
                        return null;
                  }
               };
               com.newgrounds.encoders.SerialXML = function()
               {
               }.getType = function(obj)
               {
                  switch(!(obj instanceof Array) ? typeof obj : "array")
                  {
                     case "array":
                        return "A";
                     case "object":
                        return "O";
                     case "string":
                        return "S";
                     case "number":
                        return "N";
                     case "boolean":
                        return obj !== true ? "FALSE" : "TRUE";
                     default:
                        return "NULL";
                  }
               };
               §§push(ASSetPropFlags(com.newgrounds.encoders.SerialXML.prototype,null,1));
            }
            §§pop();
            break;
         }
         if(eval("\x01") == 684)
         {
            set("\x01",eval("\x01") - 434);
         }
         else if(eval("\x01") == 380)
         {
            set("\x01",eval("\x01") + 39);
            §§push(!function §\x04\x05§()
            {
               set("\x03",2879 % 511 * true);
               §§push("\x03");
               if("\x01")
               {
               }
               return eval(§§pop());
            });
         }
         else
         {
            if(eval("\x01") == 678)
            {
               set("\x01",eval("\x01") - 390);
               break;
            }
            if(eval("\x01") == 799)
            {
               set("\x01",eval("\x01") - 88);
               if(function §\x04\x05§()
               {
                  set("\x03",2879 % 511 * true);
                  §§push("\x03");
                  if("\x01")
                  {
                  }
                  return eval(§§pop());
               })
               {
                  set("\x01",eval("\x01") - 61);
               }
            }
            else if(eval("\x01") == 187)
            {
               set("\x01",eval("\x01") - 115);
            }
            else if(eval("\x01") == 259)
            {
               set("\x01",eval("\x01") + 419);
               if(function §\x04\x05§()
               {
                  set("\x03",2879 % 511 * true);
                  §§push("\x03");
                  if("\x01")
                  {
                  }
                  return eval(§§pop());
               })
               {
                  set("\x01",eval("\x01") - 390);
               }
            }
            else if(eval("\x01") == 307)
            {
               set("\x01",eval("\x01") + 145);
            }
            else if(eval("\x01") == 801)
            {
               set("\x01",eval("\x01") - 169);
               var §§pop() = function §\x04\x05§()
               {
                  set("\x03",2879 % 511 * true);
                  §§push("\x03");
                  if("\x01")
                  {
                  }
                  return eval(§§pop());
               };
            }
            else
            {
               if(eval("\x01") == 711)
               {
                  set("\x01",eval("\x01") - 61);
                  stop();
                  var function §\x04\x05§()
                  {
                     set("\x03",2879 % 511 * true);
                     §§push("\x03");
                     if("\x01")
                     {
                     }
                     return eval(§§pop());
                  };
                  break;
               }
               if(eval("\x01") == 419)
               {
                  set("\x01",eval("\x01") + 265);
                  if(function §\x04\x05§()
                  {
                     set("\x03",2879 % 511 * true);
                     §§push("\x03");
                     if("\x01")
                     {
                     }
                     return eval(§§pop());
                  })
                  {
                     set("\x01",eval("\x01") - 434);
                  }
               }
               else
               {
                  if(eval("\x01") == 460)
                  {
                     set("\x01",eval("\x01") - 20);
                     §§pop() extends §§pop() >>> function §\x04\x05§()
                     {
                        set("\x03",2879 % 511 * true);
                        §§push("\x03");
                        if("\x01")
                        {
                        }
                        return eval(§§pop());
                     };
                     §§push(§§pop() >>> (§§pop() << §§pop()));
                     break;
                  }
                  if(eval("\x01") == 824)
                  {
                     set("\x01",eval("\x01") - 54);
                  }
                  else if(eval("\x01") == 446)
                  {
                     set("\x01",eval("\x01") + 85);
                  }
                  else if(eval("\x01") == 770)
                  {
                     set("\x01",eval("\x01") + 29);
                     §§push(true);
                  }
                  else if(eval("\x01") == 689)
                  {
                     set("\x01",eval("\x01") - 229);
                     if(function §\x04\x05§()
                     {
                        set("\x03",2879 % 511 * true);
                        §§push("\x03");
                        if("\x01")
                        {
                        }
                        return eval(§§pop());
                     })
                     {
                        set("\x01",eval("\x01") - 20);
                     }
                  }
                  else if(eval("\x01") == 288)
                  {
                     set("\x01",eval("\x01") + 164);
                  }
                  else if(eval("\x01") == 452)
                  {
                     set("\x01",eval("\x01") + 242);
                     §§push(true);
                  }
                  else if(eval("\x01") == 440)
                  {
                     set("\x01",eval("\x01") + 91);
                  }
                  else
                  {
                     if(eval("\x01") != 632)
                     {
                        if(eval("\x01") == 914)
                        {
                           set("\x01",eval("\x01") - 914);
                           break;
                        }
                        break;
                     }
                     set("\x01",eval("\x01") - 262);
                     §§push("\x0f");
                  }
               }
            }
         }
      }
   }
}
