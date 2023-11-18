package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UIlegendbackground_541")]
   public dynamic class UIlegendbackground_541 extends MovieClip
   {
       
      
      public var btnExit:SimpleButton;
      
      public function UIlegendbackground_541()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         btnExit.addEventListener(MouseEvent.CLICK,Closing);
      }
      
      public function Closing(param1:MouseEvent) : void
      {
         this.visible = false;
      }
   }
}
