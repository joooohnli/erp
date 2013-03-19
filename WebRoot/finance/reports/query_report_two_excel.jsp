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
String company=request.getParameter("company");
String time=request.getParameter("time");
String money=request.getParameter("money");
////////////////////////////////////////////////////////////////////////////////////
if(company.indexOf("编制单位：")!=-1){company=company.substring(company.indexOf("编制单位：")+("编制单位：").length());}
if(time.indexOf("时间：")!=-1){time=time.substring(time.indexOf("时间：")+("时间：").length());}
if(money.indexOf("单位：")!=-1){money=money.substring(money.indexOf("单位：")+("单位：").length());}
////////////////////////////////////////////////////////////////////////////////////
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
java.util.Date now = new java.util.Date();
long pdftime=now.getTime();
String filename="MyFirstTable"+pdftime+".xls";
session.setAttribute("excelname",filename);
File f=new File(path+"excel_files/"+filename);
jxl.write.WritableWorkbook wwb=Workbook.createWorkbook(new FileOutputStream(f));
jxl.write.WritableSheet ws =wwb.createSheet("损益表",0);
jxl.write.Label labelC =new jxl.write.Label(0,1,"编制单位：");
ws.addCell(labelC);
labelC =new jxl.write.Label(1,1,company);
ws.addCell(labelC);
labelC =new jxl.write.Label(2,1,"时间：");
ws.addCell(labelC);
labelC =new jxl.write.Label(3,1,time);
ws.addCell(labelC);
labelC =new jxl.write.Label(4,1,"单位：");
ws.addCell(labelC);
labelC =new jxl.write.Label(5,1,money);
ws.addCell(labelC);
jxl.write.WritableCellFormat wcsB = new jxl.write.WritableCellFormat(); 
wcsB.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THICK);
jxl.write.NumberFormat nf = new jxl.write.NumberFormat((String)application.getAttribute("nseerPrecision")); 
jxl.write.WritableCellFormat wcfN = new jxl.write.WritableCellFormat(nf);
wcfN.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THICK);
all_column="项目<$$>行次<$$>本月数<$$>本年累计数■"+all_column;
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
if((n==2||n==3)&&u>0){
jxl.write.Number number = new jxl.write.Number(0+n,2+u,0.00,wcfN);
ws.addCell(number);
}else{
labelC =new jxl.write.Label(0+n, 2+u," ",wcsB);
ws.addCell(labelC);}
}else{
if((n==2||n==3)&&u>0){
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
WritableCellFormat wff_merge = new WritableCellFormat();
wff_merge.setAlignment(jxl.format.Alignment.CENTRE);
wff_merge.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE); 
jxl.write.Label label30 = new Label(0,0,"损益表",wff_merge);   
ws.addCell(label30);
ws.mergeCells(0,0,3,0); 
wwb.write();
wwb.close();
}catch (Exception ex){
ex.printStackTrace();}
%>