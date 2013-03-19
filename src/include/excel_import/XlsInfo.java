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
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.Vector;
import java.util.HashMap;
import java.util.Set;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFRow;

public class XlsInfo extends Path {

  private HashMap rowCount=new HashMap();
  private HashMap columnCount=new HashMap();
  private HashMap columnTypes=new HashMap();
  private HashMap columnsNames=new HashMap();
  private HashMap sheets=new HashMap();
  private Vector sheetsName=new Vector();
  private Vector getRowValues_result=new Vector();
  private Vector getColumnsName_result=new Vector();
  private HashMap getColumnType_types=new HashMap();
  private DecimalFormat intFormat=
    MyDataFormat.intDecimalFormat;
  private DecimalFormat doubleFormat=
    MyDataFormat.doubleDecimalFormat;
  private SimpleDateFormat yyyymmddFormat=
    MyDataFormat.yyyymmddDateFormat;
  private HSSFWorkbook wb=null;
  private HSSFDataFormat df=null;

  public XlsInfo(HSSFWorkbook wb) {
    this.wb=wb;
    df=wb.createDataFormat();
  }

  public XlsInfo(String fileName) {
    String filename=getPath()+"/conf/excel_import/"+fileName;
    try{
      InputStream input=new FileInputStream(filename);
      POIFSFileSystem fs = new POIFSFileSystem( input );
      wb = new HSSFWorkbook(fs);
      df=wb.createDataFormat();
    }
    catch (Exception e){
      e.printStackTrace();
    }  
  }

  public int getRowCount(String sheetName){
    if (rowCount.containsKey(sheetName)) {
      return ((Integer)rowCount.get(sheetName)).intValue();
    }    
    HSSFSheet sheet=getSheetForSheetName(sheetName);
    int rowssize=sheet.getPhysicalNumberOfRows();
    int size=0;
    for(int i=0;i<rowssize;i++){
      HSSFRow row=sheet.getRow(i);
      if (row!=null)
	size++;
      row=null;
    }
    Integer mysize=new Integer(size);
    rowCount.put(sheetName,mysize);
    sheet=null;
    mysize=null;
    //System.gc();
    return size;  	
  }

  /**
   * 获得SHEET的列数
   * @param sheet HSSFSheet
   * @return int 
   */
  public int getColumnCount(String sheetName){
    if (columnCount.containsKey(sheetName)) {
      return ((Integer)columnCount.get(sheetName)).intValue();
    }
    HSSFSheet sheet=getSheetForSheetName(sheetName);
    HSSFRow row=sheet.getRow(0);
    int size=0;
    int cellssize = row.getPhysicalNumberOfCells();
    for (int i=0;i<cellssize;i++) {
      HSSFCell cell=row.getCell((short)i);
      if (cell!=null) {
	size++;
	cell=null;
      } // end of if ()
    }
    Integer mysize=new Integer(size);
    columnCount.put(sheetName,mysize);
    sheet=null;
    row=null;
    mysize=null;
    //System.gc();
    return size;
  }

  public Vector getColumnsName(String sheetName){
    if (columnsNames.containsKey(sheetName)) {
      return (Vector)columnsNames.get(sheetName);
    }    
    HSSFSheet sheet=getSheetForSheetName(sheetName);
    getColumnsName_result.clear();
    HSSFRow row=sheet.getRow((short)0);
    int cellssize=row.getPhysicalNumberOfCells();
    for(int i=0;i<cellssize;i++) {
      HSSFCell cell=row.getCell((short)i);
      getColumnsName_result.addElement(cell.getStringCellValue());
      cell=null;
    }
    columnsNames.put(sheetName,getColumnsName_result);
    sheet=null;
    row=null;

    //System.gc();
    return getColumnsName_result;
  }

  public Vector getRowValues(int rowNum,Vector columnNames,String sheetName) {
    getRowValues_result.clear();
    HSSFSheet sheet=getSheetForSheetName(sheetName);
    HSSFRow row=sheet.getRow(rowNum);
    for (int i=0;i<getColumnCount(sheetName);i++) {
      try {
      Vector allColumnNames=getColumnsName(sheetName);
      String aName=(String)allColumnNames.elementAt(i);
      if (columnNames.contains(aName)) {
	HSSFCell cell=row.getCell((short)i);
	String itemType=getColumnType(aName,sheetName);
	dump(getRowValues_result,cell,itemType);
	cell=null;
	itemType=null;
      } // end of if ()
      allColumnNames=null;
      aName=null;
      }catch (Exception e) {
	e.printStackTrace();
      } // end of catch
      
    }
    sheet=null;
    row=null;
    //System.gc();
    return getRowValues_result;
  }

  public Vector getRowValues(int rowNum,String sheetName) {
    getRowValues_result.clear();
    HSSFSheet sheet=getSheetForSheetName(sheetName);
    HSSFRow row=sheet.getRow(rowNum);
    for (int i=0;i<getColumnCount(sheetName);i++) {
      HSSFCell cell=row.getCell((short)i);
      String columnName=
	(String)getColumnsName(sheetName).elementAt(i);
      String itemType=getColumnType(columnName,sheetName);
      dump(getRowValues_result,cell,itemType);
      cell=null;
      columnName=null;
      itemType=null;
    }
    sheet=null;
    row=null;
    //System.gc();
    return getRowValues_result;
  }


  public String getColumnType(String columnName,
			      String sheetName) {
    if (columnTypes.containsKey(sheetName+"-"+columnName)) {
      return (String)columnTypes.get(sheetName+"-"+columnName);
    }
    HSSFSheet sheet=getSheetForSheetName(sheetName);
    int index=getColumnsName(sheetName).indexOf(columnName);
    getColumnType_types.clear();
    for (int i=1;i<getRowCount(sheetName);i++) {
      HSSFRow row=sheet.getRow(i);
      HSSFCell cell=row.getCell((short)index);
      //debug!!
      if (index==-1) {
	System.err.println("getColumnType: index==-1");
      } // end of if ()
      
      if (cell==null) {
	System.err.println("getColumnType:cell==null");	
      } // end of if ()
      String celltype=getCellDataType(cell);
      if (!getColumnType_types.containsKey(celltype)) {
        //判断是否是哈希表中已有的类型
	getColumnType_types.put(celltype,new Integer(1));	    
      } else {
	getColumnType_types.put(celltype,new Integer(((Integer)getColumnType_types.get(celltype)).intValue()+1));
      } // end of else
      row=null;
      cell=null;
      celltype=null;
    } // end of for ()
    Set set=getColumnType_types.keySet();
    Iterator it=set.iterator();
    Integer max=new Integer(0);
    String realtype="BLANK";
    int flag=0;
    while (it.hasNext()) {
      String key=(String)it.next();
      if (flag==0) {
	max=(Integer)getColumnType_types.get(key);//给max赋初值
	realtype=key;
	flag++;
      }else if (max.compareTo((Integer)getColumnType_types.get(key))<0) {
	max=(Integer)getColumnType_types.get(key);
	realtype=key;
      }
      //key=null; 
    } // end of while ()
    columnTypes.put(sheetName+"-"+columnName,realtype);	
    sheet=null;
    set=null;
    it=null;
    max=null;
    //System.gc();
    return realtype;
  }

  private String getCellDataType(HSSFCell cell) {
    String type="";
    HSSFCellStyle cellstyle=cell.getCellStyle();
    short datatype=cellstyle.getDataFormat();
    //获得STYLE的字符串形式
    if(df==null) System.err.println("df==null");
    String dataFormatStr=df.getFormat(datatype);
    //System.out.println("DATATYPE="+dataFormatStr);
    //System.out.println("CellType+"+cell.getCellType());

    switch(cell.getCellType()){
    case HSSFCell.CELL_TYPE_NUMERIC:
      if(dataFormatStr.indexOf("0_")==0||
	 dataFormatStr.indexOf("0;")==0||
	 dataFormatStr.indexOf("#,##0_")==0||
	 dataFormatStr.indexOf("#,##0;")==0||
	 dataFormatStr.equals("0")) {
	type="INT";
      } else if(dataFormatStr.equals("yyyy\\-mm\\-dd")||
		dataFormatStr.equals("yyyy-mm-dd")||
		dataFormatStr.equals("yyyy/mm/dd")||
		dataFormatStr.equals("m/d/yy")||
		dataFormatStr.equals("0x1f")){//中国式的日期类型：2004年9月15日
	type="DATE";
      } else if(dataFormatStr.indexOf("#,##0.")==0||
		dataFormatStr.indexOf("0.0")==0){
	type="DOUBLE";
      } else if(dataFormatStr.equals("General")){
	//实际类型为INT，最好将其看作字符处理导入我们的数据库，比如序号，无下划线的电话号码

	type="INT1";
      } else {
	type="NUMBERIC";
      } // end of else
      
      break;
    case HSSFCell.CELL_TYPE_STRING:
      if(dataFormatStr.equals("General")){
	type="STRING";
      } else if(dataFormatStr.equals("@")){
	type="STRING";		   
      } else if(dataFormatStr.indexOf("0_")==0||  //虽然HSSf判断的是字符串，但如果形式还是数字，做数字处理
		dataFormatStr.indexOf("0;")==0||
		dataFormatStr.indexOf("#,##0_")==0||
		dataFormatStr.indexOf("#,##0;")==0||
		dataFormatStr.equals("0")) {
	type="INT";
      } else if(dataFormatStr.indexOf("#,##0.")==0||
		dataFormatStr.indexOf("0.0")==0){
	type="DOUBLE";     
      } else {
	System.out.println(dataFormatStr);
      } // end of else
      
      break;
    case HSSFCell.CELL_TYPE_BLANK:
      type="BLANK";
      break;
    case HSSFCell.CELL_TYPE_FORMULA:
      type="FORMULA";
      break;
    case HSSFCell.CELL_TYPE_ERROR:
      type="ERROR";
      break;        
    default: 
      type="UNKNOWN";
      break;
    }
    cellstyle=null;
    dataFormatStr=null;
    //System.gc();
    return type;
  } 

  private HSSFSheet getSheetForSheetName(String sheetName) {
    if (sheets.containsKey(sheetName)) {
      return (HSSFSheet)sheets.get(sheetName);
    } // end of if ()
    for(int i=0;i<wb.getNumberOfSheets();i++) {
      HSSFSheet sheet=wb.getSheetAt(i);
      String tablename=wb.getSheetName(i);
      sheets.put(sheetName,sheet);
      if (tablename.equals(sheetName)) {
	tablename=null;
	return sheet;
      } // end of if ()
    }
    return null;
  }

  public Vector getSheetsName() {
    if (sheetsName.size()>0) {
      return sheetsName;
    } // end of if ()
    for(int i=0;i<wb.getNumberOfSheets();i++){
      String sheetName=wb.getSheetName(i);
      sheetsName.addElement(sheetName);
    }
    return sheetsName;
  }

  /**
   * Sets the value of rowCount
   *
   * @param argRowCount Value to assign to this.rowCount
   */
  public void setRowCount(HashMap argRowCount) {
    this.rowCount = argRowCount;
  }

  /**
   * Sets the value of columnCount
   *
   * @param argColumnCount Value to assign to this.columnCount
   */
  public void setColumnCount(HashMap argColumnCount) {
    this.columnCount = argColumnCount;
  }

  /**
   * Gets the value of columnTypes
   *
   * @return the value of columnTypes
   */
  public HashMap getColumnTypes()  {
    return this.columnTypes;
  }

  /**
   * Sets the value of columnTypes
   *
   * @param argColumnTypes Value to assign to this.columnTypes
   */
  public void setColumnTypes(HashMap argColumnTypes) {
    this.columnTypes = argColumnTypes;
  }

  /**
   * Gets the value of columnsNames
   *
   * @return the value of columnsNames
   */
  public HashMap getColumnsNames()  {
    return this.columnsNames;
  }

  /**
   * Sets the value of columnsNames
   *
   * @param argColumnsNames Value to assign to this.columnsNames
   */
  public void setColumnsNames(HashMap argColumnsNames) {
    this.columnsNames = argColumnsNames;
  }

  /**
   * Gets the value of sheets
   *
   * @return the value of sheets
   */
  public HashMap getSheets()  {
    return this.sheets;
  }

  /**
   * Sets the value of sheets
   *
   * @param argSheets Value to assign to this.sheets
   */
  public void setSheets(HashMap argSheets) {
    this.sheets = argSheets;
  }

  private void dump(Vector result,HSSFCell cell,String itemType) {
    String type=getCellDataType(cell);
    String num,date=null;
    if (type.equals("INT")) {
      num=
	String.valueOf(intFormat.format(cell.getNumericCellValue()));
      result.addElement(num);
    } else if (type.equals("STRING")) {
      result.addElement(cell.getStringCellValue());
    } else if (type.equals("DATE")){
      date=
	String.valueOf(yyyymmddFormat.format(cell.getDateCellValue()));
      result.addElement(date);
    } else if (type.equals("DOUBLE")){
      num=
	String.valueOf(doubleFormat.format(cell.getNumericCellValue()));
      result.addElement(num);
    } else if(type.equals("INT1")){
      num=
	String.valueOf(intFormat.format(cell.getNumericCellValue()));
      result.addElement(num);
    } else if(type.equals("BLANK")){
      if(itemType.equals("STRING")) {
	result.addElement(" ");
      } else if(itemType.equals("INT")){
	result.addElement(new Integer(0));
      } else if(itemType.equals("DOUBLE")){
	result.addElement(new Double(0.00));
      } else if(itemType.equals("DATE")){
	result.addElement("0000-00-00");
      } else if(itemType.equals("UNKNOWN")){
	result.addElement(" ");
      }
    }
    type=null;
    num=null;
    date=null;
  }

}
