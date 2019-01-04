package com.zh.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.zh.page.Expression;
import com.zh.page.PageBean;
import com.zh.page.PageConstants;
import com.zh.po.Journal;
import com.zh.utils.WorkUtils;

@Repository
@SuppressWarnings("all")
public class JournalDao extends BaseDao<Journal>{
	private PageBean<Journal> findCommon(List<Expression> exprList, int pc) throws SQLException {
		
		int ps = PageConstants.USER_PAGE_SIZE;//每页记录数
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		for(Expression expr : exprList) {
			whereSql.append(" and ").append(expr.getName())
				.append(" ").append(expr.getOperator()).append(" ");
			if(!expr.getOperator().equals("is null")) {
				whereSql.append(expr.getValue());
			}
		}

		String sql = "select count(*) from Journal " + whereSql;
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		Long l=(Long) session.createQuery(sql).uniqueResult();
		int tr = l.intValue();//得到了总记录数
		
		sql = "from Journal" + whereSql + " order by djsj desc" ;
		
		Query query=session.createQuery(sql);
		query.setFirstResult((pc-1)*ps);
		query.setMaxResults(ps);
		List<Journal> list=query.list();
		PageBean<Journal> pb = new PageBean<Journal>();
		pb.setList(list);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}

	public PageBean<Journal> findByDjrAndBmdm(String yhdm, String bmdm, int pc) throws Exception{
		List<Expression> exprList = new ArrayList<Expression>();
		if(!"".equals(WorkUtils.trim(yhdm))){
			exprList.add(new Expression("djr", "=", "'"+yhdm+"'"));
		}
		if(!"".equals(WorkUtils.trim(bmdm))){
			exprList.add(new Expression("bmdm", "=", "'"+bmdm+"'"));
		}
		return findCommon(exprList,pc);
	}

	public PageBean<Journal> findByYhdmAndRzsj(String rzsj, String yhdm, int pc) throws Exception {
		List<Expression> exprList = new ArrayList<Expression>();
		if(!"".equals(WorkUtils.trim(rzsj))){
			exprList.add(new Expression("rzsj", "=", "'"+rzsj+"'"));
		}
		if(!"".equals(WorkUtils.trim(yhdm))){
			exprList.add(new Expression("djr", "=", "'"+yhdm+"'"));
		}
		return findCommon(exprList,pc);
	}
}
