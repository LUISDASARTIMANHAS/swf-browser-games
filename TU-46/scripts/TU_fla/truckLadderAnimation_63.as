package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.truckLadderAnimation_63")]
   public dynamic class truckLadderAnimation_63 extends MovieClip
   {
       
      
      public function truckLadderAnimation_63()
      {
         super();
         addFrameScript(124,this.frame125,239,this.frame240);
      }
      
      internal function frame240() : *
      {
         stop();
      }
      
      internal function frame125() : *
      {
         GameController.playSound("cabinSound");
      }
   }
}
