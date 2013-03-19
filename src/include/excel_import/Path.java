/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.excel_import;
/**
 * 为了java 虚拟机运行目录无关性而设置的类。保证xml文件与虚拟机工作路径同步
 *
 */
public class Path {
public Path () {

}

public String getPath() {
  /* String path = System.getProperty("user.dir")
            + System.getProperty("file.separator");
   return path;*/
    String path =this.getClass().getClassLoader().getResource("/").getPath();//该方法将返回web应用程序的绝对路径 。
   return path;
}

public static void main(String[] args) {
  Path path=new Path();
}

}
