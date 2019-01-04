package com.zh.po;

import java.util.Date;

public class Leave {
	private int qjid;
	private User qjr;
	private Date qjStart;
	private Date qjStop;
	private Date djsj;
	private Status wczt;
	private Depart bmdm;
	private String remark;
	private int sfjy;
	public int getQjid() {
		return qjid;
	}
	public void setQjid(int qjid) {
		this.qjid = qjid;
	}
	public User getQjr() {
		return qjr;
	}
	public void setQjr(User qjr) {
		this.qjr = qjr;
	}
	public Date getQjStart() {
		return qjStart;
	}
	public void setQjStart(Date qjStart) {
		this.qjStart = qjStart;
	}
	public Date getQjStop() {
		return qjStop;
	}
	public void setQjStop(Date qjStop) {
		this.qjStop = qjStop;
	}
	public Date getDjsj() {
		return djsj;
	}
	public void setDjsj(Date djsj) {
		this.djsj = djsj;
	}
	public Status getWczt() {
		return wczt;
	}
	public void setWczt(Status wczt) {
		this.wczt = wczt;
	}
	public Depart getBmdm() {
		return bmdm;
	}
	public void setBmdm(Depart bmdm) {
		this.bmdm = bmdm;
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
		return "Leave [qjid=" + qjid + ", qjr=" + qjr + ", qjStart=" + qjStart
				+ ", qjStop=" + qjStop + ", djsj=" + djsj + ", wczt=" + wczt
				+ ", bmdm=" + bmdm + ", remark=" + remark + ", sfjy=" + sfjy
				+ "]";
	}

	
}
