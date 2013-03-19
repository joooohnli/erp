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

public class product_garbage_ok extends HttpServlet{

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
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String time=formatter.format(now);
String qcs_id = mySmartUpload.getRequest().getParameter("qcs_id");
String config_id = mySmartUpload.getRequest().getParameter("config_id");

String sql1="select attachment1 from qcs_product_config where qcs_id='"+qcs_id+"' and (check_tag='5' or check_tag='9')";
ResultSet rs=qcs_db.executeQuery(sql1);
if(!rs.next()){	
	response.sendRedirect("draft/qcs/product_ok.jsp?finished_tag=3");
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
String product_id = mySmartUpload.getRequest().getParameter("product_id");
String product_name = mySmartUpload.getRequest().getParameter("product_name");
String purchase_qcs_way = mySmartUpload.getRequest().getParameter("purchase_qcs_way");
String intrmanu_qcs_way = mySmartUpload.getRequest().getParameter("intrmanu_qcs_way");
String crm_deliver_qcs_way = mySmartUpload.getRequest().getParameter("crm_deliver_qcs_way");
String crm_return_qcs_way = mySmartUpload.getRequest().getParameter("crm_return_qcs_way");
String manu_product_qcs_way = mySmartUpload.getRequest().getParameter("manu_product_qcs_way");
String manu_procedure_qcs_way = mySmartUpload.getRequest().getParameter("manu_procedure_qcs_way");
String stock_qcs_way = mySmartUpload.getRequest().getParameter("stock_qcs_way");
String other_qcs_way = mySmartUpload.getRequest().getParameter("other_qcs_way");
String register = mySmartUpload.getRequest().getParameter("register");
String checker_id = mySmartUpload.getRequest().getParameter("checker_id");
String change_time = mySmartUpload.getRequest().getParameter("change_time");
String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
	String sqla = "update qcs_product_config set purchase_qcs_way='"+purchase_qcs_way+"',intrmanu_qcs_way='"+intrmanu_qcs_way+"',crm_deliver_qcs_way='"+crm_deliver_qcs_way+"',crm_return_qcs_way='"+crm_return_qcs_way+"',manu_product_qcs_way='"+manu_product_qcs_way+"',manu_procedure_qcs_way='"+manu_procedure_qcs_way+"',stock_qcs_way='"+stock_qcs_way+"',other_qcs_way='"+other_qcs_way+"',register='"+register+"',checker_id='"+checker_id+"',change_time='"+change_time+"',remark='"+remark+"',check_tag='2'";
	String sqlb = " where qcs_id='"+qcs_id+"'" ;
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
	qcs_db.executeUpdate(sql);

	sql="update design_file set purchase_qcs_way='"+purchase_qcs_way+"',intrmanu_qcs_way='"+intrmanu_qcs_way+"',crm_deliver_qcs_way='"+crm_deliver_qcs_way+"',crm_return_qcs_way='"+crm_return_qcs_way+"',manu_product_qcs_way='"+manu_product_qcs_way+"',manu_procedure_qcs_way='"+manu_procedure_qcs_way+"',stock_qcs_way='"+stock_qcs_way+"',other_qcs_way='"+other_qcs_way+"' where product_id='"+product_id+"'";
	qcs_db.executeUpdate(sql);

response.sendRedirect("draft/qcs/product_ok.jsp?finished_tag=2");
}

qcs_db.commit();
qcs_db.close();
}
catch(Exception ex){
	ex.printStackTrace();
	response.sendRedirect("draft/qcs/product_ok.jsp?finished_tag=6");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
