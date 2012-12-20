package;

import feathers.themes.MetalWorksMobileTheme;
import feathers.controls.Button;

import starling.events.Event;
import starling.display.Sprite;
import starling.core.Starling;

import flash.system.Capabilities;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;

class Main extends Sprite
{
	private var button:Button;

	public function new()
	{
		super();

		var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme(this, false);
		button = new Button();
		button.label = "hello world";
		addChild(button);

		//the button won't have a width and height until it "validates". it
		//will validate on its own before the next frame is rendered by
		//Starling, but we want to access the dimension immediately, so tell
		//it to validate right now.
		button.validate();

		button.x = 100;
		button.y = 200;

		button.addEventListener(Event.TRIGGERED, onTrigger);

	}

	private function onTrigger(e:Event):Void
	{

		trace("TRIGGERED");
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