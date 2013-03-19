package draft.crm;
 
 
import include.get_name_from_ID.getNameFromID;
import include.nseer_cookie.Divide1;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataTag;

public class file_garbage_ok extends HttpServlet{


ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;


public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
counter count=new counter(dbApplication);
getNameFromID getNameFromID = new getNameFromID();
ValidataTag   vt=new  ValidataTag();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String customer_ID=request.getParameter("customer_ID");
String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
String oldKind_chain=request.getParameter("oldKind_chain");
String oldChain_id=Divide1.getId(oldKind_chain);
String sales_name="";
String sales_ID=request.getParameter("sales_ID");
String sql2="select id from crm_config_file_kind where chain_ID='"+chain_id+"'";
ResultSet rs2=crm_db.executeQuery(sql2) ;
if(!sales_ID.equals("")){
	sales_name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"), "hr_file", "human_id", sales_ID, "human_name");
}
if(rs2.next()){
String customer_name=request.getParameter("customer_name") ;
String customer_address=request.getParameter("customer_address") ;
String type=request.getParameter("type") ;
String customer_class=request.getParameter("class") ;
String gather_sum_limit2=request.getParameter("gather_sum_limit") ;
StringTokenizer tokenTO4 = new StringTokenizer(gather_sum_limit2,",");        
String gather_sum_limit="";
            while(tokenTO4.hasMoreTokens()) {
                String gather_sum_limit1 = tokenTO4.nextToken();
		gather_sum_limit +=gather_sum_limit1;
		}
String gather_period_limit=request.getParameter("gather_period_limit") ;
String contact_period_limit=request.getParameter("contact_period_limit") ;
String used_customer_name=request.getParameter("used_customer_name") ;
String customer_bank=request.getParameter("customer_bank") ;
String customer_account=request.getParameter("customer_account") ;
String customer_web=request.getParameter("customer_web") ;
String customer_tel1=request.getParameter("customer_tel1") ;
String customer_tel2=request.getParameter("customer_tel2") ;
String customer_fax=request.getParameter("customer_fax") ;
String customer_postcode=request.getParameter("customer_postcode") ;
String contact_person1=request.getParameter("contact_person1") ;
String contact_person1_department=request.getParameter("contact_person1_department") ;
String contact_person1_duty=request.getParameter("contact_person1_duty") ;
String contact_person1_sex = request.getParameter("contact_person1_sex") ;
String contact_person1_office_tel=request.getParameter("contact_person1_office_tel") ;
String contact_person1_home_tel=request.getParameter("contact_person1_home_tel") ;
String contact_person1_mobile=request.getParameter("contact_person1_mobile") ;
String contact_person1_email=request.getParameter("contact_person1_email") ;
String contact_person2=request.getParameter("contact_person2") ;
String contact_person2_department=request.getParameter("contact_person2_department") ;
String contact_person2_duty=request.getParameter("contact_person2_duty") ;
String contact_person2_sex = request.getParameter("contact_person2_sex") ;
String contact_person2_office_tel=request.getParameter("contact_person2_office_tel") ;
String contact_person2_home_tel=request.getParameter("contact_person2_home_tel") ;
String contact_person2_mobile=request.getParameter("contact_person2_mobile") ;
String contact_person2_email=request.getParameter("contact_person2_email") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyc = new String(request.getParameter("invoice_info").getBytes("gb2312"),"gb2312");
String invoice_info=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("demand").getBytes("gb2312"),"gb2312");
String demand=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("remark").getBytes("gb2312"),"gb2312");
String remark=exchange.toHtml(bodyb);
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_file","customer_id",customer_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_file","customer_id",customer_ID,"check_tag").equals("9")){
try{

if(customer_ID==null||customer_ID.equals("")){
	customer_ID=NseerId.getId("crm/file",(String)dbSession.getAttribute("unit_db_name"));
}


	String sql = "update crm_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',customer_name='"+customer_name+"',customer_address='"+customer_address+"',customer_class='"+customer_class+"',type='"+type+"',customer_bank='"+customer_bank+"',customer_account='"+customer_account+"',customer_web='"+customer_web+"',customer_tel1='"+customer_tel1+"',customer_tel2='"+customer_tel2+"',customer_fax='"+customer_fax+"',customer_postcode='"+customer_postcode+"',used_customer_name='"+used_customer_name+"',gather_sum_limit='"+gather_sum_limit+"',gather_period_limit='"+gather_period_limit+"',contact_period_limit='"+contact_period_limit+"',contact_person1='"+contact_person1+"',contact_person1_department='"+contact_person1_department+"',contact_person1_duty='"+contact_person1_duty+"',contact_person1_sex='"+contact_person1_sex+"',contact_person1_office_tel='"+contact_person1_office_tel+"',contact_person1_home_tel='"+contact_person1_home_tel+"',contact_person1_mobile='"+contact_person1_mobile+"',contact_person1_email='"+contact_person1_email+"',contact_person2='"+contact_person2+"',contact_person2_department='"+contact_person2_department+"',contact_person2_duty='"+contact_person2_duty+"',contact_person2_sex='"+contact_person2_sex+"',contact_person2_office_tel='"+contact_person2_office_tel+"',contact_person2_home_tel='"+contact_person2_home_tel+"',contact_person2_mobile='"+contact_person2_mobile+"',contact_person2_email='"+contact_person2_email+"',register='"+register+"',register_time='"+register_time+"',invoice_info='"+invoice_info+"',demand='"+demand+"',remark='"+remark+"',sales_name='"+sales_name+"',sales_ID='"+sales_ID+"',check_tag='2' where customer_ID='"+customer_ID+"'" ;
	crm_db.executeUpdate(sql) ;
	
	if(!chain_id.equals("oldChain_id")){
		sql="select id from crm_file where chain_id='"+oldChain_id+"'";
		ResultSet rs=crm_db.executeQuery(sql);
		if(!rs.next()){
		sql="update crm_config_file_kind set delete_tag='0' where file_id='"+oldChain_id+"'";
			crm_db.executeUpdate(sql);
		}
		sql="update crm_config_file_kind set delete_tag='1' where file_id='"+chain_id+"'";
			crm_db.executeUpdate(sql);//delete_tag为1说明机构被使用	
	}

}catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/crm/file_ok.jsp?finished_tag=3");
}else{

  response.sendRedirect("draft/crm/file_ok.jsp?finished_tag=4");//用户时候登陆过

}}else{
	

response.sendRedirect("draft/crm/file_ok.jsp?finished_tag=1");

}

crm_db.commit();
crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception x){
	x.printStackTrace();

}

}
}