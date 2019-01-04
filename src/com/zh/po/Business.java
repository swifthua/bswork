package com.zh.po;

import java.util.Date;

public class Business {
	private int ccid;
	private Project xmdm;
	private String ccly;
	private User ccr;
	private String ccdz;
	private Depart bmdm;
	private Date ccStart;
	private Date ccStop;
	private Date xcStart;
	private Date xcStop;
	private Traffic xcgj;
	private String xcfy;
	private String zsfy;
	private String snjtfy;
	private String zfy;
	private Date djrq;
	private Status wczt;
	private String remark;
	private int sfjy;
	public int getCcid() {
		return ccid;
	}
	public void setCcid(int ccid) {
		this.ccid = ccid;
	}
	public Project getXmdm() {
		return xmdm;
	}
	public void setXmdm(Project xmdm) {
		this.xmdm = xmdm;
	}
	public String getCcly() {
		return ccly;
	}
	public void setCcly(String ccly) {
		this.ccly = ccly;
	}
	public User getCcr() {
		return ccr;
	}
	public void setCcr(User ccr) {
		this.ccr = ccr;
	}
	public String getCcdz() {
		return ccdz;
	}
	public void setCcdz(String ccdz) {
		this.ccdz = ccdz;
	}
	public Depart getBmdm() {
		return bmdm;
	}
	public void setBmdm(Depart bmdm) {
		this.bmdm = bmdm;
	}
	public Date getCcStart() {
		return ccStart;
	}
	public void setCcStart(Date ccStart) {
		this.ccStart = ccStart;
	}
	public Date getCcStop() {
		return ccStop;
	}
	public void setCcStop(Date ccStop) {
		this.ccStop = ccStop;
	}
	public Date getXcStart() {
		return xcStart;
	}
	public void setXcStart(Date xcStart) {
		this.xcStart = xcStart;
	}
	public Date getXcStop() {
		return xcStop;
	}
	public void setXcStop(Date xcStop) {
		this.xcStop = xcStop;
	}
	public Traffic getXcgj() {
		return xcgj;
	}
	public void setXcgj(Traffic xcgj) {
		this.xcgj = xcgj;
	}
	public String getXcfy() {
		return xcfy;
	}
	public void setXcfy(String xcfy) {
		this.xcfy = xcfy;
	}
	public String getZsfy() {
		return zsfy;
	}
	public void setZsfy(String zsfy) {
		this.zsfy = zsfy;
	}
	public String getSnjtfy() {
		return snjtfy;
	}
	public void setSnjtfy(String snjtfy) {
		this.snjtfy = snjtfy;
	}
	public String getZfy() {
		return zfy;
	}
	public void setZfy(String zfy) {
		this.zfy = zfy;
	}
	public Date getDjrq() {
		return djrq;
	}
	public void setDjrq(Date djrq) {
		this.djrq = djrq;
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
		return "Business [ccid=" + ccid + ", xmdm=" + xmdm + ", ccly=" + ccly
				+ ", ccr=" + ccr + ", ccdz=" + ccdz + ", bmdm=" + bmdm
				+ ", ccStart=" + ccStart + ", ccStop=" + ccStop + ", xcStart="
				+ xcStart + ", xcStop=" + xcStop + ", xcgj=" + xcgj + ", xcfy="
				+ xcfy + ", zsfy=" + zsfy + ", snjtfy=" + snjtfy + ", zfy="
				+ zfy + ", djrq=" + djrq + ", wczt=" + wczt + ", remark="
				+ remark + ", sfjy=" + sfjy + "]";
	}

	
}
