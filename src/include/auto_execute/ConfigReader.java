/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.auto_execute;

import java.io.*;
import java.util.*;
import org.jdom.*;
import org.jdom.input.SAXBuilder;

/**
 * ConfigReader.java
 *
 * 读auto.xml
 * Created: Wed Sep 01 14:21:36 2004
 *
 * @author <a href="mailto:Administrator@ORK"></a>
 * @version 1.0
 */
public class ConfigReader extends Path{
  private String file="";
  private SAXBuilder builder=null;
  private Document doc=null;
  private Element root=null;
  ///
  private int length=0;
  private String[] classNames=null;
  private String[] methods=null;

  public ConfigReader() {
    file=getPath()+"/conf/auto.xml";
    try {
      builder=new SAXBuilder("org.apache.xerces.parsers.SAXParser");
      doc=builder.build(new File(file));
      root=doc.getRootElement();
    } catch(Exception je) {
      je.printStackTrace();
    }
    setLength();
    
  } // configreader constructor

  /**
   * 
   * 计算出任务的数量
   */
  private void setLength(){
    int length=0;
    List tasks=root.getChildren("task");
    Iterator it=tasks.iterator();
    while (it.hasNext()) {
      length++;
      it.next();
    } // end of while ()
    this.length=length;
  }

  /**
   *
   * 获得任务的数量
   */
  private int getLength(){
    return length;
  }

  /**
   *
   * 获得全部任务的类的名称
   */
  public String[] getClassNames(){
    if (this.classNames!=null) {//为了对下面的遍历类名称只执行一次，增加该方法
      return this.classNames;
    } // end of if ()
    String[] result=new String[length];
    List tasks=root.getChildren("task");
    Iterator it=tasks.iterator();
    int index=0;
    while (it.hasNext()) {
      Element task=(Element)it.next();
      result[index]=task.getChild("classname").getText();
      index++;
    } // end of while ()
    this.classNames=result;
    return result;
  }

  /**
   *
   * 获得全部类中的全部方法列表
   */
  public String[] getMethods(){
    if (this.methods!=null) {
      return this.methods;
    } // end of if ()

    String[] result=new String[length];
    List tasks=root.getChildren("task");
    Iterator it=tasks.iterator();
    int index=0;
    while (it.hasNext()) {
      Element task=(Element)it.next();
      result[index]=task.getChild("method").getText();
      index++;
    }
    this.methods=result;
    return result;
  }

  /**
   * 获得指定类的方法（必须每个类一个方法），即找出指定类在上面getMethods()方法列表中的哪个元素
   *
   */
  public String getMethod(String className){
    if (this.classNames==null||
        this.methods==null) {
      this.classNames=getClassNames();
      this.methods=getMethods();
    } 
    int index=indexOf(classNames,className);
    if (index==-1) {
      return null;
    } else if(index>=methods.length){//类和方法的数量相同，一一对应，类的位置数大于方法数组长度，返回null
      return null;
    } // end of else
    return methods[index];
  }
  //下面是getMethod(String className)的辅助方法
  private int indexOf(String[] array,String element){
    for (int i=0;i<array.length;i++) {
      if (array[i].equals(element)) {
	return i;
      } // end of if ()
    } // end of for ()
    return -1;
  }

  public static void main(String[] args) {
    String[] names=new ConfigReader().getClassNames();
    if (names!=null) {
      for (int i=0;i<names.length;i++) {
      } // end of for ()
    } // end of if ()
  } // end of main()
  
} // ConfigReader
