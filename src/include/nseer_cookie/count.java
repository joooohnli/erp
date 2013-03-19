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

public class count extends Object {
private String currentRecord = null;
private BufferedReader file; 
private String path;
public count() {
}
public String ReadFile(String filePath) throws FileNotFoundException
{
path = filePath;
file = new BufferedReader(new FileReader(path));
String returnStr =null;
try
{
currentRecord = file.readLine();
}
catch (IOException e)
{
	e.printStackTrace();
}
if (currentRecord == null)
returnStr = "没有任何记录";
else
{
returnStr =currentRecord;
}
return returnStr;
}
public void WriteFile(String filePath,String counter) throws FileNotFoundException
{
path = filePath;
int Writestr = Integer.parseInt(counter)+1;
try {
PrintWriter pw = new PrintWriter(new FileOutputStream(filePath));
pw.println(Writestr);
pw.close();
} catch(IOException e) {
	e.printStackTrace();
}
}

}