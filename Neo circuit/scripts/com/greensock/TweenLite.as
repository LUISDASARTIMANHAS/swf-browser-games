package com.greensock
{
   import com.greensock.core.*;
   import com.greensock.plugins.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TweenLite extends TweenCore
   {
      
      public static const version:Number = 11.39;
      
      public static var plugins:Object = {};
      
      public static var fastEaseLookup:Dictionary = new Dictionary(false);
      
      public static var onPluginEvent:Function;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      public static var defaultEase:Function = TweenLite.easeOut;
      
      public static var overwriteManager:Object;
      
      public static var rootFrame:Number;
      
      public static var rootTimeline:SimpleTimeline;
      
      public static var rootFramesTimeline:SimpleTimeline;
      
      public static var masterList:Dictionary = new Dictionary(false);
      
      private static var _shape:Shape = new Shape();
      
      protected static var _reservedProps:Object = {
         "ease":1,
         "delay":1,
         "overwrite":1,
         "onComplete":1,
         "onCompleteParams":1,
         "useFrames":1,
         "runBackwards":1,
         "startAt":1,
         "onUpdate":1,
         "onUpdateParams":1,
         "roundProps":1,
         "onStart":1,
         "onStartParams":1,
         "onInit":1,
         "onInitParams":1,
         "onReverseComplete":1,
         "onReverseCompleteParams":1,
         "onRepeat":1,
         "onRepeatParams":1,
         "proxiedEase":1,
         "easeParams":1,
         "yoyo":1,
         "onCompleteListener":1,
         "onUpdateListener":1,
         "onStartListener":1,
         "onReverseCompleteListener":1,
         "onRepeatListener":1,
         "orientToBezier":1,
         "timeScale":1,
         "immediateRender":1,
         "repeat":1,
         "repeatDelay":1,
         "timeline":1,
         "data":1,
         "paused":1
      };
       
      
      public var target:Object;
      
      public var propTweenLookup:Object;
      
      public var ratio:Number = 0;
      
      public var cachedPT1:PropTween;
      
      protected var _ease:Function;
      
      protected var _overwrite:int;
      
      protected var _overwrittenProps:Object;
      
      protected var _hasPlugins:Boolean;
      
      protected var _notifyPluginsOfEnabled:Boolean;
      
      public function TweenLite(param1:Object, param2:Number, param3:Object)
      {
         var _loc5_:TweenLite = null;
         super(param2,param3);
         this.target = param1;
         if(this.target is TweenCore && Boolean(this.vars.timeScale))
         {
            this.cachedTimeScale = 1;
         }
         this.propTweenLookup = {};
         do
         {
            this._ease = defaultEase;
            this._overwrite = Number(param3.overwrite) <= -1 || !overwriteManager.enabled && param3.overwrite > 1 ? int(overwriteManager.mode) : int(param3.overwrite);
         }
         while(false);
         
         var _loc4_:Array;
         if(!(_loc4_ = masterList[param1]))
         {
            masterList[param1] = [this];
         }
         else if(this._overwrite == 1)
         {
            for each(_loc5_ in _loc4_)
            {
               if(!_loc5_.gc)
               {
                  _loc5_.setEnabled(false,false);
               }
            }
            masterList[param1] = [this];
         }
         else
         {
            _loc4_[_loc4_.length] = this;
         }
         if(this.active || Boolean(this.vars.immediateRender))
         {
            this.renderTime(0,false,true);
         }
      }
      
      public static function initClass() : void
      {
         rootFrame = 0;
         rootTimeline = new SimpleTimeline(null);
         rootFramesTimeline = new SimpleTimeline(null);
         rootTimeline.cachedStartTime = getTimer() * 0.001;
         rootFramesTimeline.cachedStartTime = rootFrame;
         rootTimeline.autoRemoveChildren = true;
         rootFramesTimeline.autoRemoveChildren = true;
         _shape.addEventListener(Event.ENTER_FRAME,updateAll,false,0,true);
         if(overwriteManager == null)
         {
            overwriteManager = {
               "mode":1,
               "enabled":false
            };
         }
      }
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenLite
      {
         return new TweenLite(param1,param2,param3);
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenLite
      {
         param3.runBackwards = true;
         if(!("immediateRender" in param3))
         {
            param3.immediateRender = true;
         }
         return new TweenLite(param1,param2,param3);
      }
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenLite
      {
         return new TweenLite(param2,0,{
            "delay":param1,
            "onComplete":param2,
            "onCompleteParams":param3,
            "immediateRender":false,
            "useFrames":param4,
            "overwrite":0
         });
      }
      
      protected static function updateAll(param1:Event = null) : void
      {
         var _loc2_:Dictionary = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         rootTimeline.renderTime((getTimer() * 0.001 - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale,false,false);
         do
         {
            rootFrame += 1;
            rootFramesTimeline.renderTime((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale,false,false);
         }
         while(false);
         
         if(!(rootFrame % 60))
         {
            _loc2_ = masterList;
            for(_loc3_ in _loc2_)
            {
               _loc5_ = int((_loc4_ = _loc2_[_loc3_]).length);
               while(--_loc5_ > -1)
               {
                  if(TweenLite(_loc4_[_loc5_]).gc)
                  {
                     _loc4_.splice(_loc5_,1);
                  }
               }
               if(_loc4_.length == 0)
               {
                  delete _loc2_[_loc3_];
               }
            }
         }
      }
      
      public static function killTweensOf(param1:Object, param2:Boolean = false, param3:Object = null) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:TweenLite = null;
         if(param1 in masterList)
         {
            _loc5_ = int((_loc4_ = masterList[param1]).length);
            while(--_loc5_ > -1)
            {
               if(!(_loc6_ = _loc4_[_loc5_]).gc)
               {
                  if(param2)
                  {
                     _loc6_.complete(false,false);
                  }
                  if(param3 != null)
                  {
                     _loc6_.killVars(param3);
                  }
                  §§push(param3 == null);
                  if(!(param3 == null))
                  {
                     §§pop();
                     while(true)
                     {
                        §§push(_loc6_.cachedPT1 == null && _loc6_.initted);
                     }
                     addr66:
                  }
                  while(§§pop())
                  {
                     _loc6_.setEnabled(false,false);
                     if(true)
                     {
                        break;
                     }
                     §§goto(addr66);
                  }
               }
            }
            if(param3 == null)
            {
               delete masterList[param1];
            }
         }
      }
      
      protected static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return 1 - (param1 = 1 - param1 / param4) * param1;
      }
      
      protected function init() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:Boolean = false;
         var _loc5_:Array = null;
         var _loc6_:PropTween = null;
         if(this.vars.onInit)
         {
            this.vars.onInit.apply(null,this.vars.onInitParams);
         }
         if(typeof this.vars.ease == "function")
         {
            this._ease = this.vars.ease;
         }
         if(this.vars.easeParams)
         {
            this.vars.proxiedEase = this._ease;
            this._ease = this.easeProxy;
         }
         do
         {
            this.cachedPT1 = null;
            this.propTweenLookup = {};
         }
         while(false);
         
         loop1:
         for(_loc1_ in this.vars)
         {
            §§push(_loc1_ in _reservedProps);
            if(_loc1_ in _reservedProps)
            {
               §§pop();
               while(true)
               {
                  §§push(!(_loc1_ == "timeScale" && this.target is TweenCore));
               }
               addr105:
            }
            while(true)
            {
               if(!§§pop())
               {
                  §§push(_loc1_ in plugins);
                  if(_loc1_ in plugins)
                  {
                     §§pop();
                     if(true)
                     {
                        §§push(Boolean((_loc3_ = new (plugins[_loc1_] as Class)()).onInitTween(this.target,this.vars[_loc1_],this)));
                        break;
                     }
                     §§goto(addr105);
                  }
                  break;
               }
               continue loop1;
            }
            if(§§pop())
            {
               this.cachedPT1 = new PropTween(_loc3_,"changeFactor",0,1,_loc3_.overwriteProps.length == 1 ? String(_loc3_.overwriteProps[0]) : "_MULTIPLE_",true,this.cachedPT1);
               if(this.cachedPT1.name == "_MULTIPLE_")
               {
                  _loc2_ = int(_loc3_.overwriteProps.length);
                  while(--_loc2_ > -1)
                  {
                     this.propTweenLookup[_loc3_.overwriteProps[_loc2_]] = this.cachedPT1;
                  }
               }
               else
               {
                  this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
               }
               if(_loc3_.priority)
               {
                  this.cachedPT1.priority = _loc3_.priority;
                  _loc4_ = true;
               }
               if(Boolean(_loc3_.onDisable) || Boolean(_loc3_.onEnable))
               {
                  this._notifyPluginsOfEnabled = true;
               }
               this._hasPlugins = true;
            }
            else
            {
               this.cachedPT1 = new PropTween(this.target,_loc1_,Number(this.target[_loc1_]),typeof this.vars[_loc1_] == "number" ? Number(this.vars[_loc1_]) - this.target[_loc1_] : Number(this.vars[_loc1_]),_loc1_,false,this.cachedPT1);
               this.propTweenLookup[_loc1_] = this.cachedPT1;
               if(true)
               {
                  continue;
               }
            }
         }
         if(_loc4_)
         {
            onPluginEvent("onInit",this);
         }
         if(this.vars.runBackwards)
         {
            _loc6_ = this.cachedPT1;
            while(_loc6_)
            {
               _loc6_.start += _loc6_.change;
               _loc6_.change = -_loc6_.change;
               _loc6_ = _loc6_.nextNode;
            }
         }
         _hasUpdate = Boolean(this.vars.onUpdate != null);
         if(this._overwrittenProps)
         {
            this.killVars(this._overwrittenProps);
            if(this.cachedPT1 == null)
            {
               this.setEnabled(false,false);
            }
         }
         while(true)
         {
            §§push(this._overwrite > 1 && this.cachedPT1);
            if(!(this._overwrite > 1 && this.cachedPT1))
            {
               break;
            }
            §§pop();
            if(true)
            {
               §§push(_loc5_ = masterList[this.target]);
               break;
            }
         }
         if(§§pop() && _loc5_.length > 1)
         {
            if(overwriteManager.manageOverwrites(this,this.propTweenLookup,_loc5_,this._overwrite))
            {
               this.init();
            }
         }
         this.initted = true;
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Number = this.cachedTime;
         if(param1 >= this.cachedDuration)
         {
            this.cachedTotalTime = this.cachedTime = this.cachedDuration;
            this.ratio = 1;
            _loc4_ = true;
            if(this.cachedDuration == 0)
            {
               §§push(param1 == 0 || _rawPrevTime < 0);
               if(param1 == 0 || _rawPrevTime < 0)
               {
                  §§pop();
                  loop1:
                  while(true)
                  {
                     §§push(_rawPrevTime != param1);
                     addr41:
                     addr75:
                     while(true)
                     {
                        if(§§pop())
                        {
                           param3 = true;
                        }
                        _rawPrevTime = param1;
                        if(true)
                        {
                           break;
                        }
                        continue loop1;
                     }
                     if(this.cachedTime == _loc5_ && !param3)
                     {
                        return;
                     }
                     if(!this.initted)
                     {
                        this.init();
                        if(!_loc4_ && Boolean(this.cachedTime))
                        {
                           this.ratio = this._ease(this.cachedTime,0,1,this.cachedDuration);
                        }
                     }
                     if(!this.active && !this.cachedPaused)
                     {
                        this.active = true;
                     }
                     §§push(_loc5_ == 0 && this.vars.onStart);
                     if(_loc5_ == 0 && this.vars.onStart)
                     {
                        §§pop();
                        while(true)
                        {
                           §§push(this.cachedTime != 0);
                        }
                        addr167:
                     }
                     while(§§pop() && !param2)
                     {
                        this.vars.onStart.apply(null,this.vars.onStartParams);
                        if(true)
                        {
                           break;
                        }
                        §§goto(addr167);
                     }
                     var _loc6_:PropTween = this.cachedPT1;
                     while(_loc6_)
                     {
                        _loc6_.target[_loc6_.property] = _loc6_.start + this.ratio * _loc6_.change;
                        _loc6_ = _loc6_.nextNode;
                     }
                     if(_hasUpdate && !param2)
                     {
                        this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
                     }
                     if(_loc4_)
                     {
                        if(this._hasPlugins && Boolean(this.cachedPT1))
                        {
                           onPluginEvent("onComplete",this);
                        }
                        complete(true,param2);
                     }
                     return;
                  }
               }
               §§goto(addr41);
            }
            §§goto(addr75);
         }
         else if(param1 <= 0)
         {
            this.cachedTotalTime = this.cachedTime = this.ratio = 0;
            if(param1 < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0)
               {
                  if(_rawPrevTime > 0)
                  {
                     param3 = true;
                     _loc4_ = true;
                  }
                  _rawPrevTime = param1;
               }
            }
            while(this.cachedReversed && _loc5_ != 0)
            {
               _loc4_ = true;
               if(true)
               {
                  break;
               }
            }
         }
         else
         {
            this.cachedTotalTime = this.cachedTime = param1;
            this.ratio = this._ease(param1,0,1,this.cachedDuration);
         }
         §§goto(addr75);
      }
      
      public function killVars(param1:Object, param2:Boolean = true) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:PropTween = null;
         var _loc5_:Boolean = false;
         if(this._overwrittenProps == null)
         {
            this._overwrittenProps = {};
         }
         for(_loc3_ in param1)
         {
            if(_loc3_ in this.propTweenLookup)
            {
               if((_loc4_ = this.propTweenLookup[_loc3_]).isPlugin && _loc4_.name == "_MULTIPLE_")
               {
                  _loc4_.target.killProps(param1);
                  if(_loc4_.target.overwriteProps.length == 0)
                  {
                     _loc4_.name = "";
                  }
               }
               if(_loc4_.name != "_MULTIPLE_")
               {
                  if(_loc4_.nextNode)
                  {
                     _loc4_.nextNode.prevNode = _loc4_.prevNode;
                  }
                  if(_loc4_.prevNode)
                  {
                     _loc4_.prevNode.nextNode = _loc4_.nextNode;
                  }
                  else if(this.cachedPT1 == _loc4_)
                  {
                     this.cachedPT1 = _loc4_.nextNode;
                  }
                  if(_loc4_.isPlugin && Boolean(_loc4_.target.onDisable))
                  {
                     _loc4_.target.onDisable();
                     while(true)
                     {
                        if(_loc4_.target.activeDisable)
                        {
                           _loc5_ = true;
                        }
                     }
                     addr62:
                  }
                  while(true)
                  {
                     delete this.propTweenLookup[_loc3_];
                     if(true)
                     {
                        break;
                     }
                     §§goto(addr62);
                  }
               }
            }
            if(param2 && param1 != this._overwrittenProps)
            {
               this._overwrittenProps[_loc3_] = 1;
            }
         }
         return _loc5_;
      }
      
      override public function invalidate() : void
      {
         if(this._notifyPluginsOfEnabled && Boolean(this.cachedPT1))
         {
            onPluginEvent("onDisable",this);
         }
         do
         {
            this.cachedPT1 = null;
            this._overwrittenProps = null;
         }
         while(false);
         
         _hasUpdate = this.initted = this.active = this._notifyPluginsOfEnabled = false;
         this.propTweenLookup = {};
      }
      
      override public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean
      {
         var _loc3_:Array = null;
         if(param1)
         {
            _loc3_ = TweenLite.masterList[this.target];
            if(!_loc3_)
            {
               TweenLite.masterList[this.target] = [this];
            }
            else
            {
               _loc3_[_loc3_.length] = this;
            }
         }
         super.setEnabled(param1,param2);
         if(this._notifyPluginsOfEnabled && Boolean(this.cachedPT1))
         {
            return onPluginEvent(param1 ? "onEnable" : "onDisable",this);
         }
         return false;
      }
      
      protected function easeProxy(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return this.vars.proxiedEase.apply(null,arguments.concat(this.vars.easeParams));
      }
   }
}
