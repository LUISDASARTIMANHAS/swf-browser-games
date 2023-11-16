package hud
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import org.flixel.FlxText;
   import org.flixel.plugin.photonstorm.FlxHealthBar;
   
   public class cEnergyBar extends FlxHealthBar
   {
       
      
      protected var m_energy:Number = 0;
      
      protected var m_prevEnergy:Number = 0;
      
      protected var m_text:FlxText;
      
      protected var m_horizontal:Boolean;
      
      public function cEnergyBar(param1:Number, param2:Number, param3:Number, param4:int, param5:int, param6:uint = 0, param7:uint = 100, param8:Boolean = false, param9:Boolean = true)
      {
         super(null,param4,param5,param6,param7,param8);
         this.energy = param3;
         this.m_horizontal = param9;
         x = param1;
         y = param2;
      }
      
      public function set energy(param1:Number) : void
      {
         this.m_energy = param1;
         if(this.m_energy > max)
         {
            this.m_energy = max;
         }
      }
      
      public function get energy() : Number
      {
         return this.m_energy;
      }
      
      override public function update() : void
      {
         if(!visible)
         {
            return;
         }
         if(this.m_energy != this.m_prevEnergy)
         {
            this.updateBar();
         }
      }
      
      override public function setRange(param1:uint, param2:uint) : void
      {
         super.setRange(param1,param2);
         if(!this.m_horizontal)
         {
            pxPerHealth = height / max;
         }
      }
      
      override public function trackParent(param1:int, param2:int) : void
      {
      }
      
      override public function stopTrackingParent(param1:int, param2:int) : void
      {
      }
      
      public function isFull() : Boolean
      {
         return this.m_energy == max;
      }
      
      private function updateBar() : void
      {
         pixels.copyPixels(emptyBar,emptyBarRect,cObjectManager.ZERO_POINT);
         if(this.m_horizontal)
         {
            this.FillHorizontalBar();
         }
         else
         {
            this.FillVerticalBar();
         }
         this.m_prevEnergy = this.m_energy;
      }
      
      private function FillHorizontalBar() : void
      {
         var _loc1_:BitmapData = pixels;
         if(this.m_energy < min)
         {
            filledBarRect.width = int(min * pxPerHealth);
         }
         else if(this.energy > max)
         {
            filledBarRect.width = int(max * pxPerHealth);
         }
         else
         {
            filledBarRect.width = int(this.m_energy * pxPerHealth);
         }
         if(this.m_energy != 0)
         {
            switch(fillDirection)
            {
               case FILL_LEFT_TO_RIGHT:
                  _loc1_.copyPixels(filledBar,filledBarRect,cObjectManager.ZERO_POINT);
                  break;
               case FILL_RIGHT_TO_LEFT:
                  filledBarRect.x = width - filledBarRect.width;
                  _loc1_.copyPixels(filledBar,filledBarRect,new Point(width - filledBarRect.width,0));
                  addr31:
                  break;
               case FILL_INSIDE_OUT:
                  filledBarRect.x = int(width / 2 - filledBarRect.width / 2);
                  _loc1_.copyPixels(filledBar,filledBarRect,new Point(width / 2 - filledBarRect.width / 2,0));
                  if(true)
                  {
                     break;
                  }
                  §§goto(addr31);
            }
         }
         pixels = _loc1_;
      }
      
      private function FillVerticalBar() : void
      {
         var _loc1_:BitmapData = pixels;
         if(this.m_energy < min)
         {
            filledBarRect.height = int(min * pxPerHealth);
         }
         else if(this.energy > max)
         {
            filledBarRect.height = int(max * pxPerHealth);
         }
         else
         {
            filledBarRect.height = int(this.m_energy * pxPerHealth);
         }
         if(this.m_energy != 0)
         {
            switch(fillDirection)
            {
               case FILL_LEFT_TO_RIGHT:
                  _loc1_.copyPixels(filledBar,filledBarRect,cObjectManager.ZERO_POINT);
                  break;
               case FILL_RIGHT_TO_LEFT:
                  filledBarRect.y = height - filledBarRect.height;
                  _loc1_.copyPixels(filledBar,filledBarRect,new Point(0,height - filledBarRect.height));
                  addr31:
                  break;
               case FILL_INSIDE_OUT:
                  filledBarRect.y = int(height / 2 - filledBarRect.height / 2);
                  _loc1_.copyPixels(filledBar,filledBarRect,new Point(0,height / 2 - filledBarRect.height / 2));
                  if(true)
                  {
                     break;
                  }
                  §§goto(addr31);
            }
         }
         pixels = _loc1_;
      }
   }
}
