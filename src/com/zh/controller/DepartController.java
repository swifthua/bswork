package com.zh.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zh.po.Depart;
import com.zh.service.DepartService;

@Controller
public class DepartController {
	
	@Autowired
	private DepartService departService;
	
	@RequestMapping("getAllDepart")
	@ResponseBody
	public String getAllDepart(HttpServletRequest req, HttpServletResponse resp){
		List<Depart> list_depart=departService.findAllDepart();
		String result=toJSON(list_depart);
		return result;
	}
	
	private String toJSON(List<Depart> list) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		for (Depart d : list) {
			json.append(d.toJsonString());
			json.append(",");
		}
		json.setCharAt(json.length() - 1, ']');
		return json.toString();
	}
}
