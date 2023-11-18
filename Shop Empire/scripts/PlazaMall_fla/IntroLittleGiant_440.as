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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.IntroLittleGiant_440")]
   public dynamic class IntroLittleGiant_440 extends MovieClip
   {
       
      
      public var seTrans:*;
      
      public var vol:*;
      
      public var head:*;
      
      public var newSE:*;
      
      public function IntroLittleGiant_440()
      {
         super();
         addFrameScript(0,frame1,1,frame2,97,frame98,142,frame143);
      }
      
      internal function frame143() : *
      {
         head = root;
         head.play();
         stop();
      }
      
      internal function frame98() : *
      {
         newSE = new SE_Intro_Explode();
         newSE.play(0,0,seTrans);
      }
      
      internal function frame1() : *
      {
         seTrans = new SoundTransform();
      }
      
      internal function frame2() : *
      {
         if(!vol && vol != 0)
         {
            vol = 1;
         }
         seTrans.volume = vol;
      }
   }
}
