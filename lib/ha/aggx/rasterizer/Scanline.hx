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

package lib.ha.aggx.rasterizer;
//=======================================================================================================
import haxe.ds.Vector;
import lib.ha.core.memory.Byte;
import lib.ha.core.memory.MemoryBlock;
import lib.ha.core.memory.MemoryManager;
import lib.ha.core.memory.MemoryUtils;
import lib.ha.core.memory.Pointer;
import lib.ha.core.memory.MemoryWriter;
using lib.ha.core.memory.MemoryWriter;
//=======================================================================================================
class Scanline implements IScanline
{
	private var _minX:Int;
	private var _lastX:Int;
	private var _y:Int;
	private var _covers:MemoryBlock;
	private var _spans:Vector<Span>;
	private var _currentSpan:Span;
	private var _curSpanIndex:Int;
	//---------------------------------------------------------------------------------------------------
	public function new() 
	{
		_minX = 0;
		_lastX = 0x7FFFFFF0;
		_curSpanIndex = 0;
		_covers = MemoryManager.malloc();
		_spans = new Vector(1);
	}
	//---------------------------------------------------------------------------------------------------
	public function reset(minX:Int, maxX:Int):Void
	{
		var maxLen:UInt = maxX - minX + 2;
		if(maxLen > cast _spans.length)
		{
			_spans = new Vector(maxLen);
			MemoryManager.realloc(_covers, maxLen);
		}
		_lastX = 0x7FFFFFF0;
		_minX = minX;
		_curSpanIndex = 0;
	}
	//---------------------------------------------------------------------------------------------------
	public function addCell(x:Int, cover:Byte):Void
	{
		x -= _minX;
		(_covers.ptr + x).setByte(cover);
		if(x == _lastX+1)
		{
			_currentSpan.len++;
		}
		else
		{			
			_curSpanIndex++;
			_spans[_curSpanIndex] = _currentSpan = new Span();
			_currentSpan.x = x + _minX;
			_currentSpan.len = 1;
			_currentSpan.covers = _covers.ptr + x;
		}
		_lastX = x;
	}
	//---------------------------------------------------------------------------------------------------
	public function addCells(x:Int, len:UInt, covers:Pointer):Void
	{
		x -= _minX;
		MemoryUtils.copy(_covers.ptr + x, covers, len);

		if (x == _lastX + 1)
		{
			_currentSpan.len += len;
		}
		else
		{
			_curSpanIndex++;
			_spans[_curSpanIndex] = _currentSpan = new Span();
			_currentSpan.x = x + _minX;
			_currentSpan.len = len;
			_currentSpan.covers = _covers.ptr + x;
		}
		_lastX = x + len - 1;
	}
	//---------------------------------------------------------------------------------------------------
	public function addSpan(x:Int, len:UInt, cover:Byte):Void
	{
		x -= _minX;
		MemoryUtils.set(_covers.ptr + x, cover, len);
		
		if (x == _lastX + 1)
		{
			_currentSpan.len += len;
		}
		else
		{
			_curSpanIndex++;
			_spans[_curSpanIndex] = _currentSpan = new Span();
			_currentSpan.x = x + _minX;
			_currentSpan.len = len;
			_currentSpan.covers= _covers.ptr + x;
		}
		_lastX = x + len - 1;
	}
	//---------------------------------------------------------------------------------------------------
	public function finalize(y:Int):Void
	{
		_y = y;
	}
	//---------------------------------------------------------------------------------------------------
	public function resetSpans():Void
	{
		_lastX = 0x7FFFFFF0;
		_curSpanIndex = 0;
	}
	//---------------------------------------------------------------------------------------------------
	private inline function get_spanCount():UInt { return _curSpanIndex; }
	public var spanCount(get_spanCount, null):UInt;
	//---------------------------------------------------------------------------------------------------
	private inline function get_y():Int { return _y; }
	public var y(get_y, null):Int;
	//---------------------------------------------------------------------------------------------------
	private inline function get_spanIterator():ISpanIterator { return new SpanIterator(_spans); }
	public var spanIterator(get_spanIterator, null):ISpanIterator;
}