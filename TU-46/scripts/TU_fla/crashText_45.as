package TU_fla
{
   import com.pavelzuk.planegame.Controller;
   import com.pavelzuk.planegame.Tracker;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.crashText_45")]
   public dynamic class crashText_45 extends MovieClip
   {
       
      
      public function crashText_45()
      {
         super();
         addFrameScript(0,this.frame1,99,this.frame100,209,this.frame210,319,this.frame320,429,this.frame430);
      }
      
      internal function frame210() : *
      {
         stop();
         Tracker.saveInfo();
         Controller.gameOver = true;
         GameController.transition.playTween(function():*
         {
            Controller.destroy();
            if(Tracker.currentCity == "tupolev")
            {
               GameController.timeline.gotoAndStop(14);
               GameController.timeline.gotoAndStop(15);
            }
            else
            {
               GameController.timeline.gotoAndStop(30);
            }
         });
      }
      
      internal function frame320() : *
      {
         stop();
         Tracker.saveInfo();
         Controller.gameOver = true;
         GameController.transition.playTween(function():*
         {
            Controller.destroy();
            GameController.timeline.gotoAndStop(30);
         });
      }
      
      internal function frame430() : *
      {
         stop();
         Tracker.saveInfo();
         Controller.gameOver = true;
         GameController.transition.playTween(function():*
         {
            Controller.destroy();
            GameController.timeline.gotoAndStop(30);
         });
      }
      
      internal function frame100() : *
      {
         stop();
         Tracker.saveInfo();
         Controller.gameOver = true;
         GameController.transition.playTween(function():*
         {
            Controller.destroy();
            if(Tracker.currentCity == "tupolev")
            {
               GameController.timeline.gotoAndStop(14);
               GameController.timeline.gotoAndStop(15);
            }
            else
            {
               GameController.timeline.gotoAndStop(30);
            }
         });
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
