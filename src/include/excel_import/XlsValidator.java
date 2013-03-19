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

import java.io.InputStream;
import java.io.FileInputStream;
import java.util.Iterator;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFRow;

public class XlsValidator extends Path {
  private String fileName=null;
  private HSSFWorkbook wb = null;
  private StringBuffer message=new StringBuffer("");
  private XlsInfo xlsInfo=null;
  /**
   * 用于获得excel文件的名称
   * 需要首先执行
   * @param fileName 文件名
   */
  public void setFile(String fileName) throws Exception{
    this.fileName=getPath()+"/conf/excel_import/"+fileName;
    if(fileName==null) {
      throw new Exception ("Exception: 必须指定验证的Excel文件名");
    }
    try{
      InputStream input=new FileInputStream(this.fileName);
      POIFSFileSystem fs = new POIFSFileSystem( input );
      wb = new HSSFWorkbook(fs);
      xlsInfo=new XlsInfo(wb);
    }
    catch (Exception e){
      e.printStackTrace();
    }
  }

  public boolean validate() {
    for(int i=0;i<wb.getNumberOfSheets();i++){
      HSSFSheet sheet=wb.getSheetAt(i);
      if (validateSheet(sheet)) {
	String sheetName=wb.getSheetName(i);
	if (validateTitle(sheet,sheetName)) {
	  if (validateContent()) {
	    if (validateValue()) {
	      return true;
	    }
	  } // end of if ()
	}
	sheetName=null;
      }
      sheet=null;
    }
    return false;
  }

  private boolean validateSheet(HSSFSheet sheet) {
    if (sheet==null) {
      message.append("有空的sheet");
      return false;
    } else if(sheet.getNumMergedRegions()>0){
      message.append("有列合并的情况<br>");
      return false;
    }
    return true;
  }

  /**
   * 判断是否有空的列标题（第一行为标题行），即第一行是否有空单元格 
   * @return true:有空标题的列
   */ 
  private boolean validateTitle(HSSFSheet sheet,
				String sheetName){

    HSSFRow row=sheet.getRow((short)0);
    if(row==null) {
      //没有标题行
      message.append("有空标题的情况,或者空的SHEET");
      return false;
    }
    Iterator cells=row.cellIterator();
    int size=0;
    while(cells.hasNext()) {
      HSSFCell cell=(HSSFCell)cells.next();
      size++;
    }
    for(int j=0;j<size-1;j++) {
      HSSFCell cell=row.getCell((short)j);	
      if(cell==null) {
	return false;
      } else {	
	 if(cell.getCellType()!=HSSFCell.CELL_TYPE_STRING){
	   message.append(""/*sheetName*/).append("的第");
	   message.append(j+1).append("列的标题类型不对<br>");
	   return false;
	 }
	 if(cell.getCellType()==HSSFCell.CELL_TYPE_BLANK){
	   message.append(""/*sheetName*/).
            append("的第").append(j+1).append("列的标题为空<br>");
	   return false;
	 }
      }
    }
    return true;
  }

  /**
   * 是validateValue的辅助方法，
   * 
   * @return false:数据不合法
   */
  public boolean validateType(HSSFCell cell,
			      String columnName,
			      String sheetName){
    try {                               
      String itemType=
	xlsInfo.getColumnType(columnName,sheetName);
      switch(cell.getCellType()){
      case HSSFCell.CELL_TYPE_STRING:		 
	if(itemType.equals("INT")||
	   itemType.equals("DOUBLE")||
	   itemType.equals("DATE")){
	  return false;
	}
	break;
      default: 
	break;
      }
      itemType=null;
    }catch(Exception e){
      e.printStackTrace();
      return false;
    }
    return true;
  }
 
  public boolean validateContent() {
    for(int i=0;i<wb.getNumberOfSheets();i++) {
      HSSFSheet sheet=wb.getSheetAt(i);
      String sheetName=wb.getSheetName(i);
      int rowCount=xlsInfo.getRowCount(sheetName);
      for(int j=1;j<rowCount;j++){
	HSSFRow row=sheet.getRow(j);
	for(int n=0;n<xlsInfo.getColumnCount(sheetName);n++){
	  HSSFCell cell=row.getCell((short)n);
	  if(cell==null){
	  message.append(""/*sheetName*/).append("有的行或者列(列");
	  message.append(n+1).append(":行");
	  message.append(j+1).append(")为空(");
	  message.append(""/*sheetName*/).append("记录总行数是");
	  message.append(rowCount).append("吗?)<br>");
	  return false;
	  }
	}
      }
    }
    return true;
  }

  public boolean validateValue(){
    for(int i=0;i<wb.getNumberOfSheets();i++) {
      HSSFSheet sheet=wb.getSheetAt(i);
      String sheetName=wb.getSheetName(i);
      int rowCount=xlsInfo.getRowCount(sheetName);
      for(int j=1;j<rowCount;j++){
	HSSFRow row=sheet.getRow(j);
	HSSFRow row1=sheet.getRow(0);//得到第一行，为了得到名称itemname
	for(int n=0;n<xlsInfo.getColumnCount(sheetName);n++){
	  HSSFCell cell1=row1.getCell((short)n);
	  String itemname=cell1.getStringCellValue();
	  HSSFCell cell=row.getCell((short)n);
	  if(!validateType(cell,itemname,sheetName)){
	    message.append("第").append(n+1);
	    message.append("列 : 第").append(j+1);
	    message.append("行变量类型不符合<br>");
	    return false;
	  }
	  cell1=null;
	  itemname=null;
	  cell=null;
	}
	row=null;
	row1=null;
      }
      sheet=null;
      sheetName=null;
    }
    return true;
  }

  public String getMessage() {
    return message.toString();
  }

}
