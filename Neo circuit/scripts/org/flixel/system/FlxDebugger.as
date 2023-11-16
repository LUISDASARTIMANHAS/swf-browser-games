package org.flixel.system
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import org.flixel.FlxG;
   import org.flixel.system.debug.Log;
   import org.flixel.system.debug.Perf;
   import org.flixel.system.debug.VCR;
   import org.flixel.system.debug.Vis;
   import org.flixel.system.debug.Watch;
   
   public class FlxDebugger extends Sprite
   {
       
      
      public var perf:Perf;
      
      public var log:Log;
      
      public var watch:Watch;
      
      public var vcr:VCR;
      
      public var vis:Vis;
      
      public var hasMouse:Boolean;
      
      protected var _layout:uint;
      
      protected var _screen:Point;
      
      protected var _gutter:uint;
      
      public function FlxDebugger(param1:Number, param2:Number)
      {
         super();
         visible = false;
         this.hasMouse = false;
         do
         {
            this._screen = new Point(param1,param2);
            addChild(new Bitmap(new BitmapData(param1,15,true,2130706432)));
         }
         while(false);
         
         var _loc3_:TextField = new TextField();
         _loc3_.x = 2;
         _loc3_.width = 160;
         _loc3_.height = 16;
         _loc3_.selectable = false;
         do
         {
            _loc3_.multiline = false;
            _loc3_.defaultTextFormat = new TextFormat("Courier",12,16777215);
         }
         while(false);
         
         var _loc4_:* = FlxG.getLibraryName();
         if(FlxG.debug)
         {
            _loc4_ += " [debug]";
         }
         else
         {
            _loc4_ += " [release]";
         }
         _loc3_.text = _loc4_;
         do
         {
            addChild(_loc3_);
            this._gutter = 8;
         }
         while(false);
         
         var _loc5_:Rectangle = new Rectangle(this._gutter,15 + this._gutter / 2,this._screen.x - this._gutter * 2,this._screen.y - this._gutter * 1.5 - 15);
         this.log = new Log("log",0,0,true,_loc5_);
         addChild(this.log);
         this.watch = new Watch("watch",0,0,true,_loc5_);
         addChild(this.watch);
         this.perf = new Perf("stats",0,0,false,_loc5_);
         addChild(this.perf);
         this.vcr = new VCR();
         this.vcr.x = (param1 - this.vcr.width / 2) / 2;
         this.vcr.y = 2;
         addChild(this.vcr);
         this.vis = new Vis();
         this.vis.x = param1 - this.vis.width - 4;
         this.vis.y = 2;
         addChild(this.vis);
         this.setLayout(FlxG.DEBUGGER_MICRO);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      public function destroy() : void
      {
         this._screen = null;
         removeChild(this.log);
         this.log.destroy();
         this.log = null;
         removeChild(this.watch);
         this.watch.destroy();
         this.watch = null;
         removeChild(this.perf);
         this.perf.destroy();
         this.perf = null;
         removeChild(this.vcr);
         this.vcr.destroy();
         this.vcr = null;
         removeChild(this.vis);
         this.vis.destroy();
         this.vis = null;
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      protected function onMouseOver(param1:MouseEvent = null) : void
      {
         this.hasMouse = true;
      }
      
      protected function onMouseOut(param1:MouseEvent = null) : void
      {
         this.hasMouse = false;
      }
      
      public function setLayout(param1:uint) : void
      {
         this._layout = param1;
         this.resetLayout();
      }
      
      public function resetLayout() : void
      {
         switch(this._layout)
         {
            case FlxG.DEBUGGER_MICRO:
               this.log.resize(this._screen.x / 4,68);
               this.log.reposition(0,this._screen.y);
               this.watch.resize(this._screen.x / 4,68);
               this.watch.reposition(this._screen.x,this._screen.y);
               this.perf.reposition(this._screen.x,0);
               break;
            case FlxG.DEBUGGER_BIG:
               this.log.resize((this._screen.x - this._gutter * 3) / 2,this._screen.y / 2);
               this.log.reposition(0,this._screen.y);
               this.watch.resize((this._screen.x - this._gutter * 3) / 2,this._screen.y / 2);
               this.watch.reposition(this._screen.x,this._screen.y);
               this.perf.reposition(this._screen.x,0);
               break;
            case FlxG.DEBUGGER_TOP:
               this.log.resize((this._screen.x - this._gutter * 3) / 2,this._screen.y / 4);
               this.log.reposition(0,0);
               this.watch.resize((this._screen.x - this._gutter * 3) / 2,this._screen.y / 4);
               this.watch.reposition(this._screen.x,0);
               this.perf.reposition(this._screen.x,this._screen.y);
               break;
            case FlxG.DEBUGGER_LEFT:
               this.log.resize(this._screen.x / 3,(this._screen.y - 15 - this._gutter * 2.5) / 2);
               this.log.reposition(0,0);
               this.watch.resize(this._screen.x / 3,(this._screen.y - 15 - this._gutter * 2.5) / 2);
               this.watch.reposition(0,this._screen.y);
               this.perf.reposition(this._screen.x,0);
               break;
            case FlxG.DEBUGGER_RIGHT:
               this.log.resize(this._screen.x / 3,(this._screen.y - 15 - this._gutter * 2.5) / 2);
               this.log.reposition(this._screen.x,0);
               this.watch.resize(this._screen.x / 3,(this._screen.y - 15 - this._gutter * 2.5) / 2);
               this.watch.reposition(this._screen.x,this._screen.y);
               this.perf.reposition(0,0);
               break;
            case FlxG.DEBUGGER_STANDARD:
            default:
               this.log.resize((this._screen.x - this._gutter * 3) / 2,this._screen.y / 4);
               this.log.reposition(0,this._screen.y);
               this.watch.resize((this._screen.x - this._gutter * 3) / 2,this._screen.y / 4);
               do
               {
                  this.watch.reposition(this._screen.x,this._screen.y);
                  this.perf.reposition(this._screen.x,0);
               }
               while(false);
               
         }
      }
   }
}
