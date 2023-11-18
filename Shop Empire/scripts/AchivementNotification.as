package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="AchivementNotification")]
   public dynamic class AchivementNotification extends MovieClip
   {
       
      
      public var body:MovieClip;
      
      public function AchivementNotification()
      {
         super();
         addFrameScript(69,frame70);
      }
      
      internal function frame70() : *
      {
         stop();
         this.parent.removeChild(this);
      }
   }
}
