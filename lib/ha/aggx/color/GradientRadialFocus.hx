//----------------------------------------------------------------------------
// Anti-Grain Geometry - Version 2.4
// Copyright (C) 2002-2005 Maxim Shemanarev (http://www.antigrain.com)
//
// Permission to copy, use, modify, sell and distribute this software 
// is granted provided this copyright notice appears in all copies. 
// This software is provided "as is" without express or implied
// warranty, and with no claim as to its suitability for any purpose.
//
// Haxe port by: Hypeartist hypeartist@gmail.com
// Copyright (C) 2011 https://code.google.com/p/aggx
//
//----------------------------------------------------------------------------
// Contact: mcseem@antigrain.com
//          mcseemagg@yahoo.com
//          http://www.antigrain.com
//----------------------------------------------------------------------------

package lib.ha.aggx.color;
//=======================================================================================================
import lib.ha.core.math.Calc;
//=======================================================================================================
class GradientRadialFocus implements IGradientFunction
{
	private var _r:Int;
	private var _fx:Int;
	private var _fy:Int;
	private var _r2:Float;
	private var _fx2:Float;
	private var _fy2:Float;
	private var _mul:Float;
	//---------------------------------------------------------------------------------------------------
	public function new(r:Float = 100, fx:Float = 0, fy:Float = 0)	
	{
		_r = Calc.iround(r * gradient_subpixel_scale);
		_fx = Calc.iround(fx * gradient_subpixel_scale);
		_fy = Calc.iround(fy * gradient_subpixel_scale);
		updateValues();
	}
	//---------------------------------------------------------------------------------------------------
	public function init(r:Float, fx:Float, fy:Float)
	{
		_r = Calc.iround(r * gradient_subpixel_scale);
		_fx = Calc.iround(fx * gradient_subpixel_scale);
		_fy = Calc.iround(fy * gradient_subpixel_scale);
		updateValues();
	}
	//---------------------------------------------------------------------------------------------------
	private function updateValues()
	{
		// Calculate the invariant values. In case the focal center
		// lies exactly on the gradient circle the divisor degenerates
		// into zero. In this case we just move the focal center by
		// one subpixel unit possibly in the direction to the origin (0,0)
		// and calculate the values again.
		//-------------------------
		_r2  = _r  * _r;
		_fx2 = _fx * _fx;
		_fy2 = _fy * _fy;
		var d = (_r2 - (_fx2 + _fy2));
		if(d == 0)
		{
			if (_fx) { if (_fx < 0)++_fx; else--_fx; }			
			if (_fy) { if (_fy < 0)++_fy; else--_fy; }			
			_fx2 = _fx * _fx;
			_fy2 = _fy * _fy;
			d = (_r2 - (_fx2 + _fy2));
		}
		_mul = _r / d;
	}	
	//---------------------------------------------------------------------------------------------------
	public function calculate(x:Int, y:Int, d:Int):Int 
	{
		var dx = x - _fx;
		var dy = y - _fy;
		var d2 = dx * _fy - dy * _fx;
		var d3 = _r2 * (dx * dx + dy * dy) - d2 * d2;
		return Calc.iround((dx * _fx + dy * _fy + Math.sqrt(Calc.fabs(d3))) * _mul);
	}
	//---------------------------------------------------------------------------------------------------
	private inline function get_radius():Int { return _r / gradient_subpixel_scale; }
	public var radius(get, null):Int;
	//---------------------------------------------------------------------------------------------------
	private inline function get_focusX():Int { return _fx / gradient_subpixel_scale; }
	public var focusX(get, null):Int;
	//---------------------------------------------------------------------------------------------------
	private inline function get_focusY():Int { return _fy / gradient_subpixel_scale; }
	public var focusY(get, null):Int;
}