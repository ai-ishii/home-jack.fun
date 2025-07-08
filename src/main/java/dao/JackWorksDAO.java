package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.Jackworks;

public class JackWorksDAO {

	//接続用の情報をフィールドに定数として定義
	private static final String RDB_DRIVE = "org.mariadb.jdbc.Driver";
	private static final String URL = "jdbc:mariadb://localhost/jackdb";
	private static final String USER = "root";
	private static final String PASSWD = "root123";

	// データベース接続を行うメソッド
	// データベース接続用定義を基にデータベースへ接続し、戻り値としてコネクション情報を返す
	private static Connection getConnection() {
		try {
			Class.forName(RDB_DRIVE);
			Connection con = DriverManager.getConnection(URL, USER, PASSWD);
			return con;
		} catch (Exception e) {
			throw new IllegalStateException(e);
		}
	}

	//DBのJackWorks情報を格納するjackworks_infoテーブルから全情報を取得するメソッド
	public ArrayList<Jackworks> selectAll() {
		Connection con = null;
		Statement smt = null;

		ArrayList<Jackworks> jackList = new ArrayList<>();

		try {
			con = getConnection();
			smt = con.createStatement();

			String sql = "SELECT * FROM jackworks_info";
			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				Jackworks jack = new Jackworks();
				jack.getJackworksId();
				jack.getUserId();
				jack.getCategory();
				jack.getAssessment();
				jack.getPoint();
				jack.getPointsGetDate();
				jack.getNote();
				jackList.add(jack);
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
		return jackList;
	}

}
