package include.nseer_cookie;

import include.nseer_db.nseer_db;

import java.io.FileNotFoundException;
import java.io.RandomAccessFile;
import java.sql.ResultSet;
import java.text.*;
import java.util.*;
import javax.servlet.ServletContext;
import javax.servlet.http.*;


public class MathString {
	
	public String mathHrefCols(String str){//*****************************************************
	String col="";
	try{
		String[] str_array=str.split("◎");
	    for(int i=0;i<str_array.length;){
		col=str_array[1];		
		//i=i+2;
	    }

		}catch(Exception ex){ex.printStackTrace();}
	
	return  col;
	}


	public static List mathHref(String str){//*****************************************************

    List list=(List)new ArrayList();

	String col_html="";

try{
String[] str_array1=str.split("⊙⊙⊙");

String[] str_array=str.split("⊙⊙⊙");

for(int i=1;i<str_array.length;i++){
        
str_array1[i]="★★★";
	    	
	    	
list.add(str_array[i]);

i=i+1;
		
}

for(int i=0;i<str_array1.length;i++){

		col_html+=str_array1[i];
	
	}

list.add(col_html);


		}catch(Exception ex){ex.printStackTrace();}
	
	return  list;
	}




public static String replaceHrefStr(List new_str,String str){//*****************************************************

String col_html="";

try{
int u=0;
String[] str_array=str.split("★★★");


for(int i=0;i<str_array.length;i++){

col_html+=str_array[i]+(String)new_str.get(i);
	
}



}catch(Exception ex){ex.printStackTrace();}
	
return  col_html;
}

public static int getCount(String dbase){
	int pre_control=0;
	try{	
	nseer_db erp_db = new nseer_db(dbase);
	String sql = "select type_name from erpplatform_config_public_char where kind='nseer_define'";
	ResultSet rs = erp_db.executeQuery(sql) ;
	if(rs.next()){
		pre_control=Integer.parseInt(rs.getString("type_name").substring(0,2))-2;
	}
	erp_db.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	return pre_control;
}

	 public static void main(String[] args) throws Exception{
     MathString dd=new MathString();
	 System.out.println(dd.mathHref("◎product_name◎a.jsp?src=⊙⊙⊙human_id⊙⊙⊙&&page=⊙⊙⊙id⊙⊙⊙&&rst=⊙⊙⊙kind⊙⊙⊙"));
}
}
