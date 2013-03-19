/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.excel_export;

import java.io.FileOutputStream;
import java.sql.*;
import java.util.Vector;
import java.util.Collection;
import java.util.Iterator;
import org.apache.poi.hssf.usermodel.*;//excel输入输出的最主要的类包
import include.nseer_db.*;
/**
 * 根据配置文件选择性写Excel文件  
 **/

// 代码运行需要 jakarta-poi-1.5.0-FINAL-20020506.jar.
public class XlsWriter {

  Masking reader;
  String sql;
  DataBaseInfo info;
  String configFile;
  nseer_db db;
  HSSFCellStyle doubleCellStyle,intCellStyle,dateCellStyle;

  public XlsWriter(String database,String configFile){
    init(database,configFile);
  }
/**
 * 初始化函数
 **/
  public XlsWriter(){

  }

  public void setSqlCondition(String condition) {
    this.sql=condition;
  }

/**
 * 得到数据库来源信息
 **/
  public void setDatabase(String database){
    init(database,null);
  }
/**
 * 得到配置好的xml文件名称
 **/
  public void setConfigFile(String configFile){
    this.configFile=configFile;
  }

  private void init(String database,String configfile){
    info=new DataBaseInfo(database);
    db=new nseer_db(database);
    this.configFile=configfile;
  }

  private void initCellTyles(HSSFWorkbook wb) {
    HSSFDataFormat df=wb.createDataFormat();
    short doubleFormat=df.getFormat("#,##0.00");
    short intFormat=df.getFormat("0");
    short dateFormat=df.getFormat("yyyy-mm-dd");
    doubleCellStyle=wb.createCellStyle();//创建表格样式 
    doubleCellStyle.setDataFormat(doubleFormat);
    intCellStyle=wb.createCellStyle();
    intCellStyle.setDataFormat(intFormat);
    dateCellStyle=wb.createCellStyle();
    dateCellStyle.setDataFormat(dateFormat);  
  }

/**
 * 执行写excel的方法
 **/
  public void write(String filename) {
    try {
      FileOutputStream fos = new FileOutputStream(filename);
      HSSFWorkbook wb = new HSSFWorkbook();
      initCellTyles(wb);
      //    HSSFSheet sheet = wb.createSheet();
      //读配置文件
      reader=new Masking(configFile);
      Vector tables=reader.getTableNicks();
      Iterator loop=tables.iterator();
      int i=0;
      //多个表，产生多个SHEET
      while(loop.hasNext()) {
	HSSFSheet sheet = wb.createSheet();
	String tablenick=(String)loop.next();
	wb.setSheetName(i, tablenick,HSSFWorkbook.ENCODING_UTF_16);
	Vector columns=reader.getColumnNicks(tablenick);
	writeTitle(columns,sheet);
	Vector columnNames=reader.getColumnNames(tablenick);

	writeContent(columnNames,sheet,reader.getTableNameFormNick(tablenick));
	i++;
	sheet=null;
	tablenick=null;
	columns=null;
	columnNames=null;

      }
      wb.write(fos);
      fos.close();
    } catch(Exception e) {
      e.printStackTrace();
    } finally {
      db.close();       
      info.finalize();
    }
    
  }

/**
 * 为write的辅助方法，写详细内容
 **/
  public void writeContent(Collection columns,HSSFSheet sheet,
			   String table) throws Exception{
    int i=1;
    Object[] names=new Object[columns.size()];
    columns.toArray(names);//将columns里的数据转化到数组中
    String SQL;
    info.setTable(table);
    if(sql==null) {
      SQL="select * from "+table;
    } else {
      SQL="select * from "+table+" "+sql;
    }
    ResultSet rs=db.executeQuery(SQL);

    try {
      while(rs.next()) {
	HSSFRow row=sheet.createRow((short)i);
	for(int j=0;j<columns.size();j++){
	  HSSFCell topcell=row.createCell((short)j);
	  String column=(String)names[j];
	  topcell.setEncoding(HSSFCell.ENCODING_UTF_16);//创建字符集

	  switch (getType(column)) {
	  //double类型的，嘿嘿
	  case HSSFCell.CELL_TYPE_NUMERIC:
	    topcell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
	    topcell.setCellStyle(doubleCellStyle);
	    topcell.setCellValue(rs.getDouble(column));
	    break;
         //字符类型的，嘿嘿
	  case HSSFCell.CELL_TYPE_STRING:
	    topcell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    topcell.setCellValue(rs.getString(column));
	    break;
	    //INT类型
	  case 200:
	    topcell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
	    topcell.setCellStyle(intCellStyle);
	    topcell.setCellValue(rs.getInt(column)); 
	    break;
	    //日期
	  case 300:
           topcell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    topcell.setCellStyle(dateCellStyle);
	    topcell.setCellValue(rs.getString(column));
	    break;
	  default:
	    topcell.setCellType(HSSFCell.CELL_TYPE_STRING);
	    topcell.setCellValue(rs.getString(column));
	    break;

	  } // end of switch ()
	  topcell=null;
	  column=null;
	}
	i++;
	row=null;
      }
    } catch(SQLException e) {
      e.printStackTrace();
    }
  }

  /**
 * 为write的辅助方法，填写表格的题目
 **/
  public void writeTitle(Collection columns,HSSFSheet sheet) {
    Object[] names=new Object[columns.size()];
    columns.toArray(names);
    HSSFRow row=sheet.createRow((short)0);
    for(int i=0;i<columns.size();i++) {
      HSSFCell cell=row.createCell((short)i);
      String column=(String)names[i];
      cell.setEncoding(HSSFCell.ENCODING_UTF_16);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue(column);
      cell=null;
      column=null;
    }
    row=null;
    names=null;
  }


   /**
 * 为writecontent 辅助方法，获得数据表中字段的属性
 **///
  public int getType(String column) throws Exception{
    //获得数据库中对应字段的类型
    String type=info.getColumnType(column);
    int hssfType;
    if(type!=null) 	{
      if(type.equals("DOUBLE")||
		  type.equals("DOUBLE PRECISION")||
		  type.equals("FLOAT")){
	hssfType=HSSFCell.CELL_TYPE_NUMERIC;
      } else if(type.equals("INTEGER")||
	       type.equals("TINY")||
	       type.equals("SHORT")||
	       type.equals("LONG")) {
	hssfType=200;
      } else if(type.equals("DATE")||
		   type.equals("TIMESTAMP")){
	hssfType=300; 
      } else {
	hssfType=HSSFCell.CELL_TYPE_STRING;
      }
    } else {
      hssfType=HSSFCell.CELL_TYPE_STRING;
    }
    return hssfType;
  }
 //按条件输出excel的方法
  public void setCondition(String sql) {
    this.sql=sql;
  }

  public static void main(String[] args) {
    XlsWriter mission=new XlsWriter("crm","table.xml");
    mission.write("Eoo.xls");
  }
}
