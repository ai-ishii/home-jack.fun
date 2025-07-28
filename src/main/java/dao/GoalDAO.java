package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Goal;

public class GoalDAO {

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
	 * 全検索を行うメソッド
	 * 
	 * @return ユーザー情報
	 * @throws IllegalStateException 例外が発生した場合
	 */
	public Goal selectByUserId(int userId) {

		Connection con = null;
		Statement smt = null;

		//呼び出し元に返すオブジェクトの生成

		//SQL文
		String sql = "SELECT * FROM goal_info WHERE user_id=" + userId;
		Goal goal = new Goal();

		try {
			con = getConnection();
			smt = con.createStatement();

			//SQL文をDBに移行
			ResultSet rs = smt.executeQuery(sql);

			//検索結果を配列に格納
			while (rs.next()) {
				goal.setGoalId(rs.getInt("goal_id")); //個人目標ID
				goal.setTeamId(rs.getString("team_id")); //グループ目標ID
				goal.setUserId(rs.getInt("user_id")); //ユーザー情報ID
				goal.setAnnualGoal(rs.getString("annual_goal")); //年間目標
				goal.setSituationChallenge(rs.getString("situation_challenge")); //現状と課題
				goal.setResult(rs.getString("result")); //年間結果達成率
				goal.setResultComment(rs.getString("result_comment")); //年間結果コメント
				goal.setResultReviewer(rs.getString("result_reviewer")); //年間結果達成率（評価者）
				goal.setResultCommentReviewer(rs.getString("result_comment_reviewer")); //年間結果コメント（評価者）
				goal.setRegistDate(rs.getTimestamp("regist_date")); //登録日時
				goal.setUpdateDate(rs.getTimestamp("update_date")); //更新日時
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
		return goal;
	}

	/**
	 * 情報を更新するメソッド
	 * 
	 * @param 更新したい情報
	 * @throws IllegalStateException 例外が発生した場合
	 */
	public void update(Goal goal) {

		Connection con = null;
		Statement smt = null;
		PreparedStatement ps = null;

		//SQL文
		String sql = "UPDATE goal_info SET "
		        + "annual_goal=?,"
		        + "situation_challenge=?,"
		        + "result=?,"
		        + "result_comment=?,"
		        + "result_reviewer=?,"
		        + "result_comment_reviewer=? "
		        + "WHERE goal_id = ?";
		try {
			con = getConnection();
			smt = con.createStatement();
			ps = con.prepareStatement(sql);

			ps.setString(1, goal.getAnnualGoal());
			ps.setString(2, goal.getSituationChallenge());
			ps.setString(3, goal.getResult());
			ps.setString(4, goal.getResultComment());
			ps.setString(5, goal.getResultReviewer());
			ps.setString(6, goal.getResultCommentReviewer());
			ps.setInt(7, goal.getGoalId());

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
