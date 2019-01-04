package com.zh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.NotifyDao;
import com.zh.page.PageBean;
import com.zh.po.Notify;

@Transactional
@Service
public class NotifyService {
	
	@Autowired
	private NotifyDao notifyDao;
	
	public void add(Notify notify){
		notifyDao.add(notify);
	}
	
	public void delete(Notify notify){
		notifyDao.delete(notify);
	}
	
	public Notify findById(int id){
		return notifyDao.findById(id);
	}
	
	public void update(Notify notify){
		notifyDao.update(notify);
	}
	
	public PageBean<Notify> findAllNotify(int pc) throws Exception{
		return notifyDao.findAllNotify(pc);
	}

	public PageBean<Notify> findNotifyCondition(String ggbt,String fqr,int pc) throws Exception{
		return notifyDao.findNotifyCondition(ggbt,fqr,pc);
	}

}
