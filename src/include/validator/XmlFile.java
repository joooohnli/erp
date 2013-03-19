/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.validator;

import java.io.*;
import org.jdom.*;
import org.jdom.input.SAXBuilder;
/**
 * XmlFile.java
 *
 *
 * Created: Sun Sep 26 11:09:19 2004
 *
 * @author <a href="mailto:Administrator@ORK"></a>
 * @version 1.0
 */
public class XmlFile {

  protected Element root=null;

  public XmlFile(String file) {
    try {
      ClassLoader loader=this.getClass().getClassLoader();
      InputStream stream=loader.getResourceAsStream(file);
      SAXBuilder builder=new SAXBuilder("org.apache.xerces.parsers.SAXParser");
      Document doc=builder.build(stream);
      root=doc.getRootElement();
    } catch(Exception je) {
      je.printStackTrace();
    }    
  } // XmlFile constructor
  
} // XmlFile
