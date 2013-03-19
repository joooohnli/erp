<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db qcsdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
try{
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<script type='text/javascript' src='../../../dwr/engine.js'></script>
<script type='text/javascript' src='../../../dwr/util.js'></script>
<script type='text/javascript' src='../../../dwr/interface/multiLangValidate.js'></script>
<script type="text/javascript" src="../../../javascript/include/div/divViewChange.js"></script>
<script type="text/javascript" src="../../../javascript/include/div/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/qcs/config/publics/publics.js"></script>
<script type="text/javascript" src="../../../javascript/qcs/config/publics/dealwith.js"></script>

<body>
<form method="post" action="strategyClass_delete_getPara.jsp">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>

<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" id="select_all" value="<%=demo.getLang("erp","全选")%>" name="check" onclick="selAll()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","启用")%>" onClick="registerOk()"></div></td>
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
                       {name: '<%=demo.getLang("erp","质检处理设置")%>'},
                       {name: '<%=demo.getLang("erp","处理方式")%>'}
                  ] 
nseer_grid.column_width=[200,100];
nseer_grid.auto='<%=demo.getLang("erp","处理方式")%>';
nseer_grid.data = [


<%
	String checked="";
 String sql = "select type_id,type_name from qcs_config_public_char where kind_id ='15' order by type_id";
 ResultSet rs = qcs_db.executeQuery(sql) ;
 int t=0;
 while(rs.next()){
 String sql1="select id,type_name,used_tag from qcs_config_public_char where kind_id='07' and describe1='"+rs.getString("type_id")+"' order by type_id";
 ResultSet rs1=qcsdb.executeQuery(sql1);
 int n=0;
 while(rs1.next()){
	 if(rs1.getString("used_tag").equals("1")){checked="checked";}else if(rs1.getString("used_tag").equals("0")){checked="";}
	 if(n==0){
  %>
	['<INPUT onclick="selAllDet(this.id)" type="button" class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全选")%>" id="P<%=rs.getString("type_id")%>">&nbsp;<%=exchange.toHtml(rs.getString("type_name"))%>','<INPUT value="<%=rs1.getString("id")%>" type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="T<%=rs.getString("type_id")%>" nseer="<%=t%>" <%=checked%>>&nbsp;<%=exchange.toHtml(rs1.getString("type_name"))%>'],
 <%
	 }else{
 %>
['','<INPUT value="<%=rs1.getString("id")%>" type="checkbox" <%=CHECKBOX_STYLE1%> class="CHECKBOX_STYLE1" name="T<%=rs.getString("type_id")%>" nseer="<%=t%>" <%=checked%>>&nbsp;<%=exchange.toHtml(rs1.getString("type_name"))%>'],
<%}
n++;}t++;}
%>
 


['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>
<%
	qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
} 
%>
 </form> 