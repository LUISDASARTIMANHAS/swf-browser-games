package
{
   import com.lib.*;
   import flash.geom.*;
   
   public class BlockData
   {
       
      
      public var block_line60_45:Object;
      
      public var block_line50:Object;
      
      public var block_line10:Object;
      
      public var block_line90:Object;
      
      public var block_cross45:Object;
      
      public var block_s1:Object;
      
      public var block_s2:Object;
      
      public var block_s3:Object;
      
      public var block_s4:Object;
      
      public var block_s5:Object;
      
      public var block_o2:Object;
      
      public var block_o3:Object;
      
      public var block_o4:Object;
      
      public var block_o5:Object;
      
      public var block_sCross1:Object;
      
      public var block_sCross2:Object;
      
      public var block_sCross3:Object;
      
      public var block_arc90_90:Object;
      
      public var block_line60:Object;
      
      public var block_o1:Object;
      
      public var block_line20:Object;
      
      private var levelScale:* = 0.7;
      
      public var block_p2:Object;
      
      public var block_t1:Object;
      
      private var main:*;
      
      public var block_p1:Object;
      
      public var block_line70:Object;
      
      public var block_arc90_60:Object;
      
      public var block_line30:Object;
      
      public var block_line180:Object;
      
      public var block_p3:Object;
      
      public var blockList:Array;
      
      public var block_line80:Object;
      
      public var block_line40:Object;
      
      public var block_cross45_half:Object;
      
      public var block_a3:Object;
      
      public var block_arc90_30:Object;
      
      public var block_a1:Object;
      
      public var block_a2:Object;
      
      public var block_a4:Object;
      
      public var block_line30_45:Object;
      
      public function BlockData(param1:*)
      {
         this.block_arc90_30 = {
            "name":"block_arc90_30",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]}],
            "connectpnts":[0,9],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            }],
            "clip":Track_arc90_30
         };
         this.block_arc90_60 = {
            "name":"block_arc90_60",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]}],
            "connectpnts":[0,9],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            }],
            "clip":Track_arc90_60
         };
         this.block_arc90_90 = {
            "name":"block_arc90_90",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]}],
            "connectpnts":[0,9],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            }],
            "clip":Track_arc90_90
         };
         this.block_line10 = {
            "name":"block_line10",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":10,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line10,
            "boundscale":true
         };
         this.block_line20 = {
            "name":"block_line20",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":20,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line20,
            "boundscale":true
         };
         this.block_line30 = {
            "name":"block_line30",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":30,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line30,
            "boundscale":true
         };
         this.block_line40 = {
            "name":"block_line40",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":40,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line40,
            "boundscale":true
         };
         this.block_line50 = {
            "name":"block_line50",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":50,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line50,
            "boundscale":true
         };
         this.block_line60 = {
            "name":"block_line60",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":60,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line60,
            "boundscale":true
         };
         this.block_line70 = {
            "name":"block_line70",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":70,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line70,
            "boundscale":true
         };
         this.block_line80 = {
            "name":"block_line80",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":80,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line80,
            "boundscale":true
         };
         this.block_line90 = {
            "name":"block_line90",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":90,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line90,
            "boundscale":true
         };
         this.block_line180 = {
            "name":"block_line180",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":180,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line180,
            "boundscale":true
         };
         this.block_line30_45 = {
            "name":"block_line30_45",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":30,
               "y":30,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line30_45
         };
         this.block_line60_45 = {
            "name":"block_line60_45",
            "pnts":[{
               "x":0,
               "y":0,
               "indices":[1]
            },{
               "x":60,
               "y":60,
               "indices":[0]
            }],
            "connectpnts":[0,1],
            "lines":[{
               "a":0,
               "b":1
            }],
            "clip":Track_line60_45
         };
         this.block_cross45 = {
            "name":"block_cross45",
            "pnts":[{
               "x":0,
               "y":30,
               "indices":[1]
            },{
               "x":60,
               "y":30,
               "indices":[0]
            },{
               "x":0,
               "y":0,
               "indices":[3]
            },{
               "x":60,
               "y":60,
               "indices":[2]
            }],
            "connectpnts":[0,1,2,3],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":2,
               "b":3
            }],
            "clip":Track_cross45
         };
         this.block_cross45_half = {
            "name":"block_cross45_half",
            "pnts":[{
               "x":0,
               "y":30,
               "indices":[1]
            },{
               "x":60,
               "y":30,
               "indices":[0]
            },{
               "x":0,
               "y":0,
               "indices":[3]
            },{
               "x":30,
               "y":30,
               "indices":[2]
            }],
            "connectpnts":[0,1,2,3],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":2,
               "b":3
            }],
            "clip":Track_cross45_half
         };
         this.block_s1 = {
            "name":"block_s1",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]}],
            "connectpnts":[0,9],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            }],
            "clip":Track_s1
         };
         this.block_s2 = {
            "name":"block_s2",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8,10]},{
               "x":0,
               "y":30,
               "indices":[9]
            }],
            "connectpnts":[0,9,10],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":9,
               "b":10
            }],
            "clip":Track_s2
         };
         this.block_s3 = {
            "name":"block_s3",
            "pnts":[{"indices":[1,11]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8,10]},{
               "x":0,
               "y":30,
               "indices":[9]
            },{
               "x":90,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,9,10,11],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":9,
               "b":10
            },{
               "a":0,
               "b":11
            }],
            "clip":Track_s3
         };
         this.block_s4 = {
            "name":"block_s4",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]}],
            "connectpnts":[0,9],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            }],
            "clip":Track_s4
         };
         this.block_s5 = {
            "name":"block_s5",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]}],
            "connectpnts":[0,9],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            }],
            "clip":Track_s5
         };
         this.block_a1 = {
            "name":"block_a1",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]}],
            "connectpnts":[0,9],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            }],
            "clip":Track_a1
         };
         this.block_a2 = {
            "name":"block_a2",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":0,
               "y":30,
               "indices":[11]
            },{
               "x":90,
               "y":30,
               "indices":[10]
            }],
            "connectpnts":[0,9,10,11],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":10,
               "b":11
            }],
            "clip":Track_a2
         };
         this.block_a3 = {
            "name":"block_a3",
            "pnts":[{"indices":[1,10]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":60,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,9,10],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":0,
               "b":10
            }],
            "clip":Track_a3
         };
         this.block_a4 = {
            "name":"block_a4",
            "pnts":[{"indices":[1,12]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":0,
               "y":30,
               "indices":[11]
            },{
               "x":90,
               "y":30,
               "indices":[10]
            },{
               "x":60,
               "y":0,
               "indices":[0]
            }],
            "connectpnts":[0,9,10,11,12],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":10,
               "b":11
            },{
               "a":0,
               "b":12
            }],
            "clip":Track_a4
         };
         this.block_sCross1 = {
            "name":"block_sCross1",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{"indices":[11]},{"indices":[10,12]},{"indices":[11,13]},{"indices":[12,14]},{"indices":[13,15]},{"indices":[14,16]},{"indices":[15,17]},{"indices":[16,18]},{"indices":[17,19]},{"indices":[18]}],
            "connectpnts":[0,9,10,19],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":10,
               "b":11
            },{
               "a":11,
               "b":12
            },{
               "a":12,
               "b":13
            },{
               "a":13,
               "b":14
            },{
               "a":14,
               "b":15
            },{
               "a":15,
               "b":16
            },{
               "a":16,
               "b":17
            },{
               "a":17,
               "b":18
            },{
               "a":18,
               "b":19
            }],
            "clip":Track_sCross1
         };
         this.block_sCross2 = {
            "name":"block_sCross2",
            "pnts":[{"indices":[1,19]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8,10]},{"indices":[11,9]},{"indices":[10,12]},{"indices":[11,13]},{"indices":[12,14]},{"indices":[13,15]},{"indices":[14,16]},{"indices":[15,17]},{"indices":[16,18]},{"indices":[17,19]},{"indices":[18,0]}],
            "connectpnts":[0,9,10,19],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":10,
               "b":11
            },{
               "a":11,
               "b":12
            },{
               "a":12,
               "b":13
            },{
               "a":13,
               "b":14
            },{
               "a":14,
               "b":15
            },{
               "a":15,
               "b":16
            },{
               "a":16,
               "b":17
            },{
               "a":17,
               "b":18
            },{
               "a":18,
               "b":19
            },{
               "a":0,
               "b":19
            },{
               "a":9,
               "b":10
            }],
            "clip":Track_sCross2
         };
         this.block_sCross3 = {
            "name":"block_sCross3",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8,10]},{"indices":[11,9]},{"indices":[10,12]},{"indices":[11,13]},{"indices":[12,14]},{"indices":[13,15]},{"indices":[14,16]},{"indices":[15,17]},{"indices":[16,18]},{"indices":[17,19]},{"indices":[18]}],
            "connectpnts":[0,9,10,19],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":10,
               "b":11
            },{
               "a":11,
               "b":12
            },{
               "a":12,
               "b":13
            },{
               "a":13,
               "b":14
            },{
               "a":14,
               "b":15
            },{
               "a":15,
               "b":16
            },{
               "a":16,
               "b":17
            },{
               "a":17,
               "b":18
            },{
               "a":18,
               "b":19
            },{
               "a":9,
               "b":10
            }],
            "clip":Track_sCross3
         };
         this.block_t1 = {
            "name":"block_t1",
            "pnts":[{"indices":[1,10]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":30,
               "y":30,
               "indices":[0]
            }],
            "connectpnts":[0,9,10],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":0,
               "b":10
            }],
            "clip":Track_t1
         };
         this.block_o1 = {
            "name":"block_o1",
            "pnts":[{"indices":[1,10]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":90,
               "y":60,
               "indices":[0]
            }],
            "connectpnts":[0,9,10],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":0,
               "b":10
            }],
            "clip":Track_o1
         };
         this.block_o2 = {
            "name":"block_o2",
            "pnts":[{"indices":[1,10]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":60,
               "y":60,
               "indices":[0]
            },{
               "x":30,
               "y":30,
               "indices":[12]
            },{
               "x":60,
               "y":30,
               "indices":[11]
            }],
            "connectpnts":[0,9,10,11,12],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":0,
               "b":10
            },{
               "a":11,
               "b":12
            }],
            "clip":Track_o2
         };
         this.block_o3 = {
            "name":"block_o3",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":30,
               "y":30,
               "indices":[11]
            },{
               "x":60,
               "y":30,
               "indices":[10]
            }],
            "connectpnts":[0,9,10,11],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":10,
               "b":11
            }],
            "clip":Track_o3
         };
         this.block_o4 = {
            "name":"block_o4",
            "pnts":[{"indices":[1,10]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":30,
               "y":60,
               "indices":[0]
            }],
            "connectpnts":[0,9,10],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":0,
               "b":10
            }],
            "clip":Track_o4
         };
         this.block_o5 = {
            "name":"block_o5",
            "pnts":[{"indices":[1,10]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8,11]},{
               "x":30,
               "y":60,
               "indices":[0]
            },{
               "x":60,
               "y":30,
               "indices":[9]
            }],
            "connectpnts":[0,9,10,11],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":0,
               "b":10
            },{
               "a":9,
               "b":11
            }],
            "clip":Track_o5
         };
         this.block_p1 = {
            "name":"block_p1",
            "pnts":[{"indices":[1,10]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":30,
               "y":90,
               "indices":[0]
            }],
            "connectpnts":[0,9,10],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":0,
               "b":10
            }],
            "clip":Track_p1
         };
         this.block_p2 = {
            "name":"block_p2",
            "pnts":[{"indices":[1,10]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8,11]},{
               "x":30,
               "y":90,
               "indices":[0]
            },{
               "x":90,
               "y":30,
               "indices":[9]
            }],
            "connectpnts":[0,9,10,11],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":0,
               "b":10
            },{
               "a":9,
               "b":11
            }],
            "clip":Track_p2
         };
         this.block_p3 = {
            "name":"block_p3",
            "pnts":[{"indices":[1]},{"indices":[0,2]},{"indices":[1,3]},{"indices":[2,4]},{"indices":[3,5]},{"indices":[4,6]},{"indices":[5,7]},{"indices":[6,8]},{"indices":[7,9]},{"indices":[8]},{
               "x":60,
               "y":30,
               "indices":[11]
            },{
               "x":90,
               "y":30,
               "indices":[10]
            },{
               "x":60,
               "y":60,
               "indices":[13]
            },{
               "x":90,
               "y":60,
               "indices":[12]
            }],
            "connectpnts":[0,9,10,11,12,13],
            "lines":[{
               "a":0,
               "b":1
            },{
               "a":1,
               "b":2
            },{
               "a":2,
               "b":3
            },{
               "a":3,
               "b":4
            },{
               "a":4,
               "b":5
            },{
               "a":5,
               "b":6
            },{
               "a":6,
               "b":7
            },{
               "a":7,
               "b":8
            },{
               "a":8,
               "b":9
            },{
               "a":10,
               "b":11
            },{
               "a":12,
               "b":13
            }],
            "clip":Track_p3
         };
         this.blockList = [this.block_arc90_30,this.block_arc90_60,this.block_arc90_90,this.block_line10,this.block_line20,this.block_line30,this.block_line40,this.block_line50,this.block_line60,this.block_line70,this.block_line80,this.block_line90,this.block_line180,this.block_line30_45,this.block_line60_45,this.block_cross45,this.block_cross45_half,this.block_s1,this.block_s2,this.block_s3,this.block_s4,this.block_s5,this.block_sCross1,this.block_sCross2,this.block_sCross3,this.block_a1,this.block_a2,this.block_a3,this.block_a4,this.block_t1,this.block_o1,this.block_o2,this.block_o3,this.block_o4,this.block_o5,this.block_p1,this.block_p2,this.block_p3];
         super();
         this.main = param1;
         this.makeBlocks();
      }
      
      private function makeArc(param1:Number, param2:Number = 0, param3:Number = 360, param4:int = 100) : *
      {
         var _loc7_:* = undefined;
         var _loc5_:* = new Array();
         var _loc6_:* = 0;
         while(_loc6_ <= param4)
         {
            _loc7_ = param2 + (param3 - param2) * (_loc6_ / param4);
            _loc5_.push({
               "x":this.ax(param1,_loc7_),
               "y":this.ay(param1,_loc7_)
            });
            _loc6_++;
         }
         return _loc5_;
      }
      
      private function ay(param1:Number, param2:Number) : *
      {
         return param1 * Math.cos(param2 * Math.PI / 180);
      }
      
      private function makeBlocks() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = this.makeArc(30,0,90,this.block_arc90_30.lines.length);
         for(_loc2_ in _loc1_)
         {
            this.block_arc90_30.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_arc90_30.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(60,0,90,this.block_arc90_60.lines.length);
         for(_loc2_ in _loc1_)
         {
            this.block_arc90_60.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_arc90_60.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(90,0,90,this.block_arc90_90.lines.length);
         for(_loc2_ in _loc1_)
         {
            this.block_arc90_90.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_arc90_90.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(90,30),new Point(50,0),new Point(-50,0),this.block_s1.lines.length);
         for(_loc2_ in _loc1_)
         {
            this.block_s1.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_s1.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(90,30),new Point(50,0),new Point(-50,0),9);
         for(_loc2_ in _loc1_)
         {
            this.block_s2.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_s2.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(90,30),new Point(50,0),new Point(-50,0),9);
         for(_loc2_ in _loc1_)
         {
            this.block_s3.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_s3.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(60,20),new Point(33,0),new Point(-33,0),this.block_s4.lines.length);
         for(_loc2_ in _loc1_)
         {
            this.block_s4.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_s4.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(30,10),new Point(16,0),new Point(-16,0),this.block_s5.lines.length);
         for(_loc2_ in _loc1_)
         {
            this.block_s5.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_s5.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(60,30),new Point(23,0),new Point(-17,-17),9);
         for(_loc2_ in _loc1_)
         {
            this.block_a1.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_a1.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(60,30),new Point(23,0),new Point(-17,-17),9);
         for(_loc2_ in _loc1_)
         {
            this.block_a2.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_a2.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(60,30),new Point(23,0),new Point(-17,-17),9);
         for(_loc2_ in _loc1_)
         {
            this.block_a3.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_a3.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(60,30),new Point(23,0),new Point(-17,-17),9);
         for(_loc2_ in _loc1_)
         {
            this.block_a4.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_a4.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(90,30),new Point(50,0),new Point(-50,0),9);
         for(_loc2_ in _loc1_)
         {
            this.block_sCross1.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_sCross1.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,30),new Point(90,0),new Point(50,0),new Point(-50,0),9);
         for(_loc2_ in _loc1_)
         {
            this.block_sCross1.pnts[_loc2_ + 10].x = _loc1_[_loc2_].x;
            this.block_sCross1.pnts[_loc2_ + 10].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(90,30),new Point(50,0),new Point(-50,0),9);
         for(_loc2_ in _loc1_)
         {
            this.block_sCross2.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_sCross2.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,30),new Point(90,0),new Point(50,0),new Point(-50,0),9);
         for(_loc2_ in _loc1_)
         {
            this.block_sCross2.pnts[_loc2_ + 10].x = _loc1_[_loc2_].x;
            this.block_sCross2.pnts[_loc2_ + 10].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,0),new Point(90,30),new Point(50,0),new Point(-50,0),9);
         for(_loc2_ in _loc1_)
         {
            this.block_sCross3.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_sCross3.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = GMath.bezierCurve(new Point(0,30),new Point(90,0),new Point(50,0),new Point(-50,0),9);
         for(_loc2_ in _loc1_)
         {
            this.block_sCross3.pnts[_loc2_ + 10].x = _loc1_[_loc2_].x;
            this.block_sCross3.pnts[_loc2_ + 10].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(30,0,90,9);
         for(_loc2_ in _loc1_)
         {
            this.block_t1.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_t1.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(60,0,90,9);
         for(_loc2_ in _loc1_)
         {
            this.block_o1.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_o1.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(60,0,90,9);
         for(_loc2_ in _loc1_)
         {
            this.block_o2.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_o2.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(60,0,90,9);
         for(_loc2_ in _loc1_)
         {
            this.block_o3.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_o3.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(60,0,90,9);
         for(_loc2_ in _loc1_)
         {
            this.block_o4.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_o4.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(60,0,90,9);
         for(_loc2_ in _loc1_)
         {
            this.block_o5.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_o5.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(90,0,90,9);
         for(_loc2_ in _loc1_)
         {
            this.block_p1.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_p1.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(90,0,90,9);
         for(_loc2_ in _loc1_)
         {
            this.block_p2.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_p2.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         _loc1_ = this.makeArc(90,0,90,9);
         for(_loc2_ in _loc1_)
         {
            this.block_p3.pnts[_loc2_].x = _loc1_[_loc2_].x;
            this.block_p3.pnts[_loc2_].y = _loc1_[_loc2_].y;
         }
         for each(_loc3_ in this.blockList)
         {
            this.calcBlockBound(_loc3_);
         }
         for each(_loc3_ in this.blockList)
         {
            this.scaleBlock(_loc3_);
         }
      }
      
      private function calcBlockBound(param1:Object) : *
      {
         var _loc6_:* = undefined;
         var _loc2_:* = 65536;
         var _loc3_:* = 65536;
         var _loc4_:* = -65536;
         var _loc5_:* = -65536;
         for each(_loc6_ in param1.pnts)
         {
            if(_loc6_.x < _loc2_)
            {
               _loc2_ = _loc6_.x;
            }
            if(_loc6_.y < _loc3_)
            {
               _loc3_ = _loc6_.y;
            }
            if(_loc6_.x > _loc4_)
            {
               _loc4_ = _loc6_.x;
            }
            if(_loc6_.y > _loc5_)
            {
               _loc5_ = _loc6_.y;
            }
         }
         _loc2_ *= this.levelScale;
         _loc3_ *= this.levelScale;
         _loc4_ *= this.levelScale;
         _loc5_ *= this.levelScale;
         param1.bound = {
            "x":_loc2_,
            "y":_loc3_,
            "width":_loc4_ - _loc2_,
            "height":_loc5_ - _loc3_
         };
         if(param1.boundscale)
         {
            _loc2_ -= 9;
            _loc3_ -= 9;
            _loc4_ += 9;
            _loc5_ += 9;
         }
         else
         {
            _loc2_ -= 2;
            _loc3_ -= 2;
            _loc4_ += 2;
            _loc5_ += 2;
         }
         param1.showBound = {
            "x":_loc2_,
            "y":_loc3_,
            "width":_loc4_ - _loc2_,
            "height":_loc5_ - _loc3_
         };
      }
      
      private function ax(param1:Number, param2:Number) : *
      {
         return param1 * Math.sin(param2 * Math.PI / 180);
      }
      
      private function scaleBlock(param1:Object) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in param1.pnts)
         {
            _loc2_.x *= this.levelScale;
            _loc2_.y *= this.levelScale;
         }
      }
   }
}
