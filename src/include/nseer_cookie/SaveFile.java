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


public class SaveFile {
public SaveFile() {
    }
public String toSave(String xml_path,String cont) {
try{

	
FileOutputStream fo=new FileOutputStream(xml_path);
Writer so = new OutputStreamWriter(fo, "UTF-8"); //?????utf-8
String content=cont;
if(content.indexOf("</textarea1>")!=-1){
	content=content.replace("</textarea1>","</textarea>");
	so.write(content);//数组加载
	}else if(content.indexOf("</TEXTAREA1>")!=-1){
	content=content.replace("</TEXTAREA1>","</TEXTAREA>");
	so.write(content);//数组加载
    }else{
	so.write(content);//数组加载
	}


so.close();

}catch(Exception ex){ex.printStackTrace();}
return cont;
}



}
