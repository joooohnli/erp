<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" errorPage="/error.htm" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="query" scope="page" class="include.excel_export.excel_three"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
 <jsp:useBean id="query1" scope="page" class="include.query.getRecordCount"/>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"></td>
 </tr>
 </table>
<script language=javascript>
function MouseDownToResize(obj){
obj.mouseDownX=event.clientX;
obj.pareneTdW=obj.parentElement.offsetWidth;
obj.pareneTableW=theObjTable.offsetWidth;
obj.setCapture();
}
function MouseMoveToResize(obj){
    if(!obj.mouseDownX) return false;
    var newWidth=obj.pareneTdW*1+event.clientX*1-obj.mouseDownX;
    if(newWidth>0)
    {
obj.parentElement.style.width = newWidth;
theObjTable.style.width=obj.pareneTableW*1+event.clientX*1-obj.mouseDownX;
}
}
function MouseUpToResize(obj){
obj.releaseCapture();
obj.mouseDownX=0;
}
</script>
<%
try{
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String voucher_in_month_ID=(String)session.getAttribute("voucher_in_month_ID");
String keyword=(String)session.getAttribute("keyword");
String dbase=(String)session.getAttribute("unit_db_name");
String tablename="finance_voucher";
String fieldName1="register_time";
String fieldName2="voucher_in_month_ID";
String[] fieldName3={"voucher_in_month_id","debit_sum","loan_sum","attachment_amount","register_time","check_time","checker","register"};
String queue="order by register_time desc";
String condition1="check_tag='0' and account_period<'16'";
String condition2="check_tag='1' and account_period<'16'";
String condition3="check_tag='9' and account_period<'16'";
String sql=query.query(dbase,tablename,timea,timeb,voucher_in_month_ID,keyword,fieldName1,fieldName2,fieldName3,condition1,queue);
int a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
sql="select distinct voucher_in_month_id,attachment_amount,debit_sum,loan_sum,register,register_time,check_tag from finance_voucher "+sql;
int intRowCount1=query1.count((String)session.getAttribute("unit_db_name"),sql);

sql=query.query(dbase,tablename,timea,timeb,voucher_in_month_ID,keyword,fieldName1,fieldName2,fieldName3,condition2,queue);
a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
sql="select distinct voucher_in_month_id,attachment_amount,debit_sum,loan_sum,register,register_time,check_tag from finance_voucher "+sql;
int intRowCount2=query1.count((String)session.getAttribute("unit_db_name"),sql);

sql=query.query(dbase,tablename,timea,timeb,voucher_in_month_ID,keyword,fieldName1,fieldName2,fieldName3,condition3,queue);
a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
sql="select distinct voucher_in_month_id,attachment_amount,debit_sum,loan_sum,register,register_time,check_tag from finance_voucher "+sql;
int intRowCount3=query1.count((String)session.getAttribute("unit_db_name"),sql);

String condition="check_tag!='3' and account_period<'16'";
sql=query.query(dbase,tablename,timea,timeb,voucher_in_month_ID,keyword,fieldName1,fieldName2,fieldName3,condition,queue);
a=sql.indexOf("where");
sql=sql.substring(a,sql.length());
sql="select distinct voucher_in_month_id,attachment_amount,debit_sum,loan_sum,register,register_time,check_tag from finance_voucher "+sql;
int intRowCount=query1.count((String)session.getAttribute("unit_db_name"),sql);
ResultSet rs1=finance_db.executeQuery(sql);

int pageSize=25;
String pageSize_temp=request.getParameter("pageSize");
if(pageSize_temp!=null&&!pageSize_temp.equals("")){pageSize=Integer.parseInt(pageSize_temp);}
pageContext.setAttribute("pageSize",new Integer(pageSize).toString());
String strPage = request.getParameter("page");
int maxPage=(intRowCount+pageSize-1)/pageSize;
if(strPage==null||strPage!=null&&(strPage.equals("")||!validata.validata(strPage))){
	strPage="1";
}else if(Integer.parseInt(strPage)<=0){
	strPage="1";
}else if(maxPage>0&&Integer.parseInt(strPage)>maxPage){
	strPage=maxPage+"";
}
strPage=strPage+"⊙"+maxPage;
%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","凭证号")%>'},
                       {name: '<%=demo.getLang("erp","附件数量")%>'},
                       {name: '<%=demo.getLang("erp","借方金额")%>'},
                       {name: '<%=demo.getLang("erp","贷方金额")%>'},
                       {name: '<%=demo.getLang("erp","制单")%>'},
                       {name: '<%=demo.getLang("erp","时间")%>'},
                       {name: '<%=demo.getLang("erp","审核状态")%>'},
					   {name: '&nbsp;'}
                  ]
nseer_grid.column_width=[70,70,180,180,70,180,70,70];
nseer_grid.auto='<%=demo.getLang("erp","时间")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%	
String voucher_tag="";
String color="#FF9A31";
if(rs1.getString("check_tag").equals("0")){
voucher_tag="等待";
}else if(rs1.getString("check_tag").equals("1")){
voucher_tag="通过";
color="#3333FF";
}else if(rs1.getString("check_tag").equals("9")){
voucher_tag="未通过";
color="red";
}
%>
	['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?voucher_in_month_id=<%=rs1.getString("voucher_in_month_id")%>&&register_time=<%=rs1.getString("register_time")%>")><span style="color:<%=color%>"><%=rs1.getString("voucher_in_month_ID")%></span></div>','<span style="color:<%=color%>"><%=rs1.getString("attachment_amount")%></span>','<span style="color:<%=color%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("debit_sum"))%></span>','<span style="color:<%=color%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("loan_sum"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("register"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("register_time"))%></span>','<span style="color:<%=color%>"><%=voucher_tag%></span>',
<%
if(rs1.getString("check_tag").equals("9")){
%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("change.jsp?voucher_in_month_id=<%=rs1.getString("voucher_in_month_id")%>&&register_time=<%=rs1.getString("register_time")%>")><span style="color:<%=color%>"><%=demo.getLang("erp","重新登记")%></span></div>'
<%}else{%>
	''
<%}%>
	],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<page:updowntag num="<%=intRowCount%>" file="query_list.jsp"/>
<%@include file="../../../include/head_msg.jsp"%>
<%
finance_db.close();

}catch(Exception tt){tt.printStackTrace();}%>