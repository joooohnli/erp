
package draft.crm;

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

public class discussion_draft_ok extends HttpServlet{
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

nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String register_id=(String)session.getAttribute("human_IDD");
String register=request.getParameter("register");
String discussion_ID=request.getParameter("discussion_ID") ;
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String demand_customer_address=request.getParameter("demand_customer_address") ;
String demand_customer_mailing_address=request.getParameter("demand_customer_mailing_address") ;
String demand_contact_person=request.getParameter("demand_contact_person") ;
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
String demand_contact_person_fax=request.getParameter("demand_contact_person_fax") ;
String demand_pay_time=request.getParameter("demand_pay_time") ;
String demand_pay_type=request.getParameter("demand_pay_type") ;
String demand_pay_fee_type=request.getParameter("demand_pay_fee_type") ;
String demand_gather_time=request.getParameter("demand_gather_time") ;
String demand_gather_type=request.getParameter("demand_gather_type") ;
String demand_gather_method=request.getParameter("demand_gather_method") ;
String demand_invoice_type=request.getParameter("demand_invoice_type") ;
String sales_ID=request.getParameter("sales_ID") ;
String sales_name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",sales_ID,"human_name");
String[] aaa={"",""};
if(!sales_ID.equals("")){
aaa=getThreeKinds.getThreeKinds((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",sales_ID);
}
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String modify_tag=request.getParameter("modify_tag") ;
String product_amount=request.getParameter("product_amount") ;
String[] product_IDn=request.getParameterValues("product_ID") ;
String[] list_pricen=request.getParameterValues("list_price") ;
String[] amountn=request.getParameterValues("amount") ;
String[] off_discountn=request.getParameterValues("off_discount") ;
int num=Integer.parseInt(product_amount);
if(num==0&&product_IDn.length==1){
	response.sendRedirect("draft/crm/discussion_ok_a.jsp?discussion_ID="+discussion_ID);
}else{
String demand_pay_fee_sum2=request.getParameter("demand_pay_fee_sum") ;
StringTokenizer tokenTO1 = new StringTokenizer(demand_pay_fee_sum2,",");        
String demand_pay_fee_sum="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_pay_fee_sum1 = tokenTO1.nextToken();
		demand_pay_fee_sum +=demand_pay_fee_sum1;
		}
double order_discount=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"security_users","human_ID",sales_ID,"order_discount");
double order_discount1=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"security_users","human_ID",register_id,"order_discount");
int n=0;
int m=0;
String product_ID_group=",";
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
		}else if(Double.parseDouble(off_discount)>order_discount&&Double.parseDouble(off_discount)>order_discount1){
			n++;
		}
}
for(int j=1;j<product_IDn.length;j++){
	product_ID_group+=product_IDn[j]+",";
	StringTokenizer tokenTO2 = new StringTokenizer(list_pricen[j],",");     
	String list_price="";
    while(tokenTO2.hasMoreTokens()) {
        String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
		if(!validata.validata(amountn[j])||!validata.validata(off_discountn[j])||!validata.validata(list_price)){
			n++;
		}else if(Double.parseDouble(off_discountn[j])>order_discount&&Double.parseDouble(off_discountn[j])>order_discount1){
			n++;
		}
}
for(int i=1;i<=num;i++){
	String tem_product_ID="product_ID"+i;
	String product_ID=request.getParameter(tem_product_ID) ;
	if(product_ID_group.indexOf(product_ID)!=-1) m++;
}

if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_discussion","discussion_ID",discussion_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_discussion","discussion_ID",discussion_ID,"check_tag").equals("9")){
if(n==0){
	if(m==0){
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
String id="";
String sql="select id from crm_discussion where discussion_ID='"+discussion_ID+"'";
ResultSet rs=crm_db.executeQuery(sql);
	if(rs.next()){
		id=rs.getString("id");
	}
	
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

		String sql1 = "update crm_discussion_details set product_ID='"+product_ID+"',product_name='"+product_name+"',product_describe='"+product_describe+"',list_price='"+list_price+"',amount='"+amount1+"',cost_price='"+cost_price+"',real_cost_price='"+real_cost_price+"',off_discount='"+off_discount+"',subtotal='"+subtotal+"' where discussion_ID='"+discussion_ID+"' and details_number='"+i+"'" ;
		crm_db.executeUpdate(sql1) ;	
	}
	String[] cost_pricen=request.getParameterValues("cost_price") ;
	String[] real_cost_pricen=request.getParameterValues("real_cost_price") ;
	String[] product_namen=request.getParameterValues("product_name") ;
	String[] product_describen=request.getParameterValues("product_describe") ;
	String[] amount_unitn=request.getParameterValues("amount_unit") ;
	for(int i=1;i<product_IDn.length;i++){   
		num++;     
	String list_price=list_pricen[i].replaceAll(",","");      
	String cost_price=cost_pricen[i].replaceAll(",","");     
	String real_cost_price=real_cost_pricen[i].replaceAll(",","");
	         double amount=0.0d;
	    double subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discountn[i])/100)*Double.parseDouble(amountn[i]);
	    		double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amountn[i]);
	    		double real_cost_price_after_discount_sum=Double.parseDouble(real_cost_price)*Double.parseDouble(amountn[i]);
	    		sale_price_sum+=subtotal;
	    		cost_price_sum+=cost_price_after_discount_sum;
	    		real_cost_price_sum+=real_cost_price_after_discount_sum;	    			
		String sql1 = "insert into crm_discussion_details(discussion_ID,details_number,product_ID,product_name,product_describe,list_price,amount,cost_price,real_cost_price,off_discount,subtotal,amount_unit) values ('"+discussion_ID+"','"+num+"','"+product_IDn[i]+"','"+product_namen[i]+"','"+product_describen[i]+"','"+list_price+"','"+amountn[i]+"','"+cost_price+"','"+real_cost_price+"','"+off_discountn[i]+"','"+subtotal+"','"+amount_unitn[i]+"')" ;
		crm_db.executeUpdate(sql1) ;
	}
	sql="update crm_discussion set customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',demand_customer_address='"+demand_customer_address+"',demand_customer_mailing_address='"+demand_customer_mailing_address+"',demand_contact_person='"+demand_contact_person+"',demand_contact_person_tel='"+demand_contact_person_tel+"',demand_contact_person_fax='"+demand_contact_person_fax+"',demand_pay_time='"+demand_pay_time+"',demand_pay_type='"+demand_pay_type+"',demand_pay_fee_type='"+demand_pay_fee_type+"',demand_gather_type='"+demand_gather_type+"',demand_gather_method='"+demand_gather_method+"',demand_invoice_type='"+demand_invoice_type+"',sales_name='"+sales_name+"',sales_ID='"+sales_ID+"',register='"+register+"',remark='"+remark+"',sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"' where discussion_ID='"+discussion_ID+"'";
	crm_db.executeUpdate(sql) ;
response.sendRedirect("draft/crm/discussion_choose_attachment.jsp?discussion_ID="+discussion_ID+"");
}else{
response.sendRedirect("draft/crm/discussion_ok.jsp?finished_tag=5");
	}
	}else{
response.sendRedirect("draft/crm/discussion_ok.jsp?finished_tag=1");
	}
}else{
response.sendRedirect("draft/crm/discussion_ok.jsp?finished_tag=4");
}
}
	crm_db.commit();
	crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}

