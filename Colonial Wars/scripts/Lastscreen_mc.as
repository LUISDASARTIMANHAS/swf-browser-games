package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="Lastscreen_mc")]
   public dynamic class Lastscreen_mc extends MovieClip
   {
       
      
      public var submit:SimpleButton;
      
      public var allScores:TextField;
      
      public var levelmap:SimpleButton;
      
      public function Lastscreen_mc()
      {
         super();
      }
   }
}
