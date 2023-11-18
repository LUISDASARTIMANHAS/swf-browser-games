package APIConnector_fla
{
   import com.newgrounds.components.APIConnector;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="APIConnector_fla.NewgroundsAPIAsset_Login_Warning_5")]
   public dynamic class NewgroundsAPIAsset_Login_Warning_5 extends MovieClip
   {
       
      
      public function NewgroundsAPIAsset_Login_Warning_5()
      {
         super();
         addFrameScript(9,this.frame10,20,this.frame21);
      }
      
      internal function frame10() : *
      {
         stop();
      }
      
      internal function frame21() : *
      {
         APIConnector(parent).clear();
      }
   }
}
