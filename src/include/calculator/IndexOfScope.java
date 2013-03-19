/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.calculator;
import java.util.Iterator;
import java.util.List;
import java.sql.*;
import include.nseer_db.*;

public class IndexOfScope{
	
	private static boolean value;

	public static boolean indexOfScope(int value1,String value2){

try{
		int scope_value1=Integer.parseInt(value2.split("⊙")[0]);
		int scope_value2=Integer.parseInt(value2.split("⊙")[1]);

        if(value1<scope_value1||value1>scope_value2){
		
		value=false;
		}else{
		
		value=true;
		
		}
}catch(Exception ex){ex.printStackTrace();}

return value;


		}




	
}	
