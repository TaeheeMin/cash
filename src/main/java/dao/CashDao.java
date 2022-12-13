package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import vo.*;

public class CashDao {
	// cash insert 등록
	public int insertCash (Cash cash) { 
		int insertRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		// db연결 
		try {
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO cash("
					+ "category_no"
					+ ", cash_date"
					+ ", cash_memo"
					+ ", cash_price"
					+ ", member_id"
					+ ", updatedate"
					+ ", createdate"
					+ ") VALUES (?, ?, ?, ?, ?, NOW(), NOW());";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getCashDate());
			stmt.setString(3, cash.getCashMemo());
			stmt.setLong(4, cash.getCashPrice());
			stmt.setString(5, cash.getMemberId());
		
			insertRow = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		return insertRow;
	}
	
	// cash list 달력목록
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT "
					+ "c.cash_no cashNo"
					+ ", c.cash_date cashDate"
					+ ", c.cash_price cashPrice"
					+ ", ct.category_no categoryNo"
					+ ", ct.category_kind categoryKind"
					+ ", ct.category_name categoryName "
					+ "FROM cash c INNER JOIN category ct "
					+ "ON c.category_no = ct.category_no "
					+ "WHERE c.member_id = ? "
					+ "AND YEAR(c.cash_date) = ? "
					+ "AND MONTH(c.cash_date) = ? "
					+ "ORDER BY c.cash_date ASC, ct.category_no ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			
			rs = stmt.executeQuery();
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo",rs.getInt("cashNo"));
				m.put("cashDate",rs.getString("cashDate"));
				m.put("cashPrice",rs.getInt("cashPrice"));
				m.put("categoryKind",rs.getString("categoryKind"));
				m.put("categoryName",rs.getString("categoryName"));
				list.add(m);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
				
		}  finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		return list;
	}
	
	// cashDateList 날짜별 목록
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
		ArrayList<HashMap<String, Object>> dateList = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT "
					+ " c.cash_no cashNo"
					+ ", c.cash_date cashDate"
					+ ", c.cash_price cashPrice"
					+ ", ct.category_kind categoryKind"
					+ ", ct.category_name categoryName"
					+ ", c.cash_memo cashMemo"
					+ " FROM cash c INNER JOIN category ct"
					+ " ON c.category_no = ct.category_no"
					+ " WHERE c.member_id = ?"
					+ " AND YEAR(c.cash_date) = ?"
					+ " AND MONTH(c.cash_date) = ?"
					+ " AND DAY(c.cash_date) = ?"
					+ " ORDER BY c.cash_date ASC, ct.category_no ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			
			dateList = new ArrayList<HashMap<String, Object>>();
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo",rs.getInt("cashNo"));
				m.put("cashDate",rs.getString("cashDate"));
				m.put("cashPrice",rs.getInt("cashPrice"));
				m.put("categoryKind",rs.getString("categoryKind"));
				m.put("categoryName",rs.getString("categoryName"));
				m.put("cashMemo",rs.getString("cashMemo"));
				dateList.add(m);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		return dateList;
	}
	
	// cashOne 하나만 출력
		public Cash cashOne(String memberId, int cashNo) {
			Cash resultCash = null;
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				conn = dbUtil.getConnection();
				String sql = "SELECT "
						+ " cash_no cashNo"
						+ ", category_no categoryNo"
						+ ", cash_date cashDate"
						+ ", cash_price cashPrice"
						+ ", category_no categoryNo"
						+ ", cash_memo cashMemo"
						+ " FROM cash"
						+ " WHERE member_id = ?"
						+ " AND cash_no = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, memberId);
				stmt.setInt(2, cashNo);
				
				resultCash  = new Cash();
				rs = stmt.executeQuery();
				while(rs.next()) {
					resultCash.setCashNo(rs.getInt("cashNo"));
					resultCash.setCategoryNo(rs.getInt("categoryNo"));
					resultCash.setCashDate(rs.getString("cashDate"));
					resultCash.setCashPrice(rs.getLong("cashPrice"));;
					resultCash.setCategoryNo(rs.getInt("categoryNo"));;
					resultCash.setCashMemo(rs.getString("cashMemo"));;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				
			} finally {
				dbUtil.close(rs, stmt, conn);
			}
			
			return resultCash;
		}
		
	// cash update
	public int updateCash (Cash cash) { 
		// db연결 
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int updateRow = 0;
		try {
			conn = dbUtil.getConnection();
			// 수정
			String sql = "UPDATE cash SET"
					+ " category_no = ?"
					+ ", cash_price = ?"
					+ ", cash_memo = ?"
					+ " WHERE cash_no = ? AND member_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setLong(2, cash.getCashPrice());
			stmt.setString(3, cash.getCashMemo());
			stmt.setInt(4, cash.getCashNo());;
			stmt.setString(5, cash.getMemberId());
			updateRow = stmt.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		return updateRow;
	}
	
	// cash delete 삭제
	public int deleteCash (int cashNo, String memberId, String memberPw) { 
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int deleteRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			// 삭제
			String sql = "DELETE c.*"
					+ " FROM cash c INNER JOIN member m"
					+ " ON c.member_id = m.member_id"
					+ " WHERE c.cash_no = ?"
					+ " AND c.member_id = ?"
					+ " AND m.member_pw = PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			stmt.setString(2, memberId);
			stmt.setString(3, memberPw);
			deleteRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		return deleteRow;
	}
	
	// 년도별 수입/지출 합계, 평균
	public ArrayList<HashMap<String, Object>> selectCashList(String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list  = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT"
					+ " YEAR(t2.cashDate) year"
					+ ", COUNT(t2.importCash) importCnt"
					+ ", IFNULL(SUM(t2.importCash), 0) importSum"
					+ ", IFNULL(ROUND(AVG(t2.importCash)),0) importAvg"
					+ ", COUNT(t2.exportCash) exportCnt"
					+ ", IFNULL(ROUND(SUM(t2.exportCash)), 0) exportSum"
					+ ", IFNULL(ROUND(AVG(t2.exportCash)), 0) exportAvg"
					+ " FROM ("
					+ "SELECT"
					+ " memberId"
					+ ", cashNo"
					+ ", cashDate"
					+ ", if(categoryKind = '수입', cashPrice, NULL) importCash"
					+ ", if(categoryKind = '지출', cashPrice, NULL) exportCash"
					+ " FROM ("
					+ "SELECT cs.cash_no cashNo"
					+ ", cs.cash_date cashDate"
					+ ", cs.cash_price cashPrice"
					+ ", cg.category_kind categoryKind"
					+ ", cg.category_name categoryName"
					+ ", cs.member_id memberId"
					+ " FROM cash cs INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ?"
					+ " GROUP BY YEAR(t2.cashDate)"
					+ " ORDER BY YEAR(t2.cashDate) DESC, MONTH(t2.cashDate) DESC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("year",rs.getInt("year"));
				m.put("importCnt",rs.getInt("importCnt"));
				m.put("importSum",rs.getInt("importSum"));
				m.put("importAvg",rs.getInt("importAvg"));
				m.put("exportCnt",rs.getInt("exportCnt"));
				m.put("exportSum",rs.getInt("exportSum"));
				m.put("exportAvg",rs.getInt("exportAvg"));
				list.add(m);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		return list;
	}
	
	// 월별 수입/지출 합계, 평균 페이징
	// 1-1 년도 목록
	public ArrayList<Cash> selectCashListYear(String memberId) {
		ArrayList<Cash> list = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT YEAR(cash_date) year FROM cash WHERE member_id = ? GROUP BY YEAR(cash_date)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			
			list = new ArrayList<Cash>();
			while(rs.next()) {
				Cash c = new Cash();
				c.setCashDate(rs.getString("year"));
				list.add(c);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		return list;
	
	}
	// 1-2 리스트 출력
	public ArrayList<HashMap<String, Object>> selectCashListByYear(String memberId, int year) throws Exception {
		ArrayList<HashMap<String, Object>> list  = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT"
					+ " MONTH(t2.cashDate) month"
					+ ", COUNT(t2.importCash) importCnt"
					+ ", IFNULL(SUM(t2.importCash), 0) importSum"
					+ ", IFNULL(ROUND(AVG(t2.importCash)),0) importAvg"
					+ ", COUNT(t2.exportCash) exportCnt"
					+ ", IFNULL(ROUND(SUM(t2.exportCash)), 0) exportSum"
					+ ", IFNULL(ROUND(AVG(t2.exportCash)), 0) exportAvg"
					+ " FROM (SELECT memberId"
					+ ", cashNo"
					+ ", cashDate"
					+ ", if(categoryKind = '수입', cashPrice, NULL) importCash"
					+ ", if(categoryKind = '지출', cashPrice, NULL) exportCash"
					+ " FROM (SELECT cs.cash_no cashNo"
					+ ", cs.cash_date cashDate"
					+ ", cs.cash_price cashPrice"
					+ ", cg.category_kind categoryKind"
					+ ", cg.category_name categoryName"
					+ ", cs.member_id memberId "
					+ " FROM cash cs INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
					+ " GROUP BY MONTH(t2.cashDate)"
					+ " ORDER BY MONTH(t2.cashDate) ASC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("month",rs.getInt("month"));
				m.put("importCnt",rs.getInt("importCnt"));
				m.put("importSum",rs.getInt("importSum"));
				m.put("importAvg",rs.getInt("importAvg"));
				m.put("exportCnt",rs.getInt("exportCnt"));
				m.put("exportSum",rs.getInt("exportSum"));
				m.put("exportAvg",rs.getInt("exportAvg"));
				list.add(m);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		return list;
	}
	
}
