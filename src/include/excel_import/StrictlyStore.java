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

import java.util.*;
import include.excel_import.helper.*;
import include.excel_export.*;
import include.nseer_db.*;
 /**
   * 将匹配好的excel数据写入数据库
      */
public class StrictlyStore {
    
  private nseer_db db=null;
  private XlsInfo xlsInfo=null;
  private Masking xml=null;
  private DataBaseInfo dbinfo=null;
  private String fileName=null;
  private Vector informations=null;
  private String table=null;
  private String realTableName=null;
  private String message=null;//导入过程的状态信息

  public StrictlyStore(String table,String database,
		       String configFile,String fileName){
    db=new nseer_db(database);
    xlsInfo=new XlsInfo(fileName);
    xml=new Masking(configFile);
    dbinfo=new DataBaseInfo(database);
    informations=new Vector();
    this.table=table;
    realTableName=xml.getTableNameFormNick(table);
    dbinfo.setTable(realTableName);
  }
  
  /**
   * 设置要导入的数据表汉字名称
   * @param table 数据别名（用汉字表示）
   */
  public void setTable(String table) {
    this.table=table;
  }
  //这个Vector必须是由Information组成！！
  public void setInformation(Vector informations) {
    this.informations=informations;
  }

  public void setXlsInfo(XlsInfo xlsInfo) {
    this.xlsInfo=xlsInfo;
  }

  public void execute() {
    try {
      Vector columns=xlsInfo.getColumnsName(table);
      StringBuffer sql=new StringBuffer("insert into ");
      sql.append(realTableName);
      StringBuffer sql2=new StringBuffer(" (");
      Vector temp=new Vector();
      Vector columnNames=new Vector();
      for (int i=0;i<informations.size();i++) {

	Information information=(Information)informations.elementAt(i);
	columnNames.addElement(information.getItem());
	sql2.append(xml.getColumnName(table,information.getColumn()));
       sql2.append(",");
      }
      sql2=new StringBuffer(sql2.substring(0,sql2.length()-1)).append(" ) ");
      String sheetName=
	((Information)informations.elementAt(0)).getSheet();
	sql.append(sql2).append("values (");
      for (int i=1;i<xlsInfo.getRowCount(sheetName);i++) {
	Vector parts=xlsInfo.getRowValues(i,columnNames,sheetName);
	StringBuffer statement=new StringBuffer("").append(sql);
	for (int j=0;j<parts.size();j++) {
	  statement.append("'").
         append(parts.elementAt(j)).append("',");
	} // end of for ()
	String last=statement.substring(0,statement.length()-1)+")";
	//System.err.println(last);
	db.executeUpdate(last);
	statement=null;
	last=null;
	parts=null;
      } // end of for ()
      sql=null;
      sql2=null;
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      db.close();
      dbinfo.finalize(); 
    } // end of finally
  }

  public String getMessage(){
    return this.message;
  }
}
