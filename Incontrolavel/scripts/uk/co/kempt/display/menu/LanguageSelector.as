package uk.co.kempt.display.menu
{
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.LanguageSelector")]
   public class LanguageSelector extends Sprite
   {
      
      private static const COLOR_SELECTED:uint = 16763904;
       
      
      public var choices_mc:lang_choices;
      
      public var down_btn:SimpleButton;
      
      public var current_mc:Sprite;
      
      public var confirm_btn:SimpleButton;
      
      private var _textFields:Array;
      
      private var _targetY:Number;
      
      public var up_btn:SimpleButton;
      
      private var _selectedIndex:int;
      
      public function LanguageSelector()
      {
         var _loc2_:DisplayObject = null;
         super();
         var _loc1_:int = int(this.choices_mc.numChildren);
         this._textFields = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this.choices_mc.getChildAt(_loc3_);
            if(_loc2_ is TextField)
            {
               this._textFields.push(_loc2_);
            }
            _loc3_++;
         }
         this._textFields.sortOn("y",Array.NUMERIC);
         this.selectedIndex = 0;
         this.checkTextFields();
         this.up_btn.addEventListener(MouseEvent.CLICK,this.onUpClicked,false,0,true);
         this.down_btn.addEventListener(MouseEvent.CLICK,this.onDownClicked,false,0,true);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameEvent,false,0,true);
         this.confirm_btn.addEventListener(MouseEvent.CLICK,this.onConfirmClicked,false,0,true);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelEvent,false,0,true);
      }
      
      private function onEnterFrameEvent(param1:Event) : void
      {
         var _loc2_:Number = (this._targetY - this.choices_mc.y) / 3;
         this.choices_mc.y += _loc2_;
      }
      
      private function onDownClicked(param1:MouseEvent) : void
      {
         ++this.selectedIndex;
      }
      
      public function get selectedLabel() : String
      {
         var _loc1_:TextField = this._textFields[this._selectedIndex];
         if(_loc1_)
         {
            return _loc1_.name;
         }
         return null;
      }
      
      private function onConfirmClicked(param1:MouseEvent) : void
      {
         mouseChildren = mouseEnabled = false;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onMouseWheelEvent(param1:MouseEvent) : void
      {
         if(param1.delta > 0)
         {
            --this.selectedIndex;
         }
         else if(param1.delta < 0)
         {
            ++this.selectedIndex;
         }
      }
      
      private function onUpClicked(param1:MouseEvent) : void
      {
         --this.selectedIndex;
      }
      
      private function checkTextFields() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:int = int(this._textFields.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._textFields[_loc3_];
            if(_loc1_.name == "en")
            {
               this.selectedIndex = this._textFields.indexOf(_loc1_);
               break;
            }
            _loc3_++;
         }
      }
      
      public function set selectedIndex(param1:int) : void
      {
         this._selectedIndex = param1;
         this._selectedIndex = Math.max(0,Math.min(this._textFields.length - 1,this._selectedIndex));
         var _loc2_:TextField = this._textFields[this._selectedIndex];
         this._targetY = this.current_mc.y - _loc2_.y + 3;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
   }
}
