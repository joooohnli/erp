/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.get_sql;

import include.excel_export.Masking;

public class checking{
public String checking() {
Masking reader=new Masking("xml/design/data.xml");
String checking=reader.getColumnName("\u4ea7\u54c1\u6863\u6848","\u6863\u6848\u53d8\u66f4\u7d2f\u8ba1");

checking=checking.substring(17,18);
checking=checking.toLowerCase();
return checking;
}
}
