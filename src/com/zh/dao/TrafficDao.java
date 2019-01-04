package com.zh.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zh.po.Traffic;

@Repository
@SuppressWarnings("all")
public class TrafficDao extends BaseDao<Traffic>{
	public Traffic findByGjid(String gjid){
		List<Traffic> list=(List<Traffic>) this.getHibernateTemplate().findByNamedParam("from Traffic t where t.gjid=:paramName", "paramName", gjid);
		return list.get(0);
	}
}
