package TU_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.stats1_108")]
   public dynamic class stats1_108 extends MovieClip
   {
       
      
      public var remaining:TextField;
      
      public var passengersInjured:TextField;
      
      public var passengersDelivered:TextField;
      
      public var company:TextField;
      
      public var passengersKilled:TextField;
      
      public function stats1_108()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
