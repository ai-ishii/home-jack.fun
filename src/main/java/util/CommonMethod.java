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
import java.util.ArrayList;

import bean.CategoryMap;

public class CommonMethod {
	
	/**
	 * 部情報を取得するメソッド
	 * @param departmentId
	 * @return ArrayList<CategoryMap>
	 */
	public ArrayList<CategoryMap> selectDepartmentName(int departmentId) {
		
		// 変数宣言
		Connection con = null;
		PreparedStatement ps = null;
		
		// 戻り値を格納する変数の確認
		ArrayList<CategoryMap> list = new ArrayList<CategoryMap>();

		// SQL文発行
		String sql = "SELECT "
						+ "department_id, "
						+ "department_code, "
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
				
				CategoryMap department = new CategoryMap();
				
				department.setId(rs.getInt("department_id"));
				department.setCode(rs.getString("department_code"));
				department.setName(rs.getString("department_name"));
				
				list.add(department);
			}
			
		} catch (SQLException e) {
			System.err.println("#" + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("#" + e.getMessage());
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
				System.err.println("#" + e.getMessage());
			} catch (Exception e) {
				System.err.println("#" + e.getMessage());
			}
		}
		
		return list;
	}
	
	/**
	 * グループ情報を取得するメソッド
	 * @param departmentId
	 * @return ArrayList<CategoryMap>
	 */
	public ArrayList<CategoryMap> selectGroup(int departmentId) {
		
		// 変数宣言
		Connection con = null;
		PreparedStatement ps = null;
		
		// 戻り値を格納する変数の確認
		ArrayList<CategoryMap> list = new ArrayList<CategoryMap>();

		// SQL文発行
		String sql = "SELECT "
						+ "group_id, "
						+ "group_code, "
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
				
				CategoryMap group = new CategoryMap();
				
				group.setId(rs.getInt("group_id"));
				group.setCode(rs.getString("group_code"));
				group.setName(rs.getString("group_name"));
				
				list.add(group);
			}
			
		} catch (SQLException e) {
			System.err.println("#" + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("#" + e.getMessage());
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
				System.err.println("#" + e.getMessage());
			} catch (Exception e) {
				System.err.println("#" + e.getMessage());
			}
		}
		
		return list;
	}

}
