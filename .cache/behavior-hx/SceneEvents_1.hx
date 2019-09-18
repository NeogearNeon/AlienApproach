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
import box2D.collision.shapes.B2Shape;

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



class SceneEvents_1 extends SceneScript
{
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		Engine.engine.setGameAttribute("EnemiesLeft", 0);
		Engine.engine.setGameAttribute("Bullets Alive", 0);
		if(((Engine.engine.getGameAttribute("PlayerAlive") : Bool) == false))
		{
			Engine.engine.setGameAttribute("PlayerAlive", true);
			Engine.engine.setGameAttribute("Score", 0);
			Engine.engine.setGameAttribute("Stage", 1);
		}
		else if(((Engine.engine.getGameAttribute("PlayerAlive") : Bool) == true))
		{
			Engine.engine.setGameAttribute("Stage", ((Engine.engine.getGameAttribute("Stage") : Float) + 1));
		}
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("escape", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				if(engine.isPaused())
				{
					engine.unpause();
				}
				else
				{
					engine.pause();
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(engine.isPaused())
				{
					g.alpha = (90/100);
					g.fillColor = Utils.convertColor(Utils.getColorRGB(0,0,0));
					g.fillRect(0, 0, getScreenWidth(), getScreenHeight());
					g.alpha = (100/100);
					g.drawString("" + "[PAUSE SCREEN]    ", (getScreenXCenter() - 80), (getScreenYCenter() - 16));
				}
				if(((Engine.engine.getGameAttribute("EnemiesLeft") : Float) == 0))
				{
					Engine.engine.setGameAttribute("Bullets Alive", 2);
					g.alpha = (10/100);
					g.fillColor = Utils.convertColor(Utils.getColorRGB(0,0,0));
					g.fillRect(0, 0, getScreenWidth(), getScreenHeight());
					g.alpha = (100/100);
					g.drawString("" + "LEVEL COMPLETE!    ", (getScreenXCenter() - 120), (getScreenYCenter() - 16));
					runLater(1000 * 1.5, function(timeTask:TimedTask):Void
					{
						switchScene(GameModel.get().scenes.get(4).getID(), createFadeOut(0.25, Utils.getColorRGB(0,0,0)), createFadeIn(0.25, Utils.getColorRGB(0,0,0)));
					}, null);
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}