package include.nseer_cookie;

import include.nseer_db.nseer_db_backup;
import include.nseer_db.nseer_db_backup1;

import java.sql.ResultSet;
import java.util.List;
public class GetWorkflow {
	public static List getList(nseer_db_backup1 db,String table_name,String type_id){
		List rsList = (List)new java.util.ArrayList();
		String[] elem=new String[3];
		try{
		String sql="select id,describe1,describe2 from "+table_name+" where type_id='"+type_id+"'";
		ResultSet rset=db.executeQuery(sql);
		while(rset.next()){
			elem=new String[3];
			elem[0]=rset.getString("id");
			elem[1]=rset.getString("describe1");
			elem[2]=rset.getString("describe2");
			rsList.add(elem);
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return rsList;
	}
	public static List getList(nseer_db_backup db,String table_name,String type_id){
		List rsList = (List)new java.util.ArrayList();
		String[] elem=new String[3];
		try{
		String sql="select id,describe1,describe2 from "+table_name+" where type_id='"+type_id+"'";
		ResultSet rset=db.executeQuery(sql);
		while(rset.next()){
			elem=new String[3];
			elem[0]=rset.getString("id");
			elem[1]=rset.getString("describe1");
			elem[2]=rset.getString("describe2");
			rsList.add(elem);
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return rsList;
	}
}
