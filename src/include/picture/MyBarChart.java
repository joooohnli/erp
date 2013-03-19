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

import org.jfree.data.*;
import org.jfree.chart.*;
import org.jfree.chart.plot.*;
import org.jfree.chart.renderer.BarRenderer3D;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import java.awt.Color;
import java.awt.Font;
/**
*条形图
*/
public class MyBarChart {

  private String title=null;//图表的标题
  private String axisXLabel=null;//目录轴的显示标签
  private String axisYLabel=null;//数值轴的显示标签
  private int width=400;//图片宽度
  private int height=300;//图片长度
  private String fileName=null;//生成图片的名称
  private double[][] data=null;//需要的数据
  private String[] category=null;//分类信息
  private String[] series=null;//序列信息

  public MyBarChart() {

  }
/**
*产生条形图的方法
*/
  public void paint(){
    try {
      check();
      CategoryDataset dataset = getDataSet(series,category,data);
      JFreeChart chart =
	ChartFactory.createBarChart3D(title,axisXLabel,axisYLabel,
				      dataset,
				      PlotOrientation.VERTICAL,
				      true,false,false);
      chart.setBackgroundPaint(Color.WHITE);
      BarRenderer3D renderer=new BarRenderer3D();
      CategoryPlot plot = chart.getCategoryPlot();
      renderer.setMaxBarWidth(0.01);
      renderer.setBaseOutlinePaint(Color.BLACK);
      renderer.setItemLabelGenerator(new StandardCategoryItemLabelGenerator());
      renderer.setItemLabelFont(new Font("黑体",Font.PLAIN,15));
      renderer.setItemLabelsVisible(true);
      renderer.setItemMargin(0.1);
      plot.setRenderer(renderer);
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
    } // end of try-catch

  }
/**
*检查条形表的所有信息，如任意信息为空，都抛出异常
*/
  private void check() throws Exception{
    if (title==null||axisXLabel==null||
        axisYLabel==null||fileName==null||
	data==null||category==null||
	series==null) {
      throw new Exception ("Some message should be assigned.");
    } // end of if ()

  }

  public String getTitle()  {
    return this.title;
  }

  public void setTitle(String argTitle) {
    this.title = argTitle;
  }

  public String getAxisXLabel()  {
    return this.axisXLabel;
  }

  public void setAxisXLabel(String argAxisXLabel) {
    this.axisXLabel = argAxisXLabel;
  }

  public String getAxisYLabel()  {
    return this.axisYLabel;
  }

  public void setAxisYLabel(String argAxisYLabel) {
    this.axisYLabel = argAxisYLabel;
  }

  public int getWidth()  {
    return this.width;
  }

  public void setWidth(int argWidth) {
    this.width = argWidth;
  }

  public int getHeight()  {
    return this.height;
  }

  public void setHeight(int argHeight) {
    this.height = argHeight;
  }

  public double[][] getData()  {
    return this.data;
  }

  public void setData(double[][] argData) {
    this.data = argData;
  }

  public String[] getCategory()  {
    return this.category;
  }

  public void setCategory(String[] argCategory) {
    this.category = argCategory;
  }

  public String[] getSeries()  {
    return this.series;
  }

  public void setSeries(String[] argSeries) {
    this.series = argSeries;
  }

  public String getFileName(){
    return this.fileName;
  }

  public void setFileName(String fileName){
    this.fileName=fileName;
  }
/**
*是paint的辅助方法，series,category,data 组合出不同结果的条形表
*/
  private CategoryDataset getDataSet(String[] series,
				     String[] category,
				     double[][]data){
    return DatasetUtilities.createCategoryDataset(series, category, data);
  }


  public static void main(String[] args) throws IOException{

/**
*示例
*/
    double[][] data = new double[][]
      {{10.0, 4.0, 15.0, 14.0},
       {5.0, 7.0, 14.0, 3.0},
       {6.0, 17.0, 12.0, 7.0},
       {7.0, 15.0, 11.0, 0.0},
       {8.0, 6.0, 10.0, 9.0},
       {9.0, 8.0, 0.0, 6.0},
       {10.0, 9.0, 7.0, 7.0},
       {11.0, 13.0, 9.0, 9.0},
       {3.0, 7.0, 11.0, 10.0}};
    String[] series=new String[]{"一月","二月","三月",
				 "四月","五月","六月","七月","八月","九月"};
    String[] category=new String[]{"风","雨","雷","电"};
    MyBarChart bar=new MyBarChart();
    bar.setTitle("太阳神");
    bar.setAxisXLabel("神力");
    bar.setAxisYLabel("产量");
    bar.setFileName("fruit.jpg");
    bar.setWidth(400);
    bar.setHeight(300);
    bar.setData(data);
    bar.setSeries(series);
    bar.setCategory(category);

    bar.paint();
  }

}
