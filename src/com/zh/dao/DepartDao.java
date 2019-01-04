package com.zh.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zh.po.Depart;

@Repository
public class DepartDao  extends BaseDao<Depart> {
	
	public List<Depart> findAllDepart(){
		return super.findAll();
	}
	
	@SuppressWarnings("all")
	public Depart findByBmdm(String bmdm){
		List<Depart> list=(List<Depart>) this.getHibernateTemplate().findByNamedParam("from Depart d where d.bmdm=:paramName", "paramName", bmdm);
		return list.get(0);
	}
}
