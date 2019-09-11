package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_42_42 extends ActorScript
{
	public var _NumberofActorstoCreate:Float;
	public var _ExplosionForce:Float;
	public var _ActortoCreate:ActorType;
	public var _NumberofSecondActorstoCreate:Float;
	public var _SecondActortoCreate:ActorType;
	public var _ExplosionForceofSecondActors:Float;
	public var _SoundtoPlay:Sound;
	public var _NumberofThirdActorstoCreate:Float;
	public var _ExplosionForceofThirdActors:Float;
	public var _ThirdActortoCreate:ActorType;
	public function _customEvent_HandleDeath():Void
	{
		if(((Engine.engine.getGameAttribute("SoundDisabled") : Bool) == false))
		{
			playSound(_SoundtoPlay);
		}
		for(index0 in 0...Std.int(_NumberofActorstoCreate))
		{
			createRecycledActor(_ActortoCreate, (actor.getX() + (actor.getWidth()/2)), (actor.getY() + (actor.getHeight()/2)), Script.FRONT);
			getLastCreatedActor().setAngularVelocity(Utils.RAD * (randomInt(-180, 180)));
			getLastCreatedActor().applyImpulseInDirection(randomInt(1, 360), _ExplosionForce);
		}
		for(index0 in 0...Std.int(_NumberofSecondActorstoCreate))
		{
			createRecycledActor(_SecondActortoCreate, (actor.getX() + (actor.getWidth()/2)), (actor.getY() + (actor.getHeight()/2)), Script.FRONT);
			getLastCreatedActor().setAngularVelocity(Utils.RAD * (randomInt(-180, 180)));
			getLastCreatedActor().applyImpulseInDirection(randomInt(1, 360), _ExplosionForceofSecondActors);
		}
		for(index0 in 0...Std.int(_NumberofThirdActorstoCreate))
		{
			createRecycledActor(_ThirdActortoCreate, (actor.getX() + (actor.getWidth()/2)), (actor.getY() + (actor.getHeight()/2)), Script.FRONT);
			getLastCreatedActor().setAngularVelocity(Utils.RAD * (randomInt(-180, 180)));
			getLastCreatedActor().applyImpulseInDirection(randomInt(1, 360), _ExplosionForceofThirdActors);
		}
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Number of Actors to Create", "_NumberofActorstoCreate");
		_NumberofActorstoCreate = 10.0;
		nameMap.set("Explosion Force", "_ExplosionForce");
		_ExplosionForce = 1.0;
		nameMap.set("Actor to Create", "_ActortoCreate");
		nameMap.set("Number of Second Actors to Create", "_NumberofSecondActorstoCreate");
		_NumberofSecondActorstoCreate = 5.0;
		nameMap.set("Second Actor to Create", "_SecondActortoCreate");
		nameMap.set("Explosion Force of Second Actors", "_ExplosionForceofSecondActors");
		_ExplosionForceofSecondActors = 0.7;
		nameMap.set("Sound to Play", "_SoundtoPlay");
		_SoundtoPlay = getSound(15);
		nameMap.set("Number of Third Actors to Create", "_NumberofThirdActorstoCreate");
		_NumberofThirdActorstoCreate = 0;
		nameMap.set("Explosion Force of Third Actors", "_ExplosionForceofThirdActors");
		_ExplosionForceofThirdActors = 0;
		nameMap.set("Third Actor to Create", "_ThirdActortoCreate");
		
	}
	
	override public function init()
	{
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}