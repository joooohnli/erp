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

import java.io.*;
import java.util.*;
import org.jdom.*;
import org.jdom.input.SAXBuilder;

public class Masking extends Path{

  private SAXBuilder builder=null;
  private Document doc=null;
  private Element root=null;

  public Masking (String fileName) {
    init(fileName);
  }

  public Masking(){
  }

  public void setFile(String fileName){
    init(fileName);
  }

  private void init(String fileName){
   String file=getPath()+"/conf/"+fileName;
    try {
      builder=new SAXBuilder("org.apache.xerces.parsers.SAXParser");//可理解为读XML的驱动
      doc=builder.build(new File(file));
      root=doc.getRootElement();
    } catch(Exception je) {
      je.printStackTrace();
    }
  }

  public Document getDocument(){
    return doc;
  }

  /**
   * 获得配置文件所有的数据表名(中文)
   *
   */


  public Vector getTableNicks() {
    Vector result=new Vector();
    Iterator tables=getTables().iterator();//实现遍历的迭代器
    while(tables.hasNext()) {
      result.addElement(getTableNick((Element)tables.next()));
    }
    return result;
  }



  /**
   * 获得配置文件所有的数据表名(英文)
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
   * 获得配置文件所有的数据表名(英文名和中文名)
   */
  public HashMap getTableNameAndNicks(){
    HashMap result=new HashMap();//将得到的数据表中英文名称成对放入哈希表
    Iterator tables=getTables().iterator();
    while(tables.hasNext()) {
      Element table=(Element)tables.next();
      result.put(getTableName(table),getTableNick(table));
    }
    return result;
  }

 /**
   * 获得某个数据表所有字段名(英文名和中文名)
   */
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

 /**
   * 获得某个数据表所有字段名(英文名)
   */
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
 /**
   * 获得某个数据表所有字段名(中文名)
   */
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


  public Vector getColumnUsedTags(String tablenick) {
    if(getTable(tablenick)!=null) {
      Vector result=new Vector();
      Iterator loop=getColumns(getTable(tablenick)).iterator();
      while(loop.hasNext()) {
        Element col=(Element)loop.next();
        result.addElement(getUsedTag(col));
      }
      return result;
    }
    return null;
  }
   public Vector getColumnRequireds(String tablenick) {
    if(getTable(tablenick)!=null) {
      Vector result=new Vector();
      Iterator loop=getColumns(getTable(tablenick)).iterator();
      while(loop.hasNext()) {
        Element col=(Element)loop.next();
        result.addElement(getRequired(col));
      }
      return result;
    }
    return null;
  }
   public Vector getColumnAttributes(String tablenick,String attribute) {
    if(getTable(tablenick)!=null) {
      Vector result=new Vector();
      Iterator loop=getColumns(getTable(tablenick)).iterator();
      while(loop.hasNext()) {
        Element col=(Element)loop.next();
        result.addElement(getAttribute(col,attribute));
      }
      return result;
    }
    return null;
  }
 /**
   * 返回字段的英文名称
   * @param tablenick 中文数据表名
   * @param columnnick 中文字段名
   */
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

  /**
   * 此处误拼from为form
   * 以后需改正
   */
  public String getTableNameFormNick(String tablenick) {
    return getTableName(getTable(tablenick));
  }
/**
   * 将某个数据表的中文名称转化为英文名称
   */
 public String getTableNameFromNick(String tablenick) {
    return getTableName(getTable(tablenick));
  }
/**
   * 将某个数据表的英文名称转化为中文名称
   */
  public String getTableNickFromName(String table) {
    HashMap map=getTableNameAndNicks();//map的键为Name，值为Nick
    if (map==null) {
      return null;
    }
    return (String)map.get(table);
  }
/**
   * 在配置文件中定位某个名称为中文的数据表区域，准备做某些操作
   */
  public Element getTable(String tablenick) {
    Iterator loop=getTables().iterator();
    while(loop.hasNext()) {
      Element table=(Element)loop.next();
      if(getTableNick(table).equals(tablenick))
        return table;
    }
    return null;
  }
/**
   * 在配置文件中得到所有的数据表区域放到list结果集 ，准备做某些操作
   */
  private List getTables() {
	  List list=root.getChild("tables").getChildren("table");
    return list;
  }
  
/**
   * 在配置文件中得到某个数据表的中文名称 ，准备做某些操作
   */
  private String getTableNick(Element table) {
    return table.getAttributeValue("nick");
  }
/**
   * 在配置文件中得到某个数据表的英文名称 ，准备做某些操作
   */
  private String getTableName(Element table) {
    return table.getAttributeValue("name");
  }
/**
   * 在配置文件中得到某个数据表的所有字段对象，放到list结果集 ，准备做某些操作
   */
  private List getColumns(Element table) {
    List list=table.getChild("columns").getChildren("column");
    return list;
  }
/**
   * 在配置文件中得到某个数据表的所有字段的数量，准备做某些操作
   */
  private int getColumnsSize(Element table) {
    return getColumns(table).size();
  }

/**
   * 在配置文件中得到某个数据表的某个字段的中文名称，准备做某些操作
   */
  private String getNick(Element column) {
    return column.getAttributeValue("nick");
  }
/**
   * 在配置文件中得到某个数据表的某个字段的英文名称，准备做某些操作
   */
  private String getName(Element column) {
    return column.getAttributeValue("name");
  }

   private String getUsedTag(Element column) {
    return column.getAttributeValue("usedTag");
  }

   private String getRequired(Element column) {
    return column.getAttributeValue("required");
  }
   private String getAttribute(Element column,String attribute) {
    return column.getAttributeValue(attribute);
  }
}
