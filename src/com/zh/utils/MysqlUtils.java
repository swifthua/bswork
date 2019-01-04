package com.zh.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author zh
 * @date 2018年4月24日 下午2:50:38
 */
public class MysqlUtils {
	private static String url = "jdbc:mysql://localhost:3306/work?characterEncoding=utf8";
	private static String user = "root";
	private static String password = "";

	private MysqlUtils() {
	}

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			throw new ExceptionInInitializerError(e);
		}
	}

	/**
	 * 连接sybase数据库
	 * @return
	 * @throws SQLException
	 */
	public static Connection getConnection() throws Exception {
		return DriverManager.getConnection(url, user, password);
	}

	/**
	 * 关闭数据库连接
	 * @param rs
	 * @param st
	 * @param conn
	 */
	public static void free(ResultSet rs,PreparedStatement ps,Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (ps != null) {
				ps.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 测试连接
	 * @throws Exception
	 */
	public static void testConnect() throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			// 2.建立连接
			conn = MysqlUtils.getConnection();
			// 3.创建语句
			ps = conn.prepareStatement("select BMDM,BMMC from depart");
			// 4.执行语句
			rs = ps.executeQuery();
			// 5.处理结果
			while (rs.next()) {
				// 参数中的1,2,3是指sql中的列索引
				System.out.println(rs.getObject(1) + "\t" + rs.getObject(2));
			}
		} finally {
			MysqlUtils.free(rs,ps,conn);
		}
	}
	
	public static void main(String[] args) throws Exception {
		testConnect();
	}
}
