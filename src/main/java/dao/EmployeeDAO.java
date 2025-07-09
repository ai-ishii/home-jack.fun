package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
	 				// 社員紹介のほう
	 				employee.setEmployeeId(rs.getInt("employee_id"));
	 				employee.setUserId(rs.getInt("user_id"));
	 				employee.setEmployeeNumber(rs.getString("employee_number"));
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
}
