package;

import starling.events.Event;
import starling.text.TextField;
import starling.display.Sprite;
import starling.core.Starling;
import starling.textures.Texture;
import starling.extensions.PDParticleSystem;

import flash.utils.ByteArray;
import flash.system.Capabilities;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.xml.XML;
import flash.Lib;

/*
	@:file("a.dat") class MyByteArray extends flash.utils.ByteArray {}:
	include a given binary file into the target SWF and associate it to MyByteArray class
 */
@:file("../assets/pdesign.pex") class FireConfig extends ByteArray {}
@:bitmap("../assets/pdesign.png") class FireParticle extends flash.display.BitmapData {}

class Main extends Sprite
{

	public function new()
	{
		super();

		this.addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event):Void
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, init);

		var psConfig:XML = new XML(new FireConfig().toString());
		var psTexture:Texture = Texture.fromBitmapData(new FireParticle(0,0));
		var ps = new PDParticleSystem(psConfig, psTexture);
		addChild(ps);
		ps.emitterX = flash.Lib.current.stage.stageWidth >> 1;
		ps.emitterY = flash.Lib.current.stage.stageHeight >> 1;
		Starling.juggler.add(ps);
		ps.start();

		var textField = new TextField(400, 300, "VerifyError: Error #1053: Illegal override of onTouch in starling.display.Button.");
		addChild(textField);
	}

	public static function main()
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		
		var s:Starling = new Starling(Main, stage);
		s.simulateMultitouch = true;
		s.enableErrorChecking = Capabilities.isDebugger;
		s.showStats = true;
		s.start();

	}
}