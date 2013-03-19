package draft.oa;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import com.jspsmart.upload.*;
import java.util.* ;

public class culture_draft_ok extends HttpServlet{

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
nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);

if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String culture_ID = request.getParameter("culture_ID");
mySmartUpload.initialize(pageContext);
String file_type=getFileLength.getFileType((String)session.getAttribute("unit_db_name"));
long d=getFileLength.getFileLength((String)session.getAttribute("unit_db_name"));
mySmartUpload.setMaxFileSize(d);
mySmartUpload.setAllowedFilesList(file_type);
try{
mySmartUpload.upload();
String[] file_name=new String[mySmartUpload.getFiles().getCount()];
String[] not_change=new String[mySmartUpload.getFiles().getCount()];
String sql1="select * from oa_culture where culture_ID='"+culture_ID+"' and (check_tag='5' or check_tag='9')";
ResultSet rs=oa_db.executeQuery(sql1);
if(!rs.next()){
	
	response.sendRedirect("draft/oa/culture_ok.jsp?finished_tag=1");
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
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"documentAttachmentcount");
	count.write((String)dbSession.getAttribute("unit_db_name"),"documentAttachmentcount",filenum);
	file_name[i]=filenum+file.getFileName();
	file.saveAs(path+"oa/file_attachments/" + filenum+file.getFileName());
}

String register = mySmartUpload.getRequest().getParameter("register");
String register_time = mySmartUpload.getRequest().getParameter("register_time");
String content = mySmartUpload.getRequest().getParameter("content");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);

String sqla = "update oa_culture set register='"+register+"',register_time='"+register_time+"',content='"+content+"',remark='"+remark+"'";
		
	String sqlb = " where culture_ID='"+culture_ID+"'" ;
if(attachment!=null){
for(int i=0;i<attachment.length;i++){
	sqla=sqla+","+attachment[i]+"=''";
	java.io.File file=new java.io.File(path+"oa/file_attachments/"+delete_file_name[i]);
	file.delete();
}
}
for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
	if(not_change[i]!=null&&not_change[i].equals("yes")) continue;
	int p=i+1;
	sqla=sqla+",attachment"+p+"='"+file_name[i]+"'";
}
String sql=sqla+sqlb;
	oa_db.executeUpdate(sql) ;
	
response.sendRedirect("draft/oa/culture_ok.jsp?finished_tag=0");
}
oa_db.commit();
oa_db.close();
}catch(Exception ex){
	response.sendRedirect("draft/oa/culture_ok_a.jsp?culture_ID="+culture_ID);
}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}