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

import java.net.*;

/**
 * 为了java 虚拟机运行目录无关性而设置的类。保证xml文件与虚拟机工作路径同步
 * 对于当前应用resin作为java 虚拟机，这个是为了得到resin的路径。
 */
public class Path {
	 private String strURL1;
public Path () {

}

public String getPath() {
	
	/*String strClassName = getClass().getName(); 
	String strPackageName = ""; if(getClass().getPackage() != null) { strPackageName = getClass().getPackage().getName(); } 
	 String strClassFileName = ""; if(!"".equals(strPackageName)) 
	{ strClassFileName = strClassName.substring(strPackageName.length() + 1,strClassName.length()); } else { strClassFileName = strClassName; }
	URL url= getClass().getResource(strClassFileName + ".class");
	String strURL = url.toString(); 
	strURL = strURL.substring(strURL.indexOf('/') + 1,strURL.lastIndexOf('/')); 
	String strURL2 = strURL.substring(0,strURL.lastIndexOf("WEB-INF"));
	 strURL1=strURL2+"WEB-INF/classes/";*/
	 
	 
   String path =this.getClass().getClassLoader().getResource("/").getPath();//该方法将返回web应用程序的绝对路径 。
   return path;
}

}