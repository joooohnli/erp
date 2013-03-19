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

import java.util.*;
import javax.servlet.http.*;

public class FormFactory {

  public FormFactory() {
    
  }

  public static Form createForm(HttpServletRequest request) {
    String formName=request.getParameter("validator.form");
    if (formName!=null) {
      Form form=new Form();
      form.setName(formName);
      Enumeration names=request.getParameterNames();
      int i=0;
      while (names.hasMoreElements()) {
	String name=(String)names.nextElement();
	String[] value=request.getParameterValues(name);
	if (!name.equals("validator.form")) {
	  Field field=new Field();
	  field.setName(name);
	  field.setValue(value);
	  form.addField(field);
	}
      } // end of for ()
      return form;
    }
    return null;
  }

}
