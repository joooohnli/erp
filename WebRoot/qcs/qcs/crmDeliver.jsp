<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8">&nbsp;</td>
</tr>
</table>
<%
try{
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db qcsdb = new nseer_db((String)session.getAttribute("unit_db_name"));
String register_ID=(String)session.getAttribute("human_IDD");
String stock_ID="";
String sql3="select stock_ID from stock_config_public_char where describe1='库房'";
ResultSet rs3=qcs_db.executeQuery(sql3);
while(rs3.next()){
	stock_ID+=rs3.getString("stock_ID")+",";
}
String pay_id_group="";
int k=0;
	String sql = "select distinct pay_ID from stock_pay where pay_pre_tag='1' and pay_tag!='2' and qcs_apply_tag='0' order by register_time" ;
	ResultSet rs = qcsdb.executeQuery(sql);
	while(rs.next()){
		String sql4="select stock_id,pay_check_tag,pay_tag,pay_ID,count(distinct pay_ID) from stock_pre_paying where pay_ID='"+rs.getString("pay_ID")+"' group by pay_ID";
		ResultSet rs4 = qcs_db.executeQuery(sql4);
		while(rs4.next()){
			if(stock_ID.indexOf(rs4.getString("stock_ID"))!= -1&&rs4.getString("pay_check_tag").equals("0")&&rs4.getString("pay_tag").equals("0")){
				pay_id_group+=","+rs4.getString("pay_ID");
				k++;
			}
		}
	}
if(pay_id_group.indexOf(",")!=-1){pay_id_group=pay_id_group.substring(1);}
String[] pay_ID=pay_id_group.split(",");
int i;
int intPageSize; 
int intRowCount; 
int intPageCount; 
int intPage; 
intPageSize = 20;
String strPage = request.getParameter("page");
if(strPage==null||strPage.equals("")){
intPage = 1;
}else{
intPage = Integer.parseInt(strPage);
if(intPage<1) intPage = 1;
}
intRowCount = k;
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
                       {name: '<%=demo.getLang("erp","出库单编号")%>'},
                       {name: '<%=demo.getLang("erp","出库理由")%>'},
                       {name: '<%=demo.getLang("erp","应出库总件数")%>'},
                       {name: '<%=demo.getLang("erp","登记人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
	                   {name: '<%=demo.getLang("erp","质检调度")%>'}
]
nseer_grid.column_width=[180,200,200,100,180,70];
nseer_grid.auto='<%=demo.getLang("erp","出库理由")%>';
nseer_grid.data = [
<%	
intPageCount = (intRowCount+intPageSize-1) / intPageSize;
if(intPage>intPageCount) intPage = intPageCount;
if(intPageCount>0){
//rs.absolute((intPage-1) * intPageSize +1);
i = (intPage-1) * intPageSize +1;
int j=intPage*intPageSize+1;
while(i<j&&i<=intRowCount){
	String sql6="select * from stock_pay where pay_ID='"+pay_ID[i-1]+"' and qcs_apply_tag='0'";
	ResultSet rs6=qcs_db.executeQuery(sql6);
	if(rs6.next()){
%>
<%
 String register_time="";
if(rs6.getString("register_time")==null)
 {register_time="";}
 else{
register_time=rs6.getString("register_time");
}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../../stock/pay/query.jsp?pay_ID=<%=rs6.getString("pay_id")%>")><%=rs6.getString("pay_id")%></div>','<%=rs6.getString("reason")%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("demand_amount"))%>','<%=exchange.toHtml(rs6.getString("register"))%>','<%=exchange.toHtml(rs6.getString("register_time"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("crmDeliver_register.jsp?pay_id=<%=rs6.getString("pay_id")%>")><%=demo.getLang("erp","质检调度")%></div>'],
<%
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
/*************************************************************/
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/head_msg.jsp"%>
<div style="position:absolute;bottom:0px;left:8px;">
<form id=form1 action="crmDeliver.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <%=demo.getLang("erp","总数：")%><%=intRowCount%><%=demo.getLang("erp","例")%>&nbsp;&nbsp;&nbsp; <%if(intPage>1){%><a href="crmDeliver.jsp?page=<%=intPage-1%>"><%=demo.getLang("erp","上页")%></a>&nbsp;&nbsp;&nbsp;<%}%>  
 <%=demo.getLang("erp","当前第")%><%=intPage%><%=demo.getLang("erp","页")%>&nbsp;&nbsp;&nbsp; <%if(intPage<intPageCount){%><a href="crmDeliver.jsp?page=<%=intPage+1%>"><%=demo.getLang("erp","下页")%></a>&nbsp;&nbsp;&nbsp;<%}%> <%=demo.getLang("erp","共")%><%=intPageCount%><%=demo.getLang("erp","页")%>&nbsp;&nbsp;<%=demo.getLang("erp","跳到第")%> <input name=page type="text" size=1> <%=demo.getLang("erp","页")%>&nbsp;&nbsp; 
<input type="image" src="../../images/go.bmp" width=18 border=0 /></td> 
 </tr> 
 </table>
 </form>
 </div>
<%	
qcs_db.close();
qcsdb.close();
}catch(Exception ex){ex.printStackTrace();}
%>