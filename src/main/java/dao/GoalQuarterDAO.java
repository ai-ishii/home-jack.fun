/**
 * 四半期目標DAO 
 * 
 * 作成者：月向亮太
 * 
 * 作成日：7月10日
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
import java.util.ArrayList;

import bean.GoalQuarter;
import util.DAOconnection;

public class GoalQuarterDAO {
	
	/**
	 * 検索を行うメソッド
	 * 
	 * @return すべての四半期目標情報
	 * @throws IllegalStateException 例外が発生した場合
	 */
	public ArrayList<GoalQuarter> selectByGoalId(int goalId) {

		Connection con = null;
		Statement smt = null;

		//呼び出し元に返すオブジェクトの生成
		ArrayList<GoalQuarter> goalQuarterList = new ArrayList<GoalQuarter>();

		//SQL文
		String sql = "SELECT "
						+ "goal_quarter_id, "
						+ "small_goal, "
						+ "judge_material, "
						+ "achieve_rate, "
						+ "report, "
						+ "achieve_rate_reviewer, "
						+ "evaluation, "
						+ "quarterly_flag "
						+ "FROM goal_quarter_info "
					+ "WHERE "
						+ "goal_id=" + goalId;

		try {
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//SQL文をDBに移行
			ResultSet rs = smt.executeQuery(sql);

			//検索結果を配列に格納
			while (rs.next()) {
				GoalQuarter goalQuarter = new GoalQuarter();
				goalQuarter.setGoalQuarterId(rs.getInt("goal_quarter_id"));
				goalQuarter.setSmallGoal(rs.getString("small_goal"));
				goalQuarter.setJudgeMaterial(rs.getString("judge_material"));
				goalQuarter.setAchieveRate(rs.getInt("achieve_rate"));
				goalQuarter.setReport(rs.getString("report"));
				goalQuarter.setAchieveRateReviewer(rs.getInt("achieve_rate_reviewer"));
				goalQuarter.setEvaluation(rs.getString("evaluation"));
				goalQuarter.setQuarterlyFlag(rs.getInt("quarterly_flag"));

				goalQuarterList.add(goalQuarter);
			}

		} catch (SQLException e) {
			System.err.println("GoalQuarterDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("GoalQuarterDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("GoalQuarterDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("GoalQuarterDAOの不明なエラー: " + e.getMessage());
			}
		}
		return goalQuarterList;
	}
	
	/**
	 * 
	 * @param goalQuarter
	 * @throws IllegalStateException 例外が発生した場合
	 */
	public void update(GoalQuarter goalQuarter) {

		Connection con = null;
		PreparedStatement smt = null;

		//SQL文
		String sql = "UPDATE "
						+ "goal_quarter_info "
					+ "SET "
						+ "small_goal=?,"
						+ "judge_material=?,"
						+ "achieve_rate=?,"
						+ "report=?,"
						+ "achieve_rate_reviewer=?,"
						+ "evaluation=?, "
						+ "quarterly_flag=? "
					+ "WHERE "
						+ "goal_quarter_id = ?";
		try {
			con = DAOconnection.getConnection();
			smt = con.prepareStatement(sql);

			smt.setString(1, goalQuarter.getSmallGoal());
			smt.setString(2, goalQuarter.getJudgeMaterial());
			smt.setInt(3, goalQuarter.getAchieveRate());
			smt.setString(4, goalQuarter.getReport());
			smt.setInt(5, goalQuarter.getAchieveRateReviewer());
			smt.setString(6, goalQuarter.getEvaluation());
			smt.setInt(7, goalQuarter.getQuarterlyFlag());
			smt.setInt(8, goalQuarter.getGoalQuarterId());

			//SQL文をDBに移行
			smt.executeUpdate();

		} catch (SQLException e) {
			System.err.println("goalQuarterDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("goalQuarterDAOの不明なエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} finally {
			try {
				if (smt != null) {
					smt.close();
				}
				if (con != null) {
					con.close();
				}
				if (smt != null) {
					smt.close();
				}
			} catch (SQLException e) {
				System.err.println("goalQuarterDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("goalQuarterDAOの不明なエラー: " + e.getMessage());
			}
		}
	}

}
