package include.nseer_cookie;

import include.nseer_db.nseer_db;
import include.tree_index.Nseer;

import java.sql.*;

public class MaxKindP {
	private nseer_db db;
	private ResultSet rs;
	private String table_name;

	public  MaxKindP(String dbase,String table,String fn,String human_id){
		this.table_name=table;
		try{
		db=new nseer_db(dbase);
		String sql="select * from "+table+" where human_id='"+human_id+"' order by file_id";
		rs=db.executeQuery(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	public  MaxKindP(String dbase,String table,String fn){
		this.table_name=table;
		try{
		db=new nseer_db(dbase);
		String sql="select * from "+table+" order by file_id";
		rs=db.executeQuery(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	public String maxValue(String fv){
		String value="";
		try{
			Nseer n=new Nseer();
			while(rs.next()){
					if(rs.getString(fv).length()>value.length()) value=rs.getString(fv);
			}
			
		}catch(Exception ex){
			value="0";
			ex.printStackTrace();
		}
		return value;
	}
	public static int getCount(String dbase){
		int pre_control=0;
		try{	
		nseer_db erp_db = new nseer_db(dbase);
		String sql = "select type_name from erpplatform_config_public_char where kind='nseer_define'";
		ResultSet rs = erp_db.executeQuery(sql) ;
		if(rs.next()){
			pre_control=Integer.parseInt(rs.getString("type_name").substring(2,4))-Integer.parseInt(rs.getString("type_name").substring(0,2))*2;
		}
		erp_db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return pre_control;
	}
public void close(){
		db.close();
	}

}
