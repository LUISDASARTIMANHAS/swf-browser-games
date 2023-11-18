package APIConnector_fla
{
   import com.newgrounds.components.APIConnector;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="APIConnector_fla.NewgroundsAPIAsset_Connection_Error_7")]
   public dynamic class NewgroundsAPIAsset_Connection_Error_7 extends MovieClip
   {
       
      
      public function NewgroundsAPIAsset_Connection_Error_7()
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
