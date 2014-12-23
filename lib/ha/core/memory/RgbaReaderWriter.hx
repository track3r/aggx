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

package lib.ha.core.memory;
//=======================================================================================================
class RgbaReaderWriter
{
	private inline static var R = 1;
	private inline static var G = 2;
	private inline static var B = 3;
	private inline static var A = 0;	
	//---------------------------------------------------------------------------------------------------
	private inline static var RS = R << 3;
	private inline static var GS = G << 3;
	private inline static var BS = B << 3;
	private inline static var AS = A << 3;
	//---------------------------------------------------------------------------------------------------	
	public static inline function getR(addr:Pointer):Byte
	{
		return untyped __vmem_get__(0, addr + R);
	}
	//---------------------------------------------------------------------------------------------------
	public static inline function getG(addr:Pointer):Byte
	{
		return untyped __vmem_get__(0, addr + G);
	}
	//---------------------------------------------------------------------------------------------------
	public static inline function getB(addr:Pointer):Byte
	{
		return untyped __vmem_get__(0, addr + B);
	}
	//---------------------------------------------------------------------------------------------------
	public static inline function getA(addr:Pointer):Byte
	{
		return untyped __vmem_get__(0, addr + A);
	}
	//---------------------------------------------------------------------------------------------------
	public static inline function setR(addr:Pointer, val:Byte):Void
	{
		untyped __vmem_set__(0, addr + R, val);
	}
	//---------------------------------------------------------------------------------------------------
	public static inline function setG(addr:Pointer, val:Byte):Void
	{
		untyped __vmem_set__(0, addr + G, val);
	}
	//---------------------------------------------------------------------------------------------------
	public static inline function setB(addr:Pointer, val:Byte):Void
	{
		untyped __vmem_set__(0, addr + B, val);
	}
	//---------------------------------------------------------------------------------------------------
	public static inline function setA(addr:Pointer, val:Byte):Void
	{
		untyped __vmem_set__(0, addr + A, val);
	}
	//---------------------------------------------------------------------------------------------------
	public static inline function setFull(addr:Pointer, r:Byte, g:Byte, b:Byte, a:Byte):Void
	{
		untyped __vmem_set__(2, addr, ((r << RS) | (g << GS) | (b << BS) | (a << AS)));
	}
}