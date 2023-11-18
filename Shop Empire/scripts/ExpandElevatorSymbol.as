package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   
   [Embed(source="/_assets/assets.swf", symbol="ExpandElevatorSymbol")]
   public dynamic class ExpandElevatorSymbol extends MovieClip
   {
       
      
      public var body:ElevatorMain;
      
      public var canBuild:*;
      
      public function ExpandElevatorSymbol()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function clean(param1:Event) : void
      {
         removeEventListener(Event.REMOVED,clean);
         removeEventListener(Event.ENTER_FRAME,animate);
      }
      
      internal function frame1() : *
      {
         addEventListener(Event.REMOVED,clean);
         addEventListener(Event.ENTER_FRAME,animate);
      }
      
      public function animate(param1:Event) : void
      {
         if(canBuild)
         {
            this.transform.colorTransform = new ColorTransform(1,1,1,0.3,0,0,0,0);
         }
         else
         {
            this.transform.colorTransform = new ColorTransform(1,0,0,0.3,0,0,0,0);
         }
      }
   }
}
