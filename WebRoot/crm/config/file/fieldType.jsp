<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *这个文件是恩信科技ERP软件的组成部分。
 *版权所有（C）2006-2010 北京恩信创业科技有限公司/http://www.nseer.com
 *
 *这一程序是自由软件，你可以遵照自由软件基金会出版的GNU通用公共许可
 *证条款来修改和重新发布这一程序。或者用许可证的第二版，或者（根据你的选
 *择）用任何更新的版本。
 *
 *发布这一程序的目的是希望它有用，但没有任何担保。甚至没有适合特定目
 *的的隐含的担保。更详细的情况请参阅GNU通用公共许可证。
 *你应该已经和程序一起收到一份GNU通用公共许可证的副本。如果还没有，
 *写信给：
 *The Free Software Foundation, Inc., 675 Mass Ave, Cambridge,
 *MA02139, USA
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<form method="post" action="fieldType_delete_getPara.jsp">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3">
<div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","添加")%>" onClick=location="fieldType_register.jsp">&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","删除")%>"></div></td>
</tr>
</table>
<% 
 String sql = "select * from crm_config_public_char where kind='客户类型' order by type_ID";
  String sql_search=sql;
%>
 <!-- ************************************************************************************************************** -->
<%@include file="../../../include/list_page.jsp"%>
 <!-- ************************************************************************************************************** -->
 <%
ResultSet rs = crm_db.executeQuery(sql_search) ;
int k=1;
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
                       {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","客户类型")%>'}
                  ]
nseer_grid.column_width=[40,180];
nseer_grid.auto='<%=demo.getLang("erp","客户类型")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
	[
<%if(!rs.getString("type_name").equals("合作伙伴")){%>	
'<input type="checkbox" name="<%=k%>" value="<%=rs.getString("id")%>" style="height:10">'
<%}else{%>
''
<%}%>
,'<%=exchange.toHtml(rs.getString("type_name"))%>'],
<%
k++;
%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>
<%crm_db.close();%>
 </form>
<page:updowntag num="<%=intRowCount%>" file="fieldType.jsp"/>
