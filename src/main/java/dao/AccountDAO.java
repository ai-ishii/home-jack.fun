package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Account;
import util.DAOconnection;

public class AccountDAO {

		/**
		 * メールアドレスでアカウント情報を検索し取り出すメソッド
		 * @param email
		 * @return アカウント情報
		 */
		public Account selectByEmail(String email) {
			
			Connection con = null;
			Statement smt = null;
			
			Account account = new Account();
			
			String sql = "SELECT account_id, email FROM account_info WHERE email = '" + email + "'";
			
			try {
				// DBに接続
				con = DAOconnection.getConnection();
				smt = con.createStatement();
				
				ResultSet rs = smt.executeQuery(sql);
				
				if (rs.next()) {
					account.setAccountId(rs.getString("account_id"));
					account.setEmail(rs.getString("email"));
				}
				
			} catch (SQLException e) {
				System.err.println("AccountDAOのデータベース接続時にエラー: " + e.getMessage());
				throw new IllegalStateException(e);
			} catch (Exception e) {
				System.err.println("AccountDAOの不明なエラー: " + e.getMessage());
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
					System.err.println("AccountDAOのcon，smtクローズ時にエラー: " + e.getMessage());
				} catch (Exception e) {
					System.err.println("AccountDAOの不明なエラー: " + e.getMessage());
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
			
			String sql = "SELECT account_id, email FROM account_info WHERE account_id = '" + accountId + "'";
			
			try {
				// DBに接続
				con = DAOconnection.getConnection();
				smt = con.createStatement();
				
				ResultSet rs = smt.executeQuery(sql);
				
				if (rs.next()) {
					account.setAccountId(rs.getString("account_id"));
					account.setEmail(rs.getString("email"));
				}
				
			} catch (SQLException e) {
				System.err.println("AccountDAOのデータベース接続時にエラー: " + e.getMessage());
				throw new IllegalStateException(e);
			} catch (Exception e) {
				System.err.println("AccountDAOの不明なエラー: " + e.getMessage());
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
					System.err.println("AccountDAOのcon，smtクローズ時にエラー: " + e.getMessage());
				} catch (Exception e) {
					System.err.println("AccountDAOの不明なエラー: " + e.getMessage());
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
				con = DAOconnection.getConnection();
				smt = con.createStatement();
				
				count = smt.executeUpdate(sql);
				
			} catch (SQLException e) {
				System.err.println("AccountDAOのデータベース接続時にエラー: " + e.getMessage());
				throw new IllegalStateException(e);
			} catch (Exception e) {
				System.err.println("AccountDAOの不明なエラー: " + e.getMessage());
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
					System.err.println("AccountDAOのcon，smtクローズ時にエラー: " + e.getMessage());
				} catch (Exception e) {
					System.err.println("AccountDAOの不明なエラー: " + e.getMessage());
				}
			}
			return count;
			
		}
}
