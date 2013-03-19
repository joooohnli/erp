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

/**********************************************
功能说明:
实现文件的拷贝
***********************************************/
public class copyFile
{

String sourcePath;
String destinationPath;
int buffer;
long fileLength;
FileInputStream sourceFile;
FileOutputStream destinationFile;
boolean makeDirs;
boolean isMoving;
boolean fieldSss;

public copyFile(String sourcePath,String destinationPath)
{
this.sourcePath = sourcePath;
this.destinationPath = destinationPath;
buffer = 2048;
fileLength = 0L;
sourceFile = null;
destinationFile = null;
makeDirs = false;
isMoving = false;
fieldSss = false;
}

public int copy()
{
File sourceFile = new File(sourcePath);
File destFile = new File(destinationPath);
File destinationFile=null;
FileInputStream sourceFileInputStream = null;
FileOutputStream destinationFileOutputStream = null;

byte buf[] = new byte[buffer];
int counter = 0;
if(!sourceFile.exists())
{
return -1;

}
if(sourceFile.isDirectory()) //如果源文件是目录，抛出异常。
{
return -2;
}

try
{
if(destFile.isDirectory()){
String srcName=sourceFile.getName();

destinationPath+=srcName;
}

destinationFile=new File(destinationPath);
String parentDirectory = destinationFile.getParent();
File parentDirFile = new File(parentDirectory);
if(!parentDirFile.exists())
{
if(!makeDirs) //如果目标文件的目录不存在，又不能创建新目录，抛出异常。
{
return -3;
}
if(makeDirs) //目标文件的目录不存在，则创建新目录。
parentDirFile.mkdirs(); //创建名为parentDirFile的目录。
}
}catch(NullPointerException _ex) { }
long oldFileLength = fileLength;
fileLength = sourceFile.length();

try
{
sourceFileInputStream = new FileInputStream(sourceFile);
destinationFileOutputStream = new FileOutputStream(destinationFile);
while((counter = sourceFileInputStream.read(buf)) != -1) //从输入流中读buf长度的数据。
{
destinationFileOutputStream.write(buf, 0, counter); //从buf中往输出流中写入counter长度的数据。
}
}
catch(IOException e)
{
return -4;
}
if(destinationFileOutputStream != null)
try
{
destinationFileOutputStream.close(); //关闭输出流。
}catch(IOException e)
{
return -4;
}
try
{
sourceFileInputStream.close(); //关闭输入流。
}catch(IOException e)
{
return -4;
}

return 1;
}

public void setMakeDirs(boolean makeDirs)
{
boolean oldValue = this.makeDirs;
this.makeDirs = makeDirs;
}

public static void main(String[] args) {
	copyFile cp = new copyFile("d:/cnbbs/face/face0.gif","d:/gggggg/crm.gif");
	cp.setMakeDirs(false);
	cp.copy();
}
}