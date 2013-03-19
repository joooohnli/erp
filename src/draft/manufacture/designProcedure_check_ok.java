package draft.manufacture;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;

public class designProcedure_check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String design_ID=request.getParameter("design_ID") ;
String[] procedure_namen=request.getParameterValues("procedure_name") ;
String procedure_amount=request.getParameter("procedure_amount") ;
int num=Integer.parseInt(procedure_amount);
int m=0;
int n=0;
for(int j=1;j<procedure_namen.length;j++){
	String sql3="select * from manufacture_design_procedure_details where design_ID='"+design_ID+"' and procedure_name='"+procedure_namen[j]+"'";
	ResultSet rs3=manufacture_db.executeQuery(sql3) ;
	if(rs3.next()){
		String procedure_ID_repeat=rs3.getString("procedure_ID");
		m++;
	}
}
if(num==0&&procedure_namen.length==1){
	response.sendRedirect("draft/manufacture/designProcedure_ok_a.jsp?design_ID="+design_ID+"");
}else{
	if(m!=0){
	response.sendRedirect("draft/manufacture/designProcedure_ok_b.jsp?design_ID="+design_ID+"");
	}else{
for(int i=1;i<=num;i++){
	String tem_labour_hour_amount="labour_hour_amount"+i;
	String tem_cost_price="cost_price"+i;
	String tem_amount_unit="amount_unit"+i;
String labour_hour_amount=request.getParameter(tem_labour_hour_amount) ;
if(labour_hour_amount.equals("")) labour_hour_amount="0";
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
if(cost_price2.equals("")) cost_price2="0";
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
		if(!validata.validata(labour_hour_amount)||!validata.validata(cost_price)){
			n++;
		}
		if(amount_unit.indexOf("'")!=-1||amount_unit.indexOf("\"")!=-1||amount_unit.indexOf(",")!=-1){
			n++;
		}
}
String[] labour_hour_amountn=request.getParameterValues("labour_hour_amount") ;
String[] cost_pricen=request.getParameterValues("cost_price") ;
for(int j=1;j<procedure_namen.length;j++){
		if(!validata.validata(labour_hour_amountn[j])||!validata.validata(cost_pricen[j])){
			n++;
		}
}
if(n==0){
String product_ID=request.getParameter("product_ID") ;
String product_name=request.getParameter("product_name") ;
String designer=request.getParameter("designer") ;
String bodyc = new String(request.getParameter("procedure_describea").getBytes("UTF-8"),"UTF-8");
String procedure_describea=exchange.toHtml(bodyc);
String register_time=request.getParameter("register_time") ;
String register=request.getParameter("register") ;
try{
	String sql = "update manufacture_design_procedure set design_ID='"+design_ID+"',product_ID='"+product_ID+"',product_name='"+product_name+"',register_time='"+register_time+"',register='"+register+"',designer='"+designer+"',procedure_describe='"+procedure_describea+"' where design_ID='"+design_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;

double cost_price_sum=0.0d;
for(int i=1;i<=num;i++){
	String tem_procedure_name="procedure_name"+i;
	String tem_procedure_ID="procedure_ID"+i;
	String tem_procedure_describe="procedure_describe"+i;
	String tem_labour_hour_amount="labour_hour_amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String procedure_name=request.getParameter(tem_procedure_name) ;
String procedure_ID=request.getParameter(tem_procedure_ID) ;
String procedure_describe=request.getParameter(tem_procedure_describe) ;
String labour_hour_amount=request.getParameter(tem_labour_hour_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
if(labour_hour_amount.equals("")) labour_hour_amount="0";
if(cost_price2.equals("")) cost_price2="0";
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(labour_hour_amount);
	cost_price_sum+=subtotal;
	String sql1 = "update manufacture_design_procedure_details set procedure_ID='"+procedure_ID+"',details_number='"+i+"',procedure_name='"+procedure_name+"',procedure_describe='"+procedure_describe+"',labour_hour_amount='"+labour_hour_amount+"',cost_price='"+cost_price+"',amount_unit='"+amount_unit+"',subtotal='"+subtotal+"' where design_ID='"+design_ID+"' and procedure_name='"+procedure_name+"'" ;
	manufacture_db.executeUpdate(sql1) ;
}
String[] procedure_IDn=request.getParameterValues("procedure_ID") ;
String[] procedure_describen=request.getParameterValues("procedure_describe") ;
String[] amount_unitn=request.getParameterValues("amount_unit") ;
for(int j=1;j<procedure_namen.length;j++){
	StringTokenizer tokenTO2 = new StringTokenizer(cost_pricen[j],","); 
	String cost_price="";
            while(tokenTO2.hasMoreTokens()) {
                String cost_price1 = tokenTO2.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(labour_hour_amountn[j]);
	cost_price_sum+=subtotal;
	int details_number=num+j;
	String sql4 = "insert into manufacture_design_procedure_details(design_ID,details_number,procedure_ID,procedure_name,procedure_describe,labour_hour_amount,cost_price,amount_unit,subtotal) values ('"+design_ID+"','"+details_number+"','"+procedure_IDn[j]+"','"+procedure_namen[j]+"','"+procedure_describen[j]+"','"+labour_hour_amountn[j]+"','"+cost_price+"','"+amount_unitn[j]+"','"+subtotal+"')" ;
	manufacture_db.executeUpdate(sql4) ;
}

List rsList = GetWorkflow.getList(manufacture_db, "manufacture_config_workflow", "01");
	String[] elem=new String[3];
	String sql2="";
	if(rsList.size()==0){
		sql2="update manufacture_design_procedure set cost_price_sum='"+cost_price_sum+"',check_tag='1',change_tag='1' where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql2) ;
	}else{
		sql2="delete from manufacture_workflow where object_ID='"+design_ID+"'";
		manufacture_db.executeUpdate(sql2) ;
		sql2="update manufacture_design_procedure set cost_price_sum='"+cost_price_sum+"',check_tag='0',change_tag='1' where design_ID='"+design_ID+"'";
			manufacture_db.executeUpdate(sql2) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql2 = "insert into manufacture_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+design_ID+"','"+elem[1]+"','"+elem[2]+"','01')" ;
		manufacture_db.executeUpdate(sql2) ;
		}
	}

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/manufacture/designProcedure_ok.jsp?finished_tag=4");
}else{
	
	response.sendRedirect("draft/manufacture/designProcedure_ok_c.jsp?design_ID="+design_ID+"");
}
  }
}
  manufacture_db.commit();
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
