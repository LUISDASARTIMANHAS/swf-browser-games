package APIConnector_fla
{
   import com.newgrounds.components.APIConnector;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="APIConnector_fla.NewgroundsAPIAsset_API_Conencted_4")]
   public dynamic class NewgroundsAPIAsset_API_Conencted_4 extends MovieClip
   {
       
      
      public function NewgroundsAPIAsset_API_Conencted_4()
      {
         super();
         addFrameScript(36,this.frame37);
      }
      
      internal function frame37() : *
      {
         APIConnector(parent).clear();
      }
   }
}
