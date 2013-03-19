/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */

package qcs.qcs;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import include.nseer_db.*;
import include.nseer_cookie.*;

import java.io.*;
import java.util.*;

import com.jspsmart.upload.*;


import include.nseer_cookie.counter;

public class other_register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
//实例化

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
counter count=new counter(dbApplication);
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	mySmartUpload.initialize(pageContext);
	String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
	long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
	mySmartUpload.setMaxFileSize(d);
	mySmartUpload.setAllowedFilesList(file_type);
try{
	mySmartUpload.upload();
	String[] file_name=new String[mySmartUpload.getFiles().getCount()];
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	String time=formatter.format(now);
	String apply_id=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

	for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
		com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
		if (file.isMissing()){
			file_name[i]="";
			continue;
		}
		int filenum1=count.read((String)dbSession.getAttribute("unit_db_name"),"qcsAttachmentcount");
		count.write((String)dbSession.getAttribute("unit_db_name"),"qcsAttachmentcount",filenum1);
		file_name[i]=filenum1+file.getFileName();
		file.saveAs(path+"qcs/file_attachments/" + filenum1+file.getFileName());
	}
String product_id = mySmartUpload.getRequest().getParameter("product_id");
String product_name = mySmartUpload.getRequest().getParameter("product_name");
String demand_amount = mySmartUpload.getRequest().getParameter("demand_amount");
String amount_unit = mySmartUpload.getRequest().getParameter("amount_unit");
String stock_name = mySmartUpload.getRequest().getParameter("stock_name");
String register = mySmartUpload.getRequest().getParameter("register");
String register_id = mySmartUpload.getRequest().getParameter("register_id");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String bodya = new String(mySmartUpload.getRequest().getParameter("other_reason").getBytes("UTF-8"),"UTF-8");
String other_reason=exchange.toHtml(bodya);
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
String sqla = "insert into qcs_apply(apply_id,remark,register,register_id,register_time,reason) values ('"+apply_id+"','"+remark+"','"+register+"','"+register_id+"','"+register_time+"','8')" ;
qcs_db.executeUpdate(sqla);	

sqla = "insert into qcs_apply_details(apply_id,stock_name,product_id,product_name,amount_unit,demand_amount,other_reason,reason,attachment1,label) values ('"+apply_id+"','"+stock_name+"','"+product_id+"','"+product_name+"','"+amount_unit+"','"+demand_amount+"','"+other_reason+"','8','"+file_name[0]+"','01')" ;
qcs_db.executeUpdate(sqla);

response.sendRedirect("qcs/qcs/other_register_ok.jsp?finished_tag=0");
qcs_db.commit();
qcs_db.close();
}catch(Exception ex){
ex.printStackTrace();
response.sendRedirect("qcs/qcs/other_register_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
ex.printStackTrace();
}
}
}
