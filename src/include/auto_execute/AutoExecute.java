/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.auto_execute;

import java.lang.reflect.Method;
import java.lang.reflect.*;
import java.util.*;
/**
 * AutoExecute.java
 *
 *
 * Created: Wed Sep 01 13:57:16 2004
 *
 * @author <a href="mailto:Administrator@ORK"></a>
 * @version 1.0
 */
public class AutoExecute extends TimerTask {
  
  private ConfigReader reader=null;

  public AutoExecute() {
    reader=new ConfigReader();    
  } // AutoExecute constructor
  
  public void run() {
    String[] classNames=reader.getClassNames();
    for (int i=0;i<classNames.length;i++) {
      try {
      Class mclass=Class.forName(classNames[i]);//class类是用于处理一般类的属性信息
      Object obj=mclass.newInstance();//根据一个类的引用，实例化一个对象
      String methodName=reader.getMethod(classNames[i]);
      Method method=mclass.getMethod(methodName,new Class[0]);//根据类的引用和方法名称得到一个方法对象，new Class[0]是个参数
      method.invoke(obj,null);//执行这个方法，必须有下列的抛出异常
      } catch (ClassNotFoundException cnfe) {
	cnfe.printStackTrace();
      } catch (InstantiationException ie) {
	ie.printStackTrace();
      } catch (NoSuchMethodException nsme) {
	nsme.printStackTrace();
      } catch (IllegalAccessException ile) {
	ile.printStackTrace();
      } catch (InvocationTargetException ive) {
	ive.printStackTrace();
      } // end of catch
      
    } // end of for ()    
  }

  public static void main(String[] args) {
    new AutoExecute().run();
  } // end of main()
  

} // AutoExecute
