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
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="available" class="stock.getBalanceAmount" scope="request"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/ecommerce/ecommerce_contact.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");
String tablename="ecommerce_contact";
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
String realname=(String)session.getAttribute("realeditorc");
String queue="order by register_time desc";
String validationXml="../../../xml/ecommerce/ecommerce_contact.xml";
String nickName="联络";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的联络总数");
int k=1;
String condition="check_tag not in ('2','5','9') and gar_tag='0'";
String condition2="check_tag='0' and gar_tag='0'";
String condition3="check_tag='1' and gar_tag='0'";
%>
<%@include file="../../../include/search_a.jsp"%>
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
condition="check_tag not in ('2','5','9') and gar_tag='0'";
%>
<%@include file="../../../include/search_b.jsp"%>
<%
ResultSet rs = ecommerce_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","机构")%>'},
                       {name: '<%=demo.getLang("erp","电话")%>'},
                       {name: '<%=demo.getLang("erp","EMAIL")%>'},
					   {name: '<%=demo.getLang("erp","查看")%>'},
					   {name: '<%=demo.getLang("erp","审核状态")%>'}
]
nseer_grid.column_width=[40,200,100,200,60,60];
nseer_grid.auto='<%=demo.getLang("erp","机构")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String status="";
if(rs.getString("check_tag").equals("0")){
			status="未审核";
			}else if(rs.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs.getString("check_tag").equals("9")){
			status="未通过";
			}
%>
  ['<%if(rs.getString("check_tag").equals("1")){%><input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>" style="height:10"><%}%>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<%=exchange.toHtml(rs.getString("tel"))%>','<%=exchange.toHtml(rs.getString("email"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?id=<%=rs.getString("id")%>")><%=demo.getLang("erp","查看")%></div>','<%=status%>'],
<%k++;%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/search_bottom.jsp"%>
<%@include file="../../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%
ecommerce_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>