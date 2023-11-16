package
{
   public class cAchievementData
   {
      
      public static const NUM_ACHIEVEMENTS:int = 16;
       
      
      public var init:Array;
      
      public var type:int;
      
      public var heading:String;
      
      public var text:String;
      
      public var checkValue:int;
      
      public var image:Class;
      
      public function cAchievementData()
      {
         super();
         this.init = [this.A00,this.A01,this.A02,this.A03,this.A04,this.A05,this.A06,this.A07,this.A08,this.A09,this.A10,this.A11,this.A12,this.A13,this.A14,this.A15];
      }
      
      public function A00() : void
      {
         this.heading = "Achievment 1";
         this.text = "";
         this.image = null;
         this.checkValue = -1;
      }
      
      public function A01() : void
      {
      }
      
      public function A02() : void
      {
      }
      
      public function A03() : void
      {
      }
      
      public function A04() : void
      {
      }
      
      public function A05() : void
      {
      }
      
      public function A06() : void
      {
      }
      
      public function A07() : void
      {
      }
      
      public function A08() : void
      {
      }
      
      public function A09() : void
      {
      }
      
      public function A10() : void
      {
      }
      
      public function A11() : void
      {
      }
      
      public function A12() : void
      {
      }
      
      public function A13() : void
      {
      }
      
      public function A14() : void
      {
      }
      
      public function A15() : void
      {
      }
   }
}
