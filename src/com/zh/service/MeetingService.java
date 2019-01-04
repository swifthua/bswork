package com.zh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.MeetingDao;
import com.zh.page.PageBean;
import com.zh.po.Meeting;

@Transactional
@Service
public class MeetingService {
	
	@Autowired
	private MeetingDao meetingDao;
	
	public void add(Meeting meeting){
		meetingDao.add(meeting);
	}
	
	public void delete(Meeting meeting){
		meetingDao.delete(meeting);
	}
	
	public Meeting findById(int id){
		return meetingDao.findById(id);
	}
	
	public void update(Meeting meeting){
		meetingDao.update(meeting);
	}
	
	public PageBean<Meeting> findAllMeeting(int pc) throws Exception{
		return meetingDao.findAllMeeting(pc);
	}

	public PageBean<Meeting> findMeetingCondition(String hybt,String hyfqr,int pc) throws Exception{
		return meetingDao.findMeetingCondition(hybt,hyfqr,pc);
	}

}
