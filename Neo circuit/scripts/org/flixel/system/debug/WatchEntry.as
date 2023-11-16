package org.flixel.system.debug
{
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import org.flixel.FlxU;
   
   public class WatchEntry
   {
       
      
      public var object:Object;
      
      public var field:String;
      
      public var custom:String;
      
      public var nameDisplay:TextField;
      
      public var valueDisplay:TextField;
      
      public var editing:Boolean;
      
      public var oldValue:Object;
      
      protected var _whiteText:TextFormat;
      
      protected var _blackText:TextFormat;
      
      public function WatchEntry(param1:Number, param2:Number, param3:Number, param4:Object, param5:String, param6:String = null)
      {
         super();
         this.editing = false;
         this.object = param4;
         this.field = param5;
         this.custom = param6;
         this._whiteText = new TextFormat("Courier",12,16777215);
         this._blackText = new TextFormat("Courier",12,0);
         this.nameDisplay = new TextField();
         this.nameDisplay.y = param1;
         this.nameDisplay.multiline = false;
         this.nameDisplay.selectable = true;
         this.nameDisplay.defaultTextFormat = this._whiteText;
         this.valueDisplay = new TextField();
         this.valueDisplay.y = param1;
         this.valueDisplay.height = 15;
         this.valueDisplay.multiline = false;
         this.valueDisplay.selectable = true;
         this.valueDisplay.doubleClickEnabled = true;
         this.valueDisplay.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this.valueDisplay.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.valueDisplay.background = false;
         this.valueDisplay.backgroundColor = 16777215;
         this.valueDisplay.defaultTextFormat = this._whiteText;
         this.updateWidth(param2,param3);
      }
      
      public function destroy() : void
      {
         this.object = null;
         this.oldValue = null;
         this.nameDisplay = null;
         this.field = null;
         this.custom = null;
         this.valueDisplay.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.valueDisplay.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this.valueDisplay = null;
      }
      
      public function setY(param1:Number) : void
      {
         this.nameDisplay.y = param1;
         this.valueDisplay.y = param1;
      }
      
      public function updateWidth(param1:Number, param2:Number) : void
      {
         this.nameDisplay.width = param1;
         this.valueDisplay.width = param2;
         if(this.custom != null)
         {
            this.nameDisplay.text = this.custom;
         }
         else
         {
            this.nameDisplay.text = "";
            if(param1 > 120)
            {
               this.nameDisplay.appendText(FlxU.getClassName(this.object,param1 < 240) + ".");
            }
            this.nameDisplay.appendText(this.field);
         }
      }
      
      public function updateValue() : Boolean
      {
         if(this.editing)
         {
            return false;
         }
         this.valueDisplay.text = this.object[this.field].toString();
         return true;
      }
      
      public function onMouseUp(param1:MouseEvent) : void
      {
         this.editing = true;
         this.oldValue = this.object[this.field];
         this.valueDisplay.type = TextFieldType.INPUT;
         this.valueDisplay.setTextFormat(this._blackText);
         this.valueDisplay.background = true;
      }
      
      public function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13 || param1.keyCode == 9 || param1.keyCode == 27)
         {
            if(param1.keyCode == 27)
            {
               this.cancel();
            }
            else
            {
               this.submit();
            }
         }
      }
      
      public function cancel() : void
      {
         this.valueDisplay.text = this.oldValue.toString();
         this.doneEditing();
      }
      
      public function submit() : void
      {
         this.object[this.field] = this.valueDisplay.text;
         this.doneEditing();
      }
      
      protected function doneEditing() : void
      {
         this.valueDisplay.type = TextFieldType.DYNAMIC;
         this.valueDisplay.setTextFormat(this._whiteText);
         this.valueDisplay.defaultTextFormat = this._whiteText;
         this.valueDisplay.background = false;
         this.editing = false;
      }
   }
}
