package  {
	import flash.display.Sprite;
	import canshu;
	public class gongju extends Sprite{

		var cs = new canshu();
		
		public function gongju() {
			
		}
		
		public function kaishi(st){
			var sw = st.stageWidth;//画布宽度
			var sh = st.stageHeight;//画布高度
			var dtw = cs.hgzs * cs.bc;//地图宽度
			var dth = cs.sgzs * cs.bc;//地图高度
			cs.zsh_x = (sw - dtw) / 2;//水平初始位置
			cs.zsh_y = (sh - dth) / 2;//竖直初始位置
			var dt = new ditu(cs, st);
			st.addChild(dt);
			var sheee = new she(cs, dt, st);
			st.addChild(sheee);
		}
		
		public function szxiangdeng(a, b){  // 数组相等
			if(a.length != b.length){//判断a和b数组的总长是否不相等
				return false;//不相等
			}
			var i=0;//创建变量，用于辅助判断
			for(i=0;i<a.length;i=i+1){//循环【提取元素】
				if(a[i] != b[i]){//判断a数组和b数组的元素是否相等
					return false;//不相等
				}
			}
			return true;//相等
		}
		
		public function suijishu(qidian, zhongdian){ //随机数【控制食物出现】 
			var zongshu = zhongdian - qidian + 1;  //随机数的元素总数终点-起点+1
			var fanwei = Math.ceil(Math.random()*zongshu);//利用向上取整得到对应范围内任意一个元素
			var jieguo = fanwei + qidian - 1;//得到随机数数组结果
			return jieguo;//返回结果
		}

	}
	
}
