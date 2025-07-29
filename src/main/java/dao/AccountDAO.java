package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Account;

public class AccountDAO {

	//接続用の情報をフィールドに定数として定義
		private static final String RDB_DRIVE="org.mariadb.jdbc.Driver";
	 	private static final String URL="jdbc:mariadb://localhost/jackdb";
	 	private static final String USER="root";
	 	private static final String PASSWD="root123";
	 
	 	/**
	 	 * データベース接続を行うメソッド
	 	 * データベース接続用定義を基にデータベースへ接続し、戻り値としてコネクション情報を返す
	 	 * @return con
	 	 */private static Connection getConnection(){
	 		try{
	 			Class.forName(RDB_DRIVE);
	 			Connection con = DriverManager.getConnection(URL, USER, PASSWD);
	 			return con;
	 		}catch(Exception e){
	 			throw new IllegalStateException(e);
	 		}
	 	}
		/**
		 * メールアドレスでアカウント情報を検索し取り出すメソッド
		 * @param email
		 * @return アカウント情報
		 */
		public Account selectByEmail(String email) {
			
			Connection con = null;
			Statement smt = null;
			
			Account account = new Account();
			
			String sql = "SELECT account_id, email, admin_flag, manager_flag FROM account_info WHERE email = '" + email + "'";
			
			try {
				// DBに接続
				con = getConnection();
				smt = con.createStatement();
				
				ResultSet rs = smt.executeQuery(sql);
				
				if (rs.next()) {
					account.setAccountId(rs.getString("account_id"));
					account.setEmail(rs.getString("email"));
					account.setAdminFlag(rs.getInt("admin_flag"));
					account.setManagerFlag(rs.getInt("manager_flag"));
				}
				
			} catch (Exception e) {
				throw new IllegalStateException(e);
			} finally {
				// リソースの解放
				if (smt != null) {
					try {
						smt.close();
					} catch (SQLException ignore) { }
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException ignore) { }
				}
			}
			return account;
		}
		
		/**
		 * アカウントIDでアカウント情報を検索し取り出すメソッド
		 * @param AccountId
		 * @return アカウント情報
		 */
		public Account selectByAccountId (String accountId) {
			
			Connection con = null;
			Statement smt = null;
			
			Account account = new Account();
			
			String sql = "SELECT account_id, email, admin_flag, manager_flag FROM account_info WHERE account_id = '" + accountId + "'";
			
			try {
				// DBに接続
				con = getConnection();
				smt = con.createStatement();
				
				ResultSet rs = smt.executeQuery(sql);
				
				if (rs.next()) {
					account.setAccountId(rs.getString("account_id"));
					account.setEmail(rs.getString("email"));
					account.setAdminFlag(rs.getInt("admin_flag"));
					account.setManagerFlag(rs.getInt("manager_flag"));
				}
				
			} catch (Exception e) {
				throw new IllegalStateException(e);
			} finally {
				// リソースの解放
				if (smt != null) {
					try {
						smt.close();
					} catch (SQLException ignore) { }
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException ignore) { }
				}
			}
			return account;
		}
		
		
		public int insert (String accountId, String email) {

			Connection con = null;
			Statement smt = null;
			
			int count = 0;
			
			String sql = "INSERT INTO account_info (account_id, email) VALUES ('" + accountId + "' ,'" + email + "')";
			
			try {
				// DBに接続
				con = getConnection();
				smt = con.createStatement();
				
				count = smt.executeUpdate(sql);
				
			} catch (Exception e) {
				throw new IllegalStateException(e);
			} finally {
				// リソースの解放
				if (smt != null) {
					try {
						smt.close();
					} catch (SQLException ignore) { }
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException ignore) { }
				}
			}
			return count;
			
		}
}
