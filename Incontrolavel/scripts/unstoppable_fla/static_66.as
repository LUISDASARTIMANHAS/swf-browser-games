package unstoppable_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.static_66")]
   public dynamic class static_66 extends MovieClip
   {
       
      
      public function static_66()
      {
         super();
         addFrameScript(15,this.frame16,24,this.frame25);
      }
      
      internal function frame25() : *
      {
         if(Math.random() < 0.4)
         {
            gotoAndPlay(1);
         }
      }
      
      internal function frame16() : *
      {
         if(Math.random() < 0.4)
         {
            gotoAndPlay(1);
         }
      }
   }
}
