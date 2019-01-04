package com.zh.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserUtils {
	public static List<String> findByBmdmAndZwdmAndYhdm(String bmdm,String zwdm,String yhdm) throws Exception{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<String> list=new ArrayList<String>();
		try {
			conn = MysqlUtils.getConnection();
			StringBuilder sql=new StringBuilder("select YHDM from user where 1=1 ");
			if(!"".equals(WorkUtils.trim(bmdm))){
				sql.append(" and bmdm="+bmdm);
			}
			if(!"".equals(WorkUtils.trim(zwdm))){
				sql.append(" and zwdm="+zwdm);
			}
			if(!"".equals(WorkUtils.trim(yhdm))){
				sql.append(" and yhdm="+yhdm);
			}
			System.out.println("sql=="+sql);
			ps= conn.prepareStatement(sql.toString());
			rs=ps.executeQuery();
			while (rs.next()) {
				list.add(rs.getString("YHDM"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
	    } finally {
	        MysqlUtils.free(rs, ps, conn);
	    }
		return list;
	}
}
