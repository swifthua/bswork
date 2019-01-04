package com.zh.po;

public class Status {
	private String ztid;
	private String ztms;
	private int sfjy;
	public String getZtid() {
		return ztid;
	}
	public void setZtid(String ztid) {
		this.ztid = ztid;
	}
	public String getZtms() {
		return ztms;
	}
	public void setZtms(String ztms) {
		this.ztms = ztms;
	}
	public int getSfjy() {
		return sfjy;
	}
	public void setSfjy(int sfjy) {
		this.sfjy = sfjy;
	}
	public Object toJsonString() {
		StringBuilder sb=new StringBuilder();
		sb.append("{\"code\":\"").append(this.ztid).append("\",");
		sb.append("\"name\":\"").append(this.ztms.trim()).append("\"");
		sb.append("}");
		return sb.toString();
	}
	
}
