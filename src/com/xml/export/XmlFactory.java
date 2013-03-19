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

import java.sql.*;
import java.io.*;
import java.util.*;
import org.jdom.*;
import org.jdom.output.*;
import org.jdom.input.*;
import com.xml.export.Path;
import com.xml.export.Datum;
import com.xml.export.Masking;

public class XmlFactory extends Path{
		 
	    //ArrayList ids = new ArrayList();
		List columnnames = null;
		Vector contents = new Vector();
	   private String file = null;
	   private SAXBuilder builder = null;
	   private Document doc= null;
	   private Element  root = null;
	   private Element table = null;
       private File cfile = null;
       private String strmask = "";
	   private String database="";
	   private String tablename="";
	   private String xml_file="";
	   private String condition="";
	   private String[] cols=new String[10000];
	
	  
	   public XmlFactory(){
	   	
	   	}
	   public XmlFactory(String filename,String database,String tablename,String[] cols,String xml_file,String condition){
		   this.database=database;
		   this.tablename=tablename;
		   this.cols=cols;
		   this.xml_file=xml_file;
		   this.condition=condition;
	   	 try {
	   	 	file = getPath()+"/"+filename;
	   	 	try {
				 FileWriter fw = new FileWriter(file);
	   	 	     fw.write("<table>");
	   	 	     fw.write("</table>");
	   	 	     fw.flush();
				 }
				 catch (Exception ex) {
				  ex.printStackTrace();
				 }
	   	 	builder = new SAXBuilder();
	   	 	doc = builder.build(new File(file));
		    }
		    catch (JDOMParseException jpex) {
		    	 try {
				 FileWriter fw = new FileWriter(file);
	   	 	     fw.write("<table>");
	   	 	     fw.write("</table>");
	   	 	     fw.flush();
				 }
				 catch (Exception ex) {
				 }
		    	jpex.printStackTrace();
		    }catch(JDOMException je){
		      	 je.printStackTrace();
		    }catch(IOException ie){
		    	 ie.printStackTrace();
		    	}
		   }
		 
		 public void setMask(String strmask){
		 	   this.strmask = strmask;
		 	}
	   String data = "";
	   Element element = null;
	   ResultSetMetaData rsmd= null;
	   public void makeElement() throws Exception{
	   	    Datum  datum = new Datum(database,tablename,condition);
	   	    Masking mask = new Masking();
	   	    mask.init(xml_file);
	   	    rsmd= datum.dbif.rs.getMetaData();
	   	    int columnnumbers = rsmd.getColumnCount();
	   	    columnnames = mask.getColumnNicks(tablename);
	   	    table = new Element("table");
	   	 	doc.setRootElement(table);
	   	 	 root = doc.getRootElement();
	   	    while(datum.dbif.rs.next()){
	   	      for(int i=0;i<cols.length;){
			   StringTokenizer token=new StringTokenizer(cols[i],"/");
			   while(token.hasMoreTokens()){
	   	       data=new String(datum.dbif.rs.getString(token.nextToken()).getBytes("UTF-8"),"UTF-8");
	   	       element =new Element(token.nextToken()); 
	   	      root.addContent(element.setText(data));
			   }
	   	      i++;
	   	    }	   	    
	   	  }    
	   }
	  
	  
	  public void Xmlwrite(){
	    try {
	    	Format format = Format.getCompactFormat();
        	format.setEncoding("UTF-8"); // 设置xml文件的字符为utf-8
        	format.setIndent("  "); // 设置xml文件的缩进为4个空格
        	XMLOutputter XMLOut = new XMLOutputter(format);// 元素后换行一层元素缩四格
        	XMLOut.output(doc, new FileOutputStream(file));
	      /*	
	      XMLOutputter outputter=new XMLOutputter("  ",true,"GB2312");//"  "意为缩进几个空格
	      FileWriter writer = new FileWriter(file);
	      outputter.setTextTrim(true);//清除空格，为了缩进一致
	      outputter.output(doc,writer);
	      writer.close();
	      */
	    } catch(FileNotFoundException e) {
	      e.printStackTrace();
	    } catch(IOException ioe) {
	      ioe.printStackTrace();
	    } 
      }
     
  }