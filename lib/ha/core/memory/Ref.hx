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
private class RefBase<T>
{
	public var value:T;
	public function new(?val:T) { value = val; }
	public inline function set(?val:T):RefBase<T> { value = val; return this; }
}
//=======================================================================================================
typedef FloatRef = RefBase<Float>;
//=======================================================================================================
typedef IntRef = RefBase<Int>;
//=======================================================================================================
typedef PointerRef = RefBase<Pointer>;
//=======================================================================================================
class Ref
{
	public static var int1 = new RefBase<Int>();
	public static var int2 = new RefBase<Int>();
	public static var int3 = new RefBase<Int>();
	public static var int4 = new RefBase<Int>();
	public static var int5 = new RefBase<Int>();
	public static var int6 = new RefBase<Int>();
	public static var int7 = new RefBase<Int>();
	public static var int8 = new RefBase<Int>();
	public static var int9 = new RefBase<Int>();
	public static var int10 = new RefBase<Int>();
	public static var int11 = new RefBase<Int>();
	public static var int12 = new RefBase<Int>();
	//---------------------------------------------------------------------------------------------------
	public static var float1 = new RefBase<Float>();
	public static var float2 = new RefBase<Float>();
	public static var float3 = new RefBase<Float>();
	public static var float4 = new RefBase<Float>();
	public static var float5 = new RefBase<Float>();
	public static var float6 = new RefBase<Float>();
	public static var float7 = new RefBase<Float>();
	public static var float8 = new RefBase<Float>();
	public static var float9 = new RefBase<Float>();
	public static var float10 = new RefBase<Float>();
	public static var float11 = new RefBase<Float>();
	public static var float12 = new RefBase<Float>();
	//---------------------------------------------------------------------------------------------------
	public static var pointer1 = new RefBase<Pointer>();
	public static var pointer2 = new RefBase<Pointer>();
	public static var pointer3 = new RefBase<Pointer>();
	public static var pointer4 = new RefBase<Pointer>();
}