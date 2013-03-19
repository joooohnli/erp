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
import include.nseer_cookie.*;

public class CopyDir{

public void cp(String sourcepath,String destpath){
File sfile = new File(sourcepath);
File dfile = new File(destpath);
File slist[]=sfile.listFiles();
File dlist[]=dfile.listFiles();
int sl=slist.length;
int dl=dlist.length;
int fileno=0;
String tempName="";
if(dlist.length==0){
	fileno=1;
}else{
	for(int j=0;j<dl;j++){
		if(!dlist[j].isDirectory()){
		tempName=dlist[j].getName();
		if(!tempName.substring(tempName.lastIndexOf(".")).equals(".db")){
		tempName=tempName.substring(5,tempName.lastIndexOf("."));
		if(fileno<Integer.parseInt(tempName)) fileno=Integer.parseInt(tempName);
		}
		}
	}
	fileno++;
}
for(int j=0;j<sl;j++){
	if(!slist[j].isDirectory()){
	tempName=slist[j].getName();
	tempName=tempName.substring(tempName.lastIndexOf("."));
	if(!tempName.equals(".db")){
	copyFile cp = new copyFile(sourcepath+"/"+slist[j].getName(),destpath+"/nseer"+fileno+tempName);
	cp.setMakeDirs(false);
	cp.copy();
	fileno++;
	}
	}
}

delFile df=new delFile();
df.delete(sourcepath);
}
public static void main(String[] args) {
	CopyDir cd = new CopyDir();
	cd.cp("D:/tomcat/webapps/erp/temp_object_dir/temp","D:/tomcat/webapps/erp/nseerImages");
}

}