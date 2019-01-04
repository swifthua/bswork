package com.zh.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.ExpenseDao;
import com.zh.page.PageBean;
import com.zh.po.Expense;

@Transactional
@Service
public class ExpenseService {
	
	@Autowired
	private ExpenseDao expenseDao;
	
	public void add(Expense expense){
		expenseDao.add(expense);
	}
	
	public PageBean<Expense> findAllExpense(int pc) throws SQLException{
		return expenseDao.findAllExpense(pc);
	}
	
	public Expense findById(int id){
		return expenseDao.findById(id);
	}
	
	public void delete(Expense expense){
		expenseDao.delete(expense);
	}

	public PageBean<Expense> findByBmdmAndYhdmAndWczt(String bmdm,String yhdm,String wczt,int pc) throws Exception{
		return expenseDao.findByBmdmAndYhdmAndWczt(bmdm,yhdm,wczt,pc);
	}

	public void update(Expense expense) {
		expenseDao.update(expense);
		
	}
}
