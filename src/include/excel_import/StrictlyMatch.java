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

import include.excel_export.*;
/**
 * 根据数据库的字段属性
 * 匹配即将进入数据的EXCEL数据字段属性
 */
public class StrictlyMatch {

  private String message=null;
  private XlsValidator xlsValidator=null;
  private XlsInfo xlsInfo=null;
  private DataBaseInfo info=null;
  private String fileName=null;
  private String tableName=null;
  private Masking xml=null;
  public StrictlyMatch(String fileName,String tableName,
		       String database,String dataxml){//得到xml文件,excel文件和数据库信息
    this.fileName=fileName;
    this.tableName=tableName;
    message="";
    xml=new Masking(dataxml);
    xlsValidator=new XlsValidator();
    try {
      xlsValidator.setFile(fileName);      
    } catch (Exception e) {
      System.err.println(e.getMessage());
    } // end of try-catch
    xlsInfo=new XlsInfo(fileName);
    info=new DataBaseInfo(database);

  }
  
  public void setXlsInfo(XlsInfo xlsInfo){
    this.xlsInfo=xlsInfo;
  }

  public XlsInfo getXlsInfo() {
    return this.xlsInfo;
  }

  /**进行匹配
  */
  public boolean match(String sheetName,String itemName,String columnName) {
    //先检查EXCEL的格式，调用outter的validate方法
    if(!xlsValidator.validate()){
      message+=xlsValidator.getMessage();
      return false;
    }
    String type="";
    String columnType="";
    try{
      type=xlsInfo.getColumnType(itemName,sheetName);
	
      if(type.equals("UNKNOWN")) {
	return false;
      }
      String realTableName=xml.getTableNameFormNick(tableName);
      String realColumnName=xml.getColumnName(tableName,columnName);
      if (realColumnName==null||realTableName==null) {
	message+="请检查XML文件,里面是否有关于该数据表以及其字段的配置信息";
	return false ;
      } // end of if ()
      
      columnType=info.getColumnType(realColumnName,realTableName);
      info.finalize();
      if(type.equals("INT")) {
	if(columnType.equals("INT")||
	   columnType.equals("LONG")||
	   columnType.equals("TINY")||
	   columnType.equals("DOUBLE")||
	   columnType.equals("FLOAT")||
	   columnType.equals("DECIMAL")) {	
	  return true;
	}
      } else if (type.equals("STRING")||
		 type.equals("INT1")){
	if(columnType.equals("TEXT")||
	   columnType.equals("VARCHAR")||
	   columnType.equals("BLOB")||
	   columnType.equals("CHAR")) {
	  return true;
	}
      } else if (type.equals("DOUBLE")){
	if(columnType.equals("DOUBLE")||
	   columnType.equals("DECIMAL"))
	  return true;
      } else if (type.equals("FLOAT")){
	if(columnType.equals("FLOAT")||
	   columnType.equals("DOUBLE")||
	   columnType.equals("DECIMAL"))
	  return true;
      } else if (type.equals("DATE")){
	if(columnType.equals("DATE"))
	  return true;
      }
	  
    }
    catch (Exception e){
      e.printStackTrace();
      info.finalize();
      return false;
    }
    message="Excel的相应字段类型为："+translateMessage(type)+" 数据库表相应字段类型为："+translateMessage(columnType);
    return false;
  }
  
  /**
  *返回匹配信息
  */
  public String getMessage() {
    return this.message;
  }
  /**
  *将英文的类型信息转换中文
  */ 
  private String translateMessage(String type) {
    String message="";
    if(type.equals("INT")){
      message="整数";
    } else if(type.equals("DOUBLE")){
      message="实数";
    } else if(type.equals("STRING")){
      message="字符";
    } else if(type.equals("DATE")){
      message="日期";
    } else if(type.equals("TEXT")||
	      type.equals("VARCHAR")||
	      type.equals("BLOB")||
              type.equals("CHAR")){
      message="字符";    	
    }
    return message;  	
  }
  
 
}
