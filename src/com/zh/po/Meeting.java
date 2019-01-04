package com.zh.po;

import java.util.Date;

public class Meeting {
	private int hyid;
	private User hyfqr;
	private Date hysj; //会议时间
	private Date djsj; //登记时间
	private String hydz;
	private String hybt;
	private String hynr;
	private String remark;
	private int sfjy;
	public int getHyid() {
		return hyid;
	}
	public void setHyid(int hyid) {
		this.hyid = hyid;
	}
	public User getHyfqr() {
		return hyfqr;
	}
	public void setHyfqr(User hyfqr) {
		this.hyfqr = hyfqr;
	}
	public Date getHysj() {
		return hysj;
	}
	public void setHysj(Date hysj) {
		this.hysj = hysj;
	}
	public String getHydz() {
		return hydz;
	}
	public void setHydz(String hydz) {
		this.hydz = hydz;
	}
	public String getHybt() {
		return hybt;
	}
	public void setHybt(String hybt) {
		this.hybt = hybt;
	}
	public String getHynr() {
		return hynr;
	}
	public void setHynr(String hynr) {
		this.hynr = hynr;
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
	
	public Date getDjsj() {
		return djsj;
	}
	public void setDjsj(Date djsj) {
		this.djsj = djsj;
	}
	@Override
	public String toString() {
		return "Meeting [hyid=" + hyid + ", hyfqr=" + hyfqr + ", hysj=" + hysj
				+ ", djsj=" + djsj + ", hydz=" + hydz + ", hybt=" + hybt
				+ ", hynr=" + hynr + ", remark=" + remark + ", sfjy=" + sfjy
				+ "]";
	}

	
}
