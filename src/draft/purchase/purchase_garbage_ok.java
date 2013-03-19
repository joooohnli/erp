package draft.purchase;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataRecordNumber;
import validata.ValidataRecord;
import validata.ValidataTag;

public class purchase_garbage_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchasedb = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&& purchase_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&purchasedb.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
counter count=new counter(dbApplication);
ValidataRecordNumber vrn=new ValidataRecordNumber();
ValidataRecord vr=new ValidataRecord();
ValidataTag vt=new ValidataTag();
String purchase_ID=request.getParameter("purchase_ID");
String config_ID=request.getParameter("config_ID");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String list_price=request.getParameter("list_price");
String demand_amount=request.getParameter("amount");
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_purchase","purchase_ID",purchase_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_purchase","purchase_ID",purchase_ID,"check_tag").equals("9")){
try{
	String sqll = "update purchase_purchase set remark='"+remark+"',check_tag='3' where purchase_ID='"+purchase_ID+"'" ;
	purchase_db.executeUpdate(sqll) ;
	int record_number=0;
	String sql98="select count(*) from purchase_details where purchase_ID='"+purchase_ID+"'";
	ResultSet rs98=purchase_db.executeQuery(sql98) ;
	while(rs98.next()){
		record_number=rs98.getInt("count(*)");
	}
	double list_price_sum=Double.parseDouble(list_price)*Double.parseDouble(demand_amount);
	String sql = "update purchase_purchase set list_price_sum='"+list_price_sum+"',list_price='"+list_price+"',remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"',purchase_tag='1',invoice_tag='1',gather_tag='1',stock_gather_tag='1',pay_tag='1'where purchase_ID='"+purchase_ID+"'" ;
	purchase_db.executeUpdate(sql) ;

    String sql9="select * from purchase_details where purchase_ID='"+purchase_ID+"'";
	ResultSet rs9=purchase_db.executeQuery(sql9) ;
	while(rs9.next()){
     
    if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",purchase_ID)<record_number){
		
    String gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));

		String sql5="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price,cost_price_sum,register,register_time) values('"+gather_ID+"','采购入库','"+purchase_ID+"','"+rs9.getString("provider_name")+"','"+rs9.getString("demand_amount")+"','"+rs9.getString("demand_price")+"','"+rs9.getString("demand_cost_price_sum")+"','"+checker+"','"+check_time+"')";
		stock_db.executeUpdate(sql5) ;
		String sql6="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,amount,ungather_amount,cost_price,subtotal) values('"+gather_ID+"','1','"+product_ID+"','"+product_name+"','"+rs9.getString("demand_amount")+"','"+rs9.getString("demand_amount")+"','"+rs9.getString("demand_price")+"','"+rs9.getString("demand_cost_price_sum")+"')";
		stock_db.executeUpdate(sql6) ;
	}
	}

	String sql99="select * from purchase_details where purchase_ID='"+purchase_ID+"'";
	ResultSet rs99=purchase_db.executeQuery(sql99) ;
	while(rs99.next()){
		String chain_id="";
		String chain_name="";
		String purchaser_ID="";
		String purchaser="";
		String sql15="select * from purchase_file where provider_ID='"+rs99.getString("provider_ID")+"'";
		ResultSet rs15=purchasedb.executeQuery(sql15);
		if(rs15.next()){
			chain_id=rs15.getString("chain_id");
			chain_name=rs15.getString("chain_name");
			purchaser_ID=rs15.getString("purchaser_ID");
			purchaser=rs15.getString("purchaser");
			if(rs99.getDouble("demand_cost_price_sum")>=0){
			double trade_amount=rs15.getDouble("trade_amount")+1;
			double trade_sum=rs15.getDouble("achievement_sum")+rs99.getDouble("demand_cost_price_sum");
			String sql90="update purchase_file set trade_amount='"+trade_amount+"',achievement_sum='"+trade_sum+"' where provider_ID='"+rs99.getString("provider_ID")+"'";
			purchase_db1.executeUpdate(sql90) ;
			}else{
			double return_amount=rs15.getDouble("return_amount")+1;
			double trade_sum=rs15.getDouble("achievement_sum")+rs99.getDouble("demand_cost_price_sum");
			double return_sum=rs15.getDouble("return_sum")+rs99.getDouble("demand_cost_price_sum");
			String sql90="update purchase_file set return_amount='"+return_amount+"',achievement_sum='"+trade_sum+"',return_sum='"+return_sum+"' where provider_ID='"+rs99.getString("provider_ID")+"'";
			purchase_db1.executeUpdate(sql90) ;
			}
		}
		
		String fund_ID=NseerId.getId("fund/pay",(String)dbSession.getAttribute("unit_db_name"));
		if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",purchase_ID)<record_number){
			
		String sql12="insert into fund_fund(fund_ID,reason,reasonexact,chain_id,chain_name,funder,funder_ID,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register,register_time,sales_purchaser_ID,sales_purchaser_name) values('"+fund_ID+"','付款','"+purchase_ID+"','"+chain_id+"','"+chain_name+"','"+rs99.getString("provider_name")+"','"+rs99.getString("provider_ID")+"','2121','应付账款','"+rs99.getString("demand_cost_price_sum")+"','人民币','元','"+checker+"','"+check_time+"','"+purchaser_ID+"','"+purchaser+"')";
		fund_db.executeUpdate(sql12);
		}
}
	
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("draft/purchase/purchase_ok.jsp?finished_tag=2");
	}else{
	
	response.sendRedirect("draft/purchase/purchase_ok.jsp?finished_tag=3");
}

	purchase_db1.commit();
	stock_db.commit();
fund_db.commit();
finance_db.commit();
purchasedb.commit();
	purchase_db.commit();
purchase_db.close();
	purchase_db1.close();
	stock_db.close();
fund_db.close();
finance_db.close();
purchasedb.close();
}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 