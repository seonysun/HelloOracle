package com.sist.dao;
import java.util.*;

public class OrdersVO {
	private int orderid,custid,bookid,saleprice;
	private Date orderDate;
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public int getCustid() {
		return custid;
	}
	public void setCustid(int custid) {
		this.custid = custid;
	}
	public int getBookid() {
		return bookid;
	}
	public void setBookid(int bookid) {
		this.bookid = bookid;
	}
	public int getSaleprice() {
		return saleprice;
	}
	public void setSaleprice(int saleprice) {
		this.saleprice = saleprice;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
}
