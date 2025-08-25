/*
 * プログラム名：Home-Jack.ver.2.0
 * 作成者：占部虎司郎
 * 作成日：2025/7/10
 * 最終更新日: 2025/8/19
 */

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;

import bean.User;
import util.DAOconnection;

public class UserDAO {

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
		String sql = "SELECT "
				+ "user_id, "
				+ "account_id, "
				+ "name, "
				+ "name_kana, "
				+ "birthday, "
				+ "address, "
				+ "post, "
				+ "phone, "
				+ "nearest_station, "
				+ "transportation, "
				+ "sex, "
				+ "employee_number, "
				+ "department_id, "
				+ "group_id, "
				+ "joining_date, "
				+ "work_history, "
				+ "marriage_flag, "
				+ "children, "
				+ "qualification, "
				+ "display_flag, "
				+ "rest_flag, "
				+ "regist_date, "
				+ "update_date "
			+ "FROM "
				+ "user_info "
				+ "ORDER BY employee_number ASC";

		try {
			// データベース接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getString("account_id"));
				user.setName(rs.getString("name"));
				user.setNameKana(rs.getString("name_kana"));
				user.setBirthday(rs.getDate("birthday"));
				user.setAddress(rs.getString("address"));
				user.setPost(rs.getString("post"));
				user.setPhone(rs.getString("phone"));
				user.setNearestStation(rs.getString("nearest_station"));
				user.setTransportation(rs.getString("transportation"));
				user.setSex(rs.getString("sex"));
				user.setEmployeeNumber(rs.getString("employee_number"));
				user.setDepartmentId(rs.getInt("department_id"));
				user.setGroupId(rs.getInt("group_id"));
				user.setJoiningDate(rs.getTimestamp("joining_date"));
				user.setWorkHistory(rs.getInt("work_history"));
				user.setMarriageFlag(rs.getInt("marriage_flag"));
				user.setChildren(rs.getInt("children"));
				user.setQualification(rs.getString("qualification"));
				user.setDisplayFlag(rs.getInt("display_flag"));
				user.setRestFlag(rs.getInt("rest_flag"));
				user.setRegistDate(rs.getTimestamp("regist_date"));
				user.setUpdateDate(rs.getTimestamp("update_date"));
				userList.add(user);
			}
		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}
		return userList;
	}

	/**
	 * 登録を行うメソッド
	 * 
	 * @param 登録したい情報
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 */
	public void insert(User user) {
		Connection con = null;
		Statement smt = null;

		LocalDateTime nowDate = LocalDateTime.now();

		//SQL文の作成
		String sql = "INSERT INTO `user_info` (`user_id`, `account_id`, `name`, "
				+ "`name_kana`, `birthday`, `address`, `post`, `phone`, "
				+ "`nearest_station`, `transportation`, `sex`, `employee_number`, "
				+ "`department_id`, `group_id`, `joining_date`, `work_history`, "
				+ "`marriage_flag`, `children`, `qualification`, `display_flag`, "
				+ "`rest_flag`, `regist_date`, `update_date`) "
				+ "VALUES (NULL, '" + user.getAccountId() + "', '" + user.getName() + "', '" + user.getNameKana()
				+ "', "
				+ "'" + user.getBirthday() + "', '" + user.getAddress() + "', '" + user.getPost() + "', '"
				+ user.getPhone() + "',"
				+ " '" + user.getNearestStation() + "', '" + user.getTransportation() + "', '" + user.getSex() + "', '"
				+ user.getEmployeeNumber()
				+ "', '" + user.getDepartmentId() + "', '" + user.getGroupId() + "', '" + user.getJoiningDate() + "',"
				+ " '" + user.getWorkHistory() + "', '" + user.getMarriageFlag() + "', '" + user.getChildren() + "', "
				+ "'" + user.getQualification() + "', '" + user.getDisplayFlag() + "', '" + user.getRestFlag() + "',"
				+ " '" + nowDate + "', 'NULL')";

		try {
			//DB接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//登録の処理
			smt.executeUpdate(sql);

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}

	}
	
	/**
	 * 権限分けを行うメソッド
	 * 
	 * @param 検索するアカウントID
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 */
	
	public String authorityByAccountId(String accountId) {
		
		Connection con = null;
		PreparedStatement ps = null;
		String role = null;
		
		String sql = "SELECT a.authority_code FROM user_info u " +
			    "JOIN authority_info a ON u.user_id = a.user_id " +
			    "WHERE u.account_id = ?";		
		try {
			// DBに接続
			con = DAOconnection.getConnection();
			ps = con.prepareStatement(sql);

			ps.setString(1, accountId);

			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				role = rs.getString("authority_code");
			}
		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}
		return role;
	}

	/**
	 * 疑似削除を行うメソッド
	 * 
	 * @param 疑似削除したいユーザーのid
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 */
	public void delete(int userId) {
		Connection con = null;
		Statement smt = null;

		//現在の日時を取得
		LocalDateTime nowDate = LocalDateTime.now();

		//SQL文の作成
		String sql = "UPDATE user_info SET birthday = NULL, address = NULL, "
				+ "post = NULL, phone = NULL, nearest_station = NULL, transportation = NULL, sex = NULL, "
				+ "employee_number = NULL, department_id = NULL, group_id = NULL, joining_date = NULL, "
				+ "children = NULL, qualification = NULL, work_history = NULL, display_flag = '1', regist_date = NULL, "
				+ "update_date = '" + nowDate + "' WHERE user_id = '" + userId + "'";

		try {
			//DB接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//更新の処理
			smt.executeUpdate(sql);

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}

	}

	/**
	 * 更新処理を行うメソッド
	 * 
	 * @param 更新したい情報
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 */
	public void update(User user) {
		Connection con = null;
		Statement smt = null;

		LocalDateTime nowDate = LocalDateTime.now();

		//SQL文の作成
		String sql = "update userinfo set name = '" + user.getName() + "', name_kana = '" + user.getNameKana()
				+ "', birthday = '" + user.getBirthday() + "', address = '" + user.getAddress() + "', "
				+ "post = '" + user.getPost() + "', phone = '" + user.getPhone() + "', nearest_station = '"
				+ user.getNearestStation() + "', transportation = '" + user.getTransportation() + "', sex = '"
				+ user.getSex() + "',"
				+ "employee_number = '" + user.getEmployeeNumber() + "', department_id = '" + user.getDepartmentId()
				+ "', group_id = '" + user.getGroupId() + "', joiningdate ='" + user.getJoiningDate() + "', "
				+ "children = '" + user.getChildren() + "', qualification = '" + user.getQualification()
				+ "', work_history = '" + user.getWorkHistory() + "', regist_date = '" + user.getRegistDate() + "', "
				+ "update_date = '" + nowDate + "' WHERE user_id = '" + user.getUserId() + "'";

		try {
			//DB接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//更新の処理
			smt.executeUpdate(sql);

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}

	}

	/**
	 * 詳細表示を行うメソッド
	 * 
	 * @param 詳細表示したいユーザーID
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 * @return 詳細表示された情報
	 */
	public User selectByUserId(int userId) {
		Connection con = null;
		Statement smt = null;

		User user = new User();

		//SQL文の作成
		String sql = "SELECT user_id, account_id, name, name_kana, birthday, address, post, phone, nearest_station, "
				+ "transportation, sex, employee_number, department_id, group_id, joining_date, work_history, marriage_flag, "
				+ "children, qualification, display_flag, rest_flag, regist_date, update_date FROM user_info WHERE user_id = "
				+ userId;

		try {

			con = DAOconnection.getConnection();
			smt = con.createStatement();

			ResultSet rs = smt.executeQuery(sql);

			if (rs.next()) {
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getString("account_id"));
				user.setName(rs.getString("name"));
				user.setNameKana(rs.getString("name_kana"));
				user.setBirthday(rs.getDate("birthday"));
				user.setAddress(rs.getString("address"));
				user.setPost(rs.getString("post"));
				user.setPhone(rs.getString("phone"));
				user.setNearestStation(rs.getString("nearest_station"));
				user.setTransportation(rs.getString("transportation"));
				user.setSex(rs.getString("sex"));
				user.setEmployeeNumber(rs.getString("employee_number"));
				user.setDepartmentId(rs.getInt("department_id"));
				user.setGroupId(rs.getInt("group_id"));
				user.setJoiningDate(rs.getTimestamp("joining_date"));
				user.setWorkHistory(rs.getInt("work_history"));
				user.setMarriageFlag(rs.getInt("marriage_flag"));
				user.setChildren(rs.getInt("children"));
				user.setQualification(rs.getString("qualification"));
				user.setDisplayFlag(rs.getInt("display_flag"));
				user.setRestFlag(rs.getInt("rest_flag"));
				user.setRegistDate(rs.getTimestamp("regist_date"));
				user.setUpdateDate(rs.getTimestamp("update_date"));
			}

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}
		// 戻り値返却
		return user;
	}

	/**
	 * アカウントIDが一致するユーザー情報を返すメソッド
	 * 
	 * @param 詳細表示したいアカウントID
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 * @return 詳細表示された情報
	 */
	public User selectByAccountId(String accountId) {
		Connection con = null;
		Statement smt = null;

		User user = new User();

		//SQL文の作成
		String sql = "SELECT user_id, account_id, name, name_kana, birthday, address, post, phone, nearest_station, "
				+ "transportation, sex, employee_number, department_id, group_id, joining_date, work_history, marriage_flag, "
				+ "children, qualification, display_flag, rest_flag, regist_date, update_date FROM user_info WHERE account_id = '"
				+ accountId + "'";

		try {

			con = DAOconnection.getConnection();
			smt = con.createStatement();

			ResultSet rs = smt.executeQuery(sql);

			if (rs.next()) {
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getString("account_id"));
				user.setName(rs.getString("name"));
				user.setNameKana(rs.getString("name_kana"));
				user.setBirthday(rs.getDate("birthday"));
				user.setAddress(rs.getString("address"));
				user.setPost(rs.getString("post"));
				user.setPhone(rs.getString("phone"));
				user.setNearestStation(rs.getString("nearest_station"));
				user.setTransportation(rs.getString("transportation"));
				user.setSex(rs.getString("sex"));
				user.setEmployeeNumber(rs.getString("employee_number"));
				user.setDepartmentId(rs.getInt("department_id"));
				user.setGroupId(rs.getInt("group_id"));
				user.setJoiningDate(rs.getTimestamp("joining_date"));
				user.setWorkHistory(rs.getInt("work_history"));
				user.setMarriageFlag(rs.getInt("marriage_flag"));
				user.setChildren(rs.getInt("children"));
				user.setQualification(rs.getString("qualification"));
				user.setDisplayFlag(rs.getInt("display_flag"));
				user.setRestFlag(rs.getInt("rest_flag"));
				user.setRegistDate(rs.getTimestamp("regist_date"));
				user.setUpdateDate(rs.getTimestamp("update_date"));
			}

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}
		// 戻り値返却
		return user;
	}

	/**
	 * 検索を行うメソッド ※オプション
	 * 
	 * @param 検索したいユーザーid
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 * @return 検索された情報
	 */

	/** 
	 * 部・グループをもとにユーザー情報を取得するメソッド
	 * 
	 * @return ArrayList<User>
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 */
	public ArrayList<User> selectByDepartmentGroup(int departmentId, int groupId) {
		Connection con = null;
		Statement smt = null;

		//戻り値用のArrayListを作成
		ArrayList<User> userList = new ArrayList<User>();

		//SQL文の作成
		String sql = "SELECT user_id, account_id, name, name_kana, birthday, address, post, phone, nearest_station, "
				+ "transportation, sex, employee_number, department_id, group_id, joining_date, work_history, marriage_flag, "
				+ "children, qualification, display_flag, rest_flag, regist_date, update_date FROM user_info "
				+ "WHERE department_id = " + departmentId + " AND group_id = " + groupId + ";";

		try {
			// データベース接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getString("account_id"));
				user.setName(rs.getString("name"));
				user.setNameKana(rs.getString("name_kana"));
				user.setBirthday(rs.getDate("birthday"));
				user.setAddress(rs.getString("address"));
				user.setPost(rs.getString("post"));
				user.setPhone(rs.getString("phone"));
				user.setNearestStation(rs.getString("nearest_station"));
				user.setTransportation(rs.getString("transportation"));
				user.setSex(rs.getString("sex"));
				user.setEmployeeNumber(rs.getString("employee_number"));
				user.setDepartmentId(rs.getInt("department_id"));
				user.setGroupId(rs.getInt("group_id"));
				user.setJoiningDate(rs.getTimestamp("joining_date"));
				user.setWorkHistory(rs.getInt("work_history"));
				user.setMarriageFlag(rs.getInt("marriage_flag"));
				user.setChildren(rs.getInt("children"));
				user.setQualification(rs.getString("qualification"));
				user.setDisplayFlag(rs.getInt("display_flag"));
				user.setRestFlag(rs.getInt("rest_flag"));
				user.setRegistDate(rs.getTimestamp("regist_date"));
				user.setUpdateDate(rs.getTimestamp("update_date"));
				userList.add(user);
			}
		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}
		return userList;
	}

	/**
	 * 入社年月をもとにユーザー情報を取得するメソッド
	 * 
	 * @return ArrayList<User>
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 */
	public ArrayList<User> selectByJoiningDate(Timestamp joiningDate) {
		Connection con = null;
		Statement smt = null;

		//戻り値用のArrayListを作成
		ArrayList<User> userList = new ArrayList<User>();

		//SQL文の作成
		String sql = "SELECT user_id, account_id, name, name_kana, birthday, address, post, phone, nearest_station, "
				+ "transportation, sex, employee_number, department_id, group_id, joining_date, work_history, marriage_flag, "
				+ "children, qualification, display_flag, rest_flag, regist_date, update_date FROM user_info "
				+ "WHERE joining_date = '" + joiningDate + "';";

		try {
			// データベース接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getString("account_id"));
				user.setName(rs.getString("name"));
				user.setNameKana(rs.getString("name_kana"));
				user.setBirthday(rs.getDate("birthday"));
				user.setAddress(rs.getString("address"));
				user.setPost(rs.getString("post"));
				user.setPhone(rs.getString("phone"));
				user.setNearestStation(rs.getString("nearest_station"));
				user.setTransportation(rs.getString("transportation"));
				user.setSex(rs.getString("sex"));
				user.setEmployeeNumber(rs.getString("employee_number"));
				user.setDepartmentId(rs.getInt("department_id"));
				user.setGroupId(rs.getInt("group_id"));
				user.setJoiningDate(rs.getTimestamp("joining_date"));
				user.setWorkHistory(rs.getInt("work_history"));
				user.setMarriageFlag(rs.getInt("marriage_flag"));
				user.setChildren(rs.getInt("children"));
				user.setQualification(rs.getString("qualification"));
				user.setDisplayFlag(rs.getInt("display_flag"));
				user.setRestFlag(rs.getInt("rest_flag"));
				user.setRegistDate(rs.getTimestamp("regist_date"));
				user.setUpdateDate(rs.getTimestamp("update_date"));
				userList.add(user);
			}
		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}
		return userList;
	}

	/**
	 * 登録を行うメソッド
	 * 
	 * @param 登録したい情報
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 */
	public void insert(String accountId, String name) {

		Connection con = null;
		PreparedStatement ps = null;

		String sql = "INSERT INTO "
				+ "user_info ("
				+ "account_id,"
				+ "name,"
				+ "marriage_flag,"
				+ "display_flag,"
				+ "rest_flag,"
				+ "regist_date" + ")"
			+ "VALUES "
				+ "(? ,?, 0, 1, 0, NOW())";

		try {
			// DBに接続
			con = DAOconnection.getConnection();
			ps = con.prepareStatement(sql);

			ps.setString(1, accountId);
			ps.setString(2, name);

			ps.executeUpdate();

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}
	}

	/**
	 * 社員番号と名前で検索を行うメソッド
	 * 
	 * @param 検索したいキーワード
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 * @return 検索された情報
	 */
	public ArrayList<User> search(String input) {
		Connection con = null;
		Statement smt = null;

		//戻り値用のArrayListを作成
		ArrayList<User> userList = new ArrayList<User>();

		//SQL文の作成
		String sql = "SELECT * FROM user_info " +
				"WHERE employee_number LIKE '%" + input + "%'"
				+ "OR name LIKE '%" + input + "%'"
				+ "OR group_id LIKE '%" + input + "%'"
				+ "OR department_id LIKE '%" + input + "%'";

		try {
			//DB接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//SQLの実行
			ResultSet rs = smt.executeQuery(sql);

			//値の登録
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getString("account_id"));
				user.setName(rs.getString("name"));
				user.setNameKana(rs.getString("name_kana"));
				user.setBirthday(rs.getDate("birthday"));
				user.setAddress(rs.getString("address"));
				user.setPhone(rs.getString("phone"));
				user.setNearestStation(rs.getString("nearest_station"));
				user.setTransportation(rs.getString("transportation"));
				user.setSex(rs.getString("sex"));
				user.setEmployeeNumber(rs.getString("employee_number"));
				user.setDepartmentId(rs.getInt("department_id"));
				user.setGroupId(rs.getInt("group_id"));
				user.setJoiningDate(rs.getTimestamp("joining_date"));
				user.setWorkHistory(rs.getInt("work_history"));
				user.setMarriageFlag(rs.getInt("marriage_flag"));
				user.setChildren(rs.getInt("children"));
				user.setQualification(rs.getString("qualification"));
				user.setDisplayFlag(rs.getInt("display_flag"));
				user.setRestFlag(rs.getInt("rest_flag"));
				user.setRegistDate(rs.getTimestamp("regist_date"));
				user.setUpdateDate(rs.getTimestamp("update_date"));
				//配列に格納
				userList.add(user);
			}

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}
		return userList;
	}

	/**
	 * 所属で検索を行うメソッド
	 * 
	 * @param 検索したい部とグループの番号
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 * @return 検索された情報
	 */
	public ArrayList<User> searchAffiliation(int part, int group) {
		Connection con = null;
		Statement smt = null;

		//戻り値用のArrayListを作成
		ArrayList<User> userList = new ArrayList<User>();

		//SQL文の作成
		String sql = "SELECT * FROM user_info " +
				"WHERE department_id = '" + part + "'"
				+ " AND group_id = '" + group + "'";

		try {
			//DB接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//SQLの実行
			ResultSet rs = smt.executeQuery(sql);

			//値を登録
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getString("account_id"));
				user.setName(rs.getString("name"));
				user.setNameKana(rs.getString("name_kana"));
				user.setBirthday(rs.getDate("birthday"));
				user.setAddress(rs.getString("address"));
				user.setPhone(rs.getString("phone"));
				user.setNearestStation(rs.getString("nearest_station"));
				user.setTransportation(rs.getString("transportation"));
				user.setSex(rs.getString("sex"));
				user.setEmployeeNumber(rs.getString("employee_number"));
				user.setDepartmentId(rs.getInt("department_id"));
				user.setGroupId(rs.getInt("group_id"));
				user.setJoiningDate(rs.getTimestamp("joining_date"));
				user.setWorkHistory(rs.getInt("work_history"));
				user.setMarriageFlag(rs.getInt("marriage_flag"));
				user.setChildren(rs.getInt("children"));
				user.setQualification(rs.getString("qualification"));
				user.setDisplayFlag(rs.getInt("display_flag"));
				user.setRestFlag(rs.getInt("rest_flag"));
				user.setRegistDate(rs.getTimestamp("regist_date"));
				user.setUpdateDate(rs.getTimestamp("update_date"));
				//配列に格納
				userList.add(user);
			}

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}
		return userList;
	}

	/**
	 * 部署とグループで検索を行うメソッド
	 * @param 検索したい部とグループの名前
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 * @return 検索された情報を返す
	 */
	public ArrayList<User> searchEmployee(String keyword) {
		Connection con = null;
		PreparedStatement ps = null;

		//戻り値用のArrayListを作成
		ArrayList<User> userList = new ArrayList<User>();

		String sql = "SELECT u.*, d.department_name, g.group_name FROM user_info u " +
				"LEFT JOIN department_info d ON u.department_id = d.department_id " +
				"LEFT JOIN group_info g ON u.group_id = g.group_id " +
				"WHERE d.department_name LIKE ? OR g.group_name LIKE ?";

		try {
			con = DAOconnection.getConnection();
			ps = con.prepareStatement(sql);

			ps.setString(1, "%" + keyword + "%");
			ps.setString(2, "%" + keyword + "%");

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getString("account_id"));
				user.setName(rs.getString("name"));
				user.setNameKana(rs.getString("name_kana"));
				user.setBirthday(rs.getDate("birthday"));
				user.setAddress(rs.getString("address"));
				user.setPhone(rs.getString("phone"));
				user.setNearestStation(rs.getString("nearest_station"));
				user.setTransportation(rs.getString("transportation"));
				user.setSex(rs.getString("sex"));
				user.setEmployeeNumber(rs.getString("employee_number"));
				user.setDepartmentId(rs.getInt("department_id"));
				user.setGroupId(rs.getInt("group_id"));
				user.setJoiningDate(rs.getTimestamp("joining_date"));
				user.setWorkHistory(rs.getInt("work_history"));
				user.setMarriageFlag(rs.getInt("marriage_flag"));
				user.setChildren(rs.getInt("children"));
				user.setQualification(rs.getString("qualification"));
				user.setDisplayFlag(rs.getInt("display_flag"));
				user.setRestFlag(rs.getInt("rest_flag"));
				user.setRegistDate(rs.getTimestamp("regist_date"));
				user.setUpdateDate(rs.getTimestamp("update_date"));
				//配列に格納
				userList.add(user);

			}

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}

		return userList;
	}

	/**
	 * 直前にINSERTされたIDを取得するメソッド
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 * @return 最後にINSERTされたユーザーID
	 */
	public int selectLastInsertId() {
		try (Connection con = DAOconnection.getConnection();
				PreparedStatement ps = con.prepareStatement("SELECT LAST_INSERT_ID()")) {

			// SQLを実行し、結果セットを取得します
			try (ResultSet rs = ps.executeQuery()) {
				// 結果セットに次の行があれば（つまり、IDが取得できれば）
				if (rs.next()) {
					// 最初の列からIDをint型で取得して返します
					return rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new IllegalStateException(e);
		}

		// IDが取得できなかった場合は0を返します
		return 0;
	}

	public void updateProfile(User user) {
		Connection con = null;
		Statement smt = null;

		LocalDateTime nowDate = LocalDateTime.now();

		//SQL文の作成
		String sql = "UPDATE "
				+ "user_info "
				+ "set "
				+ "name = '" + user.getName() + "', "
				+ "name_kana = '" + user.getNameKana() + "', "
				+ "birthday = '" + user.getBirthday() + "', "
				+ "address = '" + user.getAddress() + "', "
				+ "post = '" + user.getPost() + "', "
				+ "phone = '" + user.getPhone() + "', "
				+ "nearest_station = '" + user.getNearestStation() + "', "
				+ "transportation = '" + user.getTransportation() + "', "
				+ "sex = '" + user.getSex() + "',"
				+ "employee_number = '" + user.getEmployeeNumber() + "', "
				+ "department_id = '" + user.getDepartmentId() + "', "
				+ "group_id = '" + user.getGroupId() + "', "
				+ "joining_date ='" + user.getJoiningDate() + "', "
				+ "children = '" + user.getChildren() + "', "
				+ "qualification = '" + user.getQualification() + "', "
				+ "work_history = '" + user.getWorkHistory() + "', "
				+ "regist_date = '" + user.getRegistDate() + "', "
				+ "update_date = '" + nowDate + "' "
			+ "WHERE "
				+ "user_id = '" + user.getUserId() + "'";

		try {
			//DB接続
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//更新の処理
			smt.executeUpdate(sql);

		} catch (SQLException e) {
			System.err.println("UserDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("UserDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("UserDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("UserDAOの不明なエラー: " + e.getMessage());
			}
		}

	}

	
}
