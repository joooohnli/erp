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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="xml" class="include.nseer_cookie.ReadXmlLength" scope="page"/>
<script language=javascript src="../../javascript/winopen/winopen.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
try{
MaxKind max=new MaxKind((String)session.getAttribute("unit_db_name"),"hr_config_file_kind","file_id");//得表中字段的最长字符串
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");//得erp所在路径
path=path+"xml\\hr\\config\\file\\tree-config.xml";//传入xml读取步长.
int first_length=Integer.parseInt(xml.read(path,"table","first-length"));//一级机构步长
int step_length=Integer.parseInt(xml.read(path,"table","step-length"));//除一级机构以外的步长
int kind_rows=KindDeep.getDeep(max.maxValue("file_id"),first_length,step_length);//设置机构列数
max.close();//关闭数据库
String message_ID=request.getParameter("message_ID");
String checker_ID=(String)session.getAttribute("human_IDD");
String checker=(String)session.getAttribute("realeditorc");
String human_name=request.getParameter("human_name");
String human_ID=request.getParameter("human_ID");
String choose_value=request.getParameter("choose_value");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
%>
<FORM METHOD="POST" id="keyRegister" name="selectList" ACTION="../../oa_message_check_ok">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%String sql1 = "select * from oa_config_public_char where kind='群发工具分类' order by type_ID";
 ResultSet rs1 = db.executeQuery(sql1) ;
while(rs1.next()){if(!rs1.getString("type_name").equals("QQ")&&!rs1.getString("type_name").equals("msn")){%><INPUT name="check_type" type="checkbox" value="<%=exchange.toHtml(rs1.getString("type_name"))%>" nseer=""><%=exchange.toHtml(rs1.getString("type_name"))%>&nbsp;<%}}%><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","全选")%>" name="check" onClick=selAl(this.form)>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div>
</td>
</tr>
</table>
<%
String first_kind="";
String second_kind="";
String third_kind="";
int n=0;
String sql="select * from hr_file where check_tag='1' order by chain_id,human_id";
ResultSet rs=db.executeQuery(sql);	
%>
<div id="send_msg_checkbox"><!-- 设置全选的层 -->
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
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
String sq1="select * from  hr_config_file_kind where PARENT_CATEGORY_ID!='-1' order by file_id";
rs=db.executeQuery(sq1);
int row_tag=0;
while(rs.next()){
String file_id=rs.getString("file_id").trim();
int len=KindDeep.getDeep(file_id,first_length,step_length);//判断长度,判断属于几级机构.

String sq11="select * from  hr_file where chain_id='"+rs.getString("file_id")+"' and check_tag='1' order by chain_id";
rs1=db1.executeQuery(sq11);

String chain_name_temp=rs.getString("chain_name");
String chain_name_temp1=rs.getString("chain_name");

if(chain_name_temp.indexOf("-")!=-1)chain_name_temp=chain_name_temp.substring(chain_name_temp.lastIndexOf("-")+1,chain_name_temp.length());//显示字符串处理如uu-oo-opp,则处理为opp.
%>
[
<%
String cont="'<div><input type=\"checkbox\"  nseer="+rs.getString("file_id")+"  onclick=\"select_value(this)\">"+chain_name_temp+"</div>',"; //必须自定义nseer属性,供选择连动时使用.如nseer="+rs.getString("file_id")+"
for(int i=0;i<len;i++){/*用空字符串填补空列.*/
if(i<len-1&&row_tag==0){%>
'<%=chain_name_temp1.split("-")[i]%>',
<%}else if(i!=len-1){%>'',<%}else{%><%=cont%>
<%
}}
for(int j=0;j<kind_rows-len;j++){/*用空字符串填补空列.*/%>'',<%}
List major_data = (List)new java.util.ArrayList();
while(rs1.next()){
major_data.add(rs1.getString("chain_id")+"◎"+rs1.getString("human_major_first_kind_name")+"◎"+rs1.getString("human_major_second_kind_name")+"◎"+rs1.getString("human_id")+"◎"+rs1.getString("human_name"));
}
%>'<%for(Iterator it = major_data.iterator();it.hasNext();){String name=(String) it.next();	String name0=name.split("◎")[0];	String name1=name.split("◎")[1];String name2=name.split("◎")[2];String name3=name.split("◎")[3];	String name4=name.split("◎")[4];if(name0.equals(rs.getString("file_id"))){%><div style="padding:5px 0px 0px 0px">&nbsp;<%=name1%></div><%}}%>','<%for(Iterator it = major_data.iterator();it.hasNext();){String name=(String) it.next();	String name0=name.split("◎")[0];	String name1=name.split("◎")[1];String name2=name.split("◎")[2];String name3=name.split("◎")[3];	String name4=name.split("◎")[4];if(name0.equals(rs.getString("file_id"))){%><div style="padding:5px 0px 0px 0px">&nbsp;<%=name2%></div><%}}%>',
'<%for(Iterator it = major_data.iterator();it.hasNext();){String name=(String) it.next();	String name0=name.split("◎")[0];	String name1=name.split("◎")[1];String name2=name.split("◎")[2];String name3=name.split("◎")[3];	String name4=name.split("◎")[4];if(name0.equals(rs.getString("file_id"))){%><div><A HREF="javascript:winopen(\'../../hr/file/query.jsp?human_ID=<%=name3%>\')"><input type="checkbox" nseer="<%=name0%>1" name=\"chain_id\" value="<%=name3%>/<%=exchange.toHtml(name4)%>/<%=exchange.toHtml(name1)%>/<%=exchange.toHtml(name2)%>" >&nbsp;<%=name3%>/<%=exchange.toHtml(name4)%></A></div><%}}%>'],<%row_tag++;}%>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<input type="hidden" name="choose_value" value="<%=exchange.toHtml(choose_value)%>">
<input type="hidden" name="human_ID" value="<%=human_ID%>">
<input type="hidden" name="human_name" value="<%=exchange.toHtml(human_name)%>">
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
<input type="hidden" name="message_ID" value="<%=message_ID%>">
<input type="hidden" name="cols_number" value="<%=n%>">
<input type="hidden" name="checker" value="<%=exchange.toHtml(checker)%>">
<input type="hidden" name="checker_ID" value="<%=checker_ID%>">
<input type="hidden" name="check_time" value="<%=exchange.toHtml(time)%>">

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
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%}catch(Exception ex){ex.printStackTrace();}%>