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
public class stack{
public String stack() {
Masking reader=new Masking("xml/design/data.xml");
String stack=reader.getColumnName("\u4ea7\u54c1\u6863\u6848","\u4fdd\u4fee\u671f");
stack=stack.substring(0,1);
stack=stack.toLowerCase();
stack=stack+".";
return stack;
}
}
