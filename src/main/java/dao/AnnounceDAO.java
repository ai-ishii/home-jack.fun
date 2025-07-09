package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.Announce;

public class AnnounceDAO {

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
	 * DBにあるお知らせ情報を全件取得するメソッド
	 * @return ArrayList<Announce> list
	 */
	public ArrayList<Announce> selectAnnounceAll() {

		// 変数宣言
		Connection con = null;
		Statement smt = null;

		// 配列宣言
		ArrayList<Announce> list = new ArrayList<Announce>();

		// SQL文
		String sql = "SELECT * FROM announce_info";

		try {
			// DBに接続
			con = AnnounceDAO.getConnection();
			smt = con.createStatement();

			// SQL文発行
			ResultSet rs = smt.executeQuery(sql);

			// 検索結果をArrayListに格納
			while (rs.next()) {
				Announce announce = new Announce();
				announce.setAnnounceId(rs.getInt("announce_id"));
				announce.setUserId(rs.getInt("user_id"));
				announce.setName(rs.getString("name"));
				announce.setRegistDate(rs.getTimestamp("regist_date"));
				announce.setUpdateDate(rs.getTimestamp("update_date"));
				announce.setTitle(rs.getString("title"));
				announce.setText(rs.getString("text"));
				announce.setImage(rs.getString("image"));
				announce.setComment(rs.getString("comment"));
				announce.setLikeFlag(rs.getInt("iine_flag"));
				announce.setAnnounceFlag(rs.getInt("announce_flag"));
				announce.setFavoriteFlag(rs.getInt("favorite_flag"));
				announce.setCategory(rs.getInt("category"));
				announce.setTag(rs.getString("tag"));
				announce.setFile(rs.getString("file"));
				list.add(announce);
			}
		} catch (Exception e) {
				throw new IllegalStateException(e);
		} finally {
			// リソースの解放
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
		
		return list;
	}
}
