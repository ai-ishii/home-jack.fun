/*
 * 機能：資格、氏名、住所、(副業)申請に関するDAO
 * 
 * 作成者：桑原岳
 *  
 * 最終更新日：2025/08/01
 *  
 */
package dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import bean.AddressRequestExclusive;
import bean.LicenseRequest;
import bean.LicenseRequestExclusive;
import bean.NameRequest;
import jakarta.servlet.http.Part;
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
					+ "FROM "
					+ "license_request_info as LR "
					+ "INNER JOIN "
					+ "request_info as R "
					+ "ON "
					+ "LR.request_id = R.request_id "
					+ "INNER JOIN "
					+ "group_info as G "
					+ "ON "
					+ "LR.group_id = G.group_id "
					+ "INNER JOIN "
					+ "department_info as D "
					+ "ON "
					+ "LR.department_id = D.department_id "
					+ "INNER JOIN "
					+ "license_info as LI "
					+ "ON "
					+ "LR.license_id = LI.license_id ";

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
			String sql = licenseRequestSql
					+ "ORDER BY "
					+ "r.request_flag ASC, "
					+ "r.request_date DESC;";

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

		} catch (SQLException e) {
			System.err.println("RequestDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("RequestDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("RequestDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("RequestDAOの不明なエラー: " + e.getMessage());
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

		boolean success = false;

		//オブジェクト化
		LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();

		try {
			con = DAOconnection.getConnection();

			//SQL文
			String sql = licenseRequestSql
					+ "WHERE"
					+ " r.request_id = ? "
					+ "ORDER BY "
					+ "r.request_flag ASC, "
					+ "r.request_date DESC";

			//オートコミットを無効化
			con.setAutoCommit(false);

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

			con.commit();
			success = true;

		} catch (SQLException e) {
			System.err.println("RequestDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("RequestDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("RequestDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("RequestDAOの不明なエラー: " + e.getMessage());
			}
		}
		return licenseRequestExclusive;
	}

	/**
	 * 氏名変更申請をデータベースに登録するメソッド
	 * @param nameRequest 登録したい申請データ
	 * @return 登録に成功した場合は true, 失敗した場合は false
	 */
	public boolean insertNameChange(NameRequest nameRequest) {

		// try-with-resources構文で、処理が終わったら自動でリソースを閉じる
		try {

			Connection con = null;
			PreparedStatement smt = null;

			// 1. データベースへ接続
			con = DAOconnection.getConnection();

			// 2. INSERT文
			String sql = "INSERT "
					+ "INTO name_request_info( "
					+ "old_name, "
					+ "old_name_kana, "
					+ "new_name, "
					+ "new_name_kana) "
					+ "VALUES (?, ?, ?, ?)";

			PreparedStatement pstmt = con.prepareStatement(sql);

			// 3. SQL文の「?」に値をセット
			pstmt.setString(1, nameRequest.getOldName());
			pstmt.setString(2, nameRequest.getOldNameKana());
			pstmt.setString(3, nameRequest.getNewName());
			pstmt.setString(4, nameRequest.getNewNameKana());

			// 4. INSERT文を実行し、結果（更新された行数）を取得
			int affectedRows = pstmt.executeUpdate();

			// 5. 1行以上更新されていれば成功とみなし true を返す
			return affectedRows > 0;

		} catch (SQLException e) {
			// エラーが発生した場合は、コンソールにエラー内容を出力
			e.printStackTrace();
			// 失敗したため false を返す
			return false;
		}
	}

	/**
	 * 住所変更申請をデータベースに登録するメソッド
	 * @param addressRequestExclusive 登録したい申請データ
	 * @return 登録に成功した場合は true, 失敗した場合は false
	 */
	public boolean insertAddressChange(AddressRequestExclusive addressRequestExclusive) {

		// try-with-resources構文で、処理が終わったら自動でリソースを閉じる
		try {

			Connection con = null;
			PreparedStatement smt = null;

			// 1. データベースへ接続
			con = DAOconnection.getConnection();

			// 2. INSERT文
			String sql = "INSERT INTO address_request_info ("
					+ "employee_number, "
					+ "name, "
					+ "change_date, "
					+ "old_post, "
					+ "old_address, "
					+ "new_post, "
					+ "new_address, "
					+ "nearest_station,"
					+ "request_datetime) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

			smt = con.prepareStatement(sql); 

			// 3. SQL文の「?」に値をセット
			smt.setString(1, addressRequestExclusive.getEmployeenumber());
			smt.setString(2, addressRequestExclusive.getName());
			smt.setDate(3, Date.valueOf(addressRequestExclusive.getAddressChangedDate()));
			smt.setString(4, addressRequestExclusive.getOldPost());
			smt.setString(5, addressRequestExclusive.getOldAddress());
			smt.setString(6, addressRequestExclusive.getNewPost());
			smt.setString(7, addressRequestExclusive.getNewAddress());
			smt.setString(8, addressRequestExclusive.getNeareststation());
			smt.setDate(9, Date.valueOf(addressRequestExclusive.getApplicationDate()));
			// 4. INSERT文を実行し、結果（更新された行数）を取得
			int affectedRows = smt.executeUpdate();

			// 5. 1行以上更新されていれば成功とみなし true を返す
			return affectedRows > 0;

		} catch (SQLException e) {
			// エラーが発生した場合は、コンソールにエラー内容を出力
			e.printStackTrace();
			// 失敗したため false を返す
			return false;
		}
	}

	/**
	 * 資格申請の情報をデータベースに登録します。
	 * @param licenseRequest 登録するデータが格納されたDTO
	 * @return 登録に成功した場合は true, 失敗した場合は false
	 */
	public boolean insertLicenseRequest(LicenseRequest licenseRequest) {
		try {

			Connection con = null;
			PreparedStatement smt = null;

			// 1. データベースへ接続
			con = DAOconnection.getConnection();
			// ★SQL文は実際のテーブル名とカラム名に合わせてください
			String sql = "INSERT INTO license_request_info ("
					+ "applicant_name, "
					+ "department_name, "
					+ "group_name, "
					+ "license_name, "
					+ "exam_date, "
					+ "exam_time, "
					+ "receipt_data, "
					+ "passing_data) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			
			smt = con.prepareStatement(sql); 

			// DTOから値を取得してPreparedStatementにセット
			smt.setString(1, licenseRequest.getApplicant());
			smt.setString(2, licenseRequest.getDepartmentName());
			smt.setString(3, licenseRequest.getGroupName());
			smt.setString(4, licenseRequest.getLicenseName());
			smt.setDate(5, Date.valueOf(licenseRequest.getExamDate())); // LocalDateをjava.sql.Dateに変換
			smt.setInt(6, licenseRequest.getExamTime());

			// --- ファイル（Part）の処理 ---
			Part receiptPart = licenseRequest.getReceipt();
			Part passingPart = licenseRequest.getPassing();

			// 領収書ファイル
			if (receiptPart != null && receiptPart.getSize() > 0) {
				// PartからInputStreamを取得してセット
				try (InputStream receiptInputStream = receiptPart.getInputStream()) {
					smt.setBinaryStream(7, receiptInputStream, receiptPart.getSize());
				}
			} else {
				// ファイルが添付されていない場合はNULLをセット
				smt.setNull(7, java.sql.Types.BLOB);
			}

			// 合格証ファイル
			if (passingPart != null && passingPart.getSize() > 0) {
				// PartからInputStreamを取得してセット
				try (InputStream passingInputStream = passingPart.getInputStream()) {
					smt.setBinaryStream(8, passingInputStream, passingPart.getSize());
				}
			} else {
				// ファイルが添付されていない場合はNULLをセット
				smt.setNull(8, java.sql.Types.BLOB);
			}

			// INSERT文を実行し、更新された行数を取得
			int affectedRows = smt.executeUpdate();

			// 1行以上更新されていれば成功とみなす
			return affectedRows > 0;

		} catch (SQLException | IOException e) {
			// SQLエラーまたはファイルのI/Oエラーが発生した場合
			e.printStackTrace();
			return false;
		}
	}
}
