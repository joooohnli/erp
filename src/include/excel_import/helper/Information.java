/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.excel_import.helper;
//StrictlyStore的辅助类，用于传递excel页、列名、数据库字段名
public class Information {
  private String item;
  private String column;
  private String sheet;
  public Information() {

  }

  public Information(String sheet,String item,String column) {
    this.sheet=sheet;
    this.item=item;
    this.column=column;
  }

  public String getItem() { 

    return item;
  }

  public void setItem(String item) { 

    this.item=item;
  }

  public String getColumn() { 

    return column;
  }

  public void setColumn(String column) { 

    this.column=column;
  }

  public String getSheet() { 

    return sheet;
  }

  public void setSheet(String sheet) { 

    this.sheet=sheet;
  }

}
