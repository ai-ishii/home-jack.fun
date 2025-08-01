/*
 * 機能：資格、氏名、住所、(副業)申請に関するDAO
 * 
 * 作成者：桑原岳
 *  
 * 最終更新日：2025/08/01
 *  
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.LicenseRequestExclusive;
import util.DAOconnection;

public class RequestDAO {
	
	
	
	
	private static final String licenseRequestSql =
			
			//R(request_info),LR(license_request_info),G(group_info),D(department_info),LI(license_info)
			"SELECT "
			+ "R.request_id, "
			+ "R.applicant_id, "
			+ "R.approver_id, "
			+ "R.applicant, "
			+ "R.approver, "
			+ "R.request_date, "
			+ "R.approval_date, "
			+ "R.request_flag, "
			+ "LR.license_request_id,"
			+ "LR.group_id,"
			+ "LR.department_id, "
			+ "LR.exam_date, "
			+ "LR.exam_time, "
			+ "LR.receipt,"
			+ "LR.license_id, "
			+ "LR.passing, "
			+ "G.group_name, "
			+ "D.department_name, "
			+ "LI.license_name "
			+ "FROM license_request_info as LR "
			+ "INNER JOIN request_info as R "
			+ "ON LR.request_id = R.request_id "
			+ "INNER JOIN group_info as G "  
			+ "ON LR.group_id = G.group_id "
			+ "INNER JOIN department_info as D "
			+ "ON LR.department_id = D.department_id "
			+ "INNER JOIN license_info as LI "
			+ "ON LR.license_id = LI.license_id ";

	//-----------------------------------------------------------------------------------------------------------------------------------------------------

	/**
	 * 各テーブルから資格申請一覧を行う際に必要な情報を取り出すメソッド
	 * 取り出した情報はArrayListに格納してリターンする
	 * @return ArrayList<LicenseRequestExclusive>
	 */
	public ArrayList<LicenseRequestExclusive> selectAllLicense() {

		//変数宣言
		Connection con = null;
		Statement smt = null;

		//データを格納リストの作成
		ArrayList<LicenseRequestExclusive> licenseRequestExclusiveList = new ArrayList<LicenseRequestExclusive>();

		try {
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			//SQL文(request_infoとlicense_request_infoとgroup_infoとdepartment_infoとlicense_info)
			String sql = licenseRequestSql+ "ORDER BY r.request_flag ASC, r.request_date DESC;"; 

			ResultSet rs = smt.executeQuery(sql);

			while (rs.next()) {
				
				//オブジェクト化
				LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();
				
				//request_info
				licenseRequestExclusive.setRequestId(rs.getInt("request_id"));
				licenseRequestExclusive.setApplicantId(rs.getInt("applicant_id"));
				licenseRequestExclusive.setApproverId(rs.getInt("approver_id"));
				licenseRequestExclusive.setApplicant(rs.getString("applicant"));
				licenseRequestExclusive.setApprover(rs.getString("approver"));
				licenseRequestExclusive.setRequestDate(rs.getTimestamp("request_date"));
				licenseRequestExclusive.setApprovalDate(rs.getTimestamp("approval_date"));
				licenseRequestExclusive.setRequestFlag(rs.getInt("request_flag"));

				//license_request_info
				licenseRequestExclusive.setLicenseRequestId(rs.getInt("license_request_id"));
				licenseRequestExclusive.setGroupId(rs.getInt("group_id"));
				licenseRequestExclusive.setDepartmentId(rs.getInt("department_id"));
				licenseRequestExclusive.setLicenseId(rs.getInt("license_id"));
				licenseRequestExclusive.setExamDate(rs.getTimestamp("exam_date"));
				licenseRequestExclusive.setExamTime(rs.getInt("exam_time"));
				licenseRequestExclusive.setReceipt(rs.getString("receipt"));
				licenseRequestExclusive.setPassing(rs.getString("passing"));

				//group_info
				licenseRequestExclusive.setGroupName(rs.getString("group_name"));

				//department_info
				licenseRequestExclusive.setDepartmentName(rs.getString("department_name"));

				//license_info
				licenseRequestExclusive.setLicenseName(rs.getString("license_name"));

				licenseRequestExclusiveList.add(licenseRequestExclusive);
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
		return licenseRequestExclusiveList;
	}

	/**
	 *各テーブルから資格申請一覧を行う際に必要な情報をrequestIdで絞って取り出すメソッド
	 *requestIdの値に応じた情報をリターンする
	 *@param 申請情報のID
	 *@return  資格申請一覧を行う際に必要な情報
	 * */
	public LicenseRequestExclusive selectByRequestId(int requestId) {

		//変数宣言
		Connection con = null;
		PreparedStatement smt = null;

		//オブジェクト化
		LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();

		try {
			con = DAOconnection.getConnection();

			//SQL文
			String sql = licenseRequestSql +"WHERE r.request_id = ? "
					+ "ORDER BY r.request_flag ASC, r.request_date DESC";

			smt = con.prepareStatement(sql);
			smt.setInt(1, requestId);

			ResultSet rs = smt.executeQuery();

			while (rs.next()) {

				//request_info
				licenseRequestExclusive.setRequestId(rs.getInt("request_id"));
				licenseRequestExclusive.setApplicantId(rs.getInt("applicant_id"));
				licenseRequestExclusive.setApproverId(rs.getInt("approver_id"));
				licenseRequestExclusive.setApplicant(rs.getString("applicant"));
				licenseRequestExclusive.setApprover(rs.getString("approver"));
				licenseRequestExclusive.setRequestDate(rs.getTimestamp("request_date"));
				licenseRequestExclusive.setApprovalDate(rs.getTimestamp("approval_date"));
				licenseRequestExclusive.setRequestFlag(rs.getInt("request_flag"));

				//license_request_info
				licenseRequestExclusive.setLicenseRequestId(rs.getInt("license_request_id"));
				licenseRequestExclusive.setGroupId(rs.getInt("group_id"));
				licenseRequestExclusive.setDepartmentId(rs.getInt("department_id"));
				licenseRequestExclusive.setLicenseId(rs.getInt("license_id"));
				licenseRequestExclusive.setExamDate(rs.getTimestamp("exam_date"));
				licenseRequestExclusive.setExamTime(rs.getInt("exam_time"));
				licenseRequestExclusive.setReceipt(rs.getString("receipt"));
				licenseRequestExclusive.setPassing(rs.getString("passing"));

				//group_info
				licenseRequestExclusive.setGroupName(rs.getString("group_name"));

				//department_info
				licenseRequestExclusive.setDepartmentName(rs.getString("department_name"));

				//license_info
				licenseRequestExclusive.setLicenseName(rs.getString("license_name"));
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
		return licenseRequestExclusive;
	}

}
