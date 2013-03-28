<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_pay.xml"/>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql1="select count(id) from stock_config_workflow where type_id='06'";
ResultSet rs2=stock_db.executeQuery(sql1);
if(rs2.next()){
	workflow_amount=rs2.getInt("count(id)");
}
String stock_ID="";
String sql3="select * from stock_config_public_char where describe1='库房' and responsible_person_ID like '%"+register_ID+"%'";
ResultSet rs3=stock_db.executeQuery(sql3);
while(rs3.next()){
	stock_ID+=rs3.getString("stock_ID")+",";
}
int k=0;
String[] pay_ID_group1=new String[10000];
	String sql = "select * from stock_pay where pay_pre_tag='1' and pay_tag!='2' order by register_time" ;
	ResultSet rs = stockdb.executeQuery(sql) ;
	while(rs.next()){
		String sql4="select * from stock_pre_paying where pay_ID='"+rs.getString("pay_ID")+"'";
		
		ResultSet rs4 = stock_db.executeQuery(sql4) ;
		while(rs4.next()){
			if(rs4.getString("pay_check_tag").equals("1")&&rs4.getString("pay_tag").equals("0")){
				pay_ID_group1[k]=rs4.getString("pay_ID");
				k++;
			}
		}
	}
	String pay_ID_group="";
int p=0;
if(k!=0){

for(int i=0;i<k-1;i++){
	if(pay_ID_group.indexOf(pay_ID_group1[i])== -1){
		pay_ID_group+=pay_ID_group1[i]+",";
		p++;
	}
}
	if(pay_ID_group.indexOf(pay_ID_group1[k-1])== -1){
		pay_ID_group+=pay_ID_group1[k-1];
		p++;
	}
}
int m;
int intPageSize; 
int intRowCount; 
int intPageCount; 
int intPage; 
intPageSize = 20;
String strPage = request.getParameter("page");
if(strPage==null||strPage.equals("")){
intPage = 1;
}
else{
intPage = Integer.parseInt(strPage);
if(intPage<1) intPage = 1;
}
intRowCount = p;
String[] pay_ID=new String[p+1];
p=1;
StringTokenizer tokenTO = new StringTokenizer(pay_ID_group,","); 
	while(tokenTO.hasMoreTokens()) {
 pay_ID[p] = tokenTO.nextToken();
		p++;
		}

if(intRowCount!=0){
	session.setAttribute("task_content","none");
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%>  class="TD_STYLE3"><%=demo.getLang("erp","等待审核：")%><%=intRowCount%><%=demo.getLang("erp","例")%></td>
 </tr>
 </table>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","出库单编号")%>'},                    
<%
for(int ii=1;ii<workflow_amount;ii++){
		String title="流程"+ii;
%>
					   {name: '<%=demo.getLang("erp",title)%>'},
<%
}
	String title="流程"+workflow_amount;
%> 
                           {name: '<%=demo.getLang("erp",title)%>'}
]
nseer_grid.column_width=[180,
<%
for(int ii=1;ii<workflow_amount;ii++){
%>					   70,
<%
}
%> 
                           70
	];
nseer_grid.auto='<%=demo.getLang("erp","出库单编号")%>';
nseer_grid.data = [
<%	
intPageCount = (intRowCount+intPageSize-1) / intPageSize;
if(intPage>intPageCount) intPage = intPageCount;
if(intPageCount>0){
m = (intPage-1) * intPageSize +1;
int j=intPage*intPageSize+1;
while(m<j&&m<=intRowCount){
	String sql6="select * from stock_pay where pay_ID='"+pay_ID[m]+"'";
	ResultSet rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
		sql1="select id from stock_workflow where object_ID='"+pay_ID[m]+"' and check_tag='0' and paying_time='"+rs6.getString("paying_time")+"'";
		rs2=stockdb.executeQuery(sql1);
		if(rs2.next()){
			sql1="select check_tag,describe1,config_id from stock_workflow where object_ID='"+pay_ID[m]+"' and paying_time='"+rs6.getString("paying_time")+"' order by id";
			rs2=stockdb.executeQuery(sql1);
%>

['<%=rs6.getString("pay_ID")%>'
<%
for(int q=1;q<=workflow_amount;q++){
	String status="";
	if(rs2.next()){
			if(rs2.getString("check_tag").equals("0")){
			status="无权限";
			}else if(rs2.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs2.getString("check_tag").equals("9")){
			status="未通过";
			}
			if(rs2.getString("check_tag").equals("0")&&rs2.getString("describe1").indexOf(register_ID)!=-1){
%>
,'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("check.jsp?pay_ID=<%=rs6.getString("pay_ID")%>&config_id=<%=rs2.getString("config_id")%>&paying_time=<%=rs6.getString("paying_time")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%
}
	}
m++;
}
}
if(intPageCount==0){
intPage=1;
intPageCount=1;
}
%>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%	
}else{
	%>
<table valign="center">
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td><%session.removeAttribute("task_content");%></td>
</tr>
</table>
<%
	}
stockdb.close();
stock_db.close();
%>