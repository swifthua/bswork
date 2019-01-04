package com.zh.po;

public class Position {
	private String zwdm;
	private String zwmc;
	private int sfjy;
	public String getZwdm() {
		return zwdm;
	}
	public void setZwdm(String zwdm) {
		this.zwdm = zwdm;
	}
	public String getZwmc() {
		return zwmc;
	}
	public void setZwmc(String zwmc) {
		this.zwmc = zwmc;
	}
	public int getSfjy() {
		return sfjy;
	}
	public void setSfjy(int sfjy) {
		this.sfjy = sfjy;
	}
	@Override
	public String toString() {
		return "Position [zwdm=" + zwdm + ", zwmc=" + zwmc + ", sfjy=" + sfjy
				+ "]";
	}
	
	public String toJsonString(){
		StringBuilder sb=new StringBuilder();
		sb.append("{\"code\":\"").append(this.zwdm).append("\",");
		sb.append("\"name\":\"").append(this.zwmc.trim()).append("\"");
		sb.append("}");
		return sb.toString();
	}
}
