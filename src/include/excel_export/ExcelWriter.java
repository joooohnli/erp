package include.excel_export;



import jxl.*;
import jxl.write.*;
import java.io.*;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import include.nseer_db.nseer_db;
import java.sql.*;


public class ExcelWriter
{


private String dbase="";
private String tablename="";
private nseer_db erp_db;


public void CreExcel(String dbase,String tablename,String tablenick,String[] cols,String file_path) {

this.dbase=dbase;
this.tablename=tablename;
erp_db = new nseer_db(dbase);	  



String targetfile = file_path;//输出的excel文件名
String worksheet = tablenick;//输出的excel文件工作表名


WritableWorkbook workbook;
try
{

OutputStream os=new FileOutputStream(targetfile); 
workbook=Workbook.createWorkbook(os); 

WritableSheet sheet = workbook.createSheet(worksheet, 0);
jxl.write.Label label;

List excel_col_name= (List)new java.util.ArrayList();
List excel_col_type= (List)new java.util.ArrayList();
List excel_col_nick= (List)new java.util.ArrayList();

for(int i=0;i<cols.length;i++){

excel_col_name.add(cols[i].split("⊙")[1]);
excel_col_type.add(cols[i].split("⊙")[0]);
excel_col_nick.add(cols[i].split("⊙")[2]);

}


for(int i=0;i<excel_col_nick.size();i++){
String col_nick=(String)excel_col_nick.get(i);

label = new jxl.write.Label(i, 0, col_nick); //put the title in row1 
sheet.addCell(label); 

}

String sql="select * from "+tablename;
ResultSet rs=erp_db.executeQuery(sql);

List data= (List)new java.util.ArrayList();

int n=1;

while(rs.next()){

for(int i=0;i<excel_col_name.size();i++){
String col_name=(String)excel_col_name.get(i);
String col_type=(String)excel_col_type.get(i);



if(col_type.indexOf("text")!=-1||col_type.indexOf("mediumtext")!=-1||col_type.indexOf("varchar")!=-1){

label = new jxl.write.Label(i, n, rs.getString(col_name)); //put the title in row1 
sheet.addCell(label); 

}else if(col_type.indexOf("int")!=-1){

jxl.write.Number number = new jxl.write.Number(i, n,rs.getInt(col_name));
sheet.addCell(number);

}else if(col_type.indexOf("double")!=-1||col_type.indexOf("decimal")!=-1){

jxl.write.Number number = new jxl.write.Number(i, n,rs.getDouble(col_name));
sheet.addCell(number);

}else if(col_type.indexOf("datetime")!=-1){
Format format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date date = new Date();
Date date1 = (Date) format.parseObject(rs.getString(col_name));


jxl.write.DateFormat df = new jxl.write.DateFormat("yyyy-MM-dd HH:mm:ss"); 
jxl.write.WritableCellFormat wcfDF = new jxl.write.WritableCellFormat(df); 
jxl.write.DateTime labelDT = new jxl.write.DateTime(i,n,date1,wcfDF); 
sheet.addCell(labelDT); 

}else{

label = new jxl.write.Label(i, n, rs.getString(col_name)); //put the title in row1 
sheet.addCell(label);

}

}

n++;

}



erp_db.close();
	  
	


workbook.write(); 
workbook.close();
}catch(Exception e) 
{ 
e.printStackTrace(); 
} 	





 }  




public void CreExcel(String dbase,String tablename,String tablenick,String[] cols,String file_path,String condition,String queue) {

this.dbase=dbase;
this.tablename=tablename;
erp_db = new nseer_db(dbase);	  



String targetfile = file_path;//输出的excel文件名
String worksheet = tablenick;//输出的excel文件工作表名


WritableWorkbook workbook;
try
{

OutputStream os=new FileOutputStream(targetfile); 
workbook=Workbook.createWorkbook(os); 

WritableSheet sheet = workbook.createSheet(worksheet, 0);
jxl.write.Label label;

List excel_col_name= (List)new java.util.ArrayList();
List excel_col_type= (List)new java.util.ArrayList();
List excel_col_nick= (List)new java.util.ArrayList();

for(int i=0;i<cols.length;i++){

excel_col_name.add(cols[i].split("⊙")[1]);
excel_col_type.add(cols[i].split("⊙")[0]);
excel_col_nick.add(cols[i].split("⊙")[2]);

}


for(int i=0;i<excel_col_nick.size();i++){
String col_nick=(String)excel_col_nick.get(i);

label = new jxl.write.Label(i, 0, col_nick); //put the title in row1 
sheet.addCell(label); 

}

String sql="select * from "+tablename+" "+condition+" "+queue;
ResultSet rs=erp_db.executeQuery(sql);

List data= (List)new java.util.ArrayList();

int n=1;

while(rs.next()){

for(int i=0;i<excel_col_name.size();i++){
String col_name=(String)excel_col_name.get(i);
String col_type=(String)excel_col_type.get(i);



if(col_type.indexOf("text")!=-1||col_type.indexOf("mediumtext")!=-1||col_type.indexOf("varchar")!=-1){

label = new jxl.write.Label(i, n, rs.getString(col_name)); //put the title in row1 
sheet.addCell(label); 

}else if(col_type.indexOf("int")!=-1){

jxl.write.Number number = new jxl.write.Number(i, n,rs.getInt(col_name));
sheet.addCell(number);

}else if(col_type.indexOf("double")!=-1||col_type.indexOf("decimal")!=-1){

jxl.write.Number number = new jxl.write.Number(i, n,rs.getDouble(col_name));
sheet.addCell(number);

}else if(col_type.indexOf("datetime")!=-1){
Format format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date date = new Date();
Date date1 = (Date) format.parseObject(rs.getString(col_name));


jxl.write.DateFormat df = new jxl.write.DateFormat("yyyy-MM-dd HH:mm:ss"); 
jxl.write.WritableCellFormat wcfDF = new jxl.write.WritableCellFormat(df); 
jxl.write.DateTime labelDT = new jxl.write.DateTime(i,n,date1,wcfDF); 
sheet.addCell(labelDT); 

}else{

label = new jxl.write.Label(i, n, rs.getString(col_name)); //put the title in row1 
sheet.addCell(label);

}

}

n++;

}



erp_db.close();
	  
	


workbook.write(); 
workbook.close();
}catch(Exception e) 
{ 
e.printStackTrace(); 
} 	





 }  











public static void main(String[] args) 
{

String targetfile = "c:/out.xls";//输出的excel文件名
String worksheet = "List";//输出的excel文件工作表名
String[] title = {"ID","NAME","DESCRIB"};//excel工作表的标题


WritableWorkbook workbook;
try
{
//创建可写入的Excel工作薄,运行生成的文件在tomcat/bin下
//workbook = Workbook.createWorkbook(new File("output.xls")); 
OutputStream os=new FileOutputStream(targetfile); 
workbook=Workbook.createWorkbook(os); 

WritableSheet sheet = workbook.createSheet(worksheet, 0);


jxl.write.Label label;
for (int i=0; i<title.length; i++)
{
	for (int j=0; j<50; j++)
  {
//Label(列号,行号 ,内容 )
label = new jxl.write.Label(i, j, title[i]); //put the title in row1 
sheet.addCell(label); 
  }
}








/*

//添加数字
jxl.write.Number number = new jxl.write.Number(3, 4, 3.14159); //put the number 3.14159 in cell D5
sheet.addCell(number);

//添加带有字型Formatting的对象 
jxl.write.WritableFont wf = new jxl.write.WritableFont(WritableFont.TIMES,10,WritableFont.BOLD,true); 
jxl.write.WritableCellFormat wcfF = new jxl.write.WritableCellFormat(wf); 
jxl.write.Label labelCF = new jxl.write.Label(4,4,"文本",wcfF); 
sheet.addCell(labelCF); 

//添加带有字体颜色,带背景颜色 Formatting的对象 
jxl.write.WritableFont wfc = new jxl.write.WritableFont(WritableFont.ARIAL,10,WritableFont.BOLD,false,jxl.format.UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.RED); 
jxl.write.WritableCellFormat wcfFC = new jxl.write.WritableCellFormat(wfc); 
wcfFC.setBackground(jxl.format.Colour.BLUE);
jxl.write.Label labelCFC = new jxl.write.Label(1,5,"带颜色",wcfFC); 
sheet.addCell(labelCFC); 

//添加带有formatting的Number对象 
jxl.write.NumberFormat nf = new jxl.write.NumberFormat("#.##"); 
jxl.write.WritableCellFormat wcfN = new jxl.write.WritableCellFormat(nf); 
jxl.write.Number labelNF = new jxl.write.Number(1,1,3.1415926,wcfN); 
sheet.addCell(labelNF); 

//3.添加Boolean对象 
jxl.write.Boolean labelB = new jxl.write.Boolean(0,2,false); 
sheet.addCell(labelB); 

//4.添加DateTime对象 
jxl.write.DateTime labelDT = new jxl.write.DateTime(0,3,new java.util.Date()); 
sheet.addCell(labelDT); 

//添加带有formatting的DateFormat对象 
jxl.write.DateFormat df = new jxl.write.DateFormat("ddMMyyyyhh:mm:ss"); 
jxl.write.WritableCellFormat wcfDF = new jxl.write.WritableCellFormat(df); 
jxl.write.DateTime labelDTF = new jxl.write.DateTime(1,3,new java.util.Date(),wcfDF); 
sheet.addCell(labelDTF); 

//设置边框
jxl.write.WritableCellFormat wcsB = new jxl.write.WritableCellFormat(); 
wcsB.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THICK);
labelCFC = new jxl.write.Label(0,6,"边框设置",wcsB); 
sheet.addCell(labelCFC); 
*/


workbook.write(); 
workbook.close();
}catch(Exception e) 
{ 
e.printStackTrace(); 
} 

}
} 