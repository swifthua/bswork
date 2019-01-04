package com.zh.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.UserDao;
import com.zh.page.PageBean;
import com.zh.po.User;

@Transactional
@Service
public class UserService {
	
	@Autowired
	private UserDao userDao;
	
	public User login(User user) {
		return userDao.login(user);
	}
	
	
	public void repassword(User user){
		userDao.repassword(user);
	}
	
	public void add(User user){
		userDao.add(user);
	}
	
	public String findMaxYhdm(){
		return userDao.findMaxYhdm();
	}
	
	public User findByYhdm(String yhdm){
		return userDao.findByYhdm(yhdm);
	}
	
	public void delete(User user){
		userDao.delete(user);
	}
	
	public void update(User user){
		userDao.update(user);
	}
	
	public PageBean<User> tongxunlu(int pc) throws Exception{
		return 	userDao.tongxunlu(pc);
	}
	
	public PageBean<User> findByYhxm(String yhxm,int pc) throws SQLException{
		return userDao.findByYhxm(yhxm, pc);
	}
	
	public PageBean<User> findByZwdm(int pc) throws SQLException{
		return userDao.findByZwdm(pc);
	}


	public PageBean<User> findByBmdmAndYhdm(String bmdm,String yhdm,int pc) throws Exception {
		return userDao.findByBmdmAndYhdm(bmdm, yhdm,pc);
	}

	public List<User> getUserByDepart(String code) {
		return userDao.getUserByDepart(code);
	}


	public User findByYhzh(String yhzh) {
		return userDao.findByYhzh(yhzh);
	}
}
