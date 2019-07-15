package  {
	import flash.display.Sprite;
	import flash.utils.Timer;//引用计时器【控制蛇的运动速度】
	import flash.text.TextField;   // 文本框

	
	public class canshu extends Sprite{
		var hgzs = 45;//横格总数【地图】
		var sgzs = 25;//竖格总数【地图】
		var bc = 25;//边长
		
		var dead = 0;
		
		var shiwu;//食物（全局有效）
		
		var morenxk = 1;//默认线宽
		
		var zsh_x = 0;//水平初始位置
		var zsh_y = 0;//竖直初始位置
		
		var chidao = 0; // 食物状态【默认未吃到】
		
		
		var fenshu = 0;
		
		var shesz = [];  //控制蛇头+身体（数组）
		
		var csm = [[[2, 3], [20, 20], "0xFF00FF"], 
				   [[31, 5], [3, 12], "0x00FFFF"],
				   [[20, 2], [40, 23], "0xFFFF00"],
				   [[5, 15], [18, 5], "0x00FF00"],
				   [[15, 16], [38, 20], "0x0000FF"]];  // 传送门
				   
		var zhaw = [[[5, 6], [9, 10], "0xFF0000"],
					[[10, 9], [20, 12], "0xFF0000"],
					[[30, 12], [37, 16], "0xFF0000"],
					[[36, 15], [43, 16], "0xFF0000"],
					[[7, 22], [12, 24], "0xFF0000"],
					[[25, 3], [27, 10], "0xFF0000"],
					[[25, 23], [35, 24], "0xFF0000"],
					[[35, 5], [40, 9], "0xFF0000"],
					[[3, 20], [6, 24], "0xFF0000"]];

		public function canshu() {
			
		}

	}
	
}
