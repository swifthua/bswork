package com.zh.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.zh.po.Position;

@Repository
public class PositionDao extends BaseDao<Position>{
	public List<Position> findAllPosition(){
		return super.findAll();
	}
	
	@SuppressWarnings("all")
	public Position findByZwdm(String zwdm){
		List<Position> list=(List<Position>) this.getHibernateTemplate().findByNamedParam("from Position p where p.zwdm=:paramName", "paramName", zwdm);
		return list.get(0);
	}
	
	@SuppressWarnings("all")
	public List<Position> getPositionByDepart(String code){
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		if(code.length()==2){
			query = session.createQuery("from Position where zwdm like ? and length(zwdm)=4");
		}else{
			query = session.createQuery("from Position where zwdm like ? and length(zwdm)=6");
		}
		query.setParameter(0, code+"%");
		List<Position> list_position = query.list();
		return list_position;
	}
}
