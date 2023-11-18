package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="UI_ManualGameSavedAnimation")]
   public dynamic class UI_ManualGameSavedAnimation extends MovieClip
   {
       
      
      public function UI_ManualGameSavedAnimation()
      {
         super();
         addFrameScript(74,frame75);
      }
      
      internal function frame75() : *
      {
         stop();
         this.parent.removeChild(this);
      }
   }
}
