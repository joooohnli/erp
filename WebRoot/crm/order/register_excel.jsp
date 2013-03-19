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

String customer_name=request.getParameter("customer_name");

String customer_ID=request.getParameter("customer_ID");
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel");
String demand_pay_time=request.getParameter("demand_pay_time");
String hr_first_kind_name=request.getParameter("hr_first_kind_name");
String hr_second_kind_name=request.getParameter("hr_second_kind_name");
String hr_third_kind_name=request.getParameter("hr_third_kind_name");
String sales_name=request.getParameter("sales_name");
String sale_price_sum=request.getParameter("sale_price_sum");
String attachment_name1=request.getParameter("attachment_name1");
String accomplish_time=request.getParameter("accomplish_time");
String type=request.getParameter("type");
String remark=request.getParameter("remark");

ServletContext context=session.getServletContext();
String path=context.getRealPath("/");

java.util.Date now = new java.util.Date();
long pdftime=now.getTime();
String filename="MyFirstTable"+pdftime+".xls";

session.setAttribute("excelname",filename);


File f=new File(path+"excel_files\\"+filename);

jxl.write.WritableWorkbook wwb=Workbook.createWorkbook(new FileOutputStream(f));

jxl.write.WritableSheet ws =wwb.createSheet("销售订单",0);

jxl.write.Label labelC =new jxl.write.Label(0,2,"客户名称：");
ws.addCell(labelC);
labelC =new jxl.write.Label(1,2,customer_name);
ws.addCell(labelC);

labelC =new jxl.write.Label(2,2,"客户编号：");
ws.addCell(labelC);

labelC =new jxl.write.Label(3,2,customer_ID);
ws.addCell(labelC);

labelC =new jxl.write.Label(0,3,"电话    ：");
ws.addCell(labelC);

labelC =new jxl.write.Label(1,3,demand_contact_person_tel);
ws.addCell(labelC);

labelC =new jxl.write.Label(2,3,"提货时间：");
ws.addCell(labelC);

labelC =new jxl.write.Label(3,3,demand_pay_time);
ws.addCell(labelC);

labelC =new jxl.write.Label(0,4,"I级机构 ：");
ws.addCell(labelC);

labelC =new jxl.write.Label(1,4,hr_first_kind_name);
ws.addCell(labelC);

labelC =new jxl.write.Label(2,4,"II级机构：");
ws.addCell(labelC);

labelC =new jxl.write.Label(3,4,hr_second_kind_name);
ws.addCell(labelC);

labelC =new jxl.write.Label(0,5,"III级机构：");
ws.addCell(labelC);

labelC =new jxl.write.Label(1,5,hr_third_kind_name);
ws.addCell(labelC);

labelC =new jxl.write.Label(2,5,"销售人  ：");
ws.addCell(labelC);

labelC =new jxl.write.Label(3,5,sales_name);
ws.addCell(labelC);


/*
labelC =new jxl.write.Label(1,2,"我爱中国1,2");
ws.addCell(labelC);
*/

jxl.write.WritableCellFormat wcsB = new jxl.write.WritableCellFormat(); 
wcsB.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THICK);

jxl.write.NumberFormat nf = new jxl.write.NumberFormat((String)application.getAttribute("nseerPrecision")); 
jxl.write.WritableCellFormat wcfN = new jxl.write.WritableCellFormat(nf);
wcfN.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THICK);

all_column="商品编号<$$>商品名称<$$>描述<$$>数量<$$>单位<$$>单价（元）<$$>小计（元）<$$>折扣（%）■"+all_column;

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

if((n==3||n==5||n==6||n==7)&&u>0){

jxl.write.Number number = new jxl.write.Number(0+n,6+u,0.00,wcfN);
 //put the number 3.14159 in cell D5
ws.addCell(number);

}else{

labelC =new jxl.write.Label(0+n, 6+u," ",wcsB);
ws.addCell(labelC);}
}else{

if((n==3||n==5||n==6||n==7)&&u>0){

tok=tok.replace(",","");

jxl.write.Number number = new jxl.write.Number(0+n,6+u,Double.valueOf(tok),wcfN);
 //put the number 3.14159 in cell D5
ws.addCell(number);

}else{

labelC =new jxl.write.Label(0+n, 6+u,tok,wcsB);
ws.addCell(labelC);

}

}
n++;
}
}

labelC =new jxl.write.Label(0,u+6,"总计    ：");
ws.addCell(labelC);

labelC =new jxl.write.Label(1,u+6,sale_price_sum);
ws.addCell(labelC);

labelC =new jxl.write.Label(2,u+6,"订单附件：");
ws.addCell(labelC);

labelC =new jxl.write.Label(3,u+6,attachment_name1);
ws.addCell(labelC);

labelC =new jxl.write.Label(0,u+7,"完成时间：");
ws.addCell(labelC);

labelC =new jxl.write.Label(1,u+7,accomplish_time);
ws.addCell(labelC);

labelC =new jxl.write.Label(2,u+7,"客户类型：");
ws.addCell(labelC);

labelC =new jxl.write.Label(3,u+7,type);
ws.addCell(labelC);

labelC =new jxl.write.Label(0,u+8,"备注    ：");
ws.addCell(labelC);

labelC =new jxl.write.Label(1,u+8,remark);
ws.addCell(labelC);

WritableCellFormat wff_merge = new WritableCellFormat();

wff_merge.setAlignment(jxl.format.Alignment.CENTRE);

wff_merge.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE); 

jxl.write.Label label30 = new Label(0,0,"销售订单",wff_merge);   
ws.addCell(label30);

//合并单元格
ws.mergeCells(0,0,7,0); 

wwb.write();

wwb.close();
}catch (Exception e){
e.getMessage();}
%>