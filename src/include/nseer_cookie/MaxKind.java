package include.nseer_cookie;

import include.nseer_db.nseer_db;
import include.tree_index.Nseer;

import java.sql.*;

public class MaxKind {
	private MaxKindP m;
	public  MaxKind(String dbase,String table,String fn,String human_id){
		m=new MaxKindP(dbase,table,fn,human_id);
	}

	public  MaxKind(String dbase,String table,String fn){
		m=new MaxKindP(dbase,table,fn);
	}

	public String maxValue(String fv){
		return m.maxValue(fv);
	}
	public static int getCount(String dbase){
		int pre_control=MaxKindP.getCount(dbase);
		return pre_control;
	}
public void close(){
	m.close();
	}

}
