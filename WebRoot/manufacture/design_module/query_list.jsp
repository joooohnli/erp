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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/garbage/manufacture/design_module/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_design_procedure.xml"/>
<% 
try{
String tablename="manufacture_design_procedure";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='1' and excel_tag='2' and module_gar_tag='0' and gar_tag='0' and design_module_tag!='4'";
String queue="order by register_time desc";
String validationXml="../../xml/manufacture/manufacture_design_procedure.xml";
String nickName="产品工序设计";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的设计单总数：");
int k=1;
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs1 = manufacture_db.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '&nbsp;'},
					   {name: '<%=demo.getLang("erp","设计单编号")%>'},
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
                       {name: '<%=demo.getLang("erp","设计单状态")%>'},
	                   {name: '<%=demo.getLang("erp","审核状态")%>'}
]
nseer_grid.column_width=[50,160,180,200,90,90];
nseer_grid.auto='<%=demo.getLang("erp","产品名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%	
String check_tag="";
String design_tag="";
String color="#FF9A31";
if((rs1.getString("design_module_tag").equals("1")&&rs1.getString("design_module_change_tag").equals("0"))||rs1.getString("design_module_tag").equals("9")||rs1.getString("design_module_tag").equals("0")){
design_tag="等待";
}else if((rs1.getString("design_module_tag").equals("1")||rs1.getString("design_module_tag").equals("3"))&&rs1.getString("design_module_change_tag").equals("1")){
design_tag="执行";
color="mediumseagreen";
}else if(rs1.getString("design_module_tag").equals("2")){
design_tag="完成";
color="3333FF";
}
if(rs1.getString("design_module_tag").equals("1")||rs1.getString("design_module_tag").equals("0")){
check_tag="等待";
}else if(rs1.getString("design_module_tag").equals("2")){
check_tag="通过";
}else if(rs1.getString("design_module_tag").equals("9")){
check_tag="未通过";
}
%>
	['<%if(design_tag.equals("完成")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs1.getString("design_ID")%>⊙0" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?design_ID=<%=rs1.getString("design_ID")%>")><%=rs1.getString("design_ID")%></div>',' <span style="color:<%=color%>" ><%=rs1.getString("product_ID")%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs1.getString("product_name"))%></span>','<span style="color:<%=color%>"><%=design_tag%></span>','<span style="color:<%=color%>" ><%=check_tag%></span>'],
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
manufacture_db.close();	
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>