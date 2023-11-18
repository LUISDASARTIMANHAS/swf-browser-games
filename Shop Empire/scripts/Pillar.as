package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="Pillar")]
   public dynamic class Pillar extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public function Pillar()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
      }
   }
}
