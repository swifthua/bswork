package com.zh.page;

import java.util.List;

/**
 * 分页Bean，它会在各层之间传递！
 * @author zh
 * @date 2018年4月22日 下午10:23:45
 * @extra jdk6
 */
public class PageBean<T> {
	private int pc;//当前页码
	private int tr;//总记录数
	private int ps;//每页记录数
	private int tp;//总页数
	private String url;//请求路径和参数，例如：/findAllUser.do?method=findXXX&cid=1&bname=2
	private List<T> List;//当前页数据List  通过dao查询得到
	
	// 计算总页数
	public int getTp() {
		tp = tr / ps;
		return tr % ps == 0 ? tp : tp + 1;
	}
	
	public int getPc() {
		return pc;
	}
	public void setPc(int pc) {
		this.pc = pc;
	}
	public int getTr() {
		return tr;
	}
	public void setTr(int tr) {
		this.tr = tr;
	}
	public int getPs() {
		return ps;
	}
	public void setPs(int ps) {
		this.ps = ps;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public List<T> getList() {
		return List;
	}
	public void setList(List<T> List) {
		this.List = List;
	}
}


