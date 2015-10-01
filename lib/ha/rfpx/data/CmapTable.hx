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

package lib.ha.rfpx.data;
//=======================================================================================================
import lib.ha.core.memory.Pointer;
import lib.ha.core.memory.Ref;
import lib.ha.core.memory.MemoryReaderEx;
using lib.ha.core.memory.MemoryReaderEx;
//=======================================================================================================
class CmapTable 
{
	private var _tableRecord:TableRecord;
	private var _version:UInt;							//USHORT
	private var _numTables:UInt;						//USHORT
	private var _formats0:Array<CmapFormat0>;			//Apple
	private var _formats2:Array<CmapFormat2>;
	private var _formats4:Array<CmapFormat4>;			//Microsoft
	private var _formats6:Array<CmapFormat6>;
	//---------------------------------------------------------------------------------------------------
	public function new(record:TableRecord, data:Pointer)
	{
		_tableRecord = record;
		
		_formats0 = new Array();
		_formats2 = new Array();
		_formats4 = new Array();
		_formats6 = new Array();
		
		var dataPtr = data;
		
		_version = data.getUShort();
		data += 2;
		_numTables = data.getUShort();
		data += 2;

		var refPtr = Ref.getPointer().set(data);
		
		var i:UInt = 0;
		while (i < _numTables)
		{
			var encRecord = new EncodingRecord(refPtr);
			//var encRecordPtr = _tableRecord.offset + encRecord.offset;
			var cmapFormatPtr = dataPtr + encRecord.offset;//dataPtr + encRecordPtr;
			var cmapFormatType = cmapFormatPtr.getUShort();//encRecordPtr.getUShort();
			cmapFormatPtr += 2;
			switch (cmapFormatType)
			{
				case 0: _formats0.push(new CmapFormat0(cmapFormatPtr, encRecord));
				case 2: _formats2.push(new CmapFormat2(cmapFormatPtr));
				case 4: _formats4.push(new CmapFormat4(cmapFormatPtr));
				case 6: _formats6.push(new CmapFormat6(cmapFormatPtr));
			}
			++i;
		}
	}
	//---------------------------------------------------------------------------------------------------
	public function getGlyphIndex(charCode:UInt):UInt
	{
		return _formats4[0].getGlyphIndex(charCode);
	}

}