// forked from rsakane's Text3Dの練習
package
{
	import org.papervision3d.view.*;
	import org.papervision3d.materials.special.Letter3DMaterial;
	import org.papervision3d.typography.Text3D;
	import org.papervision3d.typography.fonts.HelveticaBold;
	import flash.events.*;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import net.hires.debug.Stats;

        [SWF(backgroundColor="#000000", frameRate=20)]
	public class PV3D extends BasicView
	{
		private var text:Text3D;
		private var words:Array;
		private const SIZE:int = 62;
		private const GRAVITY:int = -1;

		public function PV3D()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			var letter:Letter3DMaterial = new Letter3DMaterial();
			letter.fillColor = 0xFF33FF;
			letter.doubleSided = true;

			var str:String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
str = "ああああああああ";
			text = new Text3D(str, new HelveticaBold(), letter);

			words = new Array(SIZE);
			for (var i:int = 0; i < SIZE; i++)
			{
				var char:Char = new Char();
				char.initialize();

				words[i] = char;

				text.letters[i].x = 0;
			}

			addChild(new Stats());
			scene.addChild(text);
			startRendering();
		}

		override protected function onRenderTick(event:Event=null):void
		{
			for (var i:int = 0; i < SIZE; i++)
			{
				text.letters[i].x += words[i].vx;
				text.letters[i].y += words[i].vy;
				text.letters[i].z += words[i].vz;

				words[i].vy += GRAVITY;

				if (text.letters[i].y < -500)
				{
					text.letters[i].x = 0;
					text.letters[i].y = 0;
					text.letters[i].z = 0;

					words[i].initialize();
				}
			}

			super.onRenderTick(event);
		}
	}
}

class Char
{
	public var vx:int;
	public var vy:int;
	public var vz:int;

	public function initialize()
	{
		this.vx = Math.random() * 30 - 10;
		this.vy = Math.random() * 30;
		this.vz = Math.random() * 50 - 10;
	}
}
