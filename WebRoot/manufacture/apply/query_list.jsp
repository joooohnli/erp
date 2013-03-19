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
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/manufacture/manufacture_apply.xml"/>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/manufacture/apply/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/Multi.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<% 
try{
String tablename="manufacture_apply";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String realname=(String)session.getAttribute("realeditorc");
String condition="(check_tag='0' or check_tag='1') and excel_tag='2' and gar_tag='0'";
String queue="group by apply_ID order by apply_ID desc";
String validationXml="../../xml/manufacture/manufacture_apply.xml";
String nickName="生产计划";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的生产计划总数：");
int k=1;
String apply_ID="";
%>
<%@include file="../../include/search.jsp"%>
<%
ResultSet rs = manufacture_db.executeQuery(sql_search) ;
String sql_temp=sql_search.substring(0,sql_search.indexOf("limit"));
intRowCount = query.count((String)session.getAttribute("unit_db_name"),sql_temp.replace("*","distinct apply_ID"));
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
String apply_id_control="";
int maxPage=(intRowCount+pageSize-1)/pageSize;
strPage=strPage.split("⊙")[0]+"⊙"+maxPage;
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div" align="center"></div>
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
                       {name: '<%=demo.getLang("erp","生产计划编号")%>'},
                       {name: '<%=demo.getLang("erp","计划制定人")%>'},
                       {name: '<%=demo.getLang("erp","登记人")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
	                   {name: '<%=demo.getLang("erp","备注")%>'},
	                   {name: '<%=demo.getLang("erp","计划单状态")%>'}
]
nseer_grid.column_width=[40,160,70,70,160,70,70];
nseer_grid.auto='<%=demo.getLang("erp","备注")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
if(apply_id_control.indexOf(rs.getString("apply_id"))==-1){
apply_id_control+=rs.getString("apply_id");
String check_tag="1";
String manufacture_tag="";
String color="#FF9A31";
if(rs.getString("check_tag").equals("0")){
manufacture_tag="等待";
}else if(rs.getString("check_tag").equals("9")){
manufacture_tag="未通过";
color="#FF0000";
}else if(rs.getString("check_tag").equals("1")){
manufacture_tag="通过";
check_tag="0";
color="3333FF";
}
%>
['<%if(manufacture_tag.equals("通过")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("apply_ID")%>⊙<%=check_tag%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?apply_ID=<%=rs.getString("apply_ID")%>")><%=rs.getString("apply_ID")%></div>',' <span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("designer"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("register"))%></span>','<span style="color:<%=color%>"><%=exchange.toHtml(rs.getString("register_time"))%></span>','<span style="color:<%=color%>" ><%=rs.getString("remark")%></span>','<span style="color:<%=color%>" ><%=manufacture_tag%></span>'],
	<%k++;
}%>
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