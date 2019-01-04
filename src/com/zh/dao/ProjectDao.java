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
import com.zh.po.Project;
import com.zh.po.User;

@Repository
@SuppressWarnings("all")
public class ProjectDao  extends BaseDao<Project> {
	
	//新增
	public void add(Project project){
		super.add(project);
	}
	
	//删除
	public void delete(Project project){
		super.delete(project);
	}
	
	//修改
	public void update(Project project){
		super.update(project);
	}
	
	//查询
	private PageBean<Project> findCommon(List<Expression> exprList, int pc) throws SQLException {
		
		int ps = PageConstants.USER_PAGE_SIZE;//每页记录数
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		for(Expression expr : exprList) {
			whereSql.append(" and ").append(expr.getName())
				.append(" ").append(expr.getOperator()).append(" ");
			if(!expr.getOperator().equals("is null")) {
				whereSql.append(expr.getValue());
			}
		}

		String sql = "select count(*) from Project " + whereSql;
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		Long l=(Long) session.createQuery(sql).uniqueResult();
		int tr = l.intValue();//得到了总记录数
		
		sql = "from Project" + whereSql + " order by xmdm desc" ;
		
		Query query=session.createQuery(sql);
		query.setFirstResult((pc-1)*ps);
		query.setMaxResults(ps);
		List<Project> list=query.list();
		PageBean<Project> pb = new PageBean<Project>();
		pb.setList(list);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}
	
	//查询所有
	public PageBean<Project> findAllProject(int pc) throws SQLException{
		List<Expression> exprList = new ArrayList<Expression>();
		return 	findCommon(exprList,pc);
	}
	
	//查询最大xmdm值
	public String findMaxXmdm(){
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		return (String) session.createQuery("select max(xmdm) from Project").uniqueResult();
	}
	
	//根据xmmd查询project
	public Project findByXmdm(String xmdm){
		List<Project> list=(List<Project>) this.getHibernateTemplate().findByNamedParam("from Project p where p.xmdm=:paramName", "paramName", xmdm);
		return list.get(0);
	}

	public PageBean<Project> findProjectByXmmc(String xmmc, int pc) throws Exception{
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("xmmc", "like", "'%" + xmmc + "%'"));
		return findCommon(exprList,pc);
	}
}
