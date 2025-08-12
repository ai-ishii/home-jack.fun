/**
 * 経営目標DAO
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月8日
 * 
 * 最終更新日：8月12日
 * 
 */
package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.GoalDepartment;
import util.DAOconnection;

public class GoalDepartmentDAO {
	
	/**
	 * ユーザーが所属するチーム名とチームの目標を検索するメソッド
	 * @param groupCode
	 * @return goalDepartment
	 */
	public GoalDepartment selectByGroupCode(String groupCode) {
		
		// DB接続用変数の宣言
		Connection con = null;
		Statement smt = null;
		
		// 戻り値に設定する変数の宣言
		GoalDepartment goalDepartment = new GoalDepartment();
		
		// SQL文
		String sql = "SELECT "
				+ "name, "
				+ "management_theme, "
				+ "department_goal, "
				+ "group_goal "
				+ "FROM goal_department_info "
				+ "Where group_code = '" + groupCode + "';";
		
		try {
			// DB接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();
			
			// SQL文発行
			ResultSet rs = smt.executeQuery(sql);
			
			// 結果を変数に格納する
			while (rs.next()) {
				goalDepartment.setName(rs.getString("name"));
				goalDepartment.setManagementTheme(rs.getString("management_theme"));
				goalDepartment.setDepartmentGoal(rs.getString("department_goal"));
				goalDepartment.setGroupGoal(rs.getString("group_goal"));
			}
			
		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
			try {
				if (smt != null) {
					smt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException ignore) {
			}
		}
		
		return goalDepartment;
	}

}
