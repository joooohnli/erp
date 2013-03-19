package draft.manufacture;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import validata.ValidataNumber;
import validata.ValidataRecord;
import include.nseer_cookie.counter;

public class moduleBalance_check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataRecord vr=new ValidataRecord();
try{
	String time="";
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	time=formatter.format(now);
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String manufacture_ID=request.getParameter("manufacture_ID") ;
String module_time=request.getParameter("module_time");
String procedure_name=request.getParameter("procedure_name") ;
String procedure_ID=request.getParameter("procedure_ID") ;
String[] product_IDn=request.getParameterValues("product_ID") ;
String procedure_responsible_person=request.getParameter("procedure_responsible_person") ;
String product_amount=request.getParameter("product_amount") ;
String register_time=request.getParameter("register_time") ;
String register=request.getParameter("register") ;
int num=Integer.parseInt(product_amount);
int m=0;
int n=0;

for(int j=1;j<product_IDn.length;j++){
	String sql3="select * from manufacture_module_balance_details where manufacture_ID='"+manufacture_ID+"' and product_ID='"+product_IDn[j]+"'";
	ResultSet rs3=manufacture_db.executeQuery(sql3) ;
	if(rs3.next()){
		m++;
	}
}
if(num==0&&product_IDn.length==1){
	response.sendRedirect("draft/manufacture/moduleBalance_ok.jsp?finished_tag=7");
}else{
	if(m!=0){
	response.sendRedirect("draft/manufacture/moduleBalance_ok.jsp?finished_tag=6");
	}else{
		for(int i=1;i<=num;i++){
			String amount_i=request.getParameter("amount"+i);
			if(amount_i.equals("")||!validata.validata(amount_i)){
				n++;
			}
			}
String[] amount1=request.getParameterValues("amount") ;
for(int j=1;j<product_IDn.length;j++){
		if(!validata.validata(amount1[j])){
			n++;
		}
}
if(n==0){
String reason=request.getParameter("reason") ;

List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	String sql2="select id,describe1,describe2 from manufacture_config_workflow where type_id='05'";
	ResultSet rset=manufacture_db.executeQuery(sql2);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
try{
	String pay_ID="";
	if(rsList.size()==0){
		pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
	}
		double cost_price_sum=0.0d;
		double demand_amount=0.0d;
		for(int i=1;i<=num;i++){
			String tem_product_name="product_name"+i;
			String tem_product_ID="product_ID"+i;
			String tem_product_describe="product_describe"+i;
			String tem_amount="amount"+i;
			String tem_amount_unit="amount_unit"+i;
			String tem_cost_price="cost_price"+i;
		String product_name=request.getParameter(tem_product_name) ;
		String product_ID=request.getParameter(tem_product_ID) ;
		String product_describe=request.getParameter(tem_product_describe) ;
		String amount=request.getParameter(tem_amount) ;
		String amount_unit=request.getParameter(tem_amount_unit) ;
		String cost_price2=request.getParameter(tem_cost_price) ;
		StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");
		String cost_price="";
		            while(tokenTO3.hasMoreTokens()) {
		                String cost_price1 = tokenTO3.nextToken();
				cost_price +=cost_price1;
				}
			double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
			cost_price_sum+=subtotal;
			demand_amount+=Double.parseDouble(amount);
			 sql2 = "update manufacture_module_balance_details set amount='"+amount+"',subtotal='"+subtotal+"' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and register_time='"+register_time+"' and details_number='"+i+"'" ;
				manufacture_db.executeUpdate(sql2) ;
				if(rsList.size()==0){
					String sql8="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,amount,amount_unit,cost_price,subtotal) values('"+pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+amount_unit+"','"+cost_price+"','"+subtotal+"')";
					stock_db.executeUpdate(sql8) ;

			String sql4="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and product_ID='"+product_ID+"'";
			ResultSet rs4=manufacture_db.executeQuery(sql4) ;
			if(rs4.next()){
				double extra_amount=rs4.getDouble("extra_amount")+Double.parseDouble(amount);
				String sql5="update manufacture_procedure_module set extra_amount='"+extra_amount+"' where id='"+rs4.getString("id")+"'";
				manufacture_db.executeUpdate(sql5) ;
			}else{
				String sql6="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' order by details_number desc";
				ResultSet rs6=manufacture_db.executeQuery(sql6) ;
				int details_number=1;
				if(rs6.next()){
				details_number=rs6.getInt("details_number")+1;
				}
				String sql7="insert into manufacture_procedure_module(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,extra_amount,cost_price,amount_unit,subtotal,register_time) values('"+manufacture_ID+"','"+procedure_name+"','"+details_number+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+cost_price+"','"+amount_unit+"','"+subtotal+"','"+register_time+"')";
				manufacture_db.executeUpdate(sql7) ;
				}
				}
		}

String[] product_namen=request.getParameterValues("product_name") ;
String[] product_describen=request.getParameterValues("product_describe") ;
String[] cost_pricen=request.getParameterValues("cost_price") ;
String[] amountn=request.getParameterValues("amount") ;
String[] amount_unitn=request.getParameterValues("amount_unit") ;
for(int j=1;j<product_namen.length;j++){
	StringTokenizer tokenTO2 = new StringTokenizer(cost_pricen[j],",");        
	String cost_price="";
            while(tokenTO2.hasMoreTokens()) {
                String cost_price1 = tokenTO2.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amountn[j]);
	cost_price_sum+=subtotal;
	demand_amount+=Double.parseDouble(amountn[j]);
	num++;
	

	String sql4 = "insert into manufacture_module_balance_details(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,amount,cost_price,amount_unit,subtotal,register_time,module_time) values ('"+manufacture_ID+"','"+procedure_name+"','"+num+"','"+product_IDn[j]+"','"+product_namen[j]+"','"+product_describen[j]+"','"+amountn[j]+"','"+cost_price+"','"+amount_unitn[j]+"','"+subtotal+"','"+register_time+"','"+module_time+"')" ;
	manufacture_db.executeUpdate(sql4) ;
	if(rsList.size()==0){
		String sql8="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,amount,amount_unit,cost_price,subtotal) values('"+pay_ID+"','"+num+"','"+product_IDn[j]+"','"+product_namen[j]+"','"+product_describen[j]+"','"+amountn[j]+"','"+amount_unitn[j]+"','"+cost_price+"','"+subtotal+"')";
		stock_db.executeUpdate(sql8) ;

sql4="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and product_ID='"+product_IDn[j]+"'";
ResultSet rs4=manufacture_db.executeQuery(sql4) ;
if(rs4.next()){
	double extra_amount=rs4.getDouble("extra_amount")+Double.parseDouble(amountn[j]);
	String sql5="update manufacture_procedure_module set extra_amount='"+extra_amount+"' where id='"+rs4.getString("id")+"'";
	manufacture_db.executeUpdate(sql5) ;
}else{
	String sql6="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' order by details_number desc";
	ResultSet rs6=manufacture_db.executeQuery(sql6) ;
	int details_number=1;
	if(rs6.next()){
	details_number=rs6.getInt("details_number")+1;
	}
	String sql7="insert into manufacture_procedure_module(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,extra_amount,cost_price,amount_unit,subtotal,register_time) values('"+manufacture_ID+"','"+procedure_name+"','"+details_number+"','"+product_IDn[j]+"','"+product_namen[j]+"','"+product_describen[j]+"','"+amountn[j]+"','"+cost_pricen[j]+"','"+amount_unitn[j]+"','"+subtotal+"','"+register_time+"')";
	manufacture_db.executeUpdate(sql7) ;
	}
	}
}




String sql3 = "update manufacture_module_balance set module_cost_price_sum='"+cost_price_sum+"',procedure_responsible_person='"+procedure_responsible_person+"',register='"+register+"',register_time='"+register_time+"',reason='"+reason+"' where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_name='"+procedure_name+"'";
manufacture_db.executeUpdate(sql3) ;

if(rsList.size()==0){
		String sql33 = "update manufacture_module_balance set check_tag='1' where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_name='"+procedure_name+"'" ;
				manufacture_db.executeUpdate(sql33) ;
		
		if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","register_time",register_time)){
			String sql9="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+pay_ID+"','生产领料','"+manufacture_ID+"','"+procedure_name+"','"+demand_amount+"','"+demand_amount+"','"+cost_price_sum+"','"+register+"','"+register_time+"')";
			stock_db.executeUpdate(sql9) ;
		}

		}else{
			sql2="delete from manufacture_workflow where object_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"'";
			manufacture_db.executeUpdate(sql2) ;
			sql3 = "update manufacture_module_balance set procedure_responsible_person='"+procedure_responsible_person+"',checker='"+register+"',check_time='"+register_time+"',reason='"+reason+"',check_tag='0' where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"'" ;
			manufacture_db.executeUpdate(sql3) ;
			
				Iterator ite=rsList.iterator();
				while(ite.hasNext()){
				elem=(String[])ite.next();
				String sql = "insert into manufacture_workflow(config_id,object_ID,describe1,describe2,type_id,procedure_ID,module_time) values ('"+elem[0]+"','"+manufacture_ID+"','"+elem[1]+"','"+elem[2]+"','05','"+procedure_ID+"','"+module_time+"')" ;
				manufacture_db.executeUpdate(sql);
		}
		}

}catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/manufacture/moduleBalance_ok.jsp?finished_tag=4");
}else{	
	response.sendRedirect("draft/manufacture/moduleBalance_ok.jsp?finished_tag=5");
}
  }
}
  manufacture_db.commit();
  stock_db.commit();
  stock_db.close();
  manufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 