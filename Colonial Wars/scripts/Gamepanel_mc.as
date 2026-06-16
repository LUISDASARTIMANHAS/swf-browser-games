package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="Gamepanel_mc")]
   public dynamic class Gamepanel_mc extends MovieClip
   {
       
      
      public var muteOff:SimpleButton;
      
      public var muteOn:SimpleButton;
      
      public var restart:SimpleButton;
      
      public var menu:SimpleButton;
      
      public var pause:SimpleButton;
      
      public var bg_mc:MovieClip;
      
      public function Gamepanel_mc()
      {
         super();
      }
   }
}
