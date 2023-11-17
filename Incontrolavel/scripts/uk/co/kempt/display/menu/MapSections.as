package uk.co.kempt.display.menu
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.MapSections")]
   public class MapSections extends MovieClip
   {
      
      private static const FRAME_PREFIX:String = "level";
       
      
      public var bars:MovieClip;
      
      private var _currentSection:int;
      
      public var stage1:StageIcon;
      
      public var stage2:StageIcon;
      
      public var stage3:StageIcon;
      
      public var stage4:StageIcon;
      
      public var stage5:StageIcon;
      
      public function MapSections()
      {
         super();
         stop();
         this._currentSection = -1;
      }
      
      public function animateIn(param1:int) : void
      {
         this.bars.gotoAndPlay("in");
         this._currentSection = param1;
         var _loc2_:StageIcon = StageIcon(this["stage" + param1]);
         _loc2_.activate();
      }
      
      private function onZoomComplete(param1:Event) : void
      {
         gotoAndStop("blank");
         this.bars.gotoAndPlay("out");
         dispatchEvent(param1);
      }
      
      public function animateOut(param1:Boolean = false) : void
      {
         this.bars.gotoAndStop(1);
         if(this._currentSection < 1)
         {
            return;
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function setMapArea(param1:int) : void
      {
         gotoAndStop("blank");
         gotoAndStop(FRAME_PREFIX + param1.toString());
         this.stage1.set(param1.toString() + ".1");
         this.stage2.set(param1.toString() + ".2");
         this.stage3.set(param1.toString() + ".3");
         this.stage4.set(param1.toString() + ".4");
         this.stage5.set(param1.toString() + ".5");
         this.stage1.addEventListener(Event.COMPLETE,this.onZoomComplete,false,0,true);
         this.stage2.addEventListener(Event.COMPLETE,this.onZoomComplete,false,0,true);
         this.stage3.addEventListener(Event.COMPLETE,this.onZoomComplete,false,0,true);
         this.stage4.addEventListener(Event.COMPLETE,this.onZoomComplete,false,0,true);
         this.stage5.addEventListener(Event.COMPLETE,this.onZoomComplete,false,0,true);
      }
   }
}
