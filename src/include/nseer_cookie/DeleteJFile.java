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

import include.nseer_db.nseer_db;

import java.io.*;
import java.sql.ResultSet;

public class DeleteJFile extends Object {

private BufferedReader file; //BufferedReader对象，用于读取文件数据
private String path;//文件完整路径名
public DeleteJFile() {
}

public void delete(String filePath) throws FileNotFoundException
{
try {
File f=new File(filePath+"javascript/include/nseergrid/nseergrid.js");
f.delete();
} catch(Exception e) {
	e.printStackTrace();
}
}

public static void main(String[] a){
	DeleteJFile w=new DeleteJFile();
	try{
	w.delete("D:/");
	}catch(Exception ex){ex.printStackTrace();}
}
}