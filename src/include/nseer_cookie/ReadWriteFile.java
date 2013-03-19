/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import java.io.*;
import java.net.*;
import java.util.Properties;

public class ReadWriteFile {

	public void execute(String readFile,String special) {
//得绝对路径
	try{
		String strClassName = getClass().getName(); 
		String strPackageName = ""; if(getClass().getPackage() != null) { strPackageName = getClass().getPackage().getName(); } 
		 String strClassFileName = ""; if(!"".equals(strPackageName)) 
		{ strClassFileName = strClassName.substring(strPackageName.length() + 1,strClassName.length()); } else { strClassFileName = strClassName; }
		URL url= getClass().getResource(strClassFileName + ".class");
		String strURL = url.toString(); 
		strURL = strURL.substring(strURL.indexOf('/') + 1,strURL.lastIndexOf('/')); 
		String strURL2 = strURL.substring(0,strURL.lastIndexOf("WEB-INF"));
		String strURL1=strURL2+"WEB-INF/";
		 readFile=strURL1+readFile;
		 String writeFile=strURL1+special+".sql";
		 File write_aim = new File(writeFile);
		 write_aim.createNewFile();
		 String line="";
		 BufferedWriter bufferedWriter=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(writeFile),"UTF-8"));
		 BufferedReader bufferedReader=new BufferedReader(new InputStreamReader(new FileInputStream(readFile),"UTF-8"));
		 while ( (line=bufferedReader.readLine()) != null) {
			bufferedWriter.write(line.replace("ondemand1",special));
			bufferedWriter.newLine();
		 }
		 bufferedWriter.flush();
		 bufferedWriter.close();
		 bufferedReader.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
  }
} 