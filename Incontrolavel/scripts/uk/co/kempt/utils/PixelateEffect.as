package uk.co.kempt.utils
{
   import flash.display.DisplayObject;
   import flash.display.Shader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.filters.ShaderFilter;
   import flash.utils.ByteArray;
   
   public class PixelateEffect extends EventDispatcher
   {
      
      public static var EFFECT:PixelateEffect;
      
      private static const MAX_PIXELATE:Number = 6;
      
      private static const dataStr:String = "a501000000a40a005465737446696c746572a00c6e616d65737061636500756b2e636f2e6b656d707400a00c76656e646f72004b656d707400a00876657273696f6e000100a00c6465736372697074696f6e00506978656c61746500a1010200000c5f4f7574436f6f726400a3000473726300a1020401000f64737400a10101000002616d6f756e7400a2016d696e56616c7565003f800000a2016d617856616c756500437f0000a20164656661756c7456616c75650040a000001d0200c100001000040200310000a00003020031020010001a0300c10200b0001d02003103001000030200310000a0001d0200c10200b000300300f1020010001d0100f303001b00";
       
      
      private var dAmount:Number = 0.25;
      
      private var level:Number = 0;
      
      private var _shader:Shader;
      
      private var _target:DisplayObject;
      
      private var _shaderFilter:ShaderFilter;
      
      private var amount:Number = 1;
      
      public function PixelateEffect()
      {
         super();
         if(!EFFECT)
         {
         }
         EFFECT = this;
      }
      
      private static function stringToByteArray(param1:String) : ByteArray
      {
         var _loc3_:int = 0;
         var _loc2_:ByteArray = new ByteArray();
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = int(int("0x" + param1.charAt(_loc4_) + param1.charAt(_loc4_ + 1)));
            _loc2_.writeByte(_loc3_);
            _loc4_ += 2;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      private function get shader() : Shader
      {
         return this._shader = this._shader || new Shader(stringToByteArray(dataStr));
      }
      
      private function pixelate(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         this.dAmount += 0.01;
         this.amount += this.dAmount;
         if(this.amount > MAX_PIXELATE)
         {
            this.amount = MAX_PIXELATE;
            this.dAmount = 0;
            this._target.removeEventListener(Event.ENTER_FRAME,this.pixelate);
            _loc2_ = true;
         }
         this.shader.data.amount.value = [this.amount];
         this._target.filters = [this.shaderFilter];
         if(_loc2_)
         {
            this._target.filters = null;
            this._target = null;
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public function doUnpixelate(param1:DisplayObject) : *
      {
         this._target = param1;
         this.amount = 6;
         this.unpixelate(null);
         this._target.addEventListener(Event.ENTER_FRAME,this.unpixelate,false,0,true);
      }
      
      private function unpixelate(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         this.amount = this.amount - this.amount / 18 - 0.001;
         if(this.amount < 1)
         {
            this.amount = 1;
            this.dAmount = 0;
            this._target.removeEventListener(Event.ENTER_FRAME,this.unpixelate);
            _loc2_ = true;
         }
         this.shader.data.amount.value = [this.amount];
         this._target.filters = [this.shaderFilter];
         if(_loc2_)
         {
            this._target.filters = null;
            this._target = null;
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function get shaderFilter() : ShaderFilter
      {
         return this._shaderFilter = this._shaderFilter || new ShaderFilter(this.shader);
      }
      
      public function doPixelate(param1:DisplayObject) : *
      {
         this._target = param1;
         this.amount = 1;
         this.dAmount = 0;
         this.pixelate(null);
         this._target.addEventListener(Event.ENTER_FRAME,this.pixelate,false,0,true);
      }
   }
}
