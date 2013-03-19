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

public class sample_check_ok extends HttpServlet{

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
	String sample_id = mySmartUpload.getRequest().getParameter("sample_id");
	String[] file_name=new String[mySmartUpload.getFiles().getCount()];
	String[] not_change=new String[mySmartUpload.getFiles().getCount()];
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	String sqla="select attachment1 from qcs_sample where sample_id='"+sample_id+"' and (check_tag='5' or check_tag='9')";
	ResultSet rs=qcs_db.executeQuery(sqla);
	if(!rs.next()){	
		response.sendRedirect("draft/qcs/qualityStandard_ok.jsp?finished_tag=5");
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
		file.saveAs(path+"qcs/file_attachments/"+filenum+file.getFileName());
	}
	String apply_id = mySmartUpload.getRequest().getParameter("apply_id");
	String quality_type = mySmartUpload.getRequest().getParameter("quality_type");
	String sampling_person = mySmartUpload.getRequest().getParameter("sampling_person");
	String sampling_time = mySmartUpload.getRequest().getParameter("sampling_time");
	String register = mySmartUpload.getRequest().getParameter("register");
	String register_id = mySmartUpload.getRequest().getParameter("register_id");
	String register_time = mySmartUpload.getRequest().getParameter("register_time");
	String bodyab = new String(mySmartUpload.getRequest().getParameter("remark").getBytes("UTF-8"),"UTF-8");
	String remark=exchange.toHtml(bodyab);
	sqla = "update qcs_sample set apply_id='"+apply_id+"',lately_view_time='"+sampling_time+"',quality_type='"+quality_type+"',sampling_person='"+sampling_person+"',sampling_time='"+sampling_time+"',register='"+register+"',register_id='"+register_id+"',register_time='"+register_time+"',remark='"+remark+"',check_tag='0'";
	String sqlb = " where sample_id='"+sample_id+"'" ;
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

sql="delete from qcs_sample_details where sample_id='"+sample_id+"'";
qcs_db.executeUpdate(sql);

String[] sample_lable = mySmartUpload.getRequest().getParameterValues("sample_lable");
String[] product_id = mySmartUpload.getRequest().getParameterValues("product_id");
String[] product_name = mySmartUpload.getRequest().getParameterValues("product_name");
String[] amount_unit = mySmartUpload.getRequest().getParameterValues("amount_unit");
String[] sumtotal = mySmartUpload.getRequest().getParameterValues("sumtotal");
String[] sampling_amount = mySmartUpload.getRequest().getParameterValues("sampling_amount");
String[] view_cycle = mySmartUpload.getRequest().getParameterValues("view_cycle");
String[] deposit_limit = mySmartUpload.getRequest().getParameterValues("deposit_limit");
String[] deposit_place = mySmartUpload.getRequest().getParameterValues("deposit_place");
for(int i=0;i<sample_lable.length;i++){
	if(!sample_lable[i].equals("")){
	sql="insert into qcs_sample_details(sample_id,sample_lable,product_id,product_name,amount_unit,sumtotal,sampling_amount,view_cycle,deposit_limit,deposit_place,details_number) values('"+sample_id+"','"+sample_lable[i]+"','"+product_id[i]+"','"+product_name[i]+"','"+amount_unit[i]+"','"+sumtotal[i]+"','"+sampling_amount[i]+"','"+view_cycle[i]+"','"+deposit_limit[i]+"','"+deposit_place[i]+"','"+i+"')";
	qcs_db.executeUpdate(sql);
}
}
List rsList = GetWorkflow.getList(qcs_db, "qcs_config_workflow", "13");
if(rsList.size()==0){
	sql="update qcs_sample set check_tag='1' where sample_id='"+sample_id+"'";
	qcs_db.executeUpdate(sql);
}else{
	sql="delete from qcs_workflow where object_ID='"+sample_id+"'";
	qcs_db.executeUpdate(sql) ;
	sql="update qcs_sample set check_tag='0' where sample_id='"+sample_id+"'";
	qcs_db.executeUpdate(sql) ;
	Iterator ite=rsList.iterator();
	while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into qcs_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+sample_id+"','"+elem[1]+"','"+elem[2]+"')" ;
		qcs_db.executeUpdate(sql);
	}
}
response.sendRedirect("draft/qcs/qualityStandard_ok.jsp?finished_tag=4");
}
qcs_db.commit();
qcs_db.close();
}catch(Exception ex){
	response.sendRedirect("draft/qcs/qualityStandard_ok.jsp?finished_tag=6");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
