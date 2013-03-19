/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.message;

import include.excel_export.Masking;

public class announcements{
public String announcements() {
Masking reader=new Masking("xml/hr/data.xml");
String announcements=reader.getColumnName("\u6fc0\u52b1\u7ba1\u7406","\u804c\u4f4d\u540d\u79f0");
announcements=announcements.substring(14,16);
announcements=announcements.toLowerCase();
return announcements;
}
}
