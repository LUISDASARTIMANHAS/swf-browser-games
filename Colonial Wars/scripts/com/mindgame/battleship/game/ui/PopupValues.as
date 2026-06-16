package com.mindgame.battleship.game.ui
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.framework.*;
   import flash.filters.*;
   import flash.text.*;
   
   public class PopupValues
   {
       
      
      private var _world:WorldComp;
      
      private var allValue:Array;
      
      private var p:int = 0;
      
      private var allValues:SimpleCache;
      
      private var getColor:GetColor;
      
      private var size:int;
      
      public function PopupValues()
      {
         this._world = WorldComp.returnWorld;
         this.allValue = [];
         this.getColor = GetColor.returnGetColor;
         this.size = this._world.valueStock.size1;
         super();
      }
      
      public function createAllValues() : void
      {
         this.allValues = new SimpleCache(TextField,1);
      }
      
      public function createValue(param1:int, param2:int, param3:Evector, param4:int, param5:int, param6:int, param7:int) : void
      {
         var _loc8_:TextField = null;
         if(param6 == 0)
         {
            return;
         }
         (_loc8_ = this.allValues.get() as TextField).defaultTextFormat = new TextFormat("Arial",this.size,0);
         if(param5 == param7)
         {
            _loc8_.text = "+" + String(param6);
         }
         else
         {
            _loc8_.text = "-" + String(param6);
         }
         _loc8_.height = 10;
         _loc8_.autoSize = TextFieldAutoSize.CENTER;
         _loc8_.selectable = false;
         _loc8_.mouseEnabled = false;
         _loc8_.x = param1 + param3.x * param4 - _loc8_.width * 0.5;
         _loc8_.y = param2 + param3.y * param4 - _loc8_.height * 0.5;
         _loc8_.filters = [new GlowFilter(this.getColor.getRaceColor(param5),1,6,6,15,3,false,false)];
         _loc8_.cacheAsBitmap = true;
         this.allValue[this.allValue.length] = {
            "v":_loc8_,
            "c":35
         };
         this._world.valuesLayer.addChild(_loc8_);
      }
      
      public function clear() : void
      {
         var _loc1_:int = this.allValue.length - 1;
         while(this.allValue.length)
         {
            this.allValues.set((this.allValue[_loc1_] as Object).v as TextField);
            this._world.valuesLayer.removeChild((this.allValue[_loc1_] as Object).v as TextField);
            this.allValue.splice(_loc1_,1);
            _loc1_--;
         }
      }
      
      public function update() : void
      {
         this.p = 0;
         while(this.p < this.allValue.length)
         {
            if((this.allValue[this.p] as Object).c-- < 0)
            {
               this._world.valuesLayer.removeChild((this.allValue[this.p] as Object).v as TextField);
               this.allValues.set((this.allValue[this.p] as Object).v as TextField);
               this.allValue.splice(this.p,1);
            }
            else
            {
               --((this.allValue[this.p] as Object).v as TextField).y;
            }
            ++this.p;
         }
      }
   }
}
