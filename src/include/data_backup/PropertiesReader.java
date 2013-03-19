/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.data_backup;

import java.io.*;
import java.util.Properties;
import java.net.*;

public class PropertiesReader {

  private Properties properties;
  public PropertiesReader(){
    this("db.properties");//mysql.properties是专门为数据库备份的配置文件，此文件定义了一个放置备份的动态路径
  }

  public PropertiesReader(String file) {
    
       String separator=System.getProperty("file.separator");
	   String strClassName = getClass().getName(); 
String strPackageName = ""; if(getClass().getPackage() != null) { strPackageName = getClass().getPackage().getName(); } 
 String strClassFileName = ""; if(!"".equals(strPackageName)) 
{ strClassFileName = strClassName.substring(strPackageName.length() + 1,strClassName.length()); } else { strClassFileName = strClassName; }
URL url= getClass().getResource(strClassFileName + ".class");
String strURL = url.toString(); 
strURL = strURL.substring(strURL.indexOf('/') + 1,strURL.lastIndexOf('/')); 
String strURL2 = strURL.substring(0,strURL.lastIndexOf("WEB-INF"));
String strURL1=strURL2+"WEB-INF/classes";
    file =strURL1 + separator+"conf"+separator+file;
    properties = new Properties();  

    try{
      FileInputStream in = new FileInputStream(file);  // 构造文件的输入流
      properties.load(in);           // 读入file中定义的各项属性
      in.close();
    }catch(Exception e){
      e.printStackTrace();
    }
  }
/**
*得到配置文件的属性值
*/
  public String getProperty(String name){
    if (properties==null) {
      return null;
    } // end of if ()
    return properties.getProperty(name);
  }

} 

