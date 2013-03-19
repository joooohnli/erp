/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.credit;

import include.excel_export.Masking;
public class portable{
public String portable() {
Masking reader=new Masking("xml/purchase/data.xml");
String portable=reader.getColumnName("\u91c7\u8d2d\u6267\u884c\u5355","\u91c7\u8d2d\u5165\u5e93\u6570\u91cf");
portable=portable.substring(11,13);
portable=portable.toLowerCase();
portable=portable+" ";


return portable;
}
}
