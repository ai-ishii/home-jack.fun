package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;

import bean.Employee;

public class EmployeeDAO {

	//接続用の情報をフィールドに定数として定義
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
	 	
	 	/**
	 	 * 社員情報を全件取得するメソッド（SELECT）
	 	 * @return ArrayList<Employee> employeeList
	 	 */
	 	public ArrayList<Employee> selectAll() {
	 		
	 		// 変数宣言
	 		Connection con = null;
	 		Statement smt = null;
	 		
	 		// 配列宣言
	 		ArrayList<Employee> employeeList = new ArrayList<Employee>();
	 		
	 		// SQL文
	 		String sql = "SELECT * FROM employee_info;";
	 		
	 		try {
	 			// DBに接続
	 			con = EmployeeDAO.getConnection();
	 			smt = con.createStatement();
	 			
	 			// SQL文発行
	 			ResultSet rs = smt.executeQuery(sql);
	 			
	 			//データを入れるためのオブジェクトを用意
	 			Employee employee = new Employee();
	 			
	 			// 検索結果をArrayListに格納
	 			while (rs.next()) {
	 				employee.setEmployeeId(rs.getInt("employee_id"));
	 				employee.setUserId(rs.getInt("user_id"));
	 				employee.setDevloper(rs.getInt("devloper"));
	 				employee.setLangSkill(rs.getString("lang_skill"));
	 				employee.setMiddleSkill(rs.getString("middle_skill"));
	 				employee.setHobby(rs.getString("hobby"));
	 				employee.setTalent(rs.getString("talent"));
	 				employee.setIntro(rs.getString("intro"));
	 				employee.setPosition(rs.getString("position"));
	 				employee.setRegistDate(rs.getTimestamp("regist_date"));
	 				employee.setUpdateDate(rs.getTimestamp("update_date"));
	 				employee.setPhoto(rs.getString("photo"));
	 				
	 				employeeList.add(employee);
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
		
		return employeeList;
	 		
	 	}
	 	
	 	/**
	 	 * ユーザー情報IDをもとに社員写真を取得するメソッド（SELECT）
	 	 * @return String
	 	 */
	 	public String selectPhotoByUserId(int userId) {
	 		
	 		// 変数宣言
	 		Connection con = null;
	 		Statement smt = null;
	 		
	 		// 戻り値を格納する変数宣言
	 		String photo = "";
	 		
	 		// SQL文
	 		String sql = "SELECT photo FROM employee_info "
	 				+ "WHERE user_id = " + userId + ";";
	 		
	 		try {
	 			// DBに接続
	 			con = EmployeeDAO.getConnection();
	 			smt = con.createStatement();
	 			
	 			// SQL文発行
	 			ResultSet rs = smt.executeQuery(sql);
	 			
	 			//データを入れるためのオブジェクトを用意
	 			Employee employee = new Employee();
	 			
	 			// 検索結果をArrayListに格納
	 			while (rs.next()) {	
	 				employee.setPhoto(rs.getString("photo"));
	 				photo = employee.getPhoto();
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
	 		
	 		return photo;
	 		
	 	}
	 	
	 	/**
	 	 * ユーザー情報IDをもとに社員情報を取得するメソッド（SELECT）
	 	 * @return Employee
	 	 */
	 	public Employee selectByUserId(int userId) {
	 		
	 		// 変数宣言
	 		Connection con = null;
	 		Statement smt = null;
	 		
 			//データを入れるためのオブジェクトを用意
 			Employee employee = new Employee();
	 		
	 		// SQL文
	 		String sql = "SELECT * FROM employee_info "
	 				+ "WHERE user_id = " + userId + ";";
	 		
	 		try {
	 			// DBに接続
	 			con = EmployeeDAO.getConnection();
	 			smt = con.createStatement();
	 			
	 			// SQL文発行
	 			ResultSet rs = smt.executeQuery(sql);
	 			
	 			// 検索結果を格納
	 			if (rs.next()) {	
	 				employee.setEmployeeId(rs.getInt("employee_id"));
	 				employee.setUserId(rs.getInt("user_id"));
	 				employee.setDevloper(rs.getInt("devloper"));
	 				employee.setLangSkill(rs.getString("lang_skill"));
	 				employee.setMiddleSkill(rs.getString("middle_skill"));
	 				employee.setHobby(rs.getString("hobby"));
	 				employee.setTalent(rs.getString("talent"));
	 				employee.setIntro(rs.getString("intro"));
	 				employee.setPosition(rs.getString("position"));
	 				employee.setRegistDate(rs.getTimestamp("regist_date"));
	 				employee.setUpdateDate(rs.getTimestamp("update_date"));
	 				employee.setPhoto(rs.getString("photo"));
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
	 		
	 		return employee;
	 		
	 	}
	 	
	 	/**
	 	 * 社員情報をDBに登録するメソッド（INSERT）
	 	 * @param employee
	 	 */
		public void regist(Employee employee) {

			// 変数宣言
			Connection con = null;
			Statement smt = null;

			String sql = "INSERT INTO employee_info(employee_id, user_id,"
					+ " devloper, lang_skill, middle_skill, hobby, talent,"
					+ " intro, position, regist_date, update_date, photo) "
					+ "VALUES (null, null, " + employee.getDevloper() + ", '"
					+ employee.getLangSkill() + "', '" + employee.getMiddleSkill() + "', '"
					+ employee.getHobby() + "', '" + employee.getTalent() + "', '"
					+ employee.getIntro() + "', '" + employee.getPosition() + "', '"
					+ employee.getRegistDate() + "', '" + employee.getUpdateDate() + "', '"
					+ employee.getPhoto() + "');";

			try {
				// DBに接続
				con = EmployeeDAO.getConnection();
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
		 * 更新処理を行うメソッド（UPDATE）
		 * @param employee
		 */
		public void update(Employee employee) {
			
			// 変数宣言
			Connection con = null;
			Statement smt = null;
			
			LocalDateTime nowDate = LocalDateTime.now();
			
			String sql = "UPDATE employee_info SET devloper = " + employee.getDevloper() + ", "
					+ "lang_skill = '" + employee.getLangSkill() + "', middle_skill = " + employee.getMiddleSkill() + "', "
					+ "hobby = '" + employee.getHobby() + "', talent = '" + employee.getTalent() + "', "
					+ "intro = '" + employee.getIntro() + "', position = '" + employee.getPosition() + "', "
					+ "regist_date = '" + employee.getRegistDate() + "', update_date = '" + nowDate + "', "
					+ "photo = '" + employee.getPhoto() + "' WHERE user_id = " + employee.getUserId() + ";";
			
			try {
				// DBに接続
				con = EmployeeDAO.getConnection();
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
		 * 削除処理を行うメソッド（DELETE）
		 * @param employee
		 */
		public void delete(int userId) {
			
			// 変数宣言
			Connection con = null;
			Statement smt = null;
			
			String sql = "DELETE FROM employee_info WHERE user_id = " + userId + ";";
			
			try {
				// DBに接続
				con = EmployeeDAO.getConnection();
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
