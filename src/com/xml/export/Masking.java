/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package com.xml.export;

import java.io.*;
import java.util.*;
import org.jdom.*;
import org.jdom.input.*;

public class Masking extends Path{
		
		 String file = "";
		private SAXBuilder builder = null;
		private Document doc = null;
		private Element  root = null;
		private static Masking  mask = null;
		
		public Masking() {}
		
		public Masking(String filename){
				init(filename);
			}
		
		public void setFile(String filename){
			   init(filename);
			}
		public void init(String filename){			
			  try {
			  	this.file = getPath()+filename;
			  	SAXBuilder builder = new SAXBuilder();
			  	doc = builder.build(new File(file));
			  	if(doc.hasRootElement())
			  	   root = doc.getRootElement();  
			  }
			  catch (Exception jex) {
			   jex.printStackTrace();
			  }
			}
	   public static Masking getMask(){
	      return mask;
	   }
	  /*
	   *在配置文件中获得所有的数据表区域放到列表中
	   */ 
	 public List getTables(){
	 	   List list = root.getChild("tables").getChildren("table");
	 	   return list;
	 	}
	  /*
	   *在配置文件中获得某个数据表的中文名称
       */
     
     public String getTableNick(Element table){
     		return  table.getAttributeValue("nick");
     	}
	 
	 /*
	  *在配置文件中获得某个表的英文名称
	  */
	  
	  public String getTableName(Element table){
	  	    return table.getAttributeValue("name");
	  	}
	  
	  
	  /*
	   *在配置文件中获得某个表的所有字段
	  */
	  public List getColumnFields(Element table){
	  		List columnslist=table.getChild("columns").getChildren("column");
	  		return columnslist;
	  	}
	  
	  /*
	   *在配置文件中获得某个表的列个数量
	   */
	   public int getColumnCount(Element table){
	   	     return getColumnFields(table).size();
	   	}
	  /*
	   *从配置文件中获得每个字段的中文名称
	   */
	   
	   public String getColumnNick(Element column){
	   		return column.getAttributeValue("nick");
	   	}
	   
	   /*
	    *在配置文件中获得每个字段的英文名称
	    */
	    
	    public String getColumnName(Element column){
	          return column.getAttributeValue("name");		
	    }
	    
	    /*
	     *从配置文件中获得所有的表名中文
	     */
	    public Vector getTablesNicks(){
	    	   Vector result = new Vector();
	    	   Iterator i=getTables().iterator();
	    	   while(i.hasNext()){
	    	   result.add(getTableNick((Element)i.next())); 
	    	   }
	    	   return result;
	    	}
	   /*
	    *从配置表中获得所有表的英文名称
	    */
	   public Vector getTableNames(){
	   	  Vector result = new Vector();
	   	  Iterator i = getTables().iterator();
	   	  while(i.hasNext()){
	   	  		result.add(getTableName((Element)i.next()));
	   	  }
	   	  return result;
	    }
	   
	   /*
	    *获得配置文件中的所有表的中文名称和英文名称放到哈希表中
	    */
	    public Hashtable getTableNamesAndNicks(){
	    		Hashtable result = new Hashtable();
	    		Iterator i=getTables().iterator();
	    		while(i.hasNext()){
	    				result.put(getTableName((Element)i.next()),getTableNick((Element)i.next()));
	    			}
	    	    return result;
	    	}
	    
	    /*
	     *在配置文件中定位某个表的位置,根据输入的表的英文名称
	     */
	     
	     public Element locateTable(String tablename){
	     		List list = getTables();
	     		Iterator tables = list.iterator();
	     		while(tables.hasNext()){
	     		 Element table = (Element)tables.next(); 
	     		 if(getTableName(table).equals(tablename))
	     		 return table;
	     		}
	     	  return null;
	     	}
	    /*
	     *获得配置文件中某个表的所有字段的中文名称和英文名称
	     */
	     
	  public Hashtable getColumnFieldsAndNicks(String tablename){
	    	   if(locateTable(tablename)!=null){
	    	   	 Hashtable result = new Hashtable();
	    	   	 Iterator i=getColumnFields(locateTable(tablename)).iterator();
	    	   	 while(i.hasNext()){
	    	   	 	  Element col=(Element)i.next();
	    	   	 	   result.put(getColumnName(col),getColumnNick(col));
	    	   	 	}
	    	   	   return result;
	    	   	} 
	              return null;   	    		
	    	}
	  /*
	   *获得配置文件中某个表的所有字段的中文名称
	   */
	   public Vector getColumnNicks(String tablename){
	   	   if(locateTable(tablename)!=null){
	   	   	   Vector result = new Vector();
	   	   	   Iterator i=getColumnFields(locateTable(tablename)).iterator();
	   	   	   while(i.hasNext()){
	   	   	   	    Element col=(Element)i.next();
	   	   	   	    result.addElement(getColumnNick(col));
	   	   	   	}
	   	   	   	return result;
	   	   	}
	   	     return null;
	   	}
	   
	   /*
	    *获得配置文件中某个表所有字段的英文名称
	    */
	   
	   public Vector getColumnNames(String tablename){
	   	  if(locateTable(tablename)!=null){
	   	  	  Vector result = new Vector();
	   	  	  Iterator i=getColumnFields(locateTable(tablename)).iterator();
	   	  	  while(i.hasNext()){
	   	  	  		Element col =(Element)i.next();
	   	  	  		result.addElement(getColumnName(col));
	   	  	  	}
	   	  	 return result;
	   	    }
	   	    return null;
	   	}
	   
	   /*
	    *将某个表的中文名称转换成英文名称
	    */
	   
	   public String getTableNamefromNick(String tablenick){
	   	   return  getTableName(locateTable(tablenick));
	   	}
	   	
	   	/*
	   	 *将某个表的英文名称转换成中文名称
	   	 */
	   	 
	   	 public String getTableNickfromName(String tablename){
	   	 	  return getTableNick(locateTable(tablename));
	   	 	}
	   	 
	 /*  public static void main(String args[]){
	   		Masking mask = new Masking("data.xml");
	   		List oo =  mask.getColumnFields(mask.locateTable("file"));
	   	}*/
	}
	