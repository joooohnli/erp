<%/*this part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *这部分代码是恩信科技ERP软件的组成部分。
 *版权所有（C）2006-2010 北京恩信创业科技有限公司/http://www.nseer.com
 *
 *这一程序是自由软件，你可以遵照自由软件基金会出版的GNU通用公共许可
 *证条款来修改和重新发布这一程序。或者用许可证的第二版，或者（根据你的选
 *择）用任何更新的版本。
 *
 *发布这一程序的目的是希望它有用，但没有任何担保。甚至没有适合特定目
 *的的隐含的担保。更详细的情况请参阅GNU通用公共许可证。
 *你应该已经和程序一起收到一份GNU通用公共许可证的副本。如果还没有，
 *写信给：
 *The Free Software Foundation, Inc., 675 Mass Ave, Cambridge,
 *MA02139, USA*/
 %><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%><%
String search="";
nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String keyword=request.getParameter("keyword");
String table_name=request.getParameter("table_name");

String sql="select file_id,chain_name from "+table_name+" where file_id like '"+keyword+"%' or chain_name like '%"+keyword+"%' or nick_name like '"+keyword+"%'";
ResultSet rs=hr_db.executeQuery(sql);
while(rs.next()){
	search+=rs.getString("file_id")+" "+rs.getString("chain_name")+"\n";
}
search=!search.equals("")?search.substring(0,search.length()-1):"⊙";

out.print(search);
hr_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>