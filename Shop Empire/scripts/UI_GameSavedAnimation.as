package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="UI_GameSavedAnimation")]
   public dynamic class UI_GameSavedAnimation extends MovieClip
   {
       
      
      public function UI_GameSavedAnimation()
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
