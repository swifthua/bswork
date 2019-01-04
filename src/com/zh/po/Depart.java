package com.zh.po;

import java.util.Date;

public class Depart {
	private String bmdm;
	private String bmmc;
	private Date lastUpdate;
	private int sfjy;
	public String getBmdm() {
		return bmdm;
	}
	public void setBmdm(String bmdm) {
		this.bmdm = bmdm;
	}
	public String getBmmc() {
		return bmmc;
	}
	public void setBmmc(String bmmc) {
		this.bmmc = bmmc;
	}
	public Date getLastUpdate() {
		return lastUpdate;
	}
	public void setLastUpdate(Date lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	public int getSfjy() {
		return sfjy;
	}
	public void setSfjy(int sfjy) {
		this.sfjy = sfjy;
	}
	@Override
	public String toString() {
		return "Depart [bmdm=" + bmdm +  ", bmmc=" + bmmc
				+ ", lastUpdate=" + lastUpdate + ", sfjy=" + sfjy + "]";
	}

	public String toJsonString(){
		StringBuilder sb=new StringBuilder();
		sb.append("{\"code\":\"").append(this.bmdm).append("\",");
		sb.append("\"name\":\"").append(this.bmmc.trim()).append("\"");
		sb.append("}");
		return sb.toString();
	}
}
