package com.zh.po;

import java.util.Date;

public class Project {
	private String xmdm; 
	private String xmmc;
	private String bbh;
	private User lxr;
	private Date lxrq;
	private String xmxx;
	private String remark;
	private String fjmc;
	private String fjgs;
	private Float fjdx;
	private String ftpUrl;
	private Date lastUpdate;
	private int sfjy;
	public String getXmdm() {
		return xmdm;
	}
	public void setXmdm(String xmdm) {
		this.xmdm = xmdm;
	}
	public String getXmmc() {
		return xmmc;
	}
	public void setXmmc(String xmmc) {
		this.xmmc = xmmc;
	}
	public String getBbh() {
		return bbh;
	}
	public void setBbh(String bbh) {
		this.bbh = bbh;
	}
	public User getLxr() {
		return lxr;
	}
	public void setLxr(User lxr) {
		this.lxr = lxr;
	}
	public Date getLxrq() {
		return lxrq;
	}
	public void setLxrq(Date lxrq) {
		this.lxrq = lxrq;
	}
	public String getXmxx() {
		return xmxx;
	}
	public void setXmxx(String xmxx) {
		this.xmxx = xmxx;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getFjmc() {
		return fjmc;
	}
	public void setFjmc(String fjmc) {
		this.fjmc = fjmc;
	}
	public String getFjgs() {
		return fjgs;
	}
	public void setFjgs(String fjgs) {
		this.fjgs = fjgs;
	}
	public Float getFjdx() {
		return fjdx;
	}
	public void setFjdx(Float fjdx) {
		this.fjdx = fjdx;
	}
	public String getFtpUrl() {
		return ftpUrl;
	}
	public void setFtpUrl(String ftpUrl) {
		this.ftpUrl = ftpUrl;
	}
	public int getSfjy() {
		return sfjy;
	}
	public void setSfjy(int sfjy) {
		this.sfjy = sfjy;
	}
	public Date getLastUpdate() {
		return lastUpdate;
	}
	public void setLastUpdate(Date lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	@Override
	public String toString() {
		return "Project [xmdm=" + xmdm + ", xmmc=" + xmmc + ", bbh=" + bbh
				+ ", lxr=" + lxr + ", lxrq=" + lxrq + ", xmxx=" + xmxx
				+ ", remark=" + remark + ", fjmc=" + fjmc + ", fjgs=" + fjgs
				+ ", fjdx=" + fjdx + ", ftpUrl=" + ftpUrl + ", lastUpdate=" + lastUpdate + ", sfjy=" + sfjy + "]";
	}

	
}
