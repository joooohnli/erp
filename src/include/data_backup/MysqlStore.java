/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.data_backup;

import java.io.*;
import java.net.*;
import java.util.Properties;
/**
 * MysqlStore.java
 *
 * 用于mysql在windows上的数据备份和恢复
 * 需要配置mysql.prorperties文件的用户名、密码、路径等信息。
 * 当程序用在普通的java application时,mysql.properties文件位
 * 于MysqlStore.class下级的conf中；当用web application时以
 * JSP服务器不同位置不同，例如在resin时，文件放到resin\conf下
 *
 * Created: Mon Aug 30 11:51:56 2004
 *
 * @author <a href="mailto:Administrator@ORK"></a>
 * @version 1.0
 */
public class MysqlStore {
  private Runtime rt;//runtime用于调用其他可执行文件
  private PropertiesReader reader;
  private String fileName;
  private String userName;
  private String password;
  
   private String strURL1;
  // MysqlStore constructor,构造函数
  public MysqlStore() {
    reader=new PropertiesReader();
    userName=reader.getProperty("username");
    password=reader.getProperty("password");

//得绝对路径
String strClassName = getClass().getName(); 
String strPackageName = ""; if(getClass().getPackage() != null) { strPackageName = getClass().getPackage().getName(); } 
 String strClassFileName = ""; if(!"".equals(strPackageName)) 
{ strClassFileName = strClassName.substring(strPackageName.length() + 1,strClassName.length()); } else { strClassFileName = strClassName; }
URL url= getClass().getResource(strClassFileName + ".class");
String strURL = url.toString(); 
strURL = strURL.substring(strURL.indexOf('/') + 1,strURL.lastIndexOf('/')); 
String strURL2 = strURL.substring(0,strURL.lastIndexOf("WEB-INF"));
 strURL1=strURL2+"WEB-INF/";

try {
    rt=Runtime.getRuntime();//runtime的静态函数

	} catch (Exception e) {
      e.printStackTrace();
    }
  }
  /**
  *
   * 备份
   * @tableName 要备份的数据库的名字
   * @fileName 备份数据存放的文件名，扩展名为.sql
   * @return 成功的话,返回true;
   */

  public boolean backup(String fileName,String database){
    fileName=getBackupFileName(fileName);
    try {
Properties properties = new Properties();
InputStream inputstream = getClass().getClassLoader().getResourceAsStream("/conf/dbip.properties");
properties.load(inputstream);
if(inputstream != null) inputstream.close();
String masterIp=properties.getProperty("IP");
		/**
 mysql5.0.18做了相应的修改  mysqldump  -x  -u"+userName+" -p"+password+" -c --default-character-set=UTF-8  --databases ondemand1
   */
 Process process =rt.exec("mysqldump  -x  -u"+userName+" -p"+password+" -c --default-character-set=utf8  --databases "+database+" -h "+masterIp+" ");//因为两个进程难以同步，该dos命令缺少输出到目标文件，所以采用下面的解决方法从缓存得到，写入目标文件
     String line="";
      BufferedWriter bufferedWriter =
	new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileName),"UTF-8"));//创建写数据流，准备接收上面dos命令的输出
      BufferedReader bufferedReader =
	new BufferedReader(new InputStreamReader(process.getInputStream(),"UTF-8"));//读process执行的输出流，这个输出流存放在哪里，
																		//如果在内存，是否会超出内存容量而造成丢失
      while ( (line=bufferedReader.readLine()) != null) {
	bufferedWriter.write(line.replace("text NOT NULL,","text NOT NULL default '',"));
	bufferedWriter.newLine();
      }
      bufferedWriter.flush();
      bufferedWriter.close();
      process.waitFor();//等待整个进程完成
    } catch (IOException e) {
      e.printStackTrace();
      return false;
    }catch (InterruptedException ie) {
      ie.printStackTrace();
      return false;
    } // end of catch
    return true;
  }

  /**
   * 恢复
   * @tableName 数据库名
   * @fileName  文件名
   */
  public boolean recovery(String fileName){
    String btfileName=writeHelperBat(fileName);
    try {
      Process process=rt.exec("cmd /E:OFF /c start "+btfileName);//批处理加入完成后生成一个文件，
																 //程序探测到文件生成即恢复完成
      String line="";
      BufferedReader bufferedReader =
	new BufferedReader(new InputStreamReader(process.getInputStream()));
      while ( (line=bufferedReader.readLine()) != null) {
	System.out.println(line);
      }

    } catch (IOException e) {
      e.printStackTrace();
      return false;
    }

    return true;
  }

  /**
   *是backup的辅助方法，
   * 根据当前系统时间与设置的文件名生成准确的备份文件名
   * @fileName 初始的文件名
   */
  private String getBackupFileName(String fileName) {
    String time=getTime();
    int index=fileName.lastIndexOf(".");
    if (index!=-1) {
      fileName=fileName.substring(0,index)+fileName.substring(index,fileName.length());
    } else {
      fileName=fileName;
    } // end of else
	
    fileName=strURL1+fileName;
    return fileName;
  }

  /**
   * 得到恢复文件的全路径名
   * @fileName 初始的文件名
   */
  private String getRecoveryFileName(String fileName) {
    fileName=strURL1+fileName;
    return fileName;
  }

  /**
   * 获得系统的当前时间
   * @return 以yy-MM-dd-hh-mm-ss形式的时间
   */
  private String getTime(){
    java.util.Date now=new java.util.Date();
    java.text.SimpleDateFormat formater =
      new java.text.SimpleDateFormat("yy-MM-dd-hh-mm-ss");
    String time=formater.format(now);
    return time;
  }

  /**
   * 生成辅助的在dos 环境下运行的批处理文件
   *
   */
  private String writeHelperBat(String fileName){
    String btfile=getRecoveryFileName("do.bat");
    fileName=getRecoveryFileName(fileName);
    File file=new File(btfile);
    if (file.exists()) {
      file.delete();
    }
	
    try {
	Properties properties = new Properties();
InputStream inputstream = getClass().getClassLoader().getResourceAsStream("/conf/dbip.properties");
properties.load(inputstream);
if(inputstream != null) inputstream.close();
String masterIp=properties.getProperty("IP");
    BufferedWriter bufferedWriter =
      new BufferedWriter(new OutputStreamWriter(new FileOutputStream(btfile)));
    String content="mysql -u"+userName+" -p"+password+" -h "+masterIp+" <"+fileName;
    bufferedWriter.write(content);
    bufferedWriter.newLine();
    bufferedWriter.write("exit");
    bufferedWriter.flush();
    bufferedWriter.close();

    } catch (FileNotFoundException fe) {
      fe.printStackTrace();
    } catch (IOException ioe) {
      ioe.printStackTrace();
    } // end of catch


    return btfile;
  }
/**
*示例
*/
  public static void main(String[] args) {
    MysqlStore store=new MysqlStore();
    store.recovery("backm.sql");
  } // end of main()

} // MysqlStore
