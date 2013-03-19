package include.nseer_cookie;
import java.sql.*;
import include.nseer_db.nseer_db;
public class KindDeep {
	
	/**
	 * @param args
	 */
	public static int getDeep(String chain_id,int first_length,int step_length){
		int deep=1;
		chain_id=chain_id.substring(first_length);
		deep=deep+chain_id.length()/step_length;
		return deep;
	}
	
	public static String getPre(String dbase){
		String pre="###,##0.";
		try{
		int pre_control=0;
		nseer_db erp_db = new nseer_db(dbase);
		String sql = "select type_name from erpplatform_config_public_char where kind='nseer_define'";
		ResultSet rs = erp_db.executeQuery(sql) ;
		if(rs.next()){
			pre_control=Integer.parseInt(rs.getString("type_name").substring(9));
		}
		erp_db.close();
		for(int i=0;i<pre_control;i++){
			pre+="0";
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return pre;
	}
	
	public static String getAmountPre(String dbase){
		String pre="#####0.";
		try{
		int pre_control=0;
		nseer_db erp_db = new nseer_db(dbase);
		String sql = "select type_name from erpplatform_config_public_char where kind='nseer_define'";
		ResultSet rs = erp_db.executeQuery(sql) ;
		if(rs.next()){
			pre_control=Integer.parseInt(rs.getString("type_name").substring(9));
		}
		erp_db.close();
		for(int i=0;i<pre_control;i++){
			pre+="0";
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return pre;
	}
}
