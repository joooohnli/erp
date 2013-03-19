/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance;

import java.sql.*;
import java.util.*;
import include.nseer_db.nseer_db;

public class Sum {
	//查询条件信息
	private int count=0;
	private int real_count=0;
	private int[] result=new int[1];
	private String[] file_id=new String[1];
	private int[] parent_category_id=new int[1];
	private int[] category_id=new int[1];
	private String[] details_tag=new String[1];
	private String[] file_name=new String[1];
	private double[] debit_sum=new double[1];
	private double[] loan_sum=new double[1];
	private int[] debit_count=new int[1];
	private int[] loan_count=new int[1];
	private double[] current_balance_sum=new double[1];
	private double[] last_balance_sum=new double[1];
	private double debit_sum_all=0.0d;
	private double loan_sum_all=0.0d;
	private double current_balance_sum_all=0.0d;
	private double last_balance_sum_all=0.0d;
	private int debit_count_all=0;
	private int loan_count_all=0;

	public void calculate(nseer_db finance_db,String timea) {
		try{
String sql="select category_id from finance_config_file_kind where file_ID like '1001%' or bank_tag='1' order by category_id desc";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){
	count=rs.getInt("category_id")+1;
}
result=new int[count];
file_id=new String[count];
parent_category_id=new int[count];
category_id=new int[count];
details_tag=new String[count];
file_name=new String[count];
debit_sum=new double[count];
loan_sum=new double[count];
debit_count=new int[count];
loan_count=new int[count];
current_balance_sum=new double[count];
last_balance_sum=new double[count];
sql="select file_id,file_name,parent_category_id,category_id,details_tag from finance_config_file_kind where file_ID like '1001%' or bank_tag='1' order by file_ID";
rs=finance_db.executeQuery(sql);
while(rs.next()){
	file_id[rs.getInt("category_id")]=rs.getString("file_id");
	file_name[rs.getInt("category_id")]=rs.getString("file_name");
	parent_category_id[rs.getInt("category_id")]=rs.getInt("parent_category_id");
	category_id[rs.getInt("category_id")]=rs.getInt("category_id");
	details_tag[rs.getInt("category_id")]=rs.getString("details_tag");
	result[real_count]=rs.getInt("category_id");
	real_count++;
}
String account_period="";
sql="select account_period from finance_account_period where start_time<='"+timea+"' and end_time>='"+timea+"'";
rs=finance_db.executeQuery(sql);
if(rs.next()){
	account_period=rs.getString("account_period");
}
for(int j=0;j<count;j++){
	if(details_tag[j]!=null){
	sql="select last_year_balance_sum from finance_gl where account_period='"+account_period+"' and file_id='"+file_id[j]+"'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		last_balance_sum[j]=rs.getDouble("last_year_balance_sum");
	}else{
		last_balance_sum[j]=0;
	}
	}
}
double debit_loan=0.0d;
for(int j=0;j<count;j++){
	if(details_tag[j]!=null&&details_tag[j].equals("0")){
		debit_loan=0.0d;
	sql="select debit_subtotal,loan_subtotal from finance_voucher where chain_ID='"+file_id[j]+"' and check_tag='1' and account_tag='1' and register_time<'"+timea+"' and account_period='"+account_period+"' order by register_time,voucher_in_month_ID";
	rs=finance_db.executeQuery(sql);
	while(rs.next()){

		last_balance_sum[j]=last_balance_sum[j]+rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
		debit_loan=debit_loan+rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
	}
		last_balance_sum_all+=last_balance_sum[j];
		current_balance_sum[j]=last_balance_sum[j];
		setParentLastBalance(parent_category_id[j],debit_loan);
	}
}
for(int j=0;j<count;j++){
	if(details_tag[j]!=null&&details_tag[j].equals("0")){
	sql="select * from finance_voucher where chain_ID='"+file_id[j]+"' and check_tag='1' and account_tag='1' and register_time='"+timea+"' order by voucher_in_month_ID";
	rs=finance_db.executeQuery(sql);
	while(rs.next()){
		debit_sum[j]+=rs.getDouble("debit_subtotal");
		loan_sum[j]+=rs.getDouble("loan_subtotal");
		if(rs.getDouble("debit_subtotal")!=0){
			debit_count[j]++;
		}else{
			loan_count[j]++;
		}
	}		
		current_balance_sum[j]=current_balance_sum[j]+debit_sum[j]-loan_sum[j];
		setParentBalance(parent_category_id[j],debit_sum[j]-loan_sum[j]);
		setParentDebit(parent_category_id[j],debit_sum[j]);
		setParentLoan(parent_category_id[j],loan_sum[j]);
		setParentDebitCount(parent_category_id[j],debit_count[j]);
		setParentLoanCount(parent_category_id[j],loan_count[j]);
		current_balance_sum_all+=current_balance_sum[j];
		debit_sum_all+=debit_sum[j];
		loan_sum_all+=loan_sum[j];
		debit_count_all+=debit_count[j];
		loan_count_all+=loan_count[j];
	}
}
	}catch(Exception ex){ex.printStackTrace();}
	}

	public void setParentLastBalance(int parent,double value){
		last_balance_sum[parent]+=value;
		current_balance_sum[parent]=last_balance_sum[parent];
		if(parent_category_id[parent]!=0){
			setParentLastBalance(parent_category_id[parent],value);
		}
	}

	public void setParentBalance(int parent,double value){
		current_balance_sum[parent]+=value;
		if(parent_category_id[parent]!=0){
			setParentBalance(parent_category_id[parent],value);
		}
	}

	public void setParentDebit(int parent,double value){
		debit_sum[parent]+=value;
		if(parent_category_id[parent]!=0){
			setParentDebit(parent_category_id[parent],value);
		}
	}

	public void setParentLoan(int parent,double value){
		loan_sum[parent]+=value;
		if(parent_category_id[parent]!=0){
			setParentLoan(parent_category_id[parent],value);
		}
	}

	public void setParentDebitCount(int parent,int value){
		debit_count[parent]+=value;
		if(parent_category_id[parent]!=0){
			setParentDebitCount(parent_category_id[parent],value);
		}
	}

	public void setParentLoanCount(int parent,int value){
		loan_count[parent]+=value;
		if(parent_category_id[parent]!=0){
			setParentLoanCount(parent_category_id[parent],value);
		}
	}

	public int[] getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int[] category_id) {
		this.category_id = category_id;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public double[] getCurrent_balance_sum() {
		return current_balance_sum;
	}

	public void setCurrent_balance_sum(double[] current_balance_sum) {
		this.current_balance_sum = current_balance_sum;
	}

	public double getCurrent_balance_sum_all() {
		return current_balance_sum_all;
	}

	public void setCurrent_balance_sum_all(double current_balance_sum_all) {
		this.current_balance_sum_all = current_balance_sum_all;
	}

	public int[] getDebit_count() {
		return debit_count;
	}

	public void setDebit_count(int[] debit_count) {
		this.debit_count = debit_count;
	}

	public int getDebit_count_all() {
		return debit_count_all;
	}

	public void setDebit_count_all(int debit_count_all) {
		this.debit_count_all = debit_count_all;
	}

	public double[] getDebit_sum() {
		return debit_sum;
	}

	public void setDebit_sum(double[] debit_sum) {
		this.debit_sum = debit_sum;
	}

	public double getDebit_sum_all() {
		return debit_sum_all;
	}

	public void setDebit_sum_all(double debit_sum_all) {
		this.debit_sum_all = debit_sum_all;
	}

	public String[] getDetails_tag() {
		return details_tag;
	}

	public void setDetails_tag(String[] details_tag) {
		this.details_tag = details_tag;
	}

	public String[] getFile_id() {
		return file_id;
	}

	public void setFile_id(String[] file_id) {
		this.file_id = file_id;
	}

	public String[] getFile_name() {
		return file_name;
	}

	public void setFile_name(String[] file_name) {
		this.file_name = file_name;
	}

	public double[] getLast_balance_sum() {
		return last_balance_sum;
	}

	public void setLast_balance_sum(double[] last_balance_sum) {
		this.last_balance_sum = last_balance_sum;
	}

	public double getLast_balance_sum_all() {
		return last_balance_sum_all;
	}

	public void setLast_balance_sum_all(double last_balance_sum_all) {
		this.last_balance_sum_all = last_balance_sum_all;
	}

	public int[] getLoan_count() {
		return loan_count;
	}

	public void setLoan_count(int[] loan_count) {
		this.loan_count = loan_count;
	}

	public int getLoan_count_all() {
		return loan_count_all;
	}

	public void setLoan_count_all(int loan_count_all) {
		this.loan_count_all = loan_count_all;
	}

	public double[] getLoan_sum() {
		return loan_sum;
	}

	public void setLoan_sum(double[] loan_sum) {
		this.loan_sum = loan_sum;
	}

	public double getLoan_sum_all() {
		return loan_sum_all;
	}

	public void setLoan_sum_all(double loan_sum_all) {
		this.loan_sum_all = loan_sum_all;
	}

	public int[] getParent_category_id() {
		return parent_category_id;
	}

	public void setParent_category_id(int[] parent_category_id) {
		this.parent_category_id = parent_category_id;
	}

	public int getReal_count() {
		return real_count;
	}

	public void setReal_count(int real_count) {
		this.real_count = real_count;
	}

	public int[] getResult() {
		return result;
	}

	public void setResult(int[] result) {
		this.result = result;
	}
}