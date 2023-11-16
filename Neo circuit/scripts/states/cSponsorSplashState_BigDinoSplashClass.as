package states
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   [Embed(source="/_assets/assets.swf", symbol="states.cSponsorSplashState_BigDinoSplashClass")]
   public class cSponsorSplashState_BigDinoSplashClass extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function cSponsorSplashState_BigDinoSplashClass()
      {
         this.dataClass = cSponsorSplashState_BigDinoSplashClass_dataClass;
         super();
         initialWidth = 16000 / 20;
         initialHeight = 12000 / 20;
      }
      
      override public function get movieClipData() : ByteArray
      {
         if(bytes == null)
         {
            bytes = ByteArray(new this.dataClass());
         }
         return bytes;
      }
   }
}
