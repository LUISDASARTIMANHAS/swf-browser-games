package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="MenuAccPeople")]
   public dynamic class MenuAccPeople extends MovieClip
   {
       
      
      public var enterMall:Boolean;
      
      public var exitMall:Boolean;
      
      public var dx:*;
      
      public function MenuAccPeople()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
      }
   }
}
