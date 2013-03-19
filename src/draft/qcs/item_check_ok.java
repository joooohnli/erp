package draft.qcs;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import include.nseer_db.*;
import include.nseer_cookie.*;

import java.io.*;
import java.util.*;

import com.jspsmart.upload.*;


import include.nseer_cookie.counter;

public class item_check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{
//实例化

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
counter count=new counter(dbApplication);
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);

if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){

mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);

try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String[] not_change=new String[mySmartUpload.getFiles().getCount()];

String item_id = mySmartUpload.getRequest().getParameter("item_id");
String sql1="select attachment1 from qcs_item where item_id='"+item_id+"' and (check_tag='5' or check_tag='9')";
ResultSet rs=qcs_db.executeQuery(sql1);
if(!rs.next()){	
	response.sendRedirect("draft/qcs/item_ok.jsp?finished_tag=5");
}else{
String[] attachment=mySmartUpload.getRequest().getParameterValues("attachment");
String[] delete_file_name=new String[0];
if(attachment!=null){
delete_file_name=new String[attachment.length];
for(int i=0;i<attachment.length;i++){
	delete_file_name[i]=rs.getString(attachment[i]);
}
	}
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	com.jspsmart.upload.SmartFile file = mySmartUpload.getFiles().getFile(i);
	if (file.isMissing()){
		file_name[i]="";
		int q=i+1;
		String field_name="attachment"+q;
		if(!rs.getString(field_name).equals("")) not_change[i]="yes";
		continue;
	}
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"qcsAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"qcsAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"qcs/file_attachments/" + filenum+file.getFileName());
}

String item_name = mySmartUpload.getRequest().getParameter("item_name");
String analyse_method = mySmartUpload.getRequest().getParameter("analyse_method");
String default_basis = mySmartUpload.getRequest().getParameter("default_basis");
String ready_basis = mySmartUpload.getRequest().getParameter("ready_basis");
String quality_method = mySmartUpload.getRequest().getParameter("quality_method");
String quality_equipment = mySmartUpload.getRequest().getParameter("quality_equipment");
String sampling_standard = mySmartUpload.getRequest().getParameter("sampling_standard");
String defect_class = mySmartUpload.getRequest().getParameter("defect_class");
String important = mySmartUpload.getRequest().getParameter("important");
String designer = mySmartUpload.getRequest().getParameter("designer");
String register = mySmartUpload.getRequest().getParameter("register");
String register_id = mySmartUpload.getRequest().getParameter("register_id");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String QV_hidden = mySmartUpload.getRequest().getParameter("QV_hidden");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
String sqla = "update qcs_item set item_name='"+item_name+"',register_id='"+register_id+"',register='"+register+"',register_time='"+register_time+"',analyse_method='"+analyse_method+"',designer='"+designer+"',default_basis='"+default_basis+"',ready_basis='"+ready_basis+"',quality_method='"+quality_method+"',quality_equipment='"+quality_equipment+"',sampling_standard='"+sampling_standard+"',defect_class='"+defect_class+"',important='"+important+"',quality_value='"+QV_hidden+"',remark='"+remark+"',check_tag='0'";
	String sqlb = " where item_id='"+item_id+"'" ;
	if(attachment!=null){
		for(int i=0;i<attachment.length;i++){
			sqla=sqla+","+attachment[i]+"=''";
			java.io.File file=new java.io.File(path+"qcs/file_attachments/"+delete_file_name[i]);
			file.delete();
		}
		}
		for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
			if(not_change[i]!=null&&not_change[i].equals("yes")) continue;
			int p=i+1;
			sqla=sqla+",attachment"+p+"='"+file_name[i]+"'";
		}
String sql=sqla+sqlb;
	qcs_db.executeUpdate(sql) ;
List rsList = GetWorkflow.getList(qcs_db, "qcs_config_workflow", "02");
if(rsList.size()==0){
	sql="update qcs_item set check_tag='1' where item_id='"+item_id+"'";
	qcs_db.executeUpdate(sql);
}else{
	sql="delete from qcs_workflow where object_ID='"+item_id+"'";
	qcs_db.executeUpdate(sql) ;
	sql="update qcs_item set check_tag='0' where item_id='"+item_id+"'";
	qcs_db.executeUpdate(sql) ;
	Iterator ite=rsList.iterator();
	while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into qcs_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+item_id+"','"+elem[1]+"','"+elem[2]+"')" ;
		qcs_db.executeUpdate(sql);
	}
}
response.sendRedirect("draft/qcs/item_ok.jsp?finished_tag=4");
}
qcs_db.commit();
qcs_db.close();
}
catch(Exception ex){
	ex.printStackTrace();
	response.sendRedirect("draft/qcs/item_ok.jsp?finished_tag=6");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
