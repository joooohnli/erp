<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db funddb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%
try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from fund_config_workflow where type_id='03'";
ResultSet rs=fund_db.executeQuery(sql);
if(rs.next()){
	workflow_amount=rs.getInt("count(id)");
}
String fund_chain_ID="";
String sql3="select * from fund_config_fund_kind where responsible_person_ID like '%"+register_ID+"%'";
ResultSet rs3=fund_db.executeQuery(sql3);
while(rs3.next()){
	fund_chain_ID+=rs3.getString("file_ID")+",";
}
int k=0;
String[] fund_ID_group1=new String[10000];
	sql = "select * from fund_fund where check_tag='1' and fund_tag!='1' and reason='付款' and fund_execute_tag='1' order by register_time" ;
	rs = funddb.executeQuery(sql) ;
	while(rs.next()){
		String sql4="select * from fund_details where fund_ID='"+rs.getString("fund_ID")+"'";
		ResultSet rs4 = fund_db.executeQuery(sql4) ;
		while(rs4.next()){
			if(rs4.getString("execute_check_tag").equals("1")&&!rs4.getString("execute_details_tag").equals("2")){
				fund_ID_group1[k]=rs4.getString("fund_ID");
				k++;
			}
		}
	}
	String fund_ID_group="";
int p=0;
if(k!=0){
for(int i=0;i<k-1;i++){
	if(fund_ID_group.indexOf(fund_ID_group1[i])== -1){
		fund_ID_group+=fund_ID_group1[i]+",";
		p++;
	}
}
	if(fund_ID_group.indexOf(fund_ID_group1[k-1])== -1){
		fund_ID_group+=fund_ID_group1[k-1];
		p++;
	}
}
int i;
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
String[] fund_ID=new String[p+1];
p=1;
StringTokenizer tokenTO = new StringTokenizer(fund_ID_group,","); 
	while(tokenTO.hasMoreTokens()) {
 fund_ID[p] = tokenTO.nextToken();
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
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","")%>'},
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
nseer_grid.auto='<%=demo.getLang("erp","付款人")%>';
nseer_grid.data = [
<%	
intPageCount = (intRowCount+intPageSize-1) / intPageSize;
if(intPage>intPageCount) intPage = intPageCount;
if(intPageCount>0){
i = (intPage-1) * intPageSize +1;
int j=intPage*intPageSize+1;
while(i<j&&i<=intRowCount){
	String sql6="select * from fund_fund where fund_ID='"+fund_ID[i]+"'";
	ResultSet rs6=fund_db.executeQuery(sql6);
	if(rs6.next()){
	String sql1="select id from fund_workflow where object_ID='"+fund_ID[i]+"' and check_tag='0' and pay_time='"+rs6.getString("pay_time")+"'";
ResultSet rs2=funddb.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from fund_workflow where object_ID='"+fund_ID[i]+"' and pay_time='"+rs6.getString("pay_time")+"' order by id";
	rs2=funddb.executeQuery(sql1);
%> 
['<%=rs6.getString("fund_ID")%>'
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
,'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("check.jsp?fund_ID=<%=rs6.getString("fund_ID")%>&config_id=<%=rs2.getString("config_id")%>&pay_time=<%=rs6.getString("pay_time")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%
}
	}
i++;
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
funddb.close(); 
fund_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>