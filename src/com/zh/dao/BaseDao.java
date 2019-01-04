package com.zh.dao;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

/**
 * 公共dao父类
 * @author zh
 * @date 2018年3月29日 下午3:26:13
 * @extra jdk6
 */
@SuppressWarnings("all")
public class BaseDao<T> extends HibernateDaoSupport{

	private Class pClass;
	
	//HibernateDaoSupport中注入SessionFactory
    @Resource
    public void setSuperSessionFactory(SessionFactory sessionFactory) {  
       super.setSessionFactory(sessionFactory);  
    }  
	
	//构造方法
	public BaseDao() {
		Class clazz = this.getClass();
		Type type = clazz.getGenericSuperclass();
		ParameterizedType ptype = (ParameterizedType) type;
		Type[] types = ptype.getActualTypeArguments();
		Class tclass = (Class) types[0];
		this.pClass = tclass;
	}
	
	//根据id查询
	public T findById(int id) {
		return (T) this.getHibernateTemplate().get(pClass, id);
	}

	//查询所有
	public List<T> findAll() {
		//使用Class里面getSimpleName()得到类名称
		return (List<T>) this.getHibernateTemplate().find("from "+pClass.getSimpleName());
	}
	
	//添加
	public void add(T t) {
		this.getHibernateTemplate().save(t);
	}
	
	//修改
	public void update(T t) {
		this.getHibernateTemplate().update(t);
	}

	//删除
	public void delete(T t) {
		this.getHibernateTemplate().delete(t);
	}

}
