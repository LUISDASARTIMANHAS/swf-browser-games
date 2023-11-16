package utils
{
   public class cMatrix2D
   {
      
      private static var m_cache:cMatrix2D = new cMatrix2D();
      
      private static var m_transform:cMatrix2D = new cMatrix2D();
       
      
      private var a1:Number;
      
      private var a2:Number;
      
      private var a3:Number;
      
      private var b1:Number;
      
      private var b2:Number;
      
      private var b3:Number;
      
      private var c1:Number;
      
      private var c2:Number;
      
      private var c3:Number;
      
      public function cMatrix2D(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 1, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 1)
      {
         super();
         this.a1 = param1;
         this.a2 = param2;
         this.a3 = param3;
         this.b1 = param4;
         this.b2 = param5;
         this.b3 = param6;
         this.c1 = param7;
         this.c2 = param8;
         this.c3 = param9;
      }
      
      public function copy() : cMatrix2D
      {
         return new cMatrix2D(this.a1,this.a2,this.a3,this.b1,this.b2,this.b3,this.c1,this.c2,this.c3);
      }
      
      public function set(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 1, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 1) : void
      {
         this.a1 = param1;
         this.a2 = param2;
         this.a3 = param3;
         this.b1 = param4;
         this.b2 = param5;
         this.b3 = param6;
         this.c1 = param7;
         this.c2 = param8;
         this.c3 = param9;
      }
      
      public function multiply(param1:cMatrix2D) : void
      {
         m_cache.a1 = this.a1 * param1.a1 + this.a2 * param1.b1 + this.a3 * param1.c1;
         m_cache.a2 = this.a1 * param1.a2 + this.a2 * param1.b2 + this.a3 * param1.c2;
         m_cache.a3 = this.a1 * param1.a3 + this.a2 * param1.b3 + this.a3 * param1.c3;
         m_cache.b1 = this.b1 * param1.a1 + this.b2 * param1.b1 + this.b3 * param1.c1;
         m_cache.b2 = this.b1 * param1.a2 + this.b2 * param1.b2 + this.b3 * param1.c2;
         m_cache.b3 = this.b1 * param1.a3 + this.b2 * param1.b3 + this.b3 * param1.c3;
         m_cache.c1 = this.c1 * param1.a1 + this.c2 * param1.b1 + this.c3 * param1.c1;
         m_cache.c2 = this.c1 * param1.a2 + this.c2 * param1.b2 + this.c3 * param1.c2;
         m_cache.c3 = this.c1 * param1.a3 + this.c2 * param1.b3 + this.c3 * param1.c3;
         this.set(m_cache.a1,m_cache.a2,m_cache.a3,m_cache.b1,m_cache.b2,m_cache.b3,m_cache.c1,m_cache.c2,m_cache.c3);
      }
      
      public function transformVector(param1:cVector2) : void
      {
         var _loc2_:Number = this.a1 * param1.x + this.b1 * param1.y + this.c1;
         var _loc3_:Number = this.a2 * param1.x + this.b2 * param1.y + this.c2;
         param1.x = _loc2_;
         param1.y = _loc3_;
      }
      
      public function translate(param1:Number, param2:Number) : void
      {
         m_transform.set(1,0,0,0,1,0,param1,param2,1);
         this.multiply(m_transform);
      }
      
      public function scale(param1:Number, param2:Number) : void
      {
         m_transform.set(param1,0,0,0,param2,0,0,0,1);
         this.multiply(m_transform);
      }
      
      public function rotate(param1:Number) : void
      {
         var _loc2_:Number = Number(Math.sin(param1));
         var _loc3_:Number = Number(Math.cos(param1));
         m_transform.set(_loc3_,_loc2_,0,-_loc2_,_loc3_,0,0,0,1);
         this.multiply(m_transform);
      }
      
      public function rotateVector(param1:cVector2, param2:cVector2) : void
      {
         m_transform.set(param1.x,param1.y,0,param2.x,param2.y,0,0,0,1);
         this.multiply(m_transform);
      }
   }
}
