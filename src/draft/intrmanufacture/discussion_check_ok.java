package draft.intrmanufacture;


import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;
import validata.ValidataTag;

public class discussion_check_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;


public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{//实例化
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	ValidataNumber validata= new ValidataNumber();
	ValidataTag vt = new ValidataTag();
String discussion_ID=request.getParameter("discussion_ID") ;
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_discussion","discussion_ID",discussion_ID,"check_tag").equals("9")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_discussion","discussion_ID",discussion_ID,"check_tag").equals("5")){
String register=request.getParameter("register") ;
String register_id=request.getParameter("register_id") ;

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
if(n==0){

String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String demand_contact_person=request.getParameter("demand_contact_person") ;
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
String demand_contact_person_fax=request.getParameter("demand_contact_person_fax") ;
String demand_pay_time=request.getParameter("demand_pay_time") ;

String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);


try{
	String sql = "update intrmanufacture_discussion set discussion_ID='"+discussion_ID+"',provider_ID='"+provider_ID+"',provider_name='"+provider_name+"',demand_contact_person='"+demand_contact_person+"',demand_contact_person_tel='"+demand_contact_person_tel+"',demand_contact_person_fax='"+demand_contact_person_fax+"',demand_pay_time='"+demand_pay_time+"',register='"+register+"',register_id='"+register_id+"',remark='"+remark+"',check_tag='0',discussion_tag='0',modify_tag='1' where discussion_ID='"+discussion_ID+"'" ;

	intrmanufacture_db.executeUpdate(sql) ;
double pay_amount_sum=0.0d;
double sale_price_sum=0.0d;
double cost_price_sum=0.0d;
n=1;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
	String tem_cost_price="cost_price"+i;
	String tem_amount_unit="amount_unit"+i ;
String amount=request.getParameter(tem_amount) ;
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
String amount_unit=request.getParameter(tem_amount_unit) ;
	double subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(amount);
	double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	sale_price_sum+=subtotal;
	cost_price_sum+=cost_price_after_discount_sum;
	pay_amount_sum+=Double.parseDouble(amount);
	String sql1 = "update intrmanufacture_discussion_details set list_price='"+list_price+"',amount='"+amount+"',amount_unit='"+amount_unit+"',cost_price='"+cost_price+"',off_discount='"+off_discount+"',subtotal='"+subtotal+"' where discussion_ID='"+discussion_ID+"' and details_number='"+i+"'" ;
	intrmanufacture_db.executeUpdate(sql1) ;
}
String sql2="update intrmanufacture_discussion set sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"' where discussion_ID='"+discussion_ID+"'";
intrmanufacture_db.executeUpdate(sql2) ;

sql="delete from intrmanufacture_workflow where object_id='"+discussion_ID+"'";
	intrmanufacture_db.executeUpdate(sql) ;

	List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	sql="select id,describe1,describe2 from intrmanufacture_config_workflow where type_id='02'";
	ResultSet rset=intrmanufacture_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
	if(rsList.size()==0){
		sql="update intrmanufacture_discussion set check_tag='1',modify_tag='0' where discussion_ID='"+discussion_ID+"'";
		intrmanufacture_db.executeUpdate(sql) ;
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into intrmanufacture_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+discussion_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		intrmanufacture_db.executeUpdate(sql) ;
		}
	}	

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/intrmanufacture/discussion_choose_attachment.jsp?discussion_ID="+discussion_ID+"");
	}else{		
response.sendRedirect("draft/intrmanufacture/discussion_ok_a.jsp?discussion_ID="+discussion_ID+"");
}
}else{		
response.sendRedirect("draft/intrmanufacture/discussion_ok.jsp?finished_tag=2");
}
intrmanufacture_db.commit();
intrmanufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}