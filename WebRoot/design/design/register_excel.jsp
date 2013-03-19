<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"
import="jxl.*"
import="jxl.write.*"
import="jxl.format.*"
import="java.util.*"
%>
<%
try{
String all_column=request.getParameter("all_column");
String product_name=request.getParameter("product_name");
String product_ID=request.getParameter("product_ID");
String cost_price_sum=request.getParameter("cost_price_sum");
String designer=request.getParameter("designer");
String checker=request.getParameter("checker");
String check_time=request.getParameter("check_time");
String register_time=request.getParameter("register_time");
String module_describe=request.getParameter("module_describe");
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
java.util.Date now = new java.util.Date();
long pdftime=now.getTime();
String filename="MyFirstTable"+pdftime+".xls";
session.setAttribute("excelname",filename);
File f=new File(path+"excel_files/"+filename);
jxl.write.WritableWorkbook wwb=Workbook.createWorkbook(new FileOutputStream(f));
jxl.write.WritableSheet ws =wwb.createSheet("物料组成设计单",0);
jxl.write.Label labelC =new jxl.write.Label(0,1,"产品名称：");
ws.addCell(labelC);
labelC =new jxl.write.Label(1,1,product_name);
ws.addCell(labelC);
labelC =new jxl.write.Label(2,1,"产品编号：");
ws.addCell(labelC);
labelC =new jxl.write.Label(3,1,product_ID);
ws.addCell(labelC);
jxl.write.WritableCellFormat wcsB = new jxl.write.WritableCellFormat(); 
wcsB.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THICK);
jxl.write.NumberFormat nf = new jxl.write.NumberFormat((String)application.getAttribute("nseerPrecision")); 
jxl.write.WritableCellFormat wcfN = new jxl.write.WritableCellFormat(nf);
wcfN.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THICK);
all_column="物料编号<$$>物料名称<$$>用途类型<$$>描述<$$>数量<$$>单位<$$>单价（元）<$$>小计（元）■"+all_column;
StringTokenizer tokenTO2 = new StringTokenizer(all_column,"■"); 
String[] array1=new String[tokenTO2.countTokens()];
int i=0;
while(tokenTO2.hasMoreTokens()) {
array1[i]=tokenTO2.nextToken();
i++;
}
int u=0;
for(;u<array1.length;u++){
StringTokenizer tokenTO3 = new StringTokenizer(array1[u],"<$$>");
int n=0;
while(tokenTO3.hasMoreTokens()) {
String tok=tokenTO3.nextToken()+"";
if(tok.equals("⊙")){
if((n==4||n==6||n==7)&&u>0){
jxl.write.Number number = new jxl.write.Number(0+n,2+u,0.00,wcfN);
ws.addCell(number);
}else{
labelC =new jxl.write.Label(0+n, 2+u," ",wcsB);
ws.addCell(labelC);}
}else{
if((n==4||n==6||n==7)&&u>0){
tok=tok.replace(",","");
jxl.write.Number number = new jxl.write.Number(0+n,2+u,Double.valueOf(tok),wcfN);
ws.addCell(number);
}else{
labelC =new jxl.write.Label(0+n, 2+u,tok,wcsB);
ws.addCell(labelC);
}
}
n++;
}
}
labelC =new jxl.write.Label(0,u+2,"物料总成本：");
ws.addCell(labelC);
labelC =new jxl.write.Label(1,u+2,cost_price_sum);
ws.addCell(labelC);
labelC =new jxl.write.Label(0,u+3,"设计人  ：");
ws.addCell(labelC);
labelC =new jxl.write.Label(1,u+3,designer);
ws.addCell(labelC);
labelC =new jxl.write.Label(2,u+3,"审核人  ：");
ws.addCell(labelC);
labelC =new jxl.write.Label(3,u+3,checker);
ws.addCell(labelC);
labelC =new jxl.write.Label(0,u+4,"审核时间：");
ws.addCell(labelC);
labelC =new jxl.write.Label(1,u+4,check_time);
ws.addCell(labelC);
labelC =new jxl.write.Label(2,u+4,"登记时间：");
ws.addCell(labelC);
labelC =new jxl.write.Label(3,u+4,register_time);
ws.addCell(labelC);
labelC =new jxl.write.Label(0,u+5,"设计要求：");
ws.addCell(labelC);
labelC =new jxl.write.Label(1,u+5,module_describe);
ws.addCell(labelC);
WritableCellFormat wff_merge = new WritableCellFormat();
wff_merge.setAlignment(jxl.format.Alignment.CENTRE);
wff_merge.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE); 
jxl.write.Label label30 = new Label(0,0,"物料组成设计单",wff_merge);   
ws.addCell(label30);
//合并单元格
ws.mergeCells(0,0,7,0); 
wwb.write();
wwb.close();
}catch (Exception ex){
ex.printStackTrace();}
%>