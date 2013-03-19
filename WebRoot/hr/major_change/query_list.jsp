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
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_major_change.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
	 String tablename="hr_major_change";
%> 
<script src="../../javascript/table/movetable.js"></script>
<script type='text/javascript' src="../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/qcs/config/publics/dealwith.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
  </table>
<%

String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag!='5' and gar_tag='0'";
String queue="order by register_time";
String validationXml="../../xml/hr/hr_major_change.xml";
String nickName="人力资源档案";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的调动总数");
%>
<%@include file="../../include/search.jsp"%>
<% 
try{
ResultSet rs=hr_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
int k=1;
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(human_ID,check_time1,check_time2){
var check_time=check_time1+' '+check_time2;
var link1='query.jsp?human_ID='+human_ID+'&&time='+check_time;
document.location.href=link1;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","档案编号")%>'},
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","新机构")%>'},
					   {name: '<%=demo.getLang("erp","新职位分类")%>'},
					   {name: '<%=demo.getLang("erp","新职位名称")%>'},
					   {name: '<%=demo.getLang("erp","审核状态")%>'}
]
nseer_grid.column_width=[40,200,200,200,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","姓名")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
 <%	
String check_tag="";
String execute_tag="";
String fund_pre_tag="";
String color="#FF9A31";
if(rs.getString("check_tag").equals("9")){
check_tag="未通过";
color="red";
}else if(rs.getString("check_tag").equals("0")){
check_tag="等待";
}else if(rs.getString("check_tag").equals("1")){
check_tag="通过";
color="3333FF";
}
%>
  ['<%if(rs.getString("check_tag").equals("1")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link1("<%=rs.getString("human_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("check_time").substring(0,rs.getString("check_time").indexOf(" "))))%>","<%=toUtf8String.utf8String(exchange.toURL(rs.getString("check_time").substring(rs.getString("check_time").indexOf(" ")+1)))%>")><%=rs.getString("human_ID")%></div>','<%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("new_chain_name"))%>','<%=exchange.toHtml(rs.getString("new_human_major_first_kind_name"))%>','<%=exchange.toHtml(rs.getString("new_human_major_second_kind_name"))%>','<%=check_tag%>'],
  <%k++;%>
  </page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
hr_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>