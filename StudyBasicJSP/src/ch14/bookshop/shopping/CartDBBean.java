package ch14.bookshop.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDBBean {
	private static CartDBBean instance = new CartDBBean();
	
	public static CartDBBean getInstance() {
		return instance;
	}
	
	private CartDBBean() {}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context  envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	public void insertCart(CartDataBean cart) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql ="";
		sql = "insert into cart (cart_id,book_id,buyer,book_title,buy_price,buy_count"
				+ ",book_image) values(seq_cart_id.nextval,	?,?,?,?,?,?)";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cart.getBook_id());
			pstmt.setString(2, cart.getBuyer());
			pstmt.setString(3, cart.getBook_title());
			pstmt.setInt(4, cart.getBuy_price());
			pstmt.setByte(5, cart.getBuy_count());
			pstmt.setString(6, cart.getBook_image());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)
				try {pstmt.close();} catch(SQLException e) {}
			if(conn != null)
				try {conn.close();} catch(SQLException e) {}
		}
	}
	
	public int getListCount(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		sql = "select count(*) from cart where buyer=?";
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x =rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)
				try {rs.close();} catch(SQLException sqle) {}
			if(pstmt != null)
				try {pstmt.close();} catch(SQLException sqle) {}
			if(conn != null) 
				try {conn.close();} catch(SQLException sqle) {}
		}
		
		return x;
	}
	
	public List<CartDataBean> getCart(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartDataBean cart = null;
		String sql = "";
		List<CartDataBean> lists = null;
		try {
			conn =getConnection();
			sql = "select * from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			lists = new ArrayList<CartDataBean>();
			
			while(rs.next()) {
				cart = new CartDataBean();
				
				cart.setCart_id(rs.getInt("cart_id"));
				cart.setBook_id(rs.getInt("book_id"));
				cart.setBook_title(rs.getString("book_title"));
				cart.setBuy_price(rs.getInt("buy_price"));
				cart.setBuy_count(rs.getByte("buy_count"));
				cart.setBook_image(rs.getString("book_image"));
				
				lists.add(cart);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null)
				try {rs.close();} catch(SQLException sqle) {}
			if(pstmt != null)
				try {pstmt.close();} catch(SQLException sqle) {}
			if(conn != null)
				try {conn.close();} catch(SQLException sqle) {}
		}
		return lists;
	}
	
	public void updateCount(int cart_id, byte count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		sql = "update cart set buy_count=? where cart_id=?";
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setByte(1, count);
			pstmt.setInt(2, cart_id);
			
			pstmt.executeUpdate();
		}  catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)
				try {pstmt.close();} catch(SQLException sqle) {}
			if(conn != null)
				try {conn.close();} catch(SQLException sqle) {}
		}
	}
	
	public void deleteList(int cart_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("delete from cart where cart_id=?");
			pstmt.setInt(1, cart_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)
				try {pstmt.close();} catch(SQLException sqle) {}
			if(conn != null)
				try {conn.close();} catch(SQLException sqle) {}
		}
	}
	
	public void deleteAll(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("delete from cart where buyer=?");
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
		}  catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null)
				try {pstmt.close();} catch(SQLException sqle) {}
			if(conn != null)
				try {conn.close();} catch(SQLException sqle) {}
		}
	}
}
