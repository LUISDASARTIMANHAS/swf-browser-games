package
{
   public class cCpuAiData
   {
       
      
      public var neighbourList:Array;
      
      public var supporterOf:Array;
      
      public var nearestEnemy:cCPU;
      
      public var nearestNeutral:cCPU;
      
      public var nearestFriend:cCPU;
      
      public var weakestFriend:cCPU;
      
      public var strongestFriend:cCPU;
      
      public var safety:Number;
      
      public var attackPower:int;
      
      public var defensePower:int;
      
      public var upgrade:Boolean;
      
      public function cCpuAiData()
      {
         this.supporterOf = [];
         super();
      }
   }
}
