package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Monthjack;
import util.DAOconnection;

public class MonthjackDAO {

	/**
	 * DBの今月のJackWorks情報を格納するmonth_jackworks_infoテーブルから全情報を取得するメソッド
	 * 戻り値として今月のJackWorks全情報を返す
	 * @return mjackList
	 */
	public Monthjack selectAll() {
		Connection con = null;
		Statement smt = null;

		Monthjack monthJack = new Monthjack();

		try {
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			String sql = "SELECT month_jackworks_id, user_id, image, theme, note FROM month_jackworks_info";
			ResultSet rs = smt.executeQuery(sql);

			if (rs.next()) {
				monthJack.setMonthJackworksId(rs.getInt("month_jackworks_id"));
				monthJack.setUserId(rs.getInt("user_id"));
				monthJack.setImage(rs.getString("image"));
				monthJack.setTheme(rs.getString("theme"));
				monthJack.setNote(rs.getString("note"));
			}

		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
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
		return monthJack;
	}

	/**
	 * DBの今月のJackWorks情報を格納するmonth_jackworks_infoテーブルを更新するメソッド
	 * 
	 * @param 登録したい情報
	 */
	public void update(Monthjack monthJack) {
		Connection con = null;
		Statement smt = null;

		try {
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			String sql = "UPDATE month_jackworks_info SET user_id =  NULL , theme ='" + monthJack.getTheme() + "' , "
					+ "note = '" + monthJack.getNote() + "' , image = '" + monthJack.getImage() + "'"
					+ "WHERE month_jackworks_id = '1'";

			smt.executeUpdate(sql);

		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
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
}
