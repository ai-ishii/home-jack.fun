/**
 * 年間目標DAO
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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Goal;
import util.DAOconnection;

public class GoalDAO {

	/**
	 * 一覧表示する情報を検索するメソッド
	 * 
	 * @return ユーザー情報
	 * @throws IllegalStateException 例外が発生した場合
	 */
	public Goal selectByUserId(int userId) {

		// DB接続用変数の宣言
		Connection con = null;
		Statement smt = null;

		//呼び出し元に返すオブジェクトの生成
		Goal goal = new Goal();

		//SQL文
		String sql = "SELECT "
				+ "goal_id, "
				+ "group_code, "
				+ "user_id, "
				+ "annual_goal, "
				+ "situation_challenge, "
				+ "result, "
				+ "result_comment, "
				+ "result_reviewer, "
				+ "result_comment_reviewer, "
				+ "start_date, "
				+ "update_date, "
				+ "end_date "
				+ "FROM goal_info WHERE user_id=" + userId + ";";

		try {
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//SQL文をDBに移行
			ResultSet rs = smt.executeQuery(sql);

			//検索結果を配列に格納
			while (rs.next()) {
				goal.setGoalId(rs.getInt("goal_id"));
				goal.setGroupCode(rs.getString("group_code"));
				goal.setUserId(rs.getInt("user_id"));
				goal.setAnnualGoal(rs.getString("annual_goal"));
				goal.setSituationChallenge(rs.getString("situation_challenge"));
				goal.setResult(rs.getInt("result"));
				goal.setResultComment(rs.getString("result_comment"));
				goal.setResultReviewer(rs.getInt("result_reviewer"));
				goal.setResultCommentReviewer(rs.getString("result_comment_reviewer"));
				goal.setStartDate(rs.getTimestamp("start_date"));
				goal.setUpdateDate(rs.getTimestamp("update_date"));
				goal.setEndDate(rs.getTimestamp("end_date"));
			}

		} catch (SQLException e) {
			System.err.println("GoalDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("GoalDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("GoalDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("GoalDAOの不明なエラー: " + e.getMessage());
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
			con = DAOconnection.getConnection();
			smt = con.createStatement();
			ps = con.prepareStatement(sql);

			ps.setString(1, goal.getAnnualGoal());
			ps.setString(2, goal.getSituationChallenge());
			ps.setInt(3, goal.getResult());
			ps.setString(4, goal.getResultComment());
			ps.setInt(5, goal.getResultReviewer());
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
