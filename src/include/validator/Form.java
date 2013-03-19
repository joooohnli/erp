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

public class Form {

  private String name;
  private List fields = new ArrayList();
  private HashMap hfields = new HashMap();

  public Form () {}

  public String getName()  {
    return this.name;
  }

  public void setName(String argName) {
    this.name = argName;
  }

  public List getFields() {
    return Collections.unmodifiableList(fields);
  }

  public void addField(Field f) {
    this.fields.add(f);
    this.hfields.put(f.getName(),f);
  }

  public boolean containsField(String fieldName) {
    return this.hfields.containsKey(fieldName);
  }

  public Field getField(String fieldName) {
    return (Field) this.hfields.get(fieldName);
  }

}
