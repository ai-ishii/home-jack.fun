package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.QuarterGoal;
import util.DAOconnection;

public class QuarterGoalDAO {

	/**
	 * 検索を行うメソッド
	 * 
	 * @return すべての四半期目標情報
	 * @throws IllegalStateException 例外が発生した場合
	 */
	public ArrayList<QuarterGoal> selectByUserId(int userId) {

		Connection con = null;
		Statement smt = null;

		//呼び出し元に返すオブジェクトの生成
		ArrayList<QuarterGoal> quaterGoalList = new ArrayList<QuarterGoal>();

		//SQL文
		String sql = "SELECT quarter_goal_id, goal_id, user_id, small_goal,judge_material, achieve_rate, report, "
				+ "achieve_rate_reviewer, evaluation, quarterly_flag  FROM quarter_goal_info WHERE user_id=" + userId;

		try {
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//SQL文をDBに移行
			ResultSet rs = smt.executeQuery(sql);

			//検索結果を配列に格納
			while (rs.next()) {
				QuarterGoal quarterGoal = new QuarterGoal();
				quarterGoal.setQuarterGoalId(rs.getInt("quarter_goal_id"));
				quarterGoal.setGoalId(rs.getInt("goal_id"));
				quarterGoal.setUserId(rs.getInt("user_id"));
				quarterGoal.setSmallGoal(rs.getString("small_goal"));
				quarterGoal.setJudgeMaterial(rs.getString("judge_material"));
				quarterGoal.setAchieveRate(rs.getString("achieve_rate"));
				quarterGoal.setReport(rs.getString("report"));
				quarterGoal.setAchieveRateReviewer(rs.getString("achieve_rate_reviewer"));
				quarterGoal.setEvaluation(rs.getString("evaluation"));
				quarterGoal.setQuarterlyFlag(rs.getInt("quarterly_flag"));

				quaterGoalList.add(quarterGoal);
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
		return quaterGoalList;
	}

	/**
	 * 
	 * @param quarterGoal
	 * @throws IllegalStateException 例外が発生した場合
	 */
	public void update(QuarterGoal quarterGoal) {

		Connection con = null;
		Statement smt = null;
		PreparedStatement ps = null;

		//SQL文
		String sql = "UPDATE quarter_goal_info SET "
				+ "small_goal=?,"
				+ "judge_material=?,"
				+ "achieve_rate=?,"
				+ "report=?,"
				+ "achieve_rate_reviewer=?,"
				+ "evaluation=?, "
				+ "quarterly_flag=? "
				+ "WHERE quarter_goal_id = ?";
		try {
			con = DAOconnection.getConnection();
			smt = con.createStatement();
			ps = con.prepareStatement(sql);

			ps.setString(1, quarterGoal.getSmallGoal());
			ps.setString(2, quarterGoal.getJudgeMaterial());
			ps.setString(3, quarterGoal.getAchieveRate());
			ps.setString(4, quarterGoal.getReport());
			ps.setString(5, quarterGoal.getAchieveRateReviewer());
			ps.setString(6, quarterGoal.getEvaluation());
			ps.setInt(7, quarterGoal.getQuarterlyFlag());
			ps.setInt(8, quarterGoal.getQuarterGoalId());

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
