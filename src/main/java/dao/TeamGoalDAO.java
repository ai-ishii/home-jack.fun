package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.TeamGoal;

public class TeamGoalDAO {

	//接続用の情報をフィールドに定数として定義
	private static final String RDB_DRIVE = "org.mariadb.jdbc.Driver";
	private static final String URL = "jdbc:mariadb://localhost/jackdb";
	private static final String USER = "root";
	private static final String PASSWD = "root123";

	/**
	 * データベース接続を行うメソッド
	 * データベース接続用定義を基にデータベースへ接続し、戻り値としてコネクション情報を返す
	 * @return con
	 */
	private static Connection getConnection() {
		try {
			Class.forName(RDB_DRIVE);
			Connection con = DriverManager.getConnection(URL, USER, PASSWD);
			return con;
		} catch (Exception e) {
			throw new IllegalStateException(e);
		}
	}

	/**
	 * 検索を行うメソッド
	 * @param ユーザID
	 * @return ユーザーの部目標
	 */
	public TeamGoal selectByUserId(int userId) {

		Connection con = null;
		Statement smt = null;

		//呼び出し元に返すオブジェクトの生成

		//SQL文
		String sql = "SELECT * FROM team_goal_info WHERE user_id=" + userId;
		TeamGoal teamGoal = new TeamGoal();

		try {
			con = getConnection();
			smt = con.createStatement();

	
			
			//SQL文をDBに移行
			ResultSet rs = smt.executeQuery(sql);

			//検索結果を配列に格納
			while (rs.next()) {
				teamGoal.setTeamId(rs.getString("team_id"));
				teamGoal.setUserId(rs.getInt("user_id"));
				teamGoal.setManagementTheme(rs.getString("management_theme"));
				teamGoal.setDepartmentGoal(rs.getString("department_goal"));
				teamGoal.setGroupGoal(rs.getString("group_goal"));
				teamGoal.setRegistDate(rs.getTimestamp("regist_date"));
				teamGoal.setUpdateDate(rs.getTimestamp("update_date"));
			}

		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
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
		return teamGoal;
	}
	
	
	/**
	 * 
	 * @param teamGoal
	 * @throws IllegalStateException 例外が発生した場合
	 */
	public void update(TeamGoal teamGoal) {

		Connection con = null;
		Statement smt = null;
		PreparedStatement ps = null;
		

		//SQL文
		String sql = "UPDATE team_goal_info SET "
				+ "department_goal=?,"
				+ "group_goal=? "
				+ "WHERE team_id = ?";
		try {
			con = getConnection();
			smt = con.createStatement();
			ps = con.prepareStatement(sql);

			ps.setString(1, teamGoal.getDepartmentGoal());
			ps.setString(2, teamGoal.getGroupGoal());
			ps.setString(3, teamGoal.getTeamId());

			//SQL文をDBに移行
			ps.executeUpdate();

		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
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
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException ignore) {
				}
			}
		}
	}

	
}
