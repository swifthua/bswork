package com.zh.po;

import java.util.Date;

public class Examine {
	private int shid;
	private String type;
	private String shdm;
	private User shr1;
	private String shyj1;
	private Date shsj1;
	private User shr2;
	private String shyj2;
	private Date shsj2;
	private String remark;
	public int getShid() {
		return shid;
	}
	public void setShid(int shid) {
		this.shid = shid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getShdm() {
		return shdm;
	}
	public void setShdm(String shdm) {
		this.shdm = shdm;
	}
	public User getShr1() {
		return shr1;
	}
	public void setShr1(User shr1) {
		this.shr1 = shr1;
	}
	public String getShyj1() {
		return shyj1;
	}
	public void setShyj1(String shyj1) {
		this.shyj1 = shyj1;
	}
	public Date getShsj1() {
		return shsj1;
	}
	public void setShsj1(Date shsj1) {
		this.shsj1 = shsj1;
	}
	public User getShr2() {
		return shr2;
	}
	public void setShr2(User shr2) {
		this.shr2 = shr2;
	}
	public String getShyj2() {
		return shyj2;
	}
	public void setShyj2(String shyj2) {
		this.shyj2 = shyj2;
	}
	public Date getShsj2() {
		return shsj2;
	}
	public void setShsj2(Date shsj2) {
		this.shsj2 = shsj2;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Override
	public String toString() {
		return "Examine [shid=" + shid + ", type=" + type + ", shdm=" + shdm
				+ ", shr1=" + shr1 + ", shyj1=" + shyj1 + ", shsj1=" + shsj1
				+ ", shr2=" + shr2 + ", shyj2=" + shyj2 + ", shsj2=" + shsj2
				+ ", remark=" + remark + "]";
	}
	
}
