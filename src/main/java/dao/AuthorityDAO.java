package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.Authority;
import bean.AuthorityHaving;
import util.DAOconnection;


public class AuthorityDAO {

	/**
	 * 権限の名称とコードの対応表(配列)を持ってくるメソッド
	 * @return ArrayList<Authority> 権限名称コード対応表
	 */
	public ArrayList<Authority> selectAllAuthority () {

		Connection con = null;
		Statement smt = null;

		//配列宣言
		ArrayList<Authority> list = new ArrayList<Authority>();



		//SQL文
		String sql = "SELECT "
				+ "category_id, "
				+ "authority_code, "
				+ "authority_name "
				+ "FROM authority_code_info";

		try {
			// DBに接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//リザルトセットに格納
			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				//DTO宣言
				Authority authority = new Authority();
				authority.setCategoryId(rs.getInt("category_id"));
				authority.setAuthorityCode(rs.getString("authority_code"));
				authority.setAuthorityName(rs.getString("authority_name"));
				list.add(authority);
			}

		} catch (SQLException e) {
			System.err.println("AuthorityDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("AuthorityDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("AuthorityDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("AuthorityDAOの不明なエラー: " + e.getMessage());
			}
		}
		return list;
	}

	/**
	 * 受け取った権限IDのコード名と名称を変更するメソッド
	 * @param id 権限ID
	 * @param authority コード名と名称
	 */
	public void updateAuthority (int id, Authority authority) {

		Connection con = null;
		Statement smt = null;

		try {
			//SQL文
			String sql = "UPDATE authority_code_info SET "
					+ "authority_code = " + authority.getAuthorityCode() + ", "
					+ "authority_name = " + authority.getAuthorityName()
					+" WHERE category_id = " + id;

			// DBに接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//更新
			smt.executeUpdate(sql);

		} catch (SQLException e) {
			System.err.println("AuthorityDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("AuthorityDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("AuthorityDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("AuthorityDAOの不明なエラー: " + e.getMessage());
			}
		}
	}

	/**
	 * 受け取った値に一致するユーザーIDの権限を取得するメソッド
	 * @param userId
	 * @return ユーザーの権限リスト
	 */
	public ArrayList<AuthorityHaving> selectByUserId (int userId) {

		Connection con = null;
		Statement smt = null;

		//配列宣言
		ArrayList<AuthorityHaving> list = new ArrayList<AuthorityHaving>();
		
		String sql = "SELECT "
						+ "auth.authority_id, "
						+ "auth.user_id, "
						+ "auth.authority_code, "
						+ "auth.regist_date "
					+ "FROM "
						+ "authority_info AS auth "
					+ "INNER JOIN ("
						+ "SELECT "
							+ "user_id, "
							+ "MAX(regist_date) AS latest_date "
						+ "FROM "
							+ "authority_info GROUP BY user_id"
					+ ") AS subq "
					+ "ON auth.user_id = subq.user_id "
					+ "AND auth.regist_date = subq.latest_date "
					+ "WHERE auth.user_id = " + userId;

		try {
			// DBに接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//リザルトセットに格納
			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				//DTO宣言
				AuthorityHaving authHave = new AuthorityHaving();
				authHave.setAuthorityId(rs.getInt("authority_id"));
				authHave.setAuthorityCode(rs.getString("authority_code"));
				list.add(authHave);
			}

		} catch (SQLException e) {
			System.err.println("AuthorityDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("AuthorityDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("AuthorityDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("AuthorityDAOの不明なエラー: " + e.getMessage());
			}
		}
		return list;
	}

	/**
	 * 受け取ったユーザーIDと配列をもとに、権限をつけなおすメソッド
	 * @param userId
	 * @param list
	 */
	public void updateAuthorityHaving (int userId, ArrayList<AuthorityHaving> list) {
		
		Connection con = null;
		PreparedStatement smt = null;
		
		boolean success = false;
		
		String sql = "INSERT INTO "
						+ "authority_info ("
							+ "authority_id, "
							+ "user_id, "
							+ "authority_code, "
							+ "regist_date) "
						+ "VALUES ("
							+ "NULL, "
							+ "?, "
							+ "?, "
							+ "NOW());";
		
		try {
			// DBに接続
			con = DAOconnection.getConnection();
			
			//オートコミットを無効化
			con.setAutoCommit(false);
			
			smt = con.prepareStatement(sql);
			
			for (AuthorityHaving role : list) {
				smt.setInt(1, userId);
				smt.setString(2, role.getAuthorityCode());
				smt.addBatch();
			}
			
			smt.executeBatch();
			
			con.commit();
			success = true;

		} catch (SQLException e) {
			System.err.println("AuthorityDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("AuthorityDAOの不明なエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} finally {
			if (!success && con != null) {
				try {
					System.err.println("トランザクションが失敗したため、ロールバックします。");
					con.rollback();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			try {
				if (smt != null) {
					
					smt.close();
				}
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}
			} catch (SQLException e) {
				System.err.println("AuthorityDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("AuthorityDAOの不明なエラー: " + e.getMessage());
			}
		}
	}
	
	
}
