package
{
   public class cLineData
   {
       
      
      public var startCpu:cCPU;
      
      public var endCpu:cCPU;
      
      public var xStart:Number;
      
      public var yStart:Number;
      
      public var xEnd:Number;
      
      public var yEnd:Number;
      
      public var powerCost:int = 0;
      
      public var upgradeTime:Number = 0;
      
      public function cLineData(param1:Number, param2:Number, param3:cCPU)
      {
         super();
         this.startCpu = param3;
         this.upgradeTime = 0;
         this.endCpu = null;
         if(param3 != null)
         {
            this.xStart = param3.x + param3.origin.x;
            this.yStart = param3.y + param3.origin.y;
            this.xEnd = param1;
            this.yEnd = param2;
         }
         else
         {
            this.powerCost = 0;
            this.xStart = param1;
            this.yStart = param2;
            this.xEnd = param1;
            this.yEnd = param2;
         }
      }
   }
}
