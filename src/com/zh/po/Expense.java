package com.zh.po;

import java.util.Date;

public class Expense {
	private int bxid;
	private Project xmdm;
	private Depart bmdm;
	private String bxfy;
	private String bxyt;
	private User bxr;
	private Date bxrq;
	private Status wczt;
	private String remark;
	private int sfjy;
	public int getBxid() {
		return bxid;
	}
	public void setBxid(int bxid) {
		this.bxid = bxid;
	}
	public Project getXmdm() {
		return xmdm;
	}
	public void setXmdm(Project xmdm) {
		this.xmdm = xmdm;
	}
	public Depart getBmdm() {
		return bmdm;
	}
	public void setBmdm(Depart bmdm) {
		this.bmdm = bmdm;
	}
	public String getBxfy() {
		return bxfy;
	}
	public void setBxfy(String bxfy) {
		this.bxfy = bxfy;
	}
	public String getBxyt() {
		return bxyt;
	}
	public void setBxyt(String bxyt) {
		this.bxyt = bxyt;
	}
	public User getBxr() {
		return bxr;
	}
	public void setBxr(User bxr) {
		this.bxr = bxr;
	}
	public Date getBxrq() {
		return bxrq;
	}
	public void setBxrq(Date bxrq) {
		this.bxrq = bxrq;
	}
	public Status getWczt() {
		return wczt;
	}
	public void setWczt(Status wczt) {
		this.wczt = wczt;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getSfjy() {
		return sfjy;
	}
	public void setSfjy(int sfjy) {
		this.sfjy = sfjy;
	}
	@Override
	public String toString() {
		return "Expense [bxid=" + bxid + ", xmdm=" + xmdm + ", bmdm=" + bmdm
				+ ", bxfy=" + bxfy + ", bxyt=" + bxyt + ", bxr=" + bxr
				+ ", bxrq=" + bxrq + ", wczt=" + wczt + ", remark=" + remark
				+ ", sfjy=" + sfjy + "]";
	}
	

	
}
