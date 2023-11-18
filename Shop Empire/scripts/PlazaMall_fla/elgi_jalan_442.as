package PlazaMall_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.elgi_jalan_442")]
   public dynamic class elgi_jalan_442 extends MovieClip
   {
       
      
      public var myParent:*;
      
      public var newSE:*;
      
      public function elgi_jalan_442()
      {
         super();
         addFrameScript(0,frame1,6,frame7);
      }
      
      internal function frame7() : *
      {
         newSE = new SE_Intro_Walk();
         newSE.play(0,0,myParent.seTrans);
      }
      
      internal function frame1() : *
      {
         myParent = this.parent;
         newSE = new SE_Intro_Walk();
         newSE.play(0,0,myParent.seTrans);
      }
   }
}
