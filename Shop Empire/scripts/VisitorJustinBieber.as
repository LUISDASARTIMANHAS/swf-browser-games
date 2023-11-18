package
{
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="VisitorJustinBieber")]
   public class VisitorJustinBieber extends Visitor
   {
       
      
      public function VisitorJustinBieber()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3);
         interestList = new Array("Other");
         MAX_MOOD = 100;
         MIN_MOOD = 26;
         pattiene = 20;
         ACCEL_MOOD = 1;
         speedX = 2;
         specialVisitor = true;
         visitorName = "Justin Mieber";
         gender = true;
         addEventListener(Event.ADDED,Initialize);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}
