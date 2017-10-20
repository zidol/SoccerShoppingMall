	package ch14.bookshop.master;
	
	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.util.ArrayList;
	import java.util.List;
	import javax.naming.Context;
	import javax.naming.InitialContext;
	import javax.sql.DataSource;
	
	
	
	public class ShopBookDBBean {
		
		private static ShopBookDBBean instance  = new ShopBookDBBean();
		
		public static ShopBookDBBean getInstance() {
			return instance;
		}
		
		private ShopBookDBBean() {}
		
		private Connection getConnection() throws Exception {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
			return ds.getConnection();
		}
		
		public int mangaerCheck(String id, String passwd) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String dbpasswd = "";
			String sql ="";
			sql = "select managerPasswd from manager where managerId = ?";
			int x = -1;
			try {
				conn = getConnection();
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dbpasswd = rs.getString("managerPasswd");
					if(dbpasswd.equals(passwd)) {
						x=1;
					} else
						x = 0;
				}else {
					x=-1;
				}
				
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(rs != null) 
					try {rs.close();}catch(SQLException ex) {}
				if(pstmt != null)
					try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null)
					try {conn.close();} catch(SQLException ex) {}
			}
			return x;
		}
		
		public void insertBook(ShopBookDataBean book) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql ="";
			sql = "insert into book values(seq_book_id.nextval,?,?,?,?,?,?,?,?,?,?,?)";
			try {
				conn = getConnection();
				
				pstmt = conn.prepareStatement(sql);
				/*pstmt.setInt(1, book.getBook_id());*/
				pstmt.setString(1, book.getBook_kind());
				pstmt.setString(2, book.getBook_title());
				pstmt.setInt(3, book.getBook_price());
				pstmt.setShort(4, book.getBook_count());
				pstmt.setString(5, book.getAuthor());
				pstmt.setString(6, book.getPublishing_com());
				pstmt.setString(7, book.getPublishing_date());
				pstmt.setString(8, book.getBook_image());
				pstmt.setString(9, book.getBook_content());
				pstmt.setByte(10, book.getDiscount_rate());
				pstmt.setTimestamp(11, book.getReg_date());
				
				pstmt.executeUpdate();
				
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if(pstmt != null)
					try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null)
					try {conn.close();} catch(SQLException ex) {}
			}
		}
		
		public int getBookCount() throws Exception {
			Connection conn  = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int x = 0;
			
			try {
				conn = getConnection();
				
				pstmt = conn.prepareStatement("select count(*) from book");
				rs = pstmt.executeQuery();
				
				if(rs.next())
					x = rs.getInt(1);
			} catch(Exception ex) {
				ex.printStackTrace();
			}  finally {
				if(rs != null) 
					try {rs.close();}catch(SQLException ex) {}
				if(pstmt != null)
					try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null)
					try {conn.close();} catch(SQLException ex) {}
			}
			return x;
		}
		
		public List<ShopBookDataBean> getBooks(String book_kind) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ShopBookDataBean> bookList = null;
			
			try {
				conn = getConnection();
				String sql1 = "select * from book order by reg_date desc";
				String sql2 = "select * from book"
						+ " where book_kind=? order by reg_date desc";
				if(book_kind.equals("all")) {
					pstmt = conn.prepareStatement(sql1);
				} else {
					pstmt = conn.prepareStatement(sql2);
					pstmt.setString(1, book_kind);
				}
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					bookList = new ArrayList<ShopBookDataBean>();
					
					do {
						ShopBookDataBean book = new ShopBookDataBean();
						
						book.setBook_id(rs.getInt("book_id"));
						book.setBook_kind(rs.getString("book_kind"));
						book.setBook_title(rs.getString("book_title"));
						book.setBook_price(rs.getInt("book_price"));
						book.setBook_count(rs.getShort("book_count"));
						book.setAuthor(rs.getString("author"));
						book.setPublishing_com(rs.getString("publishing_com"));
						book.setPublishing_date(rs.getString("publishing_date"));
						book.setBook_image(rs.getString("book_image"));
						book.setDiscount_rate(rs.getByte("discount_rate"));
						book.setReg_date(rs.getTimestamp("reg_date"));
						
						bookList.add(book);
					} while(rs.next());
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if(rs != null) 
					try {rs.close();}catch(SQLException ex) {}
				if(pstmt != null)
					try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null)
					try {conn.close();} catch(SQLException ex) {}
			}
			return bookList;
		}
		
		public ShopBookDataBean[] getBooks(String book_kind, int count) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ShopBookDataBean [] bookList = null;
			String sql = "";
			/*sql = "select * from book where book_kind = ? "
					+ " order by reg_date desc limit ?,?";*/
			sql = "select * from "
					+ "(select rownum as rnum, bo.* "
					+ "from (select * from book where book_kind=? order by reg_date desc) bo) "
					+ "where rnum between ? and ?";
			int i = 0;
			
			try {
				conn  = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, book_kind);
				pstmt.setInt(2, 0);
				pstmt.setInt(3, count);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					bookList = new ShopBookDataBean[count];
					do {
						ShopBookDataBean book = new ShopBookDataBean();
						book.setBook_id(rs.getInt("book_id"));
						book.setBook_kind(rs.getString("book_kind"));
						book.setBook_title(rs.getString("book_title"));
						book.setBook_price(rs.getInt("book_price"));
						book.setBook_count(rs.getShort("book_count"));
						book.setAuthor(rs.getString("author"));
						book.setPublishing_com(rs.getString("publishing_com"));
						book.setPublishing_date(rs.getString("publishing_date"));
						book.setBook_image(rs.getString("book_image"));
						book.setDiscount_rate(rs.getByte("discount_rate"));
						book.setReg_date(rs.getTimestamp("reg_date"));
						
						bookList[i] = book;
						
						i++;
					} while(rs.next());
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			}finally {
				if(rs != null) 
					try {rs.close();}catch(SQLException ex) {}
				if(pstmt != null)
					try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null)
					try {conn.close();} catch(SQLException ex) {}
			}
			return bookList;
		} 
		
		public ShopBookDataBean getBook(int bookId) throws Exception {
			Connection conn  = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ShopBookDataBean book = null;
			String sql = "select * from book where book_id = ?";
			
			try { 
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bookId);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					book = new ShopBookDataBean();
					
					book.setBook_kind(rs.getString("book_kind"));
					book.setBook_title(rs.getString("book_title"));
					book.setBook_price(rs.getInt("book_price"));
					book.setBook_count(rs.getShort("book_count"));
					book.setAuthor(rs.getString("author"));
					book.setPublishing_com(rs.getString("publishing_com"));
					book.setPublishing_date(rs.getString("publishing_date"));
					book.setBook_image(rs.getString("book_image"));
					book.setBook_content(rs.getString("book_content"));
					book.setDiscount_rate(rs.getByte("discount_rate"));
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(rs != null) 
					try {rs.close();}catch(SQLException ex) {}
				if(pstmt != null)
					try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null)
					try {conn.close();} catch(SQLException ex) {}
			}
			return book;
		}
		
		public void updateBook(ShopBookDataBean book, int bookId) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql ="";
			sql = "update book set book_kind=?, book_title=?, book_price=?,"
					+ "book_count=?, author=?, publishing_com=?, publishing_date=?,"
					+ "book_image=?, book_content=?, discount_rate=? where book_id=?";
			
			try {
				
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setString(1, book.getBook_kind());
			pstmt.setString(2, book.getBook_title());
			pstmt.setInt(3, book.getBook_price());
			pstmt.setShort(4, book.getBook_count());
			pstmt.setString(5, book.getAuthor());
			pstmt.setString(6, book.getPublishing_com());
			pstmt.setString(7, book.getPublishing_date());
			pstmt.setString(8, book.getBook_image());
			pstmt.setString(9, book.getBook_content());
			pstmt.setByte(10, book.getDiscount_rate());
			pstmt.setInt(11, bookId);
			pstmt.executeUpdate();
			
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(pstmt != null)
					try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null)
					try {conn.close();} catch(SQLException ex) {}
			}
		}
		
		public void deleteBook(int bookId) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try { 
				conn = getConnection();
				
				pstmt = conn.prepareStatement("delete from book where book_id = ?");
				pstmt.setInt(1, bookId);
				
				pstmt.executeUpdate();
			}  catch(Exception ex) {
				ex.printStackTrace();
			}finally {
				if(rs != null) 
					try {rs.close();}catch(SQLException ex) {}
				if(pstmt != null)
					try {pstmt.close();} catch(SQLException ex) {}
				if(conn != null)
					try {conn.close();} catch(SQLException ex) {}
			}
		}
	}
