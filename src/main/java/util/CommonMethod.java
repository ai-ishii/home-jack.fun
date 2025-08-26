/*
 * 便利なメソッドたち
 * 
 * 作成者：大北直弥
 * 
 * 作成日：8/26
 */
package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CommonMethod {
	
public String selectDepartmentName(int departmentId) {
		
		// 変数宣言
		Connection con = null;
		PreparedStatement ps = null;
		
		// 戻り値を格納する変数の確認
		String departmentName = "";
		
		// SQL文発行
		String sql = "SELECT "
						+ "department_name "
					+ "FROM "
						+ "department_info "
					+ "WHERE "
						+ "department_id = ?";
		
		try {
			
			// DBに接続する
			con = DAOconnection.getConnection();
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, departmentId);
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				
				departmentName = rs.getString("department_name");
			}
			
		} catch (SQLException e) {
			System.err.println("RequestLicenseDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("RequestLicenseDAOの不明なエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				System.err.println("RequestLicenseDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("RequestLicenseDAOの不明なエラー: " + e.getMessage());
			}
		}
		
		return departmentName;
	}
	
	public String selectGroupName(int departmentId) {
		
		// 変数宣言
		Connection con = null;
		PreparedStatement ps = null;
		
		// 戻り値を格納する変数の確認
		String groupName = "";
		
		// SQL文発行
		String sql = "SELECT "
						+ "group_name "
					+ "FROM "
						+ "group_info "
					+ "WHERE "
						+ "group_id = ?";
		
		try {
			
			// DBに接続する
			con = DAOconnection.getConnection();
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, departmentId);
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				
				groupName = rs.getString("group_name");
			}
			
		} catch (SQLException e) {
			System.err.println("RequestLicenseDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("RequestLicenseDAOの不明なエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				System.err.println("RequestLicenseDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("RequestLicenseDAOの不明なエラー: " + e.getMessage());
			}
		}
		
		return groupName;
	}

}
