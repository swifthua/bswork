package com.zh.po;

import java.util.Date;

public class Arrange {
	private int jhid;
	private String jhlx;
	private User apr;
	private User fzr;
	private String jhnr;
	private Project xmdm;
	private Date jhStart;
	private Date jhStop;
	private Date djsj;
	private int sfjy;
	private Depart bmdm;
	public int getJhid() {
		return jhid;
	}
	public void setJhid(int jhid) {
		this.jhid = jhid;
	}
	public String getJhlx() {
		return jhlx;
	}
	public void setJhlx(String jhlx) {
		this.jhlx = jhlx;
	}
	public User getApr() {
		return apr;
	}
	public void setApr(User apr) {
		this.apr = apr;
	}
	public User getFzr() {
		return fzr;
	}
	public void setFzr(User fzr) {
		this.fzr = fzr;
	}
	public String getJhnr() {
		return jhnr;
	}
	public void setJhnr(String jhnr) {
		this.jhnr = jhnr;
	}
	public Project getXmdm() {
		return xmdm;
	}
	public void setXmdm(Project xmdm) {
		this.xmdm = xmdm;
	}
	public Date getJhStart() {
		return jhStart;
	}
	public void setJhStart(Date jhStart) {
		this.jhStart = jhStart;
	}
	public Date getJhStop() {
		return jhStop;
	}
	public void setJhStop(Date jhStop) {
		this.jhStop = jhStop;
	}
	public Date getDjsj() {
		return djsj;
	}
	public void setDjsj(Date djsj) {
		this.djsj = djsj;
	}
	public int getSfjy() {
		return sfjy;
	}
	public void setSfjy(int sfjy) {
		this.sfjy = sfjy;
	}
	
	public Depart getBmdm() {
		return bmdm;
	}
	public void setBmdm(Depart bmdm) {
		this.bmdm = bmdm;
	}
	@Override
	public String toString() {
		return "Arrange [jhid=" + jhid + ", jhlx=" + jhlx + ", apr=" + apr
				+ ", fzr=" + fzr + ", jhnr=" + jhnr + ", xmdm=" + xmdm
				+ ", jhStart=" + jhStart + ", jhStop=" + jhStop + ", djsj="
				+ djsj + ", sfjy=" + sfjy + ", bmdm=" + bmdm + "]";
	}
	
	
}
