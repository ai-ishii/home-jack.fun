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
				announce.getAnnounceId();
				announce.getUserId();
				announce.getRegistDate();
				announce.getUpdateDate();
				announce.getTitle();
				announce.getText();
				announce.getImage();
				announce.getComment();
				announce.getLikeFlag();
				announce.getAnnounceFlag();
				announce.getFavoriteFlag();
				announce.getCategory();
				announce.getTag();
				announce.getFile();
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
