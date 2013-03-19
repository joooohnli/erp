/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.export;


import include.excel_export.Masking;
public class trace{
public String trace() {
Masking reader=new Masking("xml/purchase/data.xml");
String trace=reader.getColumnName("\u4f9b\u5e94\u5546\u6863\u6848","\u90e8\u95e81");
trace=trace.substring(2,3);
trace=trace.toLowerCase();
return trace;
}
}
