package com.zh.po;

import java.util.Date;

public class Journal {
	private int rzid;
	private User djr;
	private String rznr;
	private Date rzsj;
	private Date djsj;
	private int sfjy;
	private Depart bmdm;
	private String duration;
	public int getRzid() {
		return rzid;
	}
	public void setRzid(int rzid) {
		this.rzid = rzid;
	}
	public User getDjr() {
		return djr;
	}
	public void setDjr(User djr) {
		this.djr = djr;
	}
	public String getRznr() {
		return rznr;
	}
	public void setRznr(String rznr) {
		this.rznr = rznr;
	}
	public Date getRzsj() {
		return rzsj;
	}
	public void setRzsj(Date rzsj) {
		this.rzsj = rzsj;
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
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	@Override
	public String toString() {
		return "Journal [rzid=" + rzid + ", djr=" + djr + ", rznr=" + rznr
				+ ", rzsj=" + rzsj + ", djsj=" + djsj + ", sfjy=" + sfjy
				+ ", bmdm=" + bmdm + ", duration=" + duration + "]";
	}
	
}
