package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Tips_597")]
   public dynamic class Tips_597 extends MovieClip
   {
       
      
      public var writeArea:MovieClip;
      
      public var tipsList:TextField;
      
      public function Tips_597()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         tipsList.autoSize = TextFieldAutoSize.LEFT;
         tipsList.mouseEnabled = false;
      }
   }
}
