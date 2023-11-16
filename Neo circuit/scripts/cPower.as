package
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Linear;
   import org.flixel.FlxG;
   import org.flixel.FlxSprite;
   import states.cPlayState;
   import utils.cHelper;
   import utils.cVector2;
   
   public class cPower extends FlxSprite
   {
       
      
      private var m_connection:cConnection;
      
      private var m_lifeTime:Number;
      
      private var m_direction:cVector2;
      
      public function cPower()
      {
         this.m_direction = new cVector2();
         super();
         loadGraphic(NeoCircuit.GFX.ImgPower,true,false,18,18);
         addAnimation("1",[0,1,2,3,2,1],10);
         addAnimation("2",[4,5,6,7,6,5],10);
         addAnimation("3",[8,9,10,11,10,9],10);
         addAnimation("4",[12,13,14,15,14,13],10);
      }
      
      public function init(param1:cConnection, param2:Number) : void
      {
         this.m_connection = param1;
         alpha = 0;
         health = param2;
         if(health > 1)
         {
            loadGraphic(NeoCircuit.GFX.ImgPowerBig,true,false,27,27);
         }
         else
         {
            loadGraphic(NeoCircuit.GFX.ImgPower,true,false,18,18);
         }
         if(param1.counterConnection == null)
         {
            this.m_lifeTime = param1.conLength / param1.startCPU.data.powerSpeed;
         }
         else
         {
            this.m_lifeTime = param1.conLength * 0.5 / param1.startCPU.data.powerSpeed;
         }
         play(param1.startCPU.owner.toString());
         do
         {
            x = param1.xStart - width * 0.5;
            y = param1.yStart - height * 0.5;
         }
         while(false);
         
         var _loc3_:Number = param1.xEnd - width * 0.5;
         var _loc4_:Number = param1.yEnd - height * 0.5;
         reset(x,y);
         TweenLite.to(this,0.25,{"alpha":1});
         TweenLite.to(this,this.m_lifeTime / (FlxG.state as cPlayState).gameSpeed,{
            "overwrite":0,
            "x":_loc3_,
            "y":_loc4_,
            "onComplete":this.onKill,
            "ease":Linear.easeNone
         });
      }
      
      override public function destroy() : void
      {
         TweenLite.killTweensOf(this);
         super.destroy();
      }
      
      public function toggleGameSpeed() : void
      {
         var _loc1_:Number = this.m_connection.xEnd - width * 0.5;
         var _loc2_:Number = this.m_connection.yEnd - height * 0.5;
         var _loc3_:Number = cHelper.distance(x,y,_loc1_,_loc2_);
         this.m_lifeTime *= _loc3_ / this.m_connection.conLength;
         TweenLite.to(this,this.m_lifeTime / (FlxG.state as cPlayState).gameSpeed,{
            "x":_loc1_,
            "y":_loc2_,
            "onComplete":this.onKill,
            "ease":Linear.easeNone
         });
      }
      
      public function resetMovement() : void
      {
         TweenLite.killTweensOf(this);
         if(alpha != 1)
         {
            alpha = 1;
         }
         var _loc1_:Number = this.m_connection.xEnd - width * 0.5;
         var _loc2_:Number = this.m_connection.yEnd - height * 0.5;
         var _loc3_:Number = cHelper.distance(x,y,_loc1_,_loc2_);
         this.m_lifeTime *= _loc3_ / this.m_connection.conLength;
         TweenLite.to(this,this.m_lifeTime * (FlxG.state as cPlayState).gameSpeed,{
            "x":_loc1_,
            "y":_loc2_,
            "onComplete":this.onKill,
            "ease":Linear.easeNone
         });
      }
      
      private function onKill() : void
      {
         if(!alive)
         {
            return;
         }
         this.m_lifeTime = 0;
         this.m_connection.killPower(this);
         this.kill();
      }
      
      override public function kill() : void
      {
         if(!alive)
         {
            return;
         }
         TweenLite.killTweensOf(this);
         super.kill();
      }
   }
}
