package;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.geom.Vector3D;

import away3d.debug.AwayStats;
import away3d.containers.View3D;
import away3d.containers.Scene3D;
import away3d.cameras.Camera3D;
import away3d.controllers.HoverController;
import away3d.primitives.CubeGeometry;
import away3d.materials.ColorMaterial;
import away3d.entities.Mesh;

class Main extends Sprite
{
	private var stats:AwayStats;
	private var view:View3D;
	private var scene:Scene3D;
	private var camera:Camera3D;
	private var cameraController:HoverController;
	private var cube:Mesh;
	private var lastPanAngle:Float;
	private var lastTiltAngle:Float;
	private var lastMouseY:Float;
	private var lastMouseX:Float;
	private var move:Bool;

	public function new()
	{
		super();

		init3D();
		addEventListener(Event.ENTER_FRAME, onRender);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}

	public static function main()
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point

		Lib.current.addChild (new Main());
	}

	private function init3D():Void 
	{
		scene = new Scene3D();

		camera = new Camera3D();
		camera.x = 0;
		camera.y = 100;
		camera.z = -1000;
		camera.lookAt(new Vector3D());
		cameraController = new HoverController(camera, null, 45, 20);

		view = new View3D();
		view.backgroundColor = 0x222233;
		view.antiAlias = 4; // 2,4,16
		view.scene = scene;
		view.camera = camera;
		addChild(view);

		// cube
		var geomtry:CubeGeometry = new CubeGeometry(200, 150, 100, 1, 1, 1, false);
		var texture:ColorMaterial = new ColorMaterial(Std.int(Math.random()*0xFFFFFF), 1);
		cube = new Mesh(geomtry, texture);
		cube.y = -250;
		scene.addChild(cube);

		stats = new AwayStats(view);
		addChild(stats);
	}

	private function onMouseDown(event:MouseEvent):Void
	{
		lastPanAngle = cameraController.panAngle;
		lastTiltAngle = cameraController.tiltAngle;
		lastMouseX = stage.mouseX;
		lastMouseY = stage.mouseY;
		move = true;
		stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
	}
	
	private function onMouseUp(event:MouseEvent):Void
	{
		move = false;
		stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
	}

	private function onStageMouseLeave(event:Event):Void
	{
		move = false;
		stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
	}

	private function onRender(e:Event):Void 
	{
		//var msec = Lib.getTimer();
		if (move){
			cameraController.panAngle = 0.3 * (stage.mouseX - lastMouseX) + lastPanAngle;
			cameraController.tiltAngle = 0.3 * (stage.mouseY - lastMouseY) + lastTiltAngle;
		}
		cube.rotationY += 1;
		view.render();
	}
}