package com.mindgame.tweener.shits
{
   import flash.display.*;
   import flash.geom.*;
   import flash.media.*;
   
   use namespace MotionInternal;
   
   public class TransformHustle extends SimpleHustle
   {
       
      
      protected var endColorTransform:ColorTransform;
      
      protected var endSoundTransform:SoundTransform;
      
      protected var tweenColorTransform:ColorTransform;
      
      protected var tweenSoundTransform:SoundTransform;
      
      public function TransformHustle(param1:Object, param2:Number, param3:Object)
      {
         super(param1,param2,param3);
      }
      
      override MotionInternal function apply() : void
      {
         this.initialize();
         if(this.endColorTransform)
         {
            target.transform.colorTransform = this.endColorTransform;
         }
         if(this.endSoundTransform)
         {
            target.soundTransform = this.endSoundTransform;
         }
      }
      
      override protected function initialize() : void
      {
         if("colorValue" in properties && target is DisplayObject)
         {
            this.initializeColor();
         }
         if("soundVolume" in properties || "soundPan" in properties)
         {
            this.initializeSound();
         }
         detailsLength = propertyDetails.length;
         initialized = true;
      }
      
      protected function initializeColor() : void
      {
         var _loc5_:PropertyDetails = null;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         this.endColorTransform = new ColorTransform();
         var _loc1_:Number = Number(properties.colorValue);
         var _loc2_:Number = Number(properties.colorStrength);
         if(_loc2_ < 1)
         {
            if(_loc2_ < 0.5)
            {
               _loc8_ = 1;
               _loc9_ = _loc2_ * 2;
            }
            else
            {
               _loc8_ = 1 - (_loc2_ - 0.5) * 2;
               _loc9_ = 1;
            }
            this.endColorTransform.redMultiplier = _loc8_;
            this.endColorTransform.greenMultiplier = _loc8_;
            this.endColorTransform.blueMultiplier = _loc8_;
            this.endColorTransform.redOffset = _loc9_ * (_loc1_ >> 16 & 255);
            this.endColorTransform.greenOffset = _loc9_ * (_loc1_ >> 8 & 255);
            this.endColorTransform.blueOffset = _loc9_ * (_loc1_ & 255);
         }
         else
         {
            this.endColorTransform.color = _loc1_;
         }
         var _loc3_:Array = ["redMultiplier","greenMultiplier","blueMultiplier","redOffset","greenOffset","blueOffset"];
         if("colorAlpha" in properties)
         {
            this.endColorTransform.alphaMultiplier = properties.colorAlpha;
            _loc3_.push("alphaMultiplier");
         }
         else
         {
            this.endColorTransform.alphaMultiplier = target.alpha;
         }
         var _loc4_:ColorTransform = target.transform.colorTransform;
         this.tweenColorTransform = new ColorTransform();
         for each(_loc7_ in _loc3_)
         {
            _loc6_ = Number(Number(_loc4_[_loc7_]));
            _loc5_ = new PropertyDetails(this.tweenColorTransform,_loc7_,_loc6_,Number(this.endColorTransform[_loc7_] - _loc6_));
            propertyDetails.push(_loc5_);
         }
      }
      
      protected function initializeSound() : void
      {
         var _loc1_:SoundTransform = target.soundTransform;
         this.endSoundTransform = target.soundTransform;
         this.tweenSoundTransform = new SoundTransform();
         if("soundVolume" in properties)
         {
            this.endSoundTransform.volume = properties.soundVolume;
            propertyDetails.push(new PropertyDetails(this.tweenSoundTransform,"volume",_loc1_.volume,this.endSoundTransform.volume - _loc1_.volume));
         }
         if("soundPan" in properties)
         {
            this.endSoundTransform.pan = properties.soundPan;
            propertyDetails.push(new PropertyDetails(this.tweenSoundTransform,"pan",_loc1_.pan,this.endSoundTransform.pan - _loc1_.pan));
         }
      }
      
      override MotionInternal function update(param1:Number) : void
      {
         super.MotionInternal::update(param1);
         if(this.endColorTransform)
         {
            target.transform.colorTransform = this.tweenColorTransform;
         }
         if(this.endSoundTransform)
         {
            target.soundTransform = this.tweenSoundTransform;
         }
      }
   }
}
