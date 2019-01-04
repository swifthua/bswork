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
import com.zh.po.Examine;
import com.zh.utils.WorkUtils;

@Repository
@SuppressWarnings("all")
public class ExamineDao extends BaseDao<Examine>{
	public void update(Examine Examine){
		super.update(Examine);
	}
	
	
	private PageBean<Examine> findCommon(List<Expression> exprList, int pc) throws SQLException {
		
		int ps = PageConstants.USER_PAGE_SIZE;//每页记录数
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		for(Expression expr : exprList) {
			whereSql.append(" and ").append(expr.getName())
				.append(" ").append(expr.getOperator()).append(" ");
			if(!expr.getOperator().equals("is null")) {
				whereSql.append(expr.getValue());
			}
		}

		String sql = "select count(*) from Examine " + whereSql;
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		Long l=(Long) session.createQuery(sql).uniqueResult();
		int tr = l.intValue();//得到了总记录数
		
		sql = "from Examine" + whereSql + " order by shsj2 desc" ;
		
		Query query=session.createQuery(sql);
		query.setFirstResult((pc-1)*ps);
		query.setMaxResults(ps);
		List<Examine> list=query.list();
		PageBean<Examine> pb = new PageBean<Examine>();
		pb.setList(list);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}


	public Examine findByShdmAndType(String shdm,String type,int pc) throws Exception {
		List<Expression> exprList = new ArrayList<Expression>();
		if(!"".equals(WorkUtils.trim(shdm))){
			exprList.add(new Expression("shdm", "=", "'"+shdm+"'"));
		}
		if(!"".equals(WorkUtils.trim(type))){
			exprList.add(new Expression("type", "=", "'"+type+"'"));
		}
		if(findCommon(exprList,pc).getList().size()>=1){
			System.out.println(findCommon(exprList,pc));
			System.out.println(findCommon(exprList,pc).getList());
			return findCommon(exprList,pc).getList().get(0);
		}else{
			return null;
		}
	}


}
