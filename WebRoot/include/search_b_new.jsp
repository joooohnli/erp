<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="filetree.*"%>
<%
try{
File f=new File(path_s+xmlFile_s);
if(f.exists()){
if(reader.getAttributeByAttribute("sql","url:"+url_s).size()!=0){
	flag_search=true;
sql_xml=(String)(reader.getAttributeByAttribute("sql","url:"+url_s).get(0));
strPage_xml=(String)(reader.getAttributeByAttribute("pageno","url:"+url_s).get(0));
}
strPage=request.getParameter("page");
keyword=request.getParameter(inputTextId2);
String searchTag1=request.getParameter(searchTag);
if(keyword==null){keyword="";}else{search_init++;}
if(!flag_search&&readXml==null||readXml!=null&&readXml.equals("n")||search_init!=0){
if(searchTag1==null){
sql_search=NseerSql.getRegularSql((String)session.getAttribute("unit_db_name"),tablename,keyword,condition,queue);
}else if(searchTag1.equals("1")){//高级搜索
	String[] str_select=request.getParameterValues("str_select");
	String[] str_input=new String[str_select.length];
	String[] time_select=request.getParameterValues("time_select");
	String[] time_inputa=new String[time_select.length];
	String[] time_inputb=new String[time_select.length];
	String[] num_select=request.getParameterValues("num_select");
	String[] num_inputa=new String[num_select.length];
	String[] num_inputb=new String[num_select.length];
	for(int i=0;i<str_select.length;i++){
		if(!str_select[i].equals("")){
			str_input[i]=request.getParameter(str_select[i]);
		}else{
			str_input[i]="";
		}
	}
	for(int i=0;i<time_select.length;i++){
		if(!time_select[i].equals("")){
		time_inputa[i]=request.getParameter(time_select[i]+"a");
		time_inputb[i]=request.getParameter(time_select[i]+"b");
		}else{
		time_inputa[i]="";
		time_inputb[i]="";
		}
	}
	for(int i=0;i<num_select.length;i++){
		if(!num_select[i].equals("")){
		num_inputa[i]=request.getParameter(num_select[i]+"a");
		num_inputb[i]=request.getParameter(num_select[i]+"b");
		}else{
		num_inputa[i]="";
		num_inputb[i]="";
		}
	}
	sql_search=NseerSql.getAdvanceSql((String)session.getAttribute("unit_db_name"),tablename,condition,queue,str_select,str_input,time_select,time_inputa,time_inputb,num_select,num_inputa,num_inputb);
}
}else if(flag_search&&readXml==null&&strPage==null){
	sql_search=sql_xml;
	strPage=strPage_xml;
}else if(flag_search&&readXml==null&&strPage!=null){
	sql_search=sql_xml;
}else{
	sql_search=sql_xml;
	strPage=strPage_xml;
}
nseer_db db=new nseer_db((String)session.getAttribute("unit_db_name"));
String sql_search1=sql_search.replace("*","id");
ResultSet rs_search=db.executeQuery(sql_search1);
if(rs_search.next()){
rs_search.last();
intRowCount=rs_search.getRow();
}
int maxPage=(intRowCount+pageSize-1)/pageSize;
if(strPage==null||strPage!=null&&strPage.equals("")&&!validata.validata(strPage)){
	strPage="1";
}else if(Integer.parseInt(strPage)<=0){
	strPage="1";
}else if(maxPage>0&&Integer.parseInt(strPage)>maxPage){
	strPage=maxPage+"";
}
if(reader.getAttributeByAttribute("sql","url:"+url_s).size()==0){
Inserting ins_xml=new Inserting();
String[] col_ele={"url","sql","pageno"};
String[] col_value={url_s,sql_search,strPage};
String[] v_value={};
ins_xml.addColXML(path_s+xmlFile_s,col_ele,col_value,v_value);
}else{
Updating update_xml=new Updating();
update_xml.editXML(path_s+xmlFile_s,"url",url_s,"sql",sql_search);
update_xml.editXML(path_s+xmlFile_s,"url",url_s,"pageno",strPage);
}
db.close();
sql_search=sql_search+" limit "+(Integer.parseInt(strPage)-1)*pageSize+","+pageSize;
strPage=strPage+"⊙"+maxPage;
}else{
%>
<script>
document.write('<p>&nbsp;</p>');
document.write('<div style="position:absolute;left:12%"><font color="red"><%=demo.getLang("erp","对不起，页面已过期，请重新登录！")%></font></div>');
</script>
<%
}
}catch(Exception e){
	e.printStackTrace();
}
%>