package ch12.member;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.jdbc.interceptors.ResultSetScannerInterceptor;

import oracle.net.aso.r;


public class LogonDBBean {
	private static LogonDBBean instatnce = new LogonDBBean();
	
	public static LogonDBBean getInstance() {
		return instatnce;
	}
	
	private LogonDBBean() {}
	
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	public void insertMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("insert into member values(?,?,?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setTimestamp(4, member.getReg_date());
			pstmt.setString(5, member.getAddr());
			pstmt.setString(6, member.getTel());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) 
				try {
					pstmt.close();
				} catch(SQLException sqle) {}
			if(conn != null)
				try {
					conn.close();
				} catch(SQLException sqle) {}
		}
		
	}
	public LogonDataBean updateGetMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet  rs = null;
		LogonDataBean member = null;
		String sql ="";
		sql = "select * from member where id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member = new LogonDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setAddr(rs.getString("addr"));
				member.setTel(rs.getString("tel"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)try {rs.close();}catch(SQLException e) {}
			if(pstmt!=null)try {pstmt.close();}catch(SQLException e) {}
			if(conn!=null)try {conn.close();}catch(SQLException e) {}
		}
		return member;
	}
	public int updateMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		String sql = "";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from member where id=?");
			pstmt.setString(1, member.getId());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(member.getPasswd())) {
					sql = "update member set name=?,address=?,tel=?"
							+ "where id=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, member.getName());
					pstmt.setString(2, member.getAddr());
					pstmt.setString(3, member.getTel());
					pstmt.setString(4, member.getId());
					pstmt.executeUpdate();
					x=1;
				} else {
					x=0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)
				try {rs.close();}catch(SQLException e) {}
			if(pstmt!=null)
				try {pstmt.close();}catch(SQLException e) {}
			if(conn!=null)
				try {conn.close();}catch(SQLException e) {}
		}
		return x;
	}
	
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd ="";
		int x = -1;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select passwd from member where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd=rs.getString("passwd");
				if(dbpasswd.equals(passwd))
					x=1;
				else
					x=0;
				
			}else
				x=-1;
		}catch (Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					rs.close();
				} catch(SQLException sqle) {}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch(SQLException sqle) {}
			}
			if(conn !=null) {
				try {
					conn.close();
				} catch(SQLException sqle) {}
			}
		}
		return x;
	}
}
