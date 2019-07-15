package  {
	import flash.display.Sprite;
	public class fk extends Sprite{
		var yanse = 0;
		var bianchang = 0;
		var xiankuan = 1;
		public function fk(ys, bc, xk) {
			yanse = ys;
			bianchang = bc;
			xiankuan  = xk;
			huatuxing();
		}
		public function huatuxing(){
			graphics.clear();
			graphics.beginFill(yanse, 0.8);
			graphics.lineStyle(xiankuan, 0x233333, 0.5);
			graphics.drawRect(0, 0, bianchang, bianchang);
			graphics.endFill();
		}
		public function shezhiys(ys){
			yanse = ys;
			huatuxing();
		}
		public function shezhixk(xk){
			xiankuan = xk;
			huatuxing();
		}
		
	}
	
}
