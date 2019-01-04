package com.zh.po;

import java.util.Date;

public class Notify {
	private int ggid;
	private String ggbt;
	private String ggnr;
	private Date fqsj;
	private User fqr;
	private Date lastUpdate;
	private int sfjy;
	public int getGgid() {
		return ggid;
	}
	public void setGgid(int ggid) {
		this.ggid = ggid;
	}
	public String getGgbt() {
		return ggbt;
	}
	public void setGgbt(String ggbt) {
		this.ggbt = ggbt;
	}
	public String getGgnr() {
		return ggnr;
	}
	public void setGgnr(String ggnr) {
		this.ggnr = ggnr;
	}
	public Date getFqsj() {
		return fqsj;
	}
	public void setFqsj(Date fqsj) {
		this.fqsj = fqsj;
	}
	public User getFqr() {
		return fqr;
	}
	public void setFqr(User fqr) {
		this.fqr = fqr;
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
		return "Notify [ggid=" + ggid + ", ggbt=" + ggbt + ", ggnr=" + ggnr
				+ ", fqsj=" + fqsj + ", fqr=" + fqr + ", lastUpdate="
				+ lastUpdate + ", sfjy=" + sfjy + "]";
	}

	
}
