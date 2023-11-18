package APIConnector_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="APIConnector_fla.NewgroundsAPIAsset_Load_Indicator_3")]
   public dynamic class NewgroundsAPIAsset_Load_Indicator_3 extends MovieClip
   {
       
      
      public function NewgroundsAPIAsset_Load_Indicator_3()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function onEnterFrame(param1:Event) : void
      {
         if(Boolean(visible) && Boolean(stage))
         {
            rotation += 30;
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      internal function frame1() : *
      {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
   }
}
