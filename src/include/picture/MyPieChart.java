/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.picture;

import java.io.*;
import java.awt.Color;
import org.jfree.data.*;
import org.jfree.chart.*;
//import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.*;
/**
 * 用于演示饼图的生成
 * @author Winter Lau
 */
public class MyPieChart {

  private String title;// 图表标题
  private String fileName;
  private int width=400;//图片宽度
  private int height=300;//图片高度
  private String[] item;//分块的名称
  private double[] quantity;//分额

  public String getFileName() {
    return fileName;
  }

  public void setFileName(String newFileName) {
    this.fileName = newFileName;
  }

  
  public int getWidth() {
    return width;
  }

  public void setWidth(int newWidth) {
    this.width = newWidth;
  }

  public int getHeight() {
    return height;
  }

  public void setHeight(int newHeight) {
    this.height = newHeight;
  }
 
  
  public String getTitle()  {
    return this.title;
  }

  public void setTitle(String argTitle) {
    this.title = argTitle;
  }

  public String[] getItem()  {
    return this.item;
  }

  public void setItem(String[] argItem) {
    this.item = argItem;
  }

  public double[] getQuantity()  {
    return this.quantity;
  }

  public void setQuantity(double[] argQuantity) {
    this.quantity = argQuantity;
  }
  public void setbarwidth(double percent){
  		
  	}
/**
*构造函数
*/
  public MyPieChart(){
  }

  public void paint() {
    try {
      check();      
      DefaultPieDataset dataset = getDataSet(item,quantity);
      JFreeChart chart = 
	  ChartFactory.createPie3DChart(title,  
				      dataset, 
				      true, // 是否显示图例
				      false,
				      false
				      ); 
      chart.setBackgroundPaint(Color.WHITE);
	  Pie3DPlot plot = (Pie3DPlot)chart.getPlot();
      plot.setSectionLabelType(PiePlot.PERCENT_LABELS);
      plot.setPercentFormatString("#,###0.00%");
      //用Pie3DPlot的setDepthFactor 来设置饼的宽度
      plot.setDepthFactor(0.05);
      FileOutputStream fos_jpg = null;
      try {
	fos_jpg = new FileOutputStream(fileName);
	ChartUtilities.writeChartAsJPEG(fos_jpg,1000,chart,width,height,null);
      } finally {
	try {
	  fos_jpg.close();
	} catch (Exception e) {} 
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  private void check() throws Exception {
    if (title==null||fileName==null||
	item==null||quantity==null) {
      throw new Exception("some message should be designed!");
    } else if(item.length!=quantity.length) {
      throw new Exception("length of item not equals length of quantity");
    } // end of else
    
  }

  private  DefaultPieDataset getDataSet(String[] name,double[] quantiy) {
    DefaultPieDataset dataset = new DefaultPieDataset();
    for (int i=0;i<name.length;i++) {
      dataset.setValue(name[i],quantiy[i]);
    }
    return dataset;
  }
/**
*示例
*/
  public static void main(String[] args) {
    MyPieChart pie=new MyPieChart();
    pie.setTitle("飞得更高");
    pie.setFileName("fly.jpg");
    pie.setWidth(600);
    pie.setHeight(400);
    String[] item=new String[]{"1","2","3"};
    double[] quantity=new double[]{100,200,300};
    pie.setItem(item);
    pie.setQuantity(quantity);
    pie.paint();
  } // end of main()
}
