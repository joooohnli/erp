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

public class delFile{

public void delete(String filepath){
File file = new File(filepath);       
if(file.exists()&&file.isDirectory()){
    if(file.listFiles().length==0){
        file.delete();
    }else{
        File file1[]=file.listFiles();
        for(int j=0;j<file1.length;j++){
            if(file1[j].isDirectory()){
				delete(file1[j].getAbsolutePath());
            }
            file1[j].delete();
        }
    }
    delete(filepath);
}
}
}