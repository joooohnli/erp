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

public class CreateFile {//重新生成文件
public CreateFile() {
    }
public void toFile(String xml_path,String source_value,String replace_value) {
ArrayList<String> cont = new ArrayList<String>();//定义数组
try{
RandomAccessFile filee = new RandomAccessFile(xml_path, "r");
	long filePointer = 0; 
	long length = filee.length(); 
	while (filePointer < length) {
		String mk = filee.readLine();//按行读取文件
		byte []  str=mk.getBytes("8859_1"); 
		String content = new String(str, "utf8");//以urt8格式
		if(content.indexOf(source_value)!=-1){
		content=content.replace(source_value,replace_value);
		cont.add(content);//数组加载
		}else{
		cont.add(content);
		}
		filePointer = filee.getFilePointer(); 
	}
FileOutputStream fo=new FileOutputStream(xml_path);
Writer so = new OutputStreamWriter(fo, "UTF-8"); //保存为utf-8格式的文件
for(String option :cont) {
	
so.write(option+"\r\n");//开始输出
}
so.close();
}catch(Exception ex){ex.printStackTrace();}
}

public static void main(String args[]){
try{
CreateFile cc = new CreateFile();
cc.toFile("E:\\3333.jsp","","");
}catch(Exception ex){ex.printStackTrace();}
}

}
