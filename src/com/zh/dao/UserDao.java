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
import com.zh.po.Depart;
import com.zh.po.User;
import com.zh.utils.WorkUtils;

@Repository
@SuppressWarnings("all")
public class UserDao extends BaseDao<User> {
	
//	@Resource
//	private SessionFactory sessionFactory;
//	@Resource
//	private HibernateTemplate hibernateTemplate;
//
//	public User login1(User user) {
//		Session session = sessionFactory.getCurrentSession();
//		Query query = session.createQuery("from User where YHZH=? and YHKL=?");
//		query.setParameter(0, user.getYhzh());
//		query.setParameter(1, user.getYhkl());
//		List<User> list = (List<User>) query.uniqueResult();
//		if (list != null && list.size() != 0) {
//			User u = list.get(0);
//			return u;
//		}
//		return null;
//	}

	// 用户登录
	public User login(User user) {
		List<User> list = (List<User>) this.getHibernateTemplate().find(
				"from User where YHZH=? and YHKL=?", user.getYhzh(),
				user.getYhkl());
		if (list != null && list.size() != 0) {
			User u = list.get(0);
			return u;
		}
		return null;
	}

	//重置密码
	public void repassword(User user) {
		super.update(user);
	}

	//新增用户
	public void add(User user){
		super.add(user);
	}
	
	//查询最大yhdm值
	public String findMaxYhdm(){
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		return (String) session.createQuery("select max(yhdm) from User").uniqueResult();
	}
	
	//根据yhdm查询user
	@SuppressWarnings("all")
	public User findByYhdm(String yhdm){
		List<User> list=(List<User>) this.getHibernateTemplate().findByNamedParam("from User u where u.yhdm=:paramName", "paramName", yhdm);
		return list.get(0);
	}
	
	//删除
	public void delete(User user){
		super.delete(user);
	}
	
	//修改
	public void update(User user){
		super.update(user);
	}
	
	//通讯录查询所有用户信息
	public PageBean<User> tongxunlu(int pc) throws SQLException{
		List<Expression> exprList = new ArrayList<Expression>();
		return 	findCommon(exprList,pc,"tongxunlu");
	}
	
	//按用户姓名查询
	public PageBean<User> findByYhxm(String yhxm,int pc) throws SQLException{
		List<Expression> exprList = new ArrayList<Expression>();
		if(!"".equals(WorkUtils.trim(yhxm))){
			exprList.add(new Expression("yhxm", "like", "'%" + yhxm + "%'"));
		}
		return findCommon(exprList,pc,"tongxunlu");
		
	}
	
	//通过职位代码模糊查询
	public PageBean<User> findByZwdm(int pc) throws SQLException{
		List<Expression> exprList = new ArrayList<Expression>();
		exprList.add(new Expression("zwdm", "like", "'__01'"));
		return findCommon(exprList,pc,"tongxunlu");
	}
	

	//通用的查询方法
	private PageBean<User> findCommon(List<Expression> exprList, int pc,String lx) throws SQLException {
		/*
		 * 1. 得到每页记录数 ps
		 * 2. 得到总记录数 tr
		 * 3. 得到每页显示数据List
		 * 4. 创建PageBean，返回
		 */
		int ps = PageConstants.USER_PAGE_SIZE;//每页记录数
		StringBuilder whereSql = new StringBuilder(" where 1=1"); 
		for(Expression expr : exprList) {
			whereSql.append(" and ").append(expr.getName())
				.append(" ").append(expr.getOperator()).append(" ");
			if(!expr.getOperator().equals("is null")) {
				whereSql.append(expr.getValue());
			}
		}

		String sql = "select count(*) from User " + whereSql;
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		Long l=(Long) session.createQuery(sql).uniqueResult();
		int tr = l.intValue();//得到了总记录数
		
		if("tongxunlu".equals(lx)){
			sql = "from User" + whereSql + " order by bmdm" ;
		}else{
			sql = "from User" + whereSql + " order by yhdm desc" ;
		}
		
		Query query=session.createQuery(sql);
		query.setFirstResult((pc-1)*ps);
		query.setMaxResults(ps);
		List<User> list=query.list();
		PageBean<User> pb = new PageBean<User>();
		pb.setList(list);
		pb.setPc(pc);
		pb.setPs(ps);
		pb.setTr(tr);
		
		return pb;
	}
	

	public PageBean<User> findByBmdmAndYhdm(String bmdm,String yhdm,int pc) throws Exception{
		List<Expression> exprList = new ArrayList<Expression>();
		if(!"".equals(WorkUtils.trim(bmdm))){
			exprList.add(new Expression("bmdm", "=", "'" + bmdm + "'"));
		}
		
		if(!"".equals(WorkUtils.trim(yhdm))){
			exprList.add(new Expression("yhdm", "=", "'" + yhdm + "'"));
		}
		return 	findCommon(exprList,pc,"other");
	}

	public List<User> getUserByDepart(String code) {
		SessionFactory sessionFactory=super.getSessionFactory();
		Session session = sessionFactory.getCurrentSession();
		Query query=session.createQuery("from User where bmdm.bmdm =?");
		query.setParameter(0, code);
		List<User> list_user=query.list();
		return list_user;
	}

	public User findByYhzh(String yhzh) {
		List<User> list=(List<User>) this.getHibernateTemplate().findByNamedParam("from User u where u.yhzh=:paramName", "paramName", yhzh);
		if(list.size()>=1){
			return list.get(0);
		}else{
			return null;
		}
	}
	
	
	
}
