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
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db ecommerce_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="available" class="stock.getBalanceAmount" scope="request"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/ecommerce/ecommerce_link.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
String tablename="ecommerce_link";
%>
<script language="javascript" src="../../../javascript/winopen/winopen.js"></script>
<script type='text/javascript' src="../../../javascript/include/nseerTree/nseerReadTableXml.js"></script>
<script type="text/javascript" src="../../../javascript/include/draft_gar/query_list.js"></script>
<script type='text/javascript' src='../../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../../javascript/qcs/config/publics/dealwith.js"></script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <%
 try{
String register_ID=(String)session.getAttribute("human_IDD");
int workflow_amount=0;
String sql="select count(id) from ecommerce_config_workflow where type_id='10'";
ResultSet rs3=ecommerce_db.executeQuery(sql);
if(rs3.next()){
	workflow_amount=rs3.getInt("count(id)");
}
String realname=(String)session.getAttribute("realeditorc");
String queue="order by register_time desc";
String validationXml="../../../xml/ecommerce/ecommerce_link.xml";
String nickName="链接";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的链接总数");
int k=1;
String condition="check_tag!='2' and gar_tag='0'";
String condition1="check_tag='9' and gar_tag='0'";
String condition2="check_tag='0' and gar_tag='0'";
String condition3="check_tag='1' and gar_tag='0'";
%>
<%@include file="../../../include/search_a.jsp"%>
<%
condition=condition1;
%>
<%@include file="../../../include/search_bn.jsp"%>
<%
int intRowCount1 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition2;
%>
<%@include file="../../../include/search_bn.jsp"%>
<%
int intRowCount2 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition3;
%>
<%@include file="../../../include/search_bn.jsp"%>
<%
int intRowCount3 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition="check_tag!='2' and gar_tag='0'";
%>
<%@include file="../../../include/search_b.jsp"%>
<%
ResultSet rs = ecommerce_db1.executeQuery(sql_search) ;
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar("showGarDiv1",tablename,request);
%>
<%@include file="../../../include/search_top.jsp"%>
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
                       {name: '<%=demo.getLang("erp","链接编号")%>'},
                       {name: '<%=demo.getLang("erp","链接名称")%>'},
                       {name: '<%=demo.getLang("erp","链接地址")%>'},
                       {name: '<%=demo.getLang("erp","链接图片")%>'},
					
<%
for(int i=1;i<=workflow_amount;i++){
		String title="流程"+i;
%>
					   {name: '<%=demo.getLang("erp",title)%>'},

	<%
}

%> 
                           {name: '<%=demo.getLang("erp","审核状态")%>'}
]
nseer_grid.column_width=[50,150,100,150,100,<%for(int i=1;i<workflow_amount;i++){%>70,<%}%>70];
nseer_grid.auto='<%=demo.getLang("erp","链接名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String sql1="select * from ecommerce_workflow where object_ID='"+rs.getString("link_ID")+"'";
ResultSet rs2=ecommerce_db.executeQuery(sql1);
String url=rs.getString("url");
if(url.indexOf("http://")==-1) url="http://"+rs.getString("url");
%>
  ['<%if(rs.getString("check_tag").equals("1")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>" style="height:10"><%}%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?link_ID=<%=rs.getString("link_ID")%>")><%=rs.getString("link_ID")%></div>','<%=exchange.toHtml(rs.getString("topic"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("<%=url%>")><%=exchange.toHtml(rs.getString("url"))%></div>',
<%
if(rs.getString("attachment1").equals("")){	
%>
	'',<%}else{%>'<img src="../../file_attachments/<%=rs.getString("attachment1")%>" width="50" height="50" hspace="1">',
	<%
}
for(int i=1;i<=workflow_amount;i++){
	if(rs2.next()){
%>'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("query_details.jsp?link_ID=<%=rs.getString("link_ID")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","查看")%></div>',<%}else{%>'',
	<%}}
	String status="";
if(rs.getString("check_tag").equals("0")){
			status="未审核";
			}else if(rs.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs.getString("check_tag").equals("9")){
			status="未通过";
			}
	k++;
%>'<%=status%>'	
	],

</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
ecommerce_db.close();	
ecommerce_db1.close();
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../../include/head_msg.jsp"%> 