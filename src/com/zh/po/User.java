package com.zh.po;

import java.util.Date;

public class User {
	private String yhdm; //用户代码
	private String yhzh; //用户账号
	private String yhkl; //用户口令
	private String yhxm; //用户姓名
	private Date csrq;   //出生日期
	private Depart bmdm; //部门代码
	private String yhxb; //用户性别
	private Position zwdm; //职位代码
	private String address; //地址
	private String phone; //电话
	private String email; //email
	private String remark; //说明
	private int sfjy; //是否禁用,1表示禁用
	public String getYhdm() {
		return yhdm;
	}
	public void setYhdm(String yhdm) {
		this.yhdm = yhdm;
	}
	public String getYhzh() {
		return yhzh;
	}
	public void setYhzh(String yhzh) {
		this.yhzh = yhzh;
	}
	public String getYhkl() {
		return yhkl;
	}
	public void setYhkl(String yhkl) {
		this.yhkl = yhkl;
	}
	public String getYhxm() {
		return yhxm;
	}
	public void setYhxm(String yhxm) {
		this.yhxm = yhxm;
	}
	public Date getCsrq() {
		return csrq;
	}
	public void setCsrq(Date csrq) {
		this.csrq = csrq;
	}
	public Depart getBmdm() {
		return bmdm;
	}
	public void setBmdm(Depart bmdm) {
		this.bmdm = bmdm;
	}
	public String getYhxb() {
		return yhxb;
	}
	public void setYhxb(String yhxb) {
		this.yhxb = yhxb;
	}
	public Position getZwdm() {
		return zwdm;
	}
	public void setZwdm(Position zwdm) {
		this.zwdm = zwdm;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
		return "User [yhdm=" + yhdm + ", yhzh=" + yhzh + ", yhkl=" + yhkl
				+ ", yhxm=" + yhxm + ", csrq=" + csrq + ", bmdm=" + bmdm
				+ ", yhxb=" + yhxb + ", zwdm=" + zwdm + ", address=" + address
				+ ", phone=" + phone + ", email=" + email + ", remark="
				+ remark + ", sfjy=" + sfjy + "]";
	}
	public Object toJsonString() {
		StringBuilder sb=new StringBuilder();
		sb.append("{\"code\":\"").append(this.yhdm).append("\",");
		sb.append("\"name\":\"").append(this.yhxm.trim()).append("\"");
		sb.append("}");
		return sb.toString();
	}
	
	
}
