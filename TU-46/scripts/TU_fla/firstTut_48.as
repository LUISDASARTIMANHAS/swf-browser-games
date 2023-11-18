package TU_fla
{
   import com.pavelzuk.planegame.Controller;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.firstTut_48")]
   public dynamic class firstTut_48 extends MovieClip
   {
       
      
      public function firstTut_48()
      {
         super();
         addFrameScript(209,this.frame210,459,this.frame460,2270,this.frame2271);
      }
      
      internal function frame460() : *
      {
         stop();
         if(Boolean(Controller.level) && Boolean(Controller.level.gameClip))
         {
            this.addEventListener(Event.ENTER_FRAME,this.loop);
         }
      }
      
      internal function frame210() : *
      {
         stop();
         if(Boolean(Controller.level) && Boolean(Controller.level.gameClip))
         {
            this.addEventListener(Event.ENTER_FRAME,this.loop3);
         }
      }
      
      internal function frame2271() : *
      {
         stop();
      }
      
      public function loop(param1:Event) : *
      {
         if(!Controller.level || !Controller.level.gameClip)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.loop);
         }
         if(Boolean(Controller.level) && Boolean(Controller.level.gameClip))
         {
            if(Controller.level.gameClip.y > 65)
            {
               play();
               this.removeEventListener(Event.ENTER_FRAME,this.loop);
            }
         }
      }
      
      public function loop3(param1:Event) : *
      {
         if(!Controller.level || !Controller.level.gameClip)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.loop3);
         }
         if(Controller.level.plane)
         {
            if(Controller.level.plane.engineOn == true)
            {
               play();
               this.removeEventListener(Event.ENTER_FRAME,this.loop3);
            }
         }
      }
   }
}
