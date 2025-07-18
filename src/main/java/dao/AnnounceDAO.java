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
	public ArrayList<Announce> selectAll() {

		// 変数宣言
		Connection con = null;
		Statement smt = null;

		// 配列宣言
		ArrayList<Announce> list = new ArrayList<Announce>();

		// SQL文
		String sql = "SELECT * FROM announce_info ORDER BY regist_date DESC";

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
				announce.setComment(rs.getString("comment"));
				announce.setLikeFlag(rs.getInt("like_flag"));
				announce.setAnnounceFlag(rs.getInt("announce_flag"));
				announce.setAnnounceCategoryId(rs.getInt("announce_category_id"));
				announce.setTag(rs.getString("tag"));
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

	/**
	 * 引数として受け取ったAnnounceIdをもとに
	 * Announce_infoテーブル内で検索を行うメソッド
	 * @param announceId
	 * @return Announce
	 */
	public Announce selectByAnnounceId(int announceId) {

		// 変数宣言
		Connection con = null;
		Statement smt = null;

		// SQL文
		String sql = "select * from announce_info where announce_id = " + announceId + ";";

		Announce announce = new Announce();

		try {
			// DBに接続
			con = AnnounceDAO.getConnection();
			smt = con.createStatement();

			// SQL文発行
			ResultSet rs = smt.executeQuery(sql);

			// 検索結果を変数に格納
			while (rs.next()) {
				announce.setAnnounceId(rs.getInt("announce_id"));
				announce.setUserId(rs.getInt("user_id"));
				announce.setName(rs.getString("name"));
				announce.setRegistDate(rs.getTimestamp("regist_date"));
				announce.setUpdateDate(rs.getTimestamp("update_date"));
				announce.setTitle(rs.getString("title"));
				announce.setText(rs.getString("text"));
				announce.setComment(rs.getString("comment"));
				announce.setLikeFlag(rs.getInt("like_flag"));
				announce.setAnnounceFlag(rs.getInt("announce_flag"));
				announce.setAnnounceCategoryId(rs.getInt("announce_category_id"));
				announce.setTag(rs.getString("tag"));
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

		return announce;
	}

	/**
	 * 最新3件のお知らせ情報を取得するメソッド
	 * @return 最新3件のお知らせが格納された可変長配列
	 */
	public ArrayList<Announce> selectNew() {

		// 変数宣言
		Connection con = null;
		Statement smt = null;

		// 配列宣言
		ArrayList<Announce> list = new ArrayList<Announce>();

		// SQL文
		String sql = "SELECT * FROM announce_info WHERE NOT announce_category_id = '2' ORDER BY regist_date DESC LIMIT 3";

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
				announce.setName(rs.getString("name"));
				announce.setRegistDate(rs.getTimestamp("regist_date"));
				announce.setUpdateDate(rs.getTimestamp("update_date"));
				announce.setTitle(rs.getString("title"));
				announce.setAnnounceFlag(rs.getInt("announce_flag"));
				announce.setAnnounceCategoryId(rs.getInt("announce_category_id"));
				announce.setTag(rs.getString("tag"));
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

	/**
	 * 重要なお知らせ(announce_flag = 1)をすべて取得するメソッド
	 * @return announce_flag = 1のお知らせ 
	 */
	public ArrayList<Announce> selectImportant() {

		// 変数宣言
		Connection con = null;
		Statement smt = null;

		// 配列宣言
		ArrayList<Announce> list = new ArrayList<Announce>();

		// SQL文
		String sql = "SELECT * FROM announce_info WHERE announce_flag = '1' ORDER BY regist_date DESC";

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
				announce.setName(rs.getString("name"));
				announce.setRegistDate(rs.getTimestamp("regist_date"));
				announce.setUpdateDate(rs.getTimestamp("update_date"));
				announce.setTitle(rs.getString("title"));
				announce.setAnnounceFlag(rs.getInt("announce_flag"));
				announce.setAnnounceCategoryId(rs.getInt("announce_category_id"));
				announce.setTag(rs.getString("tag"));
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

	/**
	 * 最新3件のチーム活動を取得するメソッド
	 * @return category = 2のチーム活動
	 */
	public ArrayList<Announce> selectActivity() {

		// 変数宣言
		Connection con = null;
		Statement smt = null;

		// 配列宣言
		ArrayList<Announce> list = new ArrayList<Announce>();

		// SQL文
		String sql = "SELECT * FROM announce_info WHERE announce_category_id = '2' ORDER BY regist_date DESC LIMIT 3";

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
				announce.setName(rs.getString("name"));
				announce.setRegistDate(rs.getTimestamp("regist_date"));
				announce.setUpdateDate(rs.getTimestamp("update_date"));
				announce.setTitle(rs.getString("title"));
				announce.setAnnounceFlag(rs.getInt("announce_flag"));
				announce.setAnnounceCategoryId(rs.getInt("announce_category_id"));
				announce.setTag(rs.getString("tag"));
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

	//	//受け取ったリストの画像を受け取るメソッド
	//	
	//	public ArrayList<AnnounceImage> selectImage (ArrayList<Announce> list) {
	//
	//		// 変数宣言
	//		Connection con = null;
	//		Statement smt = null;
	//
	//		// 配列宣言
	//		ArrayList<AnnounceImage> imageList = new ArrayList<AnnounceImage>();
	//		ArrayList<Integer> imageId = new ArrayList<Integer>();
	//		
	//		for (int i = 0; i < list.size(); i++) {
	//			imageId.add(list.get(i).getAnnounceId());
	//		}
	//		
	//		String placeholders = String.join(", ", Collections.nCopies(imageId.size(), "?"));
	//
	//		// SQL文
	//		String sql = "SELECT * FROM announce_image_info WHERE announce_id IN("  + placeholders + ")";
	//		
	//		try {
	//			// DBに接続
	//			con = AnnounceDAO.getConnection();
	//			smt = con.createStatement();
	//			
	//			// SQL文発行
	//			ResultSet rs = smt.executeQuery(sql);
	//
	//			// 検索結果をArrayListに格納
	//			while (rs.next()) {
	//				AnnounceImage image = new AnnounceImage();
	//				image.setAnnounceImageId(rs.getInt("announce_image_id"));
	//				image.setAnnounceId(rs.getInt("announce_id"));
	//				image.setImage(rs.getString("image"));
	//				imageList.add(image);
	//			}
	//			
	//		} catch (Exception e) {
	//			throw new IllegalStateException(e);
	//		} finally {
	//			// リソースの解放
	//			if (smt != null) {
	//				try {
	//					smt.close();
	//				} catch (SQLException ignore) { }
	//			}
	//			if (con != null) {
	//				try {
	//					con.close();
	//				} catch (SQLException ignore) { }
	//			}
	//		}
	//		return imageList;
	//	}

	public String selectByCategory(int categoryId) {

		// 変数宣言
		Connection con = null;
		Statement smt = null;

		String category = "";

		String sql = "SELECT * FROM announce_category_info WHERE announce_category_id = '" + categoryId + "'";

		try {
			// DBに接続
			con = AnnounceDAO.getConnection();
			smt = con.createStatement();

			// SQL文発行
			ResultSet rs = smt.executeQuery(sql);

			if (rs.next()) {
				category = rs.getString("category");
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
		return category;
	}

	/**
	 * 新規投稿をDBに登録するメソッド
	 * @param announce
	 */
	public void regist(Announce announce) {

		// 変数宣言
		Connection con = null;
		Statement smt = null;

		String sql = "INSERT INTO announce_info(announce_id, name,"
				+ " regist_date, update_date, title, text, comment,"
				+ " like_flag, announce_flag, announce_category_id, tag) "
				+ "VALUES (null, null, '" + announce.getRegistDate() + "', null, '"
				+ announce.getTitle() + "', '" + announce.getText() + "', null, 0, 0, "
				+ announce.getAnnounceCategoryId() + ", null)";

		try {
			// DBに接続
			con = AnnounceDAO.getConnection();
			smt = con.createStatement();

			// SQL文発行
			smt.executeUpdate(sql);

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
	}

	/**
	 * 投稿を編集してDBに登録するメソッド
	 * @param announce
	 */
	public void update(Announce announce) {

		// 変数宣言
		Connection con = null;
		Statement smt = null;

		String sql = "UPDATE announce_info SET title = '" + announce.getTitle() + "', update_date = '"
				+ announce.getUpdateDate() + "', text = '" + announce.getText() + "' WHERE announce_id = '"
				+ announce.getAnnounceId() + "'";

		try {
			// DBに接続
			con = AnnounceDAO.getConnection();
			smt = con.createStatement();

			// SQL文発行
			smt.executeUpdate(sql);

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
	}
}
