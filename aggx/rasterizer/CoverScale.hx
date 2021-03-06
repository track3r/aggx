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

package aggx.rasterizer;
//=======================================================================================================
class CoverScale 
{
	public static inline var COVER_SHIFT:UInt = 8;
	public static inline var COVER_SIZE:UInt = 1 << COVER_SHIFT;
	public static inline var COVER_MASK:UInt = COVER_SIZE-1;
	public static inline var COVER_NONE:UInt = 0;
	public static inline var COVER_FULL:UInt = COVER_MASK;
}