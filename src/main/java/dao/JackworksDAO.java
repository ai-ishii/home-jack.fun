package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.Jackworks;

public class JackworksDAO {

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
	 * DBのJackWorks情報を格納するjackworks_infoテーブルから全情報を取得するメソッド
	 * 戻り値としてJackWorks全情報を返す
	 * @return jackList
	 */
	public ArrayList<Jackworks> selectAll() {
		Connection con = null;
		Statement smt = null;

		ArrayList<Jackworks> jackList = new ArrayList<>();

		try {
			con = getConnection();
			smt = con.createStatement();

			String sql = "SELECT * FROM jackworks_info ORDER BY points_get_date DESC";
			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				Jackworks jack = new Jackworks();
				jack.setJackworksId(rs.getInt("jackworks_id"));
				jack.setUserId(rs.getInt("user_id"));
				jack.setEmployeeNumber(rs.getString("employee_number"));
				jack.setName(rs.getString("name"));
				jack.setCategory(rs.getString("category"));
				jack.setAssessment(rs.getString("assessment"));
				jack.setPoint(rs.getInt("point"));
				jack.setPointsGetDate(rs.getDate("points_get_date"));
				jack.setNote(rs.getString("note"));
				jack.setProject(rs.getString("project"));
				jack.setWorkSeason(rs.getString("work_season"));
				jack.setPrice(rs.getInt("price"));
				jack.setPay(rs.getInt("pay"));
				jack.setWorkPlace(rs.getString("work_place"));
				jack.setWorkContent(rs.getString("work_content"));
				jack.setPhase(rs.getString("phase"));
				jack.setLanguage(rs.getString("language"));
				jack.setSkill(rs.getString("skill"));
				jack.setNeedPeople(rs.getString("need_people"));
				jack.setSeller(rs.getString("seller"));
				jack.setContact(rs.getString("contact"));
				jack.setOther(rs.getString("other"));
				jack.setManagerFlag(rs.getInt("manager_flag"));
				jack.setAdminFlag(rs.getInt("admin_flag"));
				jack.setTemporaryFlag(rs.getInt("temporary_flag"));
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

	/**
	 * 引数のjackworksIdでJackWorksをDBから削除するメソッド
	 * 
	 * @param 削除したい情報のjackworksId
	 */
	public void delete(int jackworksId) {
		Connection con = null;
		Statement smt = null;

		try {
			con = getConnection();
			smt = con.createStatement();

			String sql = "DELETE FROM jackworks_info WHERE jackworks_id=" + jackworksId;

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

	/**
	 * 引数のjackでJackWorks情報をDBに登録するメソッド
	 * 
	 * @param 登録したい情報のJackworks
	 */
	public void insert(Jackworks jack) {
		Connection con = null;
		Statement smt = null;

		try {
			con = getConnection();
			smt = con.createStatement();

			String sql = "INSERT INTO jackworks_info VALUES (NULL, NULL, '" + jack.getName() + "', '"
					+ jack.getEmployeeNumber() + "', '" + jack.getCategory() + "', "
					+ "'" + jack.getAssessment() + "', '" + jack.getPoint() + "', '" + jack.getPointsGetDate() + "', '"
					+ jack.getNote()
					+ "',"
					+ " '" + jack.getProject() + "', '" + jack.getWorkSeason() + "', '" + jack.getPrice() + "', '"
					+ jack.getPay() + "', '" + jack.getWorkPlace() + "', "
					+ "'" + jack.getWorkContent() + "', '" + jack.getPhase() + "', '" + jack.getLanguage() + "', '"
					+ jack.getSkill() + "', '" + jack.getNeedPeople() + "', "
					+ "'" + jack.getSeller() + "', '" + jack.getContact() + "', '" + jack.getOther() + "', '"
					+ jack.getManagerFlag() + "', '" + jack.getAdminFlag() + "' , '" + jack.getTemporaryFlag() + "')";

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

	/**
	 * JackWorks情報を格納するjackworks_infoテーブルを更新するメソッド
	 * 
	 * @param 登録したい情報
	 */
	public void update(Jackworks jack) {
		Connection con = null;
		Statement smt = null;

		try {
			con = getConnection();
			smt = con.createStatement();

			String sql = "UPDATE jackworks_info SET project =  '" + jack.getProject() + "' , work_season = '"
					+ jack.getWorkSeason() + "' , "
					+ "price = '" + jack.getPrice() + "' , pay = '" + jack.getPay() + "' , work_place = '"
					+ jack.getWorkPlace() + "' , "
					+ "work_content = '" + jack.getWorkContent() + "' , phase = '" + jack.getPhase() + "', language = '"
					+ jack.getLanguage() + "', "
					+ "skill = '" + jack.getSkill() + "' , need_people = '" + jack.getNeedPeople() + "', seller = '"
					+ jack.getSeller() + "', "
					+ "contact = '" + jack.getContact() + "' , other = '" + jack.getOther() + "', language = '"
					+ jack.getLanguage() + "', "
					+ "temporary_flag = '1' "
					+ "WHERE jackworks_id = '" + jack.getJackworksId() + "'";

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

	/**
	 * 引数の入力された文字から該当データの絞込み検索処理を行うメソッド
	 * 戻り値として該当しているJackWorksの全情報を返す
	 * @return jackList
	 */

	public ArrayList<Jackworks> search(String name) {

		Connection con = null;
		Statement smt = null;

		ArrayList<Jackworks> jackList = new ArrayList<>();

		try {
			con = getConnection();
			smt = con.createStatement();

			//検索内容と同じ文字のみ検索をおこなうsql
			String sql = "SELECT * FROM jackworks_info "
					+ "WHERE employee_number = '" + name + "'"
					+ "OR point = '" + name + "'";

			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				Jackworks jack = new Jackworks();
				jack.setJackworksId(rs.getInt("jackworks_id"));
				jack.setEmployeeNumber(rs.getString("employee_number"));
				jack.setPoint(rs.getInt("point"));
				jack.setPointsGetDate(rs.getDate("points_get_date"));
				jack.setName(rs.getString("name"));
				jack.setCategory(rs.getString("category"));
				jack.setAssessment(rs.getString("assessment"));
				jack.setNote(rs.getString("note"));
				jack.setAdminFlag(rs.getInt("admin_flag"));
				jackList.add(jack);
			}

			//検索内容を含んだ文字の検索をおこなうsql(あいまい検索)
			if (jackList.size() == 0) {
				sql = "SELECT * FROM jackworks_info "
						+ "WHERE category LIKE '%" + name + "%' "
						+ "OR assessment LIKE '%" + name + "%' "
						+ "OR name LIKE '%" + name + "%' "
						+ "OR note LIKE '%" + name + "%'";

				rs = smt.executeQuery(sql);

				while (rs.next()) {
					Jackworks jack = new Jackworks();
					jack.setJackworksId(rs.getInt("jackworks_id"));
					jack.setEmployeeNumber(rs.getString("employee_number"));
					jack.setPoint(rs.getInt("point"));
					jack.setPointsGetDate(rs.getDate("points_get_date"));
					jack.setName(rs.getString("name"));
					jack.setCategory(rs.getString("category"));
					jack.setAssessment(rs.getString("assessment"));
					jack.setNote(rs.getString("note"));
					jack.setAdminFlag(rs.getInt("admin_flag"));
					jackList.add(jack);
				}
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

	/**
	 * 引数の選択された年月の該当データの絞込み検索処理を行うメソッド
	 * 戻り値として該当しているJackWorksの全情報を返す
	 * @return jackList
	 */

	public ArrayList<Jackworks> selectSearch(String selectSearch) {

		Connection con = null;
		Statement smt = null;

		ArrayList<Jackworks> jackList = new ArrayList<>();

		try {
			con = getConnection();
			smt = con.createStatement();

			String sql = "SELECT * FROM jackworks_info "
					+ "WHERE points_get_date LIKE '%" + selectSearch + "%'";

			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				Jackworks jack = new Jackworks();
				jack.setJackworksId(rs.getInt("jackworks_id"));
				jack.setEmployeeNumber(rs.getString("employee_number"));
				jack.setPoint(rs.getInt("point"));
				jack.setPointsGetDate(rs.getDate("points_get_date"));
				jack.setName(rs.getString("name"));
				jack.setCategory(rs.getString("category"));
				jack.setAssessment(rs.getString("assessment"));
				jack.setNote(rs.getString("note"));
				jack.setAdminFlag(rs.getInt("admin_flag"));
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

	/**
	 * DBのJackWorks情報を格納するjackworks_infoテーブルから全情報を取得するメソッド
	 * 戻り値としてJackWorks全情報を返す
	 * @return jackList
	 */
	public ArrayList<Jackworks> selectByJackworksId(int jackworksId) {
		Connection con = null;
		Statement smt = null;

		ArrayList<Jackworks> jackList = new ArrayList<>();

		try {
			con = getConnection();
			smt = con.createStatement();

			String sql = "SELECT * FROM jackworks_info WHERE jackworks_id = '" + jackworksId + "'";
			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				Jackworks jack = new Jackworks();
				jack.setJackworksId(rs.getInt("jackworks_id"));
				jack.setUserId(rs.getInt("user_id"));
				jack.setEmployeeNumber(rs.getString("employee_number"));
				jack.setName(rs.getString("name"));
				jack.setCategory(rs.getString("category"));
				jack.setAssessment(rs.getString("assessment"));
				jack.setPoint(rs.getInt("point"));
				jack.setPointsGetDate(rs.getDate("points_get_date"));
				jack.setNote(rs.getString("note"));
				jack.setProject(rs.getString("project"));
				jack.setWorkSeason(rs.getString("work_season"));
				jack.setPrice(rs.getInt("price"));
				jack.setPay(rs.getInt("pay"));
				jack.setWorkPlace(rs.getString("work_place"));
				jack.setWorkContent(rs.getString("work_content"));
				jack.setPhase(rs.getString("phase"));
				jack.setLanguage(rs.getString("language"));
				jack.setSkill(rs.getString("skill"));
				jack.setNeedPeople(rs.getString("need_people"));
				jack.setSeller(rs.getString("seller"));
				jack.setContact(rs.getString("contact"));
				jack.setOther(rs.getString("other"));
				jack.setManagerFlag(rs.getInt("manager_flag"));
				jack.setAdminFlag(rs.getInt("admin_flag"));
				jack.setTemporaryFlag(rs.getInt("temporary_flag"));
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
	
	/**
	 * JackWorksIdを引数にフラグを変更するメソッド
	 * 
	 * @param 申請許可したい情報
	 */
	public void updateAdminFlag(int jackworksId) {
		Connection con = null;
		Statement smt = null;

		try {
			con = getConnection();
			smt = con.createStatement();

			String sql = "UPDATE jackworks_info SET admin_flag = ' 1 '"
						+ "WHERE jackworks_id = '" + jackworksId + "'";

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
	
	/**
	 * 管理者が未承認のJackWorksIdを取得するメソッド
	 * 
	 * @param なし
	 * @return 登録したいJackworksId
	 */

//	public int selectByAdminFlag() {
//
//		Connection con = null;
//		Statement smt = null;
//
//		int JackworksId = 0;
//
//		try {
//			con = getConnection();
//			smt = con.createStatement();
//
//			String sql = "SELECT * FROM jackworks_info WHERE admin_flag = '0' ";
//
//			ResultSet rs = smt.executeQuery(sql);
//
//			if (rs.next()) {
//				JackworksId = rs.getInt("jackworks_id");
//			}
//
//		} catch (Exception e) {
//			throw new IllegalStateException(e);
//		} finally {
//			if (smt != null) {
//				try {
//					smt.close();
//				} catch (SQLException ignore) {
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (SQLException ignore) {
//				}
//			}
//		}
//		return JackworksId;
//	}
}
