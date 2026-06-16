package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="InputScreen_mc")]
   public dynamic class InputScreen_mc extends MovieClip
   {
       
      
      public var input_name:TextField;
      
      public var title:MovieClip;
      
      public var okay:SimpleButton;
      
      public var close:SimpleButton;
      
      public function InputScreen_mc()
      {
         super();
      }
   }
}
