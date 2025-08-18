/**
 * 経営目標DAO
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月8日
 * 
 * 最終更新日：8月18日
 * 
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.GoalDepartment;
import util.DAOconnection;

public class GoalDepartmentDAO {

	/**
	 * 部目標を更新するメソッド
	 * @param goalDepartment
	 * @throws IllegalStateException 例外が発生した場合
	 */
	public void update(GoalDepartment goalDepartment) {

		Connection con = null;
		PreparedStatement smt = null;
		
		boolean success = false;
		
		String groupCode = goalDepartment.getGroupCode();
		String departmentCode = groupCode.substring(0, 3);

		//SQL文
		String sql_A = "UPDATE "
							+ "goal_department_info "
						+ "SET "
							+ "management_theme = ? "
						+ "WHERE "
							+ "end_date = null;";
		
		String sql_B = "UPDATE "
							+ "goal_department_info "
						+ "SET "
							+ "department_goal = ?"
						+ "WHERE "
							+ "group_code LIKE '" + departmentCode + "%';";
		
		String sql_C = "UPDATE "
							+ "goal_department_info "
						+ "SET "
							+ "group_goal = ?"
						+ "WHERE "
							+ "group_code = '" + groupCode + "';";
		
		try {
			// DBに接続
			con = DAOconnection.getConnection();
			
			// オートコミットを無効化
			con.setAutoCommit(false);
			
			smt = con.prepareStatement(sql_A);

			// 1つ目のSQL文実行
			smt.setString(1, goalDepartment.getManagementTheme());
			smt.addBatch();
			smt.executeBatch();
			
			// 2つ目のSQL文実行
			smt = con.prepareStatement(sql_B);
			
			smt.setString(1, goalDepartment.getDepartmentGoal());
			smt.addBatch();
			smt.executeBatch();
			
			// 3つ目のSQL文実行
			smt = con.prepareStatement(sql_C);
			
			smt.setString(1, goalDepartment.getDepartmentGoal());
			smt.addBatch();
			smt.executeBatch();
			
			con.commit();
			success = true;

		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
			if (!success && con != null) {
				try {
					System.err.println("トランザクションが失敗したため、ロールバックします。");
					con.rollback();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			//リソースの開放
			if (smt != null) {
				try {
					smt.close();
				} catch (SQLException ignore) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ignore) {
				}
			}
		}
	}

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

	} catch (SQLException e) {
		System.err.println("GoalDepartmentDAOのデータベース接続時にエラー: " + e.getMessage());
		throw new IllegalStateException(e);
	} catch (Exception e) {
		System.err.println("GoalDepartmentDAOの不明なエラー: " + e.getMessage());
		throw new IllegalStateException(e);
	} finally {
		try {
			if (smt != null) {
				smt.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (SQLException e) {
			System.err.println("GoalDepartmentDAOのcon，smtクローズ時にエラー: " + e.getMessage());
		} catch (Exception e) {
			System.err.println("GoalDepartmentDAOの不明なエラー: " + e.getMessage());
		}
	}

	return goalDepartment;
}

}
