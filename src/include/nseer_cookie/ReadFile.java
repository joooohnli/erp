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
import java.util.*;
import java.text.*;

public class ReadFile {
public ReadFile() {
    }
public List<String> toFile(String xml_path) {

	ArrayList<String> cont = new ArrayList<String>();//定义数组
try{
	

RandomAccessFile filee = new RandomAccessFile(xml_path, "r");
	long filePointer = 0; 
	long length = filee.length(); 
	while (filePointer < length) {
		String mk = filee.readLine();//按行读取文件
		byte []  str=mk.getBytes("8859_1"); 
		String content = new String(str, "utf8"); //保存为utf-8格式的文件
		if(content.indexOf("</textarea>")!=-1){
			content=content.replace("</textarea>","</textarea1>");
			cont.add(content);//数组加载
			}else if(content.indexOf("</TEXTAREA>")!=-1){
			content=content.replace("</TEXTAREA>","</TEXTAREA1>");
			cont.add(content);//数组加载
		    }else{
			cont.add(content);
			}
			filePointer = filee.getFilePointer(); 
	}


}catch(Exception ex){ex.printStackTrace();}

return cont;
}

public static void main(String args[]){
try{
CreateFile cc = new CreateFile();
cc.toFile("E:\\3333.jsp","","");
}catch(Exception ex){ex.printStackTrace();}
}

}
