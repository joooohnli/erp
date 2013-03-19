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
public class accident_check_ok extends HttpServlet{
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
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String[] not_change=new String[mySmartUpload.getFiles().getCount()];
String accident_id = mySmartUpload.getRequest().getParameter("accident_id");
String config_id = request.getParameter("config_id");
String sqla="select attachment1 from qcs_accident where accident_id='"+accident_id+"' and (check_tag='5' or check_tag='9')";
ResultSet rs=qcs_db.executeQuery(sqla);
if(!rs.next()){
  response.sendRedirect("draft/qcs/accident_ok.jsp?finished_tag=5");
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
String accident_time = mySmartUpload.getRequest().getParameter("accident_time");
String accident_name = mySmartUpload.getRequest().getParameter("accident_name");
String product_id = mySmartUpload.getRequest().getParameter("product_id");
String product_name = mySmartUpload.getRequest().getParameter("product_name");
String bodya = new String(mySmartUpload.getRequest().getParameter("accident_outlines").getBytes("UTF-8"),"UTF-8");
String accident_outlines=exchange.toHtml(bodya);
String body1 = new String(mySmartUpload.getRequest().getParameter("explanation").getBytes("UTF-8"),"UTF-8");
String explanation=exchange.toHtml(body1);
String body2 = new String(mySmartUpload.getRequest().getParameter("survey_result").getBytes("UTF-8"),"UTF-8");
String survey_result=exchange.toHtml(body2);
String body3 = new String(mySmartUpload.getRequest().getParameter("scene_measure").getBytes("UTF-8"),"UTF-8");
String scene_measure=exchange.toHtml(body3);
String bodyb = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String register = mySmartUpload.getRequest().getParameter("register");
String register_id = mySmartUpload.getRequest().getParameter("register_id");
String register_time = mySmartUpload.getRequest().getParameter("register_time");

sqla = "update qcs_accident set accident_time='"+accident_time+"',accident_name='"+accident_name+"',product_id='"+product_id+"',product_name='"+product_name+"',accident_outlines='"+accident_outlines+"',explanation='"+explanation+"',survey_result='"+survey_result+"',scene_measure='"+scene_measure+"',register_id='"+register_id+"',register='"+register+"',register_time='"+register_time+"',remark='"+remark+"'";
String sqlb = " where accident_id='"+accident_id+"'" ;
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
List rsList = GetWorkflow.getList(qcs_db, "qcs_config_workflow", "14");
if(rsList.size()==0){
	sql="update qcs_accident set check_tag='1' where accident_id='"+accident_id+"'";
	qcs_db.executeUpdate(sql);
}else{
	sql="delete from qcs_workflow where object_ID='"+accident_id+"'";
	qcs_db.executeUpdate(sql) ;
	sql="update qcs_accident set check_tag='0' where accident_id='"+accident_id+"'";
	qcs_db.executeUpdate(sql) ;
	Iterator ite=rsList.iterator();
	while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into qcs_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+accident_id+"','"+elem[1]+"','"+elem[2]+"')" ;
		qcs_db.executeUpdate(sql);
	}
}

response.sendRedirect("draft/qcs/accident_ok.jsp?finished_tag=4");
}

qcs_db.commit();
qcs_db.close();
}else{
	response.sendRedirect("error_conn.htm");}
}catch(Exception ex){
ex.printStackTrace();
response.sendRedirect("draft/qcs/accident_ok.jsp?finished_tag=2");
}
}
}
