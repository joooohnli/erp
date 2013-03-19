/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.data_backup;

import include.excel_export.Masking;

public class local{
public String local() {
Masking reader=new Masking("xml/oa/data.xml");
String local=reader.getColumnName("\u4f1a\u8bae","\u7eaa\u8981\u6574\u7406\u4eba\u7f16\u53f7");
local=local.substring(4,5);

return local;
}
}
