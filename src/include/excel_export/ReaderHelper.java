/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.excel_export;


import java.util.*;
import org.jdom.*;
import org.jdom.input.SAXBuilder;
/**
 * 处理XML的帮助类，是solid.java的辅助类
 * 屏蔽掉JDOM的东西
 **/

public class ReaderHelper {

  private String file=null;
  private SAXBuilder builder=null;
  private Document doc=null;
  private Element root=null;

  public ReaderHelper (Document doc) {
    this.doc=doc;
    root=doc.getRootElement();
  }

  public Document getDocument(){
    return doc;
  }

  /**
   * 获得数据表名(中文)
   *
   */
  public Vector getTableNicks() {
    Vector result=new Vector();
    Iterator tables=getTables().iterator();
    while(tables.hasNext()) {
      result.addElement(getTableNick((Element)tables.next()));
    }
    return result;
  }

  /**
   * 获得数据表名(英文)
   */
  public Vector getTableNames() {
    Vector result=new Vector();
    Iterator tables=getTables().iterator();
    while(tables.hasNext()) {
      result.addElement(getTableName((Element)tables.next()));
    }
    return result;
  }
  /**
   * 获得数据表名(英文名和中文名)
   */
  public HashMap getTableNameAndNicks(){
    HashMap result=new HashMap();
    Iterator tables=getTables().iterator();
    while(tables.hasNext()) {
      Element table=(Element)tables.next();
      result.put(getTableName(table),getTableNick(table));
    }
    return result;
  }

  public HashMap getColumnNameAndNicks(String tablenick) {
    if(getTable(tablenick)!=null) {
      HashMap result=new HashMap();
      Iterator loop=getColumns(getTable(tablenick)).iterator();
      while(loop.hasNext()) {
        Element col=(Element)loop.next();
        result.put(getName(col),getNick(col));
      }
      return result;
    }
    return null;
  }

  public Vector getColumnNames(String tablenick) {
    if(getTable(tablenick)!=null) {
      Vector result=new Vector();
      Iterator loop=getColumns(getTable(tablenick)).iterator();
      while(loop.hasNext()) {
        Element col=(Element)loop.next();
        result.addElement(getName(col));
      }
      return result;
    }
    return null;
  }

  public Vector getColumnNicks(String tablenick) {
    if(getTable(tablenick)!=null) {
      Vector result=new Vector();
      Iterator loop=getColumns(getTable(tablenick)).iterator();
      while(loop.hasNext()) {
        Element col=(Element)loop.next();
        result.addElement(getNick(col));
      }
      return result;
    }
    return null;
  }

 public String getColumnName(String tablenick,String columnnick) {
   Element table=getTable(tablenick);
   Iterator loop=getColumns(table).iterator();
   while(loop.hasNext()) {
     Element col=(Element)loop.next();
     if (getNick(col).equals(columnnick)){
        return getName(col);
     }
   }
   return null;
 }

 public String getTableNameFormNick(String tablenick) {
   return getTableName(getTable(tablenick));
 }

  public Element getTable(String tablenick) {
    Iterator loop=getTables().iterator();
    while(loop.hasNext()) {
      Element table=(Element)loop.next();
      if(getTableNick(table).equals(tablenick))
        return table;
    }
    return null;
  }

  private List getTables() {
    List list=root.getChild("tables").getChildren("table");
    return list;
  }

  private String getTableNick(Element table) {
    return table.getAttributeValue("nick");
  }

  private String getTableName(Element table) {
    return table.getAttributeValue("name");
  }

  private List getColumns(Element table) {
    List list=table.getChild("columns").getChildren("column");
    return list;
  }

  private int getColumnsSize(Element table) {
    return getColumns(table).size();
  }

  private String getNick(Element column) {
    return column.getAttributeValue("nick");
  }

  private String getName(Element column) {
    return column.getAttributeValue("name");
  }

}
