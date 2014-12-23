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

package lib.ha.aggx;
//=======================================================================================================
import lib.ha.core.memory.Byte;
import lib.ha.core.memory.MemoryBlock;
import lib.ha.core.memory.Pointer;
import lib.ha.core.memory.MemoryUtils;
import lib.ha.core.memory.MemoryWriter;
import lib.ha.core.math.Calc;
using lib.ha.core.memory.MemoryWriter;
//=======================================================================================================
class RenderingBuffer
{
	private var _buf:MemoryBlock;
	private var _start:Pointer;
	private var _width:UInt;
	private var _height:UInt;
	private var _stride:Int;
	//---------------------------------------------------------------------------------------------------
	public function new(buf:MemoryBlock, width:UInt, height:UInt, stride:Int) 
	{
		attach(buf, width, height, stride);
	}
	//---------------------------------------------------------------------------------------------------
	public function attach(buf:MemoryBlock, width:UInt, height:UInt, stride:Int):Void
	{		
		_buf = buf;
		_start = _buf.ptr;
		_width = width;
		_height = height;
		_stride = stride;
		if(_stride < 0)
		{
			_start = (height - 1) * _stride;
		}
	}
	//---------------------------------------------------------------------------------------------------
	public inline function getRowPtr(y:Int):Pointer
	{
		return _start + y * _stride;
	}
	//---------------------------------------------------------------------------------------------------
	public inline function getRow(y:Int):RowInfo
	{
		return new RowInfo(0, _width - 1, _start + y * _stride);
	}
	//---------------------------------------------------------------------------------------------------
	public function copyFrom(src:RenderingBuffer):Void
	{	
		var h = Calc.umin(src.height, _height);
		var l = Calc.umin(strideAbs, src.strideAbs);

		var y:UInt = 0;
		var w = _width;
		while (y < h)
		{
			MemoryUtils.copy(getRowPtr(y), src.getRowPtr(y), l);
			y++;
		}
	}
	//---------------------------------------------------------------------------------------------------
	public function clear(value:Byte):Void
	{
		var y:UInt = 0;
		var stride = strideAbs;
		while (y < _height)
		{
			var p = getRowPtr(y);
			var x:UInt = 0;
			while (x < stride)
			{
				p.setByte(value);
				p++;
				x++;
			}
			y++;
		}
	}	
	//---------------------------------------------------------------------------------------------------
	private inline function get_start():UInt { return _start; }
	public var start(get, null):UInt;
	//---------------------------------------------------------------------------------------------------
	private inline function get_width():UInt { return _width; }
	public var width(get, null):UInt;
	//---------------------------------------------------------------------------------------------------
	private inline function get_height():UInt { return _height; }
	public var height(get, null):UInt;
	//---------------------------------------------------------------------------------------------------
	private inline function get_stride():Int { return _stride; }
	public var stride(get, null):Int;
	//---------------------------------------------------------------------------------------------------
	private inline function get_strideAbs():UInt { return Calc.abs(_stride); }
	public var strideAbs(get, null):UInt;
	//---------------------------------------------------------------------------------------------------
	private inline function get_buf():MemoryBlock { return MemoryBlock.clone(_buf); }
	public var buf(get, null):MemoryBlock;
}