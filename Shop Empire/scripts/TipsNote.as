package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TipsNote")]
   public dynamic class TipsNote extends MovieClip
   {
       
      
      public var note:MovieClip;
      
      public function TipsNote()
      {
         super();
         addFrameScript(148,frame149);
      }
      
      internal function frame149() : *
      {
         stop();
         this.parent.removeChild(this);
      }
   }
}
