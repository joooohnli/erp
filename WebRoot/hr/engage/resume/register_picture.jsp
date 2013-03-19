<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%counter count=new counter(application);%>
<%nseer_db_backup hr_db = new nseer_db_backup(application);%>
<%
String major_first_kind_ID="";
String major_first_kind_name="";
String major_second_kind_ID="";
String major_second_kind_name="";
String major_first_kind=request.getParameter("select4");
StringTokenizer tokenTO4 = new StringTokenizer(major_first_kind,"/"); 
	while(tokenTO4.hasMoreTokens()) {
 major_first_kind_ID = tokenTO4.nextToken();
		major_first_kind_name = tokenTO4.nextToken();
		}
String major_second_kind=request.getParameter("select5");
StringTokenizer tokenTO5 = new StringTokenizer(major_second_kind,"/"); 
	while(tokenTO5.hasMoreTokens()) {
 major_second_kind_ID = tokenTO5.nextToken();
		major_second_kind_name = tokenTO5.nextToken();
		}
String human_name=request.getParameter("human_name") ;
String human_address=request.getParameter("human_address") ;
String demand_salary_standard1=request.getParameter("demand_salary_standard");
String demand_salary_standard="";
if(!demand_salary_standard1.equals("")){
StringTokenizer tokenTO6 = new StringTokenizer(demand_salary_standard1,",");
	while(tokenTO6.hasMoreTokens()) {
 demand_salary_standard+=tokenTO6.nextToken();
		}
}else{
demand_salary_standard="0.0";
}
String human_tel=request.getParameter("human_tel") ;
String human_home_tel=request.getParameter("human_home_tel") ;
String human_postcode=request.getParameter("human_postcode") ;
String human_cellphone=request.getParameter("human_cellphone") ;
String idcard=request.getParameter("idcard") ;
String college=request.getParameter("college") ;
String religion=request.getParameter("religion") ;
String party=request.getParameter("party") ;
String race=request.getParameter("race") ;
String nationality=request.getParameter("nationality") ;
String age=request.getParameter("age") ;
String engage_type=request.getParameter("engage_type") ;
String sex=request.getParameter("sex") ;
String speciality=request.getParameter("speciality") ;
String hobby=request.getParameter("hobby") ;
String birthday=request.getParameter("birthday") ;
String birthplace=request.getParameter("birthplace") ;
String human_email=request.getParameter("human_email") ;
String educated_degree=request.getParameter("educated_degree") ;
String educated_years=request.getParameter("educated_years") ;
String educated_major=request.getParameter("educated_major") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("history_records").getBytes("UTF-8"),"UTF-8");
String history_records=exchange.toHtml(bodya);
if(hr_db.conn((String)session.getAttribute("unit_db_name"))){
	String time1="";
java.util.Date now1 = new java.util.Date();
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd");
time1=formatter1.format(now1);
String details_number = NseerId.getId("hr/engage/resume",(String)session.getAttribute("unit_db_name"));
	String sql = "insert into hr_resume(details_number,human_major_first_kind_ID,human_major_first_kind_name,human_major_second_kind_ID,human_major_second_kind_name,human_name,human_address,human_tel,human_home_tel,human_postcode,demand_salary_standard,educated_degree,educated_years,educated_major,register_time,history_records,remark,human_cellphone,idcard,college,religion,race,nationality,party,age,birthday,birthplace,sex,speciality,hobby,human_email,engage_type) values ('"+details_number+"','"+major_first_kind_ID+"','"+major_first_kind_name+"','"+major_second_kind_ID+"','"+major_second_kind_name+"','"+human_name+"','"+human_address+"','"+human_tel+"','"+human_home_tel+"','"+human_postcode+"','"+demand_salary_standard+"','"+educated_degree+"','"+educated_years+"','"+educated_major+"','"+register_time+"','"+history_records+"','"+remark+"','"+human_cellphone+"','"+idcard+"','"+college+"','"+religion+"','"+race+"','"+nationality+"','"+party+"','"+age+"','"+birthday+"','"+birthplace+"','"+sex+"','"+speciality+"','"+hobby+"','"+human_email+"','"+engage_type+"')" ;
	hr_db.executeUpdate(sql) ;
	hr_db.close();
	response.sendRedirect("register_choose_picture.jsp?details_number="+details_number+"");
%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form method="post" action="../../../hr_engage_resume_register_ok?details_number=<%=details_number%>" ENCTYPE="multipart/form-data">
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3">
	 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","上传")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","上传附件")%>" onClick=location="register_choose_attachment.jsp?details_number=<%=details_number%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","完成")%>" onClick=location="register.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","请上传照片")%><input type="file" <%=FILE_STYLE1%> class="FILE_STYLE1" <%=FILE_STYLE1%> class="FILE_STYLE1" name="file1" width="100%"></td>
 </tr>
 </table>
 </div>
</form>
<%}else{%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register.jsp"></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 </tr>
 </table>
 </div>
<%}%>