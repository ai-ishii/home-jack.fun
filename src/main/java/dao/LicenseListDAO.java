/*
 * 資格状況確認一覧DAO
 * 7/14 
 * 川上
 * 
 */

package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.LicenseList;
import util.DAOconnection;

public class LicenseListDAO {

	/**
	 * 全データ検索メソッド
	 * 
	* @return list
	*/
	public ArrayList<LicenseList> selectAll() {
		//変数宣言
		Connection con = null;
		Statement smt = null;

		//オブジェクト生成
		ArrayList<LicenseList> list = new ArrayList<LicenseList>();

		//SQL文
		String sql = " SELECT license_list_id, user_id, regist_date, image FROM license_list_info";

		try {
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//SQL文を発行
			ResultSet rs = smt.executeQuery(sql);

			//検索結果を格納
			while (rs.next()) {
				LicenseList licenselist = new LicenseList();
				licenselist.setLicenseListId(rs.getInt("license_list_id"));
				licenselist.setUserId(rs.getInt("user_id"));
				licenselist.setRegistDate(rs.getTimestamp("regist_date"));
				licenselist.setImage(rs.getString("image"));
				//listに格納
				list.add(licenselist);

			}
		} catch (Exception e) {
			throw new IllegalStateException(e);

		} finally {
			//リソース開放
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
		return list;//return end

	}

	public ArrayList<LicenseList> selectByLicenseListId(int licenseListId) {
		//変数の宣言
		Connection con = null;
		Statement smt = null;

		ArrayList<LicenseList> list = new ArrayList<LicenseList>();

		try {

			//SQL文
			String sql = "SELECT license_list_id, user_id, regist_date, image FROM license_list_info "
					+ "WHERE license_list_id = " + licenseListId + ";";

			// データベース接続の準備
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			// SQL文発行
			ResultSet rs = smt.executeQuery(sql);
			//繰り返し処理。一行ずつ格納
			while (rs.next()) {
				LicenseList licenselist = new LicenseList();
				licenselist.setLicenseListId(rs.getInt("licenselistid"));
				licenselist.setUserId(rs.getInt("userid"));
				licenselist.setRegistDate(rs.getTimestamp("registDate"));
				licenselist.setImage(rs.getString("image"));

				//listに格納
				list.add(licenselist);
			}

		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
			//リソース開放
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
		return list;//return end
	}

	public ArrayList<LicenseList> selectByUserId(int userId) {
		//変数の宣言
		Connection con = null;
		Statement smt = null;

		ArrayList<LicenseList> list = new ArrayList<LicenseList>();

		try {

			//SQL文
			String sql = "SELECT user_id FROM license_list_info "
					+ "WHERE user_id = " + userId + ";";

			// データベース接続の準備
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			// SQL文発行
			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				LicenseList licenselist = new LicenseList();
				licenselist.setLicenseListId(rs.getInt("license_list_id"));
				licenselist.setUserId(rs.getInt("user_id"));
				licenselist.setRegistDate(rs.getTimestamp("regist_date"));
				licenselist.setImage(rs.getString("image"));

				//listに格納
				list.add(licenselist);
			}

		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
			//リソース開放
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
		return list;//return end

	}

}
