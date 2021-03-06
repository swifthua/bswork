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
import com.zh.po.Notify;
import com.zh.utils.WorkUtils;

@Repository
@SuppressWarnings("all")
public class NotifyDao extends BaseDao<Notify>{
	//查询
	private PageBean<Notify> findCommon(List<Expression> exprList, int pc) throws SQLException {
		
		int ps = PageConstants.USER_PAGE_SIZE;//每页记录数
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		for(Expression expr : exprList) {
			whereSql.append(" and ").append(expr.getName())
				.append(" ").append(expr.getOperator()).append(" ");
			if(!expr.getOperator().equals("is null")) {
				whereSql.append(expr.getValue());
			}
		}

		String sql = "select count(*) from Notify " + whereSql;
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		Long l=(Long) session.createQuery(sql).uniqueResult();
		int tr = l.intValue();//得到了总记录数
		
		sql = "from Notify" + whereSql + " order by lastUpdate desc" ;
		
		Query query=session.createQuery(sql);
		query.setFirstResult((pc-1)*ps);
		query.setMaxResults(ps);
		List<Notify> list=query.list();
		PageBean<Notify> pb = new PageBean<Notify>();
		pb.setList(list);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}
	
	//查询所有
	public PageBean<Notify> findAllNotify(int pc) throws SQLException{
		List<Expression> exprList = new ArrayList<Expression>();
		return 	findCommon(exprList,pc);
	}

	public PageBean<Notify> findNotifyCondition(String ggbt, String fqr,
			int pc) throws Exception{
		List<Expression> exprList = new ArrayList<Expression>();
		if(!"".equals(WorkUtils.trim(ggbt))){
			exprList.add(new Expression("ggbt", "like", "'%" + ggbt + "%'"));
		}
		if(!"".equals(WorkUtils.trim(fqr))){
			exprList.add(new Expression("fqr", "=", "'"+fqr+"'"));
		}
		return 	findCommon(exprList,pc);
	}
}
