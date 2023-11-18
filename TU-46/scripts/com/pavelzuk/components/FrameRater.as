package com.pavelzuk.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class FrameRater extends Sprite
   {
       
      
      private var _timer:Timer;
      
      private var _dropShadow:GlowFilter;
      
      private var _graph:Sprite;
      
      private var _tf:TextFormat;
      
      private var _showGraph:Boolean;
      
      private var _text:TextField;
      
      private var _graphColor:uint;
      
      private var _c:uint = 0;
      
      private var _graphCounter:uint;
      
      private var _graphBox:Sprite;
      
      public function FrameRater(param1:uint = 0, param2:Boolean = false, param3:Boolean = true, param4:uint = 16711680)
      {
         super();
         this._showGraph = param3;
         this._graphColor = param4;
         if(this._showGraph)
         {
            this.initGraph();
         }
         this._dropShadow = new GlowFilter(0,1,2,2,1000);
         this._tf = new TextFormat();
         this._tf.color = param1;
         this._tf.font = "verdana";
         this._tf.size = 10;
         this._text = new TextField();
         this._text.width = 100;
         this._text.height = 20;
         this._text.x = 3;
         if(param2)
         {
            this._text.filters = [this._dropShadow];
         }
         addChild(this._text);
         this._timer = new Timer(500);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer.start();
         addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      public function updateGraph(param1:Number) : void
      {
         if(this._graphCounter > 30)
         {
            --this._graph.x;
         }
         ++this._graphCounter;
         this._graph.graphics.lineTo(this._graphCounter,1 + (stage.frameRate - param1) / 3);
      }
      
      private function onFrame(param1:Event) : void
      {
         ++this._c;
      }
      
      private function initGraph() : void
      {
         this._graphCounter = 0;
         this._graph = new Sprite();
         this._graphBox = new Sprite();
         this._graphBox.graphics.beginFill(16711680);
         this._graphBox.graphics.drawRect(0,0,36,100);
         this._graphBox.graphics.endFill();
         this._graph.mask = this._graphBox;
         this._graph.x = this._graphBox.x = 5;
         this._graph.y = this._graphBox.y = 20;
         this._graph.graphics.lineStyle(1,this._graphColor);
         addChild(this._graph);
         addChild(this._graphBox);
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:Number = this.computeTime();
         this._text.text = Math.floor(_loc2_).toString() + " fps";
         this._text.setTextFormat(this._tf);
         this._text.autoSize = "left";
         if(this._showGraph)
         {
            this.updateGraph(_loc2_);
         }
      }
      
      public function computeTime() : Number
      {
         var _loc1_:uint = this._c;
         this._c = 0;
         return _loc1_ * 2 - 1;
      }
   }
}
