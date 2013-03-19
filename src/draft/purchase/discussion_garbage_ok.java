package draft.purchase;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import include.nseer_db.*;
import java.io.*;
import java.util.*;
import java.text.SimpleDateFormat;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;
import include.get_three_kinds.getThreeKinds;
import include.get_name_from_ID.getNameFromID;
import include.get_rate_from_ID.getRateFromID;
import include.nseer_cookie.exchange;

public class discussion_garbage_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup erp_db = null;
	
public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
PrintWriter out=response.getWriter();
session=request.getSession();
counter count=new counter(dbApplication);
ValidataNumber validata = new ValidataNumber();
ValidataRecord vr = new ValidataRecord();
ValidataTag vt = new ValidataTag();
getThreeKinds getThreeKinds = new getThreeKinds();
getNameFromID getNameFromID = new getNameFromID();
getRateFromID getRateFromID = new getRateFromID();

nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);

if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String register_ID=(String)session.getAttribute("human_IDD");
String config_id=request.getParameter("config_id") ;
String discussion_ID=request.getParameter("discussion_ID") ;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String demand_contact_person=request.getParameter("demand_contact_person") ;
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
String demand_contact_person_fax=request.getParameter("demand_contact_person_fax") ;
String demand_pay_time=request.getParameter("demand_pay_time") ;
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String modify_tag=request.getParameter("modify_tag") ;
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int n=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
String amount=request.getParameter(tem_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
String list_price2=request.getParameter(tem_list_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");     

String list_price="";
            while(tokenTO2.hasMoreTokens()) {
                String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
		if(!validata.validata(amount)||!validata.validata(off_discount)||!validata.validata(list_price)){
			n++;
		}
}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_discussion","discussion_ID",discussion_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_discussion","discussion_ID",discussion_ID,"check_tag").equals("9")){
if(n==0){
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

String sql = "update purchase_discussion set discussion_ID='"+discussion_ID+"',provider_ID='"+provider_ID+"',provider_name='"+provider_name+"',demand_contact_person='"+demand_contact_person+"',demand_contact_person_tel='"+demand_contact_person_tel+"',demand_contact_person_fax='"+demand_contact_person_fax+"',checker='"+checker+"',checker_ID='"+checker_ID+"',remark='"+remark+"',check_tag='2' where discussion_ID='"+discussion_ID+"'" ;
	purchase_db.executeUpdate(sql) ;

try{

int service_count=0;
int stock_number=0;
int pay_amount_sum=0;
double sale_price_sum=0.0d;
double cost_price_sum=0.0d;
double real_cost_price_sum=0.0d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
	String tem_cost_price="cost_price"+i;
	String tem_real_cost_price="real_cost_price"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount1=request.getParameter(tem_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
String list_price2=request.getParameter(tem_list_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO2.hasMoreTokens()) {
                String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
String real_cost_price2=request.getParameter(tem_real_cost_price) ;
StringTokenizer tokenTO4 = new StringTokenizer(real_cost_price2,",");        
String real_cost_price="";
            while(tokenTO4.hasMoreTokens()) {
                String real_cost_price1 = tokenTO4.nextToken();
		real_cost_price +=real_cost_price1;
		}
String amount_unit=request.getParameter(tem_amount_unit) ;
double amount=0.0d;
	double subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(amount1);
	double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount1);
	double real_cost_price_after_discount_sum=Double.parseDouble(real_cost_price)*Double.parseDouble(amount1);
	sale_price_sum+=subtotal;
	cost_price_sum+=cost_price_after_discount_sum;
	real_cost_price_sum+=real_cost_price_after_discount_sum;
		
double order_sale_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"order_sale_bonus_rate")*subtotal/100;
double order_profit_bonus_subtotal=0.0d;

	String sql1 = "update purchase_discussion_details set product_ID='"+product_ID+"',product_name='"+product_name+"',product_describe='"+product_describe+"',list_price='"+list_price+"',amount='"+amount1+"',cost_price='"+cost_price+"',off_discount='"+off_discount+"',subtotal='"+subtotal+"' where discussion_ID='"+discussion_ID+"' and details_number='"+i+"'" ;
	purchase_db.executeUpdate(sql1) ;

String product_type="";
String sql16="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs16=purchase_db.executeQuery(sql16);
if(rs16.next()){
	product_type=rs16.getString("type");
}
}

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/purchase/discussion_choose_attachment.jsp?discussion_ID="+discussion_ID+"");
}else{
response.sendRedirect("draft/purchase/discussion_ok.jsp?finished_tag=0");
}
}else{
response.sendRedirect("draft/purchase/discussion_ok.jsp?finished_tag=2");
}

	purchase_db.commit();
	purchase_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}

