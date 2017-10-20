package student.info;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class StudentDBBean {
	
	private static StudentDBBean instance = new StudentDBBean();
	
	public static StudentDBBean getInstance() {
		return instance;
	}
	
	private StudentDBBean() {}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/sptest");
		return ds.getConnection();
	}
	
	public StudentDataBean getStudentList(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from student";
		StudentDataBean member = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				member = new StudentDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setSnum(rs.getString("snum"));
				member.setEnt_year(rs.getString("ent_year"));
				member.setMajor(rs.getString("major"));
				member.setAddr(rs.getString("addr"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)
				try {rs.close();} catch(SQLException sqle) {}
			if(pstmt != null)
				try {pstmt.close();} catch(SQLException sqle) {}
			if(conn != null)
				try {conn.close();} catch(SQLException sqle) {}
		}
		return member;
	}
	
}
