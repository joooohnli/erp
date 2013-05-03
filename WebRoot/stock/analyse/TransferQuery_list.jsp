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
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="getFourAmount" scope="page" class="include.query.query_three"/>
<jsp:useBean id="FileKind" scope="page" class="include.nseer_cookie.FileKind"/>

<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_paying_gathering.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
  <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
try{
String tablename="stock_paying_gathering_transfer";
String realname=(String)session.getAttribute("realeditorc");
String condition="product_ID!='' and check_tag='1'";
String queue="order by product_ID";
String validationXml="../../xml/stock/stock_paying_gathering.xml";
String nickName="";
String fileName="payingGatheringQuery_list.jsp";
String rowSummary="";
String queue1="order by register_time";
String condition1="demand_amount!='0'";
String dbase=(String)session.getAttribute("unit_db_name");
String fieldName1="register_time";
String fieldName2="pay_ID";
String fieldName4="product_ID,product_name";
String[] fieldName3=column.Column(dbase,tablename);
String timea="";
String timeb="";
%>
<%@include file="../../include/search.jsp"%>
 <% 
try{

sql_search=sql_search.replace("*","distinct product_ID,product_name");
intRowCount=query.count((String)session.getAttribute("unit_db_name"),sql_search.substring(0,sql_search.indexOf("limit")));
int maxPage=(intRowCount+pageSize-1)/pageSize;
strPage=strPage.substring(0,strPage.indexOf("⊙"))+"⊙"+maxPage;
ResultSet rs1 = stock_db.executeQuery(sql_search) ;
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
function id_link1(product_ID,product_name,timea,keyword){

var link1='payingGatheringQuery_getpara.jsp?product_ID='+product_ID+'&&product_name='+product_name+'&&timea='+timea+'&&keyword='+keyword;
document.location.href=link1;

}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","产品编号")%>'},
                       {name: '<%=demo.getLang("erp","产品名称")%>'},
					   {name: '<%=demo.getLang("erp","产品分类")%>'},
                       {name: '<%=demo.getLang("erp","期初库存")%>'},
	                   {name: '<%=demo.getLang("erp","入库小计")%>'},
                       {name: '<%=demo.getLang("erp","出库小计")%>'},
	                   {name: '<%=demo.getLang("erp","期末库存")%>'}
]
nseer_grid.column_width=[180,200,180,100,70,70,100];
nseer_grid.auto='<%=demo.getLang("erp","产品分类")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>"> 
<%
	 String[] aaa=FileKind.getKind((String)session.getAttribute("unit_db_name"),"design_file","product_ID",rs1.getString("product_ID"));
 ResultSet rs2=getFourAmount.queryDB(dbase,tablename,"","",rs1.getString("product_ID"),"",fieldName1,"product_ID",fieldName3,condition1,queue1);
if(rs2.first()){
double original_amount=rs2.getDouble("balance_amount");
if(rs2.getString("paying_or_gathering").equals("入库")){
original_amount=original_amount-rs2.getDouble("amount");
}else{
original_amount=original_amount+rs2.getDouble("amount");
}
	double gathering_amount=getFourAmount.sumTotal("amount","入库",1);
	double paying_amount=getFourAmount.sumTotal("amount","出库",0);
	double final_amount=original_amount+gathering_amount-paying_amount;
 %>

['<div style="text-decoration : underline;color:#3366FF" onclick=id_link1("<%=rs1.getString("product_ID")%>","<%=toUtf8String.utf8String(exchange.toURL(rs1.getString("product_name")))%>","<%=toUtf8String.utf8String(exchange.toURL(timea))%>","<%=toUtf8String.utf8String(exchange.toURL(timeb))%>","<%=toUtf8String.utf8String(exchange.toURL(keyword))%>")><%=rs1.getString("product_ID")%></div>','<%=exchange.toHtml(rs1.getString("product_name"))%>','<%=aaa[1]%>','<%=original_amount%>','<%=gathering_amount%>','<%=paying_amount%>','<%=final_amount%>'],
<%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
stock_db.close();
}catch(Exception ex){ex.printStackTrace();}
}catch(Exception ex){ex.printStackTrace();}
%>