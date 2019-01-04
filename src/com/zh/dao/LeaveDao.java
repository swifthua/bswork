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
import com.zh.po.Leave;
import com.zh.utils.WorkUtils;

@Repository
@SuppressWarnings("all")
public class LeaveDao extends BaseDao<Leave>{
	
	private PageBean<Leave> findCommon(List<Expression> exprList, int pc) throws SQLException {
		
		int ps = PageConstants.USER_PAGE_SIZE;//每页记录数
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		for(Expression expr : exprList) {
			whereSql.append(" and ").append(expr.getName())
				.append(" ").append(expr.getOperator()).append(" ");
			if(!expr.getOperator().equals("is null")) {
				whereSql.append(expr.getValue());
			}
		}

		String sql = "select count(*) from Leave " + whereSql;
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		Long l=(Long) session.createQuery(sql).uniqueResult();
		int tr = l.intValue();//得到了总记录数
		
		sql = "from Leave" + whereSql + " order by djsj desc" ;
		
		Query query=session.createQuery(sql);
		query.setFirstResult((pc-1)*ps);
		query.setMaxResults(ps);
		List<Leave> list=query.list();
		PageBean<Leave> pb = new PageBean<Leave>();
		pb.setList(list);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}

	public PageBean<Leave> findByQjrAndBmdmAndWczt(String yhdm, String bmdm,String wczt, int pc) throws Exception{
		List<Expression> exprList = new ArrayList<Expression>();
		if(!"".equals(WorkUtils.trim(yhdm))){
			exprList.add(new Expression("qjr", "=", "'"+yhdm+"'"));
		}
		if(!"".equals(WorkUtils.trim(bmdm))){
			exprList.add(new Expression("bmdm", "=", "'"+bmdm+"'"));
		}
		if(!"".equals(WorkUtils.trim(wczt))){
			exprList.add(new Expression("wczt", "=", "'"+wczt+"'"));
		}
		return findCommon(exprList,pc);
	}
}
