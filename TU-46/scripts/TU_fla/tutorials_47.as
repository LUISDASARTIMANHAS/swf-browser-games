package TU_fla
{
   import com.pavelzuk.planegame.Tracker;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.tutorials_47")]
   public dynamic class tutorials_47 extends MovieClip
   {
       
      
      public var tutorial:MovieClip;
      
      public function tutorials_47()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         if(Tracker.currentCity == "tupolev")
         {
            gotoAndStop(2);
         }
      }
   }
}
