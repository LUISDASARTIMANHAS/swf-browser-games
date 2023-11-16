package com.greensock.plugins
{
   import com.greensock.*;
   import flash.display.*;
   import flash.geom.ColorTransform;
   
   public class ColorTransformPlugin extends TintPlugin
   {
      
      public static const API:Number = 1;
       
      
      public function ColorTransformPlugin()
      {
         super();
         this.propName = "colorTransform";
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         if(!(param1 is DisplayObject))
         {
            return false;
         }
         var _loc4_:ColorTransform = param1.transform.colorTransform;
         loop0:
         for(_loc5_ in param2)
         {
            if(_loc5_ == "tint" || _loc5_ == "color")
            {
               if(param2[_loc5_] != null)
               {
                  _loc4_.color = int(param2[_loc5_]);
               }
            }
            else
            {
               §§push(_loc5_ == "tintAmount");
               if(!(_loc5_ == "tintAmount"))
               {
                  §§pop();
                  while(true)
                  {
                     §§push(_loc5_ == "exposure");
                  }
                  addr46:
               }
               while(!(§§pop() || _loc5_ == "brightness"))
               {
                  _loc4_[_loc5_] = param2[_loc5_];
                  if(false)
                  {
                     §§goto(addr46);
                     continue;
                  }
                  continue loop0;
               }
            }
         }
         if(!isNaN(param2.tintAmount))
         {
            _loc6_ = param2.tintAmount / (1 - (_loc4_.redMultiplier + _loc4_.greenMultiplier + _loc4_.blueMultiplier) / 3);
            _loc4_.redOffset *= _loc6_;
            do
            {
               _loc4_.greenOffset *= _loc6_;
               _loc4_.blueOffset *= _loc6_;
            }
            while(false);
            
            _loc4_.redMultiplier = _loc4_.greenMultiplier = _loc4_.blueMultiplier = 1 - param2.tintAmount;
         }
         else if(!isNaN(param2.exposure))
         {
            _loc4_.redOffset = _loc4_.greenOffset = _loc4_.blueOffset = 255 * (param2.exposure - 1);
            _loc4_.redMultiplier = _loc4_.greenMultiplier = _loc4_.blueMultiplier = 1;
         }
         else if(!isNaN(param2.brightness))
         {
            _loc4_.redOffset = _loc4_.greenOffset = _loc4_.blueOffset = Math.max(0,(param2.brightness - 1) * 255);
            _loc4_.redMultiplier = _loc4_.greenMultiplier = _loc4_.blueMultiplier = 1 - Math.abs(param2.brightness - 1);
         }
         _ignoreAlpha = Boolean(param3.vars.alpha != undefined && param2.alphaMultiplier == undefined);
         init(param1 as DisplayObject,_loc4_);
         return true;
      }
   }
}
