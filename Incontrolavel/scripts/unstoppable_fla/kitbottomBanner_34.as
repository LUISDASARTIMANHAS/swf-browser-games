package unstoppable_fla
{
   import com.memecounter.Tracker;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.kitbottomBanner_34")]
   public dynamic class kitbottomBanner_34 extends MovieClip
   {
       
      
      public var link_btn:SimpleButton;
      
      public function kitbottomBanner_34()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,39,this.frame40);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         this.link_btn.addEventListener(MouseEvent.CLICK,this.onLinkClicked,false,0,true);
      }
      
      internal function frame40() : *
      {
         stop();
      }
      
      public function onLinkClicked(param1:MouseEvent) : void
      {
         var _loc2_:String = KemptTrans.getTranslation("unstoppable_link");
         var _loc3_:String = KemptTrans.getTranslation("unstoppable_link_id");
         var _loc4_:int = int(parseInt(_loc3_));
         trace("ID: " + _loc4_);
         if(!_loc2_ || _loc2_.length == 0)
         {
            trace("wrong url: \"" + _loc2_ + "\"");
         }
         else if(!_loc4_)
         {
            trace("wrong id: \"" + _loc3_ + "\"");
         }
         else
         {
            Tracker.kvClick(_loc4_);
            navigateToURL(new URLRequest(_loc2_),"_blank");
         }
      }
   }
}
