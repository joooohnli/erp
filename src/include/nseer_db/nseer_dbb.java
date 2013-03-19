/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_db;

import java.io.*;
import java.sql.*;
import java.util.Properties;

public class nseer_dbb
{
    private Connection a;
    private Statement statement;
    private String drivername;
    private String database;
    private String url1;
    private String url2;

    public nseer_dbb(String file,String file1,String s)
    {
        getProperty(file,file1);
        database = s;
        String s1 = url1 + s + "?" + url2;
        String s2 = drivername;
        try
        {
            Class.forName(s2);
        }
        catch(ClassNotFoundException classnotfoundexception)
        {
            classnotfoundexception.printStackTrace();
        }
        try
        {
            a = DriverManager.getConnection(s1);
            statement = a.createStatement();
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
        }
    }

    public void close()
    {
        try
        {
            statement.close();
            a.close();
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
        }
    }

    public ResultSet executeQuery(String s)
    {
        ResultSet resultset = null;
        try
        {
            resultset = statement.executeQuery(s);
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
        }
        return resultset;
    }

    public void executeUpdate(String s)
    {
        try
        {
            statement.executeUpdate(s);
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
        }
    }

    public String getTable()
    {
        return database;
    }

    public void getProperty(String file,String file1)
    {
        Properties properties = new Properties();
		Properties properties1 = new Properties();
        try
        {
            InputStream inputstream = getClass().getClassLoader().getResourceAsStream("/conf/"+file);
			InputStream inputstream1 = getClass().getClassLoader().getResourceAsStream("/conf/"+file1);
            properties.load(inputstream);
			properties1.load(inputstream1);
            if(inputstream != null)
                inputstream.close();
				inputstream1.close();
        }
        catch(IOException ex)
        {
            System.err.println("Open Propety File Error");
        }
        drivername = properties.getProperty("DRIVER");
        url1 = properties.getProperty("URL1")+properties1.getProperty("IP")+":3306/";
        url2 = properties.getProperty("URL2");
    }

    public void setTable(String s)
    {
        database = s;
    }
}
