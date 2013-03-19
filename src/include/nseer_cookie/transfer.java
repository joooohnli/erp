/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import java.sql.*;
import include.nseer_db.*;

public class transfer{


private String[] fieldA=new String[3];
private String[] fieldB=new String[3];
private String tableA="";
private String tableB="";

public void transfer(String main,String main1, String[] fieldA,String[] fieldB,String tableA,String tableB,String dbA,String dbB){
try{
nseer_db nseerA=new nseer_db(dbA);
nseer_db nseerB=new nseer_db(dbB);

String sql="select "+fieldA[0]+","+fieldA[1]+","+fieldA[2]+" from "+tableA+" order by id";
ResultSet rs=nseerA.executeQuery(sql);
String sql1="";
while(rs.next()){

String field1=rs.getString(fieldA[0]);
String field2=rs.getString(fieldA[1]);
String field3=rs.getString(fieldA[2]).substring(6);
int a=field3.indexOf("/");
field3=field3.substring(a+1);
a=field3.indexOf("/");
field3=field3.substring(0,a);

sql1="insert into  "+tableB+"("+fieldB[0]+","+fieldB[1]+","+fieldB[2]+") values ('"+field1+"','"+field2+"','"+field3+"')";
nseerB.executeQuery(sql1);
}



}catch(Exception ex){}


}
}