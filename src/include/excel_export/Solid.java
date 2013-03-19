// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Solid.java

/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.excel_export;

import java.io.*;
import java.util.*;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

public class Solid extends Path
{

    private ReaderHelper a;
    private String _fldfor;
    private SAXBuilder builder;
    private Document _fldint;
    private Element _flddo;
    private Element _fldif;

    public Solid()
    {
        a = null;
        _fldfor = null;
        builder = null;
        _fldint = null;
        _flddo = null;
        _fldif = null;
    }

    public Solid(String s)
    {
        a = null;
        _fldfor = null;
        builder = null;
        _fldint = null;
        _flddo = null;
        _fldif = null;
        a(s);
    }

    public void add(String s, String s1, String as[], String as1[])
    {
        Vector vector = a.getTableNames();
        if(vector == null)
            insert(s, s1, as, as1);
        else
        if(!vector.contains(s))
        {
            insert(s, s1, as, as1);
        } else
        {
            Element element = new Element("table");
            element.setAttribute("nick", s1);
            element.setAttribute("name", s);
            _flddo.addContent(element);
            Element element1 = new Element("columns");
            element.addContent(element1);
            for(int i = 0; i < as.length; i++)
            {
                Element element2 = new Element("column");
                Vector vector1 = a.getColumnNames(s1);
                if(vector1 == null || !vector1.contains(as[i]))
                {
                    element2.setAttribute("nick", as1[i]);
                    element2.setAttribute("name", as[i]);
                    element1.addContent(element2);
                }
            }

            a();
        }
    }

    private Element a(List list, String s)
    {
        if(s == null)
            return null;
        for(Iterator iterator = list.iterator(); iterator.hasNext();)
        {
            Element element = (Element)iterator.next();
            if(s.equals(element.getAttributeValue("name")))
                return element;
        }

        return null;
    }

    private void a(String s)
    {
        try
        {
            _fldfor = getPath() + "conf/" + s;
            builder = new SAXBuilder();
            _fldint = builder.build(new File(_fldfor));
            _fldif = _fldint.getRootElement();
            a = new ReaderHelper(_fldint);
            _flddo = _fldif.getChild("tables");
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
    }

    public void insert(String s, String s1, String as[], String as1[])
    {
        Element element = new Element("table");
        element.setAttribute("nick", s1);
        element.setAttribute("name", s);
        _flddo.addContent(element);
        Element element1 = new Element("columns");
        element.addContent(element1);
        for(int i = 0; i < as.length; i++)
        {
            Element element2 = new Element("column");
            element2.setAttribute("nick", as1[i]);
            element2.setAttribute("name", as[i]);
            element1.addContent(element2);
        }
        a();
    }

    private void a()
    {
        try
        {
        	Format format = Format.getCompactFormat();
        	format.setEncoding("UTF-8"); // 设置xml文件的字符为utf-8
        	format.setIndent("  "); // 设置xml文件的缩进为2个空格
        	XMLOutputter XMLOut = new XMLOutputter(format);// 元素后换行一层元素缩四格
        	XMLOut.output(_fldint, new FileOutputStream(_fldfor));
        	/*使用旧的jdom包前
        	 XMLOutputter xmloutputter = new XMLOutputter(format);
             FileWriter filewriter = new FileWriter(_fldfor);
             xmloutputter.output("", filewriter);
             xmloutputter.setTextTrim(true);
             xmloutputter.output(_fldint, filewriter);
             filewriter.close();
             */        	
        }
        catch(FileNotFoundException filenotfoundexception)
        {
            filenotfoundexception.printStackTrace();
        }
        catch(IOException ioexception)
        {
            ioexception.printStackTrace();
        }
    }

    public static void main(String args[])
    {
        Solid solid = new Solid("table.xml");
        String args1[] = {
            "first", "second"
        };
        String args2[] = {
            "441", "441"
        };
        solid.update("quit", "退出", args1, args2);
    }

    public void setFile(String s)
    {
        a(s);
    }

    public void update(String s, String s1, String as[], String as1[])
    {
        if(s != null)
        {
            _flddo.removeChildren("table");
            insert(s, s1, as, as1);
        } else
        {
            insert(s, s1, as, as1);
        }
    }

    public void update2(String s, String s1, String as[], String as1[])
    {
        Vector vector = a.getTableNames();
        if(vector != null && vector.contains(s))
        {
            Element element = a.getTable(s1);
            _flddo.removeContent(element);
            insert(s, s1, as, as1);
        } else
        {
            insert(s, s1, as, as1);
        }
    }
}
