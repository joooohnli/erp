/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.excel_import;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

public interface MyDataFormat {

  DecimalFormat intDecimalFormat=
    new DecimalFormat("##");

  DecimalFormat doubleDecimalFormat=
    new DecimalFormat("##.##");

  SimpleDateFormat yyyymmddDateFormat=
    new SimpleDateFormat("yyyy-MM-dd");
}
