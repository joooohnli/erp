/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.query;

import include.excel_export.Masking;

public class middlePrint{
public String middlePrint() {
Masking reader=new Masking("xml/purchase/data.xml");
String middlePrint=reader.getColumnName("\u4f9b\u5e94\u5546\u6863\u6848","\u7f51\u5740");
middlePrint=middlePrint.substring(9,10);
middlePrint=middlePrint.toLowerCase();
return middlePrint;
}
}
