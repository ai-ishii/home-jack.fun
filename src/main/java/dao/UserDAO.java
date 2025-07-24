/*
 * プログラム名：Home-Jack.ver.2.0
 * 作成者：占部虎司郎
 * 作成日：2025/7/10
 */

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;

import bean.User;

public class UserDAO {

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
		String sql = "SELECT * FROM user_info order by employee_number asc";

		try {
			// データベース接続
			con = getConnection();
			smt = con.createStatement();

			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getInt("account_id"));
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
				+ "VALUES (NULL, '"+user.getAccountId()+"', '"+user.getName()+"', '"+user.getNameKana()+"', "
				+ "'"+user.getBirthday()+"', '"+user.getAddress()+"', '"+user.getPost()+"', '"+user.getPhone()+"',"
				+ " '"+user.getNearestStation()+"', '"+user.getTransportation()+"', '"+user.getSex()+"', '"+user.getEmployeeNumber()
				+"', '"+user.getDepartmentId()+"', '"+user.getGroupId()+"', '"+user.getJoiningDate()+"',"
				+ " '"+user.getWorkHistory()+"', '"+user.getMarriageFlag()+"', '"+user.getChildren()+"', "
				+ "'"+user.getQualification()+"', '"+user.getDisplayFlag()+"', '"+user.getRestFlag()+"',"
				+ " '"+nowDate+"', 'NULL')";
		
		try {
			//DB接続
			con = getConnection();
			smt = con.createStatement();
			
			//登録の処理
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
	 * 疑似削除を行うメソッド
	 * 
	 * @param 疑似削除したいユーザーのid
	 * @throws IllegalStateException メソッド内部で例外が発生した場合
	 */
	public void delete(int userId) {
		Connection con = null;
		Statement smt = null;
		
		LocalDateTime nowDate = LocalDateTime.now();
		
		//SQL文の作成
		String sql = "update userinfo set birthday = NULL, address = NULL, "
				+ "post = NULL, phone = NULL, nearest_station = NULL, transportation = NULL, sex = NULL, "
				+ "employee_number = 'NULL, department_id = NULL, group_id = NULL, joiningdate = NULL, "
				+ "children = NULL, qualification = NULL, work_history = NULL, regist_date = NULL, "
				+ "update_date = '"+ nowDate +"' WHERE user_id = '"+userId+"'";
		
		try {
			//DB接続
			con = getConnection();
			smt = con.createStatement();
			
			//更新の処理
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
		String sql = "update userinfo set name = '"+user.getName()+"', name_kana = '"+user.getNameKana()+"', birthday = '"+user.getBirthday()+"', address = '"+user.getAddress()+"', "
				+ "post = '"+user.getPost()+"', phone = '"+user.getPhone()+"', nearest_station = '"+user.getNearestStation()+"', transportation = '"+user.getTransportation()+"', sex = '"+user.getSex()+"',"
				+ "employee_number = '"+user.getEmployeeNumber()+"', department_id = '"+user.getDepartmentId()+"', group_id = '"+user.getGroupId()+"', joiningdate ='"+user.getJoiningDate()+"', "
				+ "children = '"+user.getChildren()+"', qualification = '"+user.getQualification()+"', work_history = '"+user.getWorkHistory()+"', regist_date = '"+user.getRegistDate()+"', "
				+ "update_date = '"+ nowDate +"' WHERE user_id = '"+user.getUserId()+"'";
		
		try {
			//DB接続
			con = getConnection();
			smt = con.createStatement();
			
			//更新の処理
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
		String sql = "SELECT * FROM user_info WHERE user_id = " + userId;
		
		try {

			con = getConnection();
			smt = con.createStatement();

			ResultSet rs = smt.executeQuery(sql);

			if (rs.next()) {
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getInt("account_id"));
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
	public ArrayList<User> selectByDepartmentTeam(String department, String team) {
		Connection con = null;
		Statement smt = null;
		
		//戻り値用のArrayListを作成
		ArrayList<User> userList = new ArrayList<User>();
		
		//SQL文の作成
		String sql = "SELECT * FROM user_info "
				+ "WHERE department = '" + department
				+ "' AND team = '" + team + "';";
		
		try {
			// データベース接続
			con = getConnection();
			smt = con.createStatement();
			
			ResultSet rs = smt.executeQuery(sql);
			
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getInt("account_id"));
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
		String sql = "SELECT * FROM user_info "
				+ "WHERE joining_date = '" + joiningDate + "';";
		
		try {
			// データベース接続
			con = getConnection();
			smt = con.createStatement();
			
			ResultSet rs = smt.executeQuery(sql);
			
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setAccountId(rs.getInt("account_id"));
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

	
	/**
     * 検索を行うメソッド ※オプション
     * 
     * @param 検索したいキーワード
     * @throws IllegalStateException メソッド内部で例外が発生した場合
     * @return 検索された情報
     */
    public ArrayList<User> search(String input){
        Connection con = null;
        Statement smt = null;
        
        //戻り値用のArrayListを作成
        ArrayList<User> userList = new ArrayList<User>();
        
        //SQL文の作成
        String sql = "SELECT isbn,title,price FROM user_info " +
                "WHERE employee_number LIKE '%" + input + "%'"
                + " OR name LIKE '%" + input + "%'";
        
        try {
            //DB接続
            con = getConnection();
            smt = con.createStatement();
            
            ResultSet rs = smt.executeQuery(sql);
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setAccountId(rs.getInt("account_id"));
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
    
    /**
     * 検索を行うメソッド ※オプション
     * 
     * @param 検索したい部とグループの番号
     * @throws IllegalStateException メソッド内部で例外が発生した場合
     * @return 検索された情報
     */
    public ArrayList<User> searchAffiliation(int part, int group){
        Connection con = null;
        Statement smt = null;
        
        //戻り値用のArrayListを作成
        ArrayList<User> userList = new ArrayList<User>();
        
        //SQL文の作成
        String sql = "SELECT isbn,title,price FROM user_info " +
                "WHERE department_id LIKE '%" + part + "%'"
                + " AND team LIKE '%" + group  + "%'";
        
        try {
            //DB接続
            con = getConnection();
            smt = con.createStatement();
            
            ResultSet rs = smt.executeQuery(sql);
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setAccountId(rs.getInt("account_id"));
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
}
