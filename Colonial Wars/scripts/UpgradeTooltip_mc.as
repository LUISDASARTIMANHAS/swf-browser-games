package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="UpgradeTooltip_mc")]
   public dynamic class UpgradeTooltip_mc extends MovieClip
   {
       
      
      public var price:TextField;
      
      public var text:TextField;
      
      public var coins:MovieClip;
      
      public function UpgradeTooltip_mc()
      {
         super();
      }
   }
}
