package assets
{
   public class sfx
   {
       
      
      public var SndClick:Class;
      
      public var SndConnect:Class;
      
      public var SndCountDown:Class;
      
      public var SndCut:Class;
      
      public var SndHover:Class;
      
      public var SndHover2:Class;
      
      public var SndLevelStart:Class;
      
      public var SndLoose:Class;
      
      public var SndWin:Class;
      
      public var SndTutorial:Class;
      
      public var SndUpgrade:Class;
      
      public var SndResultDrop:Class;
      
      public var SndMusic:Class;
      
      public var SndMenuMusic:Class;
      
      public var SndPlaceChip:Class;
      
      public var SndUpgrade01:Class;
      
      public var SndUpgrade02:Class;
      
      public var SndUpgrade03:Class;
      
      public var SndUpgrade04:Class;
      
      public var SndUpgrade05:Class;
      
      public var SndUpgrade06:Class;
      
      public var SndUpgrade07:Class;
      
      public var upgrade:Array;
      
      public function sfx()
      {
         this.SndClick = sfx_SndClick;
         this.SndConnect = sfx_SndConnect;
         this.SndCountDown = sfx_SndCountDown;
         this.SndCut = sfx_SndCut;
         this.SndHover = sfx_SndHover;
         this.SndHover2 = sfx_SndHover2;
         this.SndLevelStart = sfx_SndLevelStart;
         this.SndLoose = sfx_SndLoose;
         this.SndWin = sfx_SndWin;
         this.SndTutorial = sfx_SndTutorial;
         this.SndUpgrade = sfx_SndUpgrade;
         this.SndResultDrop = sfx_SndResultDrop;
         this.SndMusic = sfx_SndMusic;
         this.SndMenuMusic = sfx_SndMenuMusic;
         this.SndPlaceChip = sfx_SndPlaceChip;
         this.SndUpgrade01 = sfx_SndUpgrade01;
         this.SndUpgrade02 = sfx_SndUpgrade02;
         this.SndUpgrade03 = sfx_SndUpgrade03;
         this.SndUpgrade04 = sfx_SndUpgrade04;
         this.SndUpgrade05 = sfx_SndUpgrade05;
         this.SndUpgrade06 = sfx_SndUpgrade06;
         this.SndUpgrade07 = sfx_SndUpgrade07;
         this.upgrade = [this.SndUpgrade01,this.SndUpgrade02,this.SndUpgrade03,this.SndUpgrade04,this.SndUpgrade05,this.SndUpgrade06,this.SndUpgrade07];
         super();
      }
   }
}
