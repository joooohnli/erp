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

public class writeFile extends Object {

private BufferedReader file; //BufferedReader对象，用于读取文件数据
private String path;//文件完整路径名
public writeFile() {
}

public void Write(String filePath,String a,String b) throws FileNotFoundException
{
path = filePath;
try {
//创建PrintWriter对象，用于写入数据到文件中
PrintWriter pw = new PrintWriter(new FileOutputStream(filePath));
pw.println(a);
pw.println(b);
pw.close();
} catch(IOException e) {
	e.printStackTrace();
}
}

}