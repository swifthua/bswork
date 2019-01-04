package com.zh.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zh.po.Status;

@Repository
@SuppressWarnings("all")
public class StatusDao extends BaseDao<Status>{
	
	//按id查询
	public Status findById(int id){
		return super.findById(id);
	}
	
	public Status findByZtid(String ztid){
		List<Status> list=(List<Status>) this.getHibernateTemplate().findByNamedParam("from Status s where s.ztid=:paramName", "paramName", ztid);
		return list.get(0);
	}
}
