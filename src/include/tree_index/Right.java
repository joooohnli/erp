package include.tree_index;

import java.sql.*;
import include.nseer_db.*;
import java.util.regex.*;
import include.tree_index.Nseer;

public class Right {
  private String database;

  public Right(String database) {
    this.database=database;
  }  
  public  boolean hasRight(String unit_db_name,String user,String right) {
    nseer_db db=null;
    boolean flag=false;
    Nseer n=new Nseer();
    try {
	  String table1=database+"_view";
	  String table2=database+"_tree";
	  db=new nseer_db(unit_db_name);
	  right=right.substring(1);
	  right=right.substring(right.indexOf("/")+1);
	  String filepath=right.substring(0,right.lastIndexOf("/")+1);
	  String filetemp=right.substring(right.lastIndexOf("/")+1);
	  String filename="";
if(filetemp.indexOf("_")!=-1){
	filename=filetemp.substring(0,filetemp.indexOf("_"));
}else{
	filename=filetemp;
}
      ResultSet rs=
        db.executeQuery("select hreflink from "+table1+" r where r.human_ID='"+user+"' and r.file_path='"+filepath+"'");//对比目录树表和权限表中这个用户有那些权限
      while(rs.next()) {                     
		String aa=filename+"[^a-zA-Z].*";
		Pattern b = Pattern.compile(aa);
		Matcher m1 = b.matcher(rs.getString("hreflink"));
		if(m1.find()){
		flag=true;
		break;
		}
      }
      db.close();
    } catch(Exception e) {
      e.printStackTrace();
      db.close();
      return flag;
    }
    return flag;
  }
}