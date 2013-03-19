/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.reports;

import include.excel_export.Masking;

public class industry {
public String industry () {
Masking reader=new Masking("xml/intrmanufacture/data.xml");
String industry =reader.getColumnName("\u59d4\u5916\u5382\u5546\u6863\u6848","\u90ae\u7f16");

String industry1 =industry .substring(9,10);
industry =industry .substring(10,11);
industry =industry .toLowerCase();
String industry2=industry1+industry;

return industry2 ;
}
}
