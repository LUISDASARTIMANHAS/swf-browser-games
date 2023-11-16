package
{
   import patterns.cEnum;
   
   public class cPlayerAiData
   {
      
      public static const ATTACKER_TYPE:int = cEnum.Enum(0);
      
      public static const BALANCED_TYPE:int = cEnum.inc;
      
      public static const DEFENDER_TYPE:int = cEnum.inc;
      
      public static const MAX_PLAYERAI_DATA:int = 3;
       
      
      public var init:Array;
      
      public var attackPlayerThreshold:Number;
      
      public var attackNeutralThreshold:Number;
      
      public var supportThreshold:Number;
      
      public var keepPowerThreshold:Number;
      
      public var keepPowerSafetyThreshold:Number;
      
      public var supportSafetyThreshold:Number;
      
      public var upgradeThreshold:Number;
      
      public var cutSupportSafetyThreshold:Number;
      
      public var upgradeSafety:Number;
      
      public function cPlayerAiData()
      {
         super();
         this.init = [this.ATTACKER,this.BALANCED,this.DEFENDER];
      }
      
      private function ATTACKER() : void
      {
         this.attackPlayerThreshold = 0;
         this.attackNeutralThreshold = 0;
         this.supportThreshold = 0.25;
         this.upgradeThreshold = 0.25;
         this.supportSafetyThreshold = 0.5;
         this.keepPowerThreshold = 0.1;
         this.keepPowerSafetyThreshold = 0.25;
         this.cutSupportSafetyThreshold = 0.5;
         this.upgradeSafety = 0.25;
      }
      
      private function BALANCED() : void
      {
         this.attackPlayerThreshold = 0.25;
         this.attackNeutralThreshold = 0.1;
         this.supportThreshold = 0.2;
         this.upgradeThreshold = 0.5;
         this.supportSafetyThreshold = 0.75;
         this.keepPowerThreshold = 0.25;
         this.keepPowerSafetyThreshold = 0.5;
         this.cutSupportSafetyThreshold = 0.75;
         this.upgradeSafety = 0.5;
      }
      
      private function DEFENDER() : void
      {
         this.attackPlayerThreshold = 0.4;
         this.attackNeutralThreshold = 0.25;
         this.supportThreshold = 0.1;
         this.upgradeThreshold = 0.75;
         this.supportSafetyThreshold = 0.75;
         this.keepPowerThreshold = 0.35;
         this.keepPowerSafetyThreshold = 0.5;
         this.cutSupportSafetyThreshold = 0.75;
         this.upgradeSafety = 0.75;
      }
   }
}
