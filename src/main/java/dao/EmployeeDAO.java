//<!-- 社員紹介DAO（作：石井） -->
//<!-- 作成日：　最終更新日：8/15 14:00 -->

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;

import bean.Employee;
import util.DAOconnection;

public class EmployeeDAO {
	
		LocalDateTime nowDate = LocalDateTime.now();
	 	
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
	 			con = DAOconnection.getConnection();
	 			smt = con.createStatement();
	 			
	 			// SQL文発行
	 			ResultSet rs = smt.executeQuery(sql);
	 			
	 			//データを入れるためのオブジェクトを用意
	 			Employee employee = new Employee();
	 			
	 			// 検索結果をArrayListに格納
	 			while (rs.next()) {
	 				employee.setEmployeeId(rs.getInt("employee_id"));
	 				employee.setUserId(rs.getInt("user_id"));
	 				employee.setDeveloper(rs.getInt("devloper"));
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
	 		} catch (SQLException e) {
				System.err.println("EmployeeDAOのデータベース接続時にエラー: " + e.getMessage());
				throw new IllegalStateException(e);
			} catch (Exception e) {
				System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
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
					System.err.println("EmployeeDAOのcon，smtクローズ時にエラー: " + e.getMessage());
				} catch (Exception e) {
					System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
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
	 			con = DAOconnection.getConnection();
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
	 			
	 		} catch (SQLException e) {
				System.err.println("EmployeeDAOのデータベース接続時にエラー: " + e.getMessage());
				throw new IllegalStateException(e);
			} catch (Exception e) {
				System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
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
					System.err.println("EmployeeDAOのcon，smtクローズ時にエラー: " + e.getMessage());
				} catch (Exception e) {
					System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
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
	 				+ "WHERE user_id = " + userId;
	 		
	 		try {
	 			// DBに接続
	 			con = DAOconnection.getConnection();
	 			smt = con.createStatement();
	 			
	 			// SQL文発行
	 			ResultSet rs = smt.executeQuery(sql);
	 			
	 			// 検索結果を格納
	 			if (rs.next()) {	
	 				employee.setEmployeeId(rs.getInt("employee_id"));
	 				employee.setUserId(rs.getInt("user_id"));
	 				employee.setDeveloper(rs.getInt("developer"));
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
	 		} catch (SQLException e) {
				System.err.println("EmployeeDAOのデータベース接続時にエラー: " + e.getMessage());
				throw new IllegalStateException(e);
			} catch (Exception e) {
				System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
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
					System.err.println("EmployeeDAOのcon，smtクローズ時にエラー: " + e.getMessage());
				} catch (Exception e) {
					System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
				}
			}
	 		
	 		return employee;
	 		
	 	}
	 	
	 	/**
	 	 * 社員情報をDBに登録するメソッド（INSERT）
	 	 * @param employee
	 	 */
		public void regist(Employee employee, int userId) {

			// 変数宣言
			Connection con = null;
			PreparedStatement ps = null;
			
			String sql = "INSERT INTO employee_info(user_id,"
					+ " developer, lang_skill, middle_skill, hobby, talent,"
					+ " intro, position, regist_date, update_date, photo) "
					+ "VALUES (?,?,?,?,?,?,?,?,NOW(),NOW(),?)";

			try {
				// DBに接続
				con = DAOconnection.getConnection();
				ps = con.prepareStatement(sql);

				ps.setInt(1, userId);
				ps.setInt(2, employee.getDeveloper());
				ps.setString(3, employee.getLangSkill());
				ps.setString(4, employee.getMiddleSkill());
				ps.setString(5, employee.getHobby());
				ps.setString(6, employee.getTalent());
				ps.setString(7, employee.getIntro());
				ps.setString(8, employee.getPosition());
				ps.setString(9, employee.getPhoto());
				
				// SQL文発行
				ps.executeUpdate();

			} catch (SQLException e) {
				System.err.println("EmployeeDAOのデータベース接続時にエラー: " + e.getMessage());
				throw new IllegalStateException(e);
			} catch (Exception e) {
				System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
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
					System.err.println("EmployeeDAOのcon，smtクローズ時にエラー: " + e.getMessage());
				} catch (Exception e) {
					System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
				}
			}
		}
		
		/**
		 * 更新処理を行うメソッド（UPDATE）
		 * @param employee
		 */
		public void update(Employee employee, int userId) {
			
			// 変数宣言
			Connection con = null;
			Statement smt = null;
			
			String sql = "UPDATE employee_info SET devloper = " + employee.getDeveloper() + ", "
					+ "lang_skill = '" + employee.getLangSkill() + "', middle_skill = '" + employee.getMiddleSkill() + "', "
					+ "hobby = '" + employee.getHobby() + "', talent = '" + employee.getTalent() + "', "
					+ "intro = '" + employee.getIntro() + "', position = '" + employee.getPosition() + "', "
					+ "update_date = '" + nowDate + "', "
					+ "photo = '" + employee.getPhoto() + "' WHERE user_id = " + userId + ";";
			
			try {
				// DBに接続
				con = DAOconnection.getConnection();
				smt = con.createStatement();
				
				// SQL文発行
				smt.executeUpdate(sql);
				
			} catch (SQLException e) {
				System.err.println("EmployeeDAOのデータベース接続時にエラー: " + e.getMessage());
				throw new IllegalStateException(e);
			} catch (Exception e) {
				System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
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
					System.err.println("EmployeeDAOのcon，smtクローズ時にエラー: " + e.getMessage());
				} catch (Exception e) {
					System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
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
				con = DAOconnection.getConnection();
				smt = con.createStatement();
				
				// SQL文発行
				smt.executeUpdate(sql);
				
			} catch (SQLException e) {
				System.err.println("EmployeeDAOのデータベース接続時にエラー: " + e.getMessage());
				throw new IllegalStateException(e);
			} catch (Exception e) {
				System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
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
					System.err.println("EmployeeDAOのcon，smtクローズ時にエラー: " + e.getMessage());
				} catch (Exception e) {
					System.err.println("EmployeeDAOの不明なエラー: " + e.getMessage());
				}
			}
		}



}
