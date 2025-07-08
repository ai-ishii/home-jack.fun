package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.User;

public class UserDAO {

	//接続用の情報をフィールドに定数として定義
<<<<<<< HEAD
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

	/**
	 * 全情報を取得するメソッド
	 * 
	 * @return ユーザーの全情報
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 */
	public ArrayList<User> selectAll() {
		Connection con = null;
		Statement smt = null;

		//戻り値用のArrayListを作成
		ArrayList<User> userList = new ArrayList<User>();

		//SQL文の作成
		String sql = "SELECT * FROM user_info";

		try {
			// データベース接続
			con = getConnection();
			smt = con.createStatement();

			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				User user = new User();
				user.setUser_id(rs.getInt("user_id"));
				user.setAcount_id(rs.getInt("account_id"));
				user.setName(rs.getString("name"));
				user.setName_kana(rs.getString("name_kana"));
				user.setBirthday(rs.getDate("birthday"));
				user.setAddress(rs.getString("address"));
				user.setPhone(rs.getString("phone"));
				user.setNearest_station(rs.getString("nearest_station"));
				user.setTransportation(rs.getString("transportation"));
				user.setSex(rs.getString("sex"));
				user.setEmployee_number(rs.getString("employee_number"));
				user.setDepartment(rs.getString("department"));
				user.setTeam(rs.getString("team"));
				user.setJoining_date(rs.getTimestamp("joining_date"));
				user.setWork_history(rs.getInt("work_history"));
				user.setMarriage_flag(rs.getInt("marriage_flag"));
				user.setChildren(rs.getInt("children"));
				user.setQualification(rs.getString("qualification"));
				user.setDisplay_flag(rs.getInt("display_flag"));
				user.setRest_flag(rs.getInt("rest_flag"));
				user.setRegist_date(rs.getTimestamp("regist_date"));
				user.setUpdate_date(rs.getTimestamp("update_date"));
				userList.add(user);
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
		return userList;
	}

=======
		private static final String RDB_DRIVE="org.mariadb.jdbc.Driver";
	 	private static final String URL="jdbc:mariadb://localhost/jackdb";
	 	private static final String USER="root";
	 	private static final String PASSWD="root123";
	 
	 	/**
	 	 * データベース接続を行うメソッド
	 	 * データベース接続用定義を基にデータベースへ接続し、戻り値としてコネクション情報を返す
	 	 * @return con
	 	 */
	 	private static Connection getConnection(){
	 		try{
	 			Class.forName(RDB_DRIVE);
	 			Connection con = DriverManager.getConnection(URL, USER, PASSWD);
	 			return con;
	 		}catch(Exception e){
	 			throw new IllegalStateException(e);
	 		}
	 	}
>>>>>>> branch 'master' of https://github.com/ai-ishii/home-jack.fun.git
}
