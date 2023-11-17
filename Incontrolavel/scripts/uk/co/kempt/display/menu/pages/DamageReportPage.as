package uk.co.kempt.display.menu.pages
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.LevelStatistics;
   import uk.co.kempt.display.HUD;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.DamageReportPage")]
   public class DamageReportPage extends AbstractPage
   {
       
      
      private var _budget:int;
      
      public var cost_txt:TextField;
      
      private var _delay:int;
      
      private var _cost:int;
      
      public var level_txt:TextField;
      
      public var budget_txt:TextField;
      
      private var _countSpeed:int;
      
      private var _time:int;
      
      private var _targetCost:int;
      
      public var dBadge:MovieClip;
      
      public function DamageReportPage()
      {
         super();
         addFrameScript(12,this.frame13);
         var _loc1_:LevelStatistics = Engine.instance.levelStatistics;
         this.level_txt.text = 1 + Math.floor((Engine.instance.currentLevelNum - 1) / 5) + "." + (1 + (Engine.instance.currentLevelNum - 1) % 5);
         this._cost = 0;
         this._targetCost = _loc1_.totalCost;
         this._budget = _loc1_.budget;
         this._time = Engine.GAME_FRAMERATE * 1.2;
         this._countSpeed = this._targetCost / this._time;
         this._delay = 12;
         this.dBadge.gotoAndStop(AbstractPage.getBadgeLabel(_loc1_));
         this.onEnterFrameEvent(null);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameEvent,false,0,true);
         stop();
         this.updateText();
      }
      
      private function updateText() : void
      {
         this.cost_txt.text = HUD.formatMoney(this._cost);
         this.budget_txt.textColor = this._budget < 0 ? 16711680 : 65280;
         this.budget_txt.text = HUD.formatMoney(this._budget);
      }
      
      private function onEnterFrameEvent(param1:Event) : void
      {
         if(this._delay > 0)
         {
            --this._delay;
            return;
         }
         if(this._time > 0)
         {
            --this._time;
            if(this._time <= 0)
            {
               play();
            }
         }
         var _loc2_:Number = this._targetCost - this._cost;
         var _loc3_:Number = this._countSpeed;
         _loc3_ = Number(Math.min(_loc2_,_loc3_));
         this._cost += _loc3_;
         this._budget -= _loc3_;
         this.updateText();
      }
      
      internal function frame13() : *
      {
         stop();
      }
   }
}
