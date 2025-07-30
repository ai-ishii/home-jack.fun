/*RequestDAO.java */
package dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.AddressRequest;
import bean.LicenseRequest;
import bean.NameRequest;
import bean.Request;
import bean.RequestLicenseRequestUser;
import bean.User;
import bean.WorkRequest;

public class RequestDAO {
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

	//request_info から全てのデータを取得するメソッド
	public ArrayList<Request> selectAll() {
		//変数宣言
		Connection con = null;
		Statement smt = null;

		//データを格納リストの作成
		ArrayList<Request> requestList = new ArrayList<Request>();

		try {
			con = getConnection();
			smt = con.createStatement();

			//SQL文
			String sql = "SELECT request_id, applicant_id, approver, applicant, approver, request_date, approval_date, "
					+ "request_type_flag, request_flag FROM request_info ORDER BY request_info.request_date DESC";

			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				Request request = new Request();

				request.setRequestId(rs.getInt("request_id"));
				request.setApplicantId(rs.getInt("applicant_id"));
				request.setApproverId(rs.getInt("approver_id"));
				request.setApplicant(rs.getString("applicant"));
				request.setApprover(rs.getString("approver"));
				request.setRequestDate(rs.getTimestamp("request_date"));
				request.setApprovalDate(rs.getTimestamp("approval_date"));
				request.setRequestTypeFlag(rs.getInt("request_type_flag"));
				request.setRequestFlag(rs.getInt("request_flag"));
				
 
				requestList.add(request);
			}

		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
			//リソースの開放
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
		return requestList;
	}
	//work_request_infoの情報を取り出すメソッド
	public WorkRequest selectByWorkRequestId(int requestid) {
		//変数宣言
		Connection con = null;
		Statement smt = null;
		WorkRequest workRequest = new WorkRequest();
		
		try {
			con = getConnection();
			smt = con.createStatement();

			//SQL文
			String sql = "SELECT work_request_id, situation, job_location, low_root, price, near_station, route_name "
					+ "FROM work_request_info where request_id=" + requestid ;

			ResultSet rs = smt.executeQuery(sql);
			
			while (rs.next()) {
				

				workRequest.setWorkRequestId(rs.getInt("work_request_id"));
				workRequest.setRequestId(rs.getInt("request_id"));
				workRequest.setSituation(rs.getString("situation"));
				workRequest.setJobLocation(rs.getString("job_location"));
				workRequest.setLowRoot(rs.getString("low_root"));
				workRequest.setPrice(rs.getInt("price"));
				workRequest.setNearStation(rs.getString("near_station"));
				workRequest.setRouteName(rs.getString("route_name"));

			}

		} catch (Exception e) {
			throw new IllegalStateException(e);
		} finally {
			//リソースの開放
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
		return workRequest;
	}
	//name_request_infoの情報を取り出すメソッド
		public NameRequest selectByNameRequestId(int requestid) {
			//変数宣言
			Connection con = null;
			Statement smt = null;
			NameRequest nameRequest = new NameRequest();
			
			try {
				con = getConnection();
				smt = con.createStatement();

				//SQL文
				String sql = "SELECT name_request_id, request_id, old_name, old_name_kana, new_name, new_name_kana "
						+ "FROM name_request_info where request_id=" + requestid ;

				ResultSet rs = smt.executeQuery(sql);
				
				while (rs.next()) {
					

					nameRequest.setNameRequestId(rs.getInt("name_request_id"));
					nameRequest.setRequestId(rs.getInt("request_id"));
					nameRequest.setOldName(rs.getString("old_name"));
					nameRequest.setOldNameKana(rs.getString("old_name_kana"));
					nameRequest.setNewName(rs.getString("new_name"));
					nameRequest.setNewNameKana(rs.getString("new_name_kana"));
		

				}

			} catch (Exception e) {
				throw new IllegalStateException(e);
			} finally {
				//リソースの開放
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
			return nameRequest;
		}
		//address_request_infoの情報を取り出すメソッド
		public AddressRequest selectByAddressRequestId(int requestid) {
			//変数宣言
			Connection con = null;
			Statement smt = null;
			AddressRequest addressRequest = new AddressRequest();
			
			try {
				con = getConnection();
				smt = con.createStatement();

				//SQL文
				String sql = "SELECT address_request_id, request_id, old_address, new_address, old_post, new_post "
						+ "FROM address_request_info where request_id=" + requestid ;

				ResultSet rs = smt.executeQuery(sql);
				
				while (rs.next()) {
					

					addressRequest.setAddressRequestId(rs.getInt("address_request_id"));
					addressRequest.setRequestId(rs.getInt("request_id"));
					addressRequest.setOldAddress(rs.getString("old_address"));
					addressRequest.setNewAddress(rs.getString("new_address"));
					addressRequest.setOldPost(rs.getString("old_post"));
					addressRequest.setNewPost(rs.getString("new_post"));

				}

			} catch (Exception e) {
				throw new IllegalStateException(e);
			} finally {
				//リソースの開放
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
			return addressRequest;
		}
		//license_request_infoの情報を取り出すメソッド
		public RequestLicenseRequestUser selectLicenseRequestId(int requestid) {
			//変数宣言
			Connection con = null;
			Statement smt = null;
			RequestLicenseRequestUser requestLicenseRequestUser = new RequestLicenseRequestUser();
			LicenseRequest licenseRequest = new LicenseRequest();
			Request request = new Request();
			User user = new User();
			
			try {
				con = getConnection();
				smt = con.createStatement();

				//SQL文
				String sql = "SELECT user_info.department_id,user_info.group_id,request_info.name,license_request_info.license_name,license_request_info.exam_date,"
						+ "license_request_info.exam_time FROM user_info INNER JOIN request_info ON user_info.user_id = request_info.applicant_id"
						+ " INNER JOIN license_request_info ON request_info.request_id = license_request_info.request_id "
						+ "WHERE .request_info.request_id=" + requestid;

				ResultSet rs = smt.executeQuery(sql);
				
				while (rs.next()) {
					licenseRequest.setLicenseName(rs.getString("license_name"));
					licenseRequest.setExamDate(rs.getTimestamp("exam_date"));
					licenseRequest.setExamTime(rs.getInt("exam_time"));
					
					user.setDepartmentId(rs.getInt("department_id"));
					user.setGroupId(rs.getInt("group_id"));
					
					request.setApplicant(rs.getString("applicant"));
					request.setApprover(rs.getString("approver"));
					
					requestLicenseRequestUser.setRequest(request);
					requestLicenseRequestUser.setLicenseRequest(licenseRequest);
					requestLicenseRequestUser.setUser(user);

				}

			} catch (Exception e) {
				throw new IllegalStateException(e);
			} finally {
				//リソースの開放
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
			return requestLicenseRequestUser;
		}

}
