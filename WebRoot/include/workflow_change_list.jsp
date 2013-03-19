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
<%@ page import="include.anti_repeat_submit.Globals"%>

<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="xml" class="include.nseer_cookie.ReadXmlLength" scope="page"/>
<%
try{
String workflow_url_temp="";
String workflow_file_url=request.getRequestURI();
for(int i=0;i<workflow_file_url.split("/").length-3;i++){
	workflow_url_temp+="../";
}
%>
<script type="text/javascript" src="<%=workflow_url_temp%>javascript/ajax/niceforms.js"></script>
<script type="text/javascript" src="<%=workflow_url_temp%>javascript/include/nseergrid/nseergrid.js"></script>
<script type="text/javascript" src="<%=workflow_url_temp%>javascript/include/search/ajaxDiv.js"></script>
<link rel="stylesheet" type="text/css" href="<%=workflow_url_temp%>css/include/nseergrid/nseergrid_workflow.css" />

<script language=javascript src="<%=workflow_url_temp%>javascript/winopen/winopen.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
MaxKind max=new MaxKind((String)session.getAttribute("unit_db_name"),"hr_config_file_kind","file_id");//得表中字段的最长字符串
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");//得erp所在路径
path=path+"xml\\hr\\config\\file\\tree-config.xml";//传入xml读取步长.
int first_length=Integer.parseInt(xml.read(path,"table","first-length"));//一级机构步长
int step_length=Integer.parseInt(xml.read(path,"table","step-length"));//除一级机构以外的步长
String maxLength=max.maxValue("file_id");
if(!maxLength.equals("0")){
int kind_rows=KindDeep.getDeep(maxLength,first_length,step_length);//设置机构列数
max.close();//关闭数据库
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db2 = new nseer_db((String)session.getAttribute("unit_db_name"));

String fileKind_chain=request.getParameter("fileKind_chain");
String fileKind_chain_id="";
String fileKind_chain_name="";
StringTokenizer token=new StringTokenizer(fileKind_chain," ");
while(token.hasMoreTokens()){
				fileKind_chain_id=token.nextToken();
				fileKind_chain_name=token.nextToken();
}
String id=request.getParameter("id");

String type_id=request.getParameter("type_id");
String human_major_first_kind_name=request.getParameter("select4");
String human_major_second_kind_name="";
if(human_major_first_kind_name==null) human_major_first_kind_name="";

String select5=request.getParameter("select5");
if(select5!=null&&!select5.equals("")){
	StringTokenizer tokenTO3 = new StringTokenizer(select5,"/"); 
 while(tokenTO3.hasMoreTokens()) {
  human_major_first_kind_name = tokenTO3.nextToken();
				human_major_second_kind_name = tokenTO3.nextToken();
		}
}
%>
<form method="post" id="keyRegister" name="selectList" action="<%=servlet_file%>">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全选")%>" name="check" onClick=selAl(this.form)>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1">&nbsp<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="<%=locate_file%>?type_id=<%=type_id%>&id=<%=id%>"></div>
</td>
</tr>
</table>
<input type="hidden" name="type_id" value="<%=type_id%>">
<input type="hidden" name="id" value="<%=id%>">
<div id="send_msg_checkbox"><!-- 设置全选的层 -->
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.imgPath = '<%=workflow_url_temp%>';
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       <%
for(int i=1;i<=kind_rows;i++){%>
  {name: '<%=i%><%=demo.getLang("erp","级机构")%>'},
<%}
%>    
	  {name: '<%=demo.getLang("erp","职位分类")%>'},
	  {name: '<%=demo.getLang("erp","职位")%>'},
      {name: '<%=demo.getLang("erp","人员")%>'}
]
nseer_grid.column_width=[<%
for(int i=1;i<=kind_rows;i++){%>90,<%}
%>70,70,190];
nseer_grid.auto='<%=demo.getLang("erp","人员")%>';
nseer_grid.data = [
<%
int n=0;
String condition="";
if(human_major_first_kind_name.equals("")&&human_major_second_kind_name.equals("")){
	condition="check_tag='1'";
}else if(!human_major_first_kind_name.equals("")&&human_major_second_kind_name.equals("")){
	condition="human_major_first_kind_name='"+human_major_first_kind_name+"' and check_tag='1'";
}else if(human_major_first_kind_name.equals("")&&!human_major_second_kind_name.equals("")){
	condition="human_major_second_kind_name='"+human_major_second_kind_name+"' and check_tag='1'";
}else if(!human_major_first_kind_name.equals("")&&!human_major_second_kind_name.equals("")){
	condition="human_major_first_kind_name='"+human_major_first_kind_name+"' and human_major_second_kind_name='"+human_major_second_kind_name+"' and check_tag='1'";
}
String sq1="select * from  hr_config_file_kind where file_id like '"+fileKind_chain_id+"%' and PARENT_CATEGORY_ID!='-1' order by file_id";
ResultSet rs=db.executeQuery(sq1);
String sql2="select describe1 from "+workflow_table+" where id='"+id+"'";
ResultSet rs2=db2.executeQuery(sql2);
if(rs2.next()){
int row_tag=0;
while(rs.next()){
String file_id=rs.getString("file_id").trim();
int len=KindDeep.getDeep(file_id,first_length,step_length);//判断长度,判断属于几级机构.
String sq11="select * from  hr_file where chain_id='"+rs.getString("file_id")+"' and "+condition+" order by chain_id";
ResultSet rs1=db1.executeQuery(sq11);
String chain_name_temp=rs.getString("chain_name");
String chain_name_temp1=rs.getString("chain_name");
if(chain_name_temp.indexOf("-")!=-1)chain_name_temp=chain_name_temp.substring(chain_name_temp.lastIndexOf("-")+1,chain_name_temp.length());//显示字符串处理如uu-oo-opp,则处理为opp.
%>
[
<%
List major_data = (List)new java.util.ArrayList();
String cont1="";
while(rs1.next()){
major_data.add(rs1.getString("chain_id")+"◎"+rs1.getString("human_major_first_kind_name")+"◎"+rs1.getString("human_major_second_kind_name")+"◎"+rs1.getString("human_id")+"◎"+rs1.getString("human_name"));
if(rs2.getString("describe1").indexOf(rs1.getString("human_ID"))!=-1)cont1="checked";
}

String cont="'<div><input type=\"checkbox\"  nseer="+rs.getString("file_id")+"  onclick=\"select_value(this)\"  "+cont1+">"+chain_name_temp+"</div>',";
//必须自定义nseer属性,供选择连动时使用.如nseer="+rs.getString("file_id")+"
for(int i=0;i<len;i++){/*用空字符串填补空列.*/
if(!fileKind_chain_id.equals("")&&i<len-1&&row_tag==0){%>
'<%=chain_name_temp1.split("-")[i]%>',
<%}else if(i!=len-1){%>'',<%}else{%><%=cont%>
<%
}}
for(int j=0;j<kind_rows-len;j++){/*用空字符串填补空列.*/%>'',<%}

%>'<%for(Iterator it = major_data.iterator();it.hasNext();){String name=(String) it.next();	String name0=name.split("◎")[0];	String name1=name.split("◎")[1];String name2=name.split("◎")[2];String name3=name.split("◎")[3];	String name4=name.split("◎")[4];if(name0.equals(rs.getString("file_id"))){%><div style="height:20px;padding:5px 0px 0px 0px">&nbsp;<%=name1%></div><%}}%>','<%for(Iterator it = major_data.iterator();it.hasNext();){String name=(String) it.next();	String name0=name.split("◎")[0];	String name1=name.split("◎")[1];String name2=name.split("◎")[2];String name3=name.split("◎")[3];	String name4=name.split("◎")[4];if(name0.equals(rs.getString("file_id"))){%><div style="height:20px;padding:5px 0px 0px">&nbsp;<%=name2%></div><%}}%>',
'<%for(Iterator it = major_data.iterator();it.hasNext();){String name=(String) it.next();	String name0=name.split("◎")[0];	String name1=name.split("◎")[1];String name2=name.split("◎")[2];String name3=name.split("◎")[3];	String name4=name.split("◎")[4];if(name0.equals(rs.getString("file_id"))){%><div><A HREF="javascript:winopen(\'<%=workflow_url_temp%>hr/file/query.jsp?human_ID=<%=name3%>\')"><input type="checkbox" nseer="<%=name0%>1" name=\"chain_id\" value="<%=name3%>/<%=exchange.toHtml(name4)%>" <%if(rs2.getString("describe1").indexOf(name3)!=-1){%>checked<%}%>>&nbsp;<%=name3%>/<%=exchange.toHtml(name4)%></A></div><%}}%>'],<%row_tag++;}}%>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" 
 value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<script>
function select_value(s){
var file_id=s.getAttribute('nseer').split('/')[0];
var value_length=file_id.length;
if(s.checked){
var checkbox_array=document.getElementsByTagName('input');
for(var i=0;i<checkbox_array.length;i++){
if(checkbox_array[i].type=='checkbox'&&checkbox_array[i].getAttribute('nseer').substring(0,value_length)==file_id&&checkbox_array[i].getAttribute('nseer').length>value_length){
checkbox_array[i].checked=true;
}
}
}else{
var checkbox_array=document.getElementsByTagName('input');
for(var i=0;i<checkbox_array.length;i++){
if(checkbox_array[i].type=='checkbox'&&checkbox_array[i].getAttribute('nseer').substring(0,value_length)==file_id&&checkbox_array[i].getAttribute('nseer').length>value_length){
checkbox_array[i].checked=false;
}
}
}
}
function selAl(){
var checkbox_array=document.getElementById('send_msg_checkbox').getElementsByTagName('input');
if(document.getElementById('check').value=='反选'){
for(var i=0;i<checkbox_array.length;i++){
if(checkbox_array[i].type=='checkbox'){
checkbox_array[i].checked=false;
}
}
document.getElementById('check').value='全选';
}else{
for(var i=0;i<checkbox_array.length;i++){
if(checkbox_array[i].type=='checkbox'){
checkbox_array[i].checked=true;
}
}
document.getElementById('check').value='反选';
}
}
</script>
<%
db.close();
db1.close();
db2.close();
}else{
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
</table>
<TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE1%> class="TD_STYLE8"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="history.back();" value="<%=demo.getLang("erp","返回")%>"></div></td>
</tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","机构未设置，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"></td>
 </tr>
 </table>
 </div>
<%}
}catch(Exception ex){ex.printStackTrace();}
%>