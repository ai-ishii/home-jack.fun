/*
 * 機能：資格、氏名、住所、(副業)申請に関するDAO
 * 
 * 作成者：桑原岳
 *  
 * 最終更新日：2025/08/27
 *  
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;

import bean.AddressRequestExclusive;
import bean.LicenseName;
import bean.LicenseRequestExclusive;
import bean.NameRequest;
import bean.Request;
import bean.User;
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
					+ "LR.receipt_name, "
					+ "LR.passing_name, "
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
					+ "R.request_flag ASC, "
					+ "R.request_id DESC;";

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
				java.sql.Date requestDate = rs.getDate("request_date");
				if (requestDate != null) {
					licenseRequestExclusive.setRequestDate(requestDate.toLocalDate());
				}
				licenseRequestExclusive.setApprovalDate(rs.getTimestamp("approval_date"));
				licenseRequestExclusive.setRequestFlag(rs.getInt("request_flag"));

				//license_request_info
				licenseRequestExclusive.setLicenseRequestId(rs.getInt("license_request_id"));
				licenseRequestExclusive.setGroupId(rs.getInt("group_id"));
				licenseRequestExclusive.setDepartmentId(rs.getInt("department_id"));
				licenseRequestExclusive.setLicenseId(rs.getInt("license_id"));
				java.sql.Date examDate = rs.getDate("exam_date");
				if (examDate != null) {
					licenseRequestExclusive.setExamDate(examDate.toLocalDate());
				}
				licenseRequestExclusive.setExamTime(rs.getInt("exam_time"));
				licenseRequestExclusive.setReceipt(rs.getBytes("receipt"));
				licenseRequestExclusive.setPassing(rs.getBytes("passing"));
				licenseRequestExclusive.setReceiptName(rs.getString("receipt_name"));
				licenseRequestExclusive.setPassingName(rs.getString("passing_name"));

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
					+ "R.request_flag ASC, "
					+ "R.request_id DESC";

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
				licenseRequestExclusive.setRequestDate(rs.getDate("request_date").toLocalDate());
				licenseRequestExclusive.setApprovalDate(rs.getTimestamp("approval_date"));
				licenseRequestExclusive.setRequestFlag(rs.getInt("request_flag"));

				//license_request_info
				licenseRequestExclusive.setLicenseRequestId(rs.getInt("license_request_id"));
				licenseRequestExclusive.setGroupId(rs.getInt("group_id"));
				licenseRequestExclusive.setDepartmentId(rs.getInt("department_id"));
				licenseRequestExclusive.setLicenseId(rs.getInt("license_id"));
				licenseRequestExclusive.setExamDate(rs.getDate("exam_date").toLocalDate());
				licenseRequestExclusive.setExamTime(rs.getInt("exam_time"));
				licenseRequestExclusive.setReceipt(rs.getBytes("receipt"));
				licenseRequestExclusive.setPassing(rs.getBytes("passing"));
				licenseRequestExclusive.setReceiptName(rs.getString("receipt_name"));
				licenseRequestExclusive.setPassingName(rs.getString("passing_name"));

				
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
	 * 住所変更申請をトランザクション内で2つのテーブルに登録します。
	 * 1. request_infoに申請者と日付を登録し、request_idを取得。
	 * 2. address_request_infoに詳細情報を登録。
	 * @param addressRequestExclusive 登録したい申請データ
	 * @return 登録に成功した場合は true, 失敗した場合は false
	 */
	public boolean insertAddressChange(AddressRequestExclusive addressRequestExclusive) {

		Connection con = null;
		PreparedStatement smt1 = null; // request_infoへのINSERT用
		PreparedStatement smt2 = null; // address_request_infoへのINSERT用
		ResultSet rs = null; // 生成されたrequest_idを取得するため

		try {
			// データベース接続を取得
			con = DAOconnection.getConnection();

			// トランザクションを開始
			con.setAutoCommit(false);

			// request_infoテーブルに氏名と現在日時をINSERT 
			// 親テーブルにINSERT 
			// 親テーブルにINSERT
			String sql1 = "INSERT INTO request_info (applicant, request_date) VALUES (?, NOW())";
			smt1 = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
			smt1.setString(1, addressRequestExclusive.getName());
			smt1.executeUpdate();

			// request_idを取得
			rs = smt1.getGeneratedKeys();
			long newRequestId = 0;
			if (rs.next()) {
				newRequestId = rs.getLong(1);
			} else {
				throw new SQLException("request_idの取得に失敗しました。");
			}

			// 子テーブルにINSERT
			String sql2 = "INSERT INTO address_request_info ("
					+ "request_id, "
					+ "old_post, "
					+ "old_address, "
					+ "new_post, "
					+ "new_address, "
					+ "nearest_station, "
					+ "address_change_date) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

			smt2 = con.prepareStatement(sql2);
			smt2.setLong(1, newRequestId);
			smt2.setString(2, addressRequestExclusive.getOldPost());
			smt2.setString(3, addressRequestExclusive.getOldAddress());
			smt2.setString(4, addressRequestExclusive.getNewPost());
			smt2.setString(5, addressRequestExclusive.getNewAddress());
			smt2.setString(6, addressRequestExclusive.getNeareststation());

			// LocalDate → Timestamp に変換
			smt2.setTimestamp(7, Timestamp.valueOf(
					addressRequestExclusive.getAddressChangedDate().atStartOfDay()));

			int affectedRows = smt2.executeUpdate();
			con.commit();
			return affectedRows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			if (con != null) {
				try {
					con.rollback();
				} catch (SQLException e2) {
					e2.printStackTrace();
				}
			}
			return false;

		} finally {
			// 最後に必ずリソースを解放する
			try {
				if (rs != null)
					rs.close();
				if (smt1 != null)
					smt1.close();
				if (smt2 != null)
					smt2.close();
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * useridで資格申請に必要な情報(氏名、部名、グループ名)を取り出すメソッド
	 * @param  userId
	 * @return 必要な情報を格納したArrayList
	 */
	public ArrayList<LicenseRequestExclusive> selectUserId(int userId) {
		PreparedStatement pstmt = null;
		ArrayList<LicenseRequestExclusive> userList = new ArrayList<>();

		Connection con = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT "
					+ "U.name, "
					+ "D.department_name, "
					+ "G.group_name "
					+ "FROM "
					+ "user_info as U "
					+ "INNER JOIN "
					+ "department_info as D "
					+ "ON "
					+ "U.department_id = D.department_id "
					+ "INNER JOIN "
					+ "group_info as G "
					+ "ON "
					+ "U.group_id = G.group_id "
					+ "WHERE "
					+ "user_id = ?";

			con = DAOconnection.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();
				licenseRequestExclusive.setApplicant(rs.getString("name"));
				licenseRequestExclusive.setDepartmentName(rs.getString("department_name"));
				licenseRequestExclusive.setGroupName(rs.getString("group_name"));
				userList.add(licenseRequestExclusive);
			}
		} catch (SQLException e) {
			// エラーが発生した場合の処理（例：ログ出力）
			e.printStackTrace();
		} finally {
			// finallyブロック内で発生するSQLExceptionを個別に処理する
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return userList;
	}

	/**
	 * 資格名を取り出すメソッド
	 * 
	 * @return 資格名を格納したArrayList
	 */
	public ArrayList<LicenseName> selectAllLicenseName() {

		Statement smt = null;
		ArrayList<LicenseName> licenseNameList = new ArrayList<>();
		Connection con = null;
		ResultSet rs = null;

		try {
			con = DAOconnection.getConnection();
			smt = con.createStatement();

			String sql = "SELECT "
					+ "license_id, "
					+ "type_code, "
					+ "license_name "
					+ "FROM "
					+ "license_info";

			rs = smt.executeQuery(sql);
			while (rs.next()) {
				LicenseName license = new LicenseName();
				license.setLicenseId(rs.getInt("license_id"));
				license.setTypeCode(rs.getString("type_code"));
				license.setLicenseName(rs.getString("license_name"));
				licenseNameList.add(license);
			}
		} catch (SQLException e) {
			// エラーが発生した場合の処理（例：ログ出力）
			e.printStackTrace();
		} finally {
			// finallyブロック内で発生するSQLExceptionを個別に処理する
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (smt != null) {
					smt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return licenseNameList;
	}

	/**
	 * 親テーブルにapplicantIdを登録して request_id を返すメソッド
	 * 
	 * 
	 * */
	public long insertLicenseRequestID(int applicantId) {
		String sql = "INSERT INTO "
				+ "request_info "
				+ "(applicant_id) "
				+ "VALUES (?)";

		try (Connection con = DAOconnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			pstmt.setInt(1, applicantId);
			int affectedRows = pstmt.executeUpdate();

			if (affectedRows == 0) {
				return -1; // 登録失敗
			}

			try (ResultSet rs = pstmt.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getLong(1);
				} else {
					return -1; // request_id 取得失敗
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	/**
	 *  子テーブル（license_request_info）に登録するメソッド
	 * 
	 * 
	 * */
	public boolean insertLicenseRequestDetails(long requestId, LicenseRequestExclusive licenseRequestExclusive) {
		String sql = "INSERT INTO "
				+ "license_request_test_info ("
				+ "request_id, "
				+ "group_id, "
				+ "department_id, "
				+ "license_id, "
				+ "exam_date, "
				+ "exam_time, "
				+ "receipt, "
				+ "passing, "
				+ "receipt_name, "
				+ "passing_name) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (Connection con = DAOconnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setLong(1, requestId);
			pstmt.setInt(2, licenseRequestExclusive.getGroupId());
			pstmt.setInt(3, licenseRequestExclusive.getDepartmentId());
			pstmt.setInt(4, licenseRequestExclusive.getLicenseId());
			pstmt.setDate(5, Date.valueOf(licenseRequestExclusive.getExamDate()));
			pstmt.setInt(6, licenseRequestExclusive.getExamTime());
			pstmt.setBytes(7, licenseRequestExclusive.getReceipt());
			pstmt.setBytes(8, licenseRequestExclusive.getPassing());
			pstmt.setString(9, licenseRequestExclusive.getReceiptName());
			pstmt.setString(10, licenseRequestExclusive.getPassingName());

			return pstmt.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// 部署名から department_id を取得
	public int selectByDepartmentId(String department) {
		String sql = "SELECT department_id FROM department_info WHERE department_name = ?";

		try (Connection con = DAOconnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setString(1, department);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt("department_id");
				} else {
					return -1; // 見つからなかった場合
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	// グループ名から group_id を取得
	public int selectByGroupId(String group) {
		String sql = "SELECT group_id FROM group_info WHERE group_name = ?";

		try (Connection con = DAOconnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setString(1, group);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt("group_id");
				} else {
					return -1;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	// 資格名から license_id を取得
	public int selectByLicenseId(String license) {
		String sql = "SELECT license_id FROM license_info WHERE license_name = ?";

		try (Connection con = DAOconnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setString(1, license);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt("license_id");
				} else {
					return -1;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	// 親テーブルに登録して request_id を返す
	public long insertReceiptFileProvisional(byte[] receiptBytes, String receiptFileName) {
		String sql = "INSERT INTO "
				+ "license_request_test_info "
				+ "(receipt,receipt_name) "
				+ "VALUES (?,?)";

		try (Connection con = DAOconnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			pstmt.setBytes(1, receiptBytes);
			pstmt.setString(2, receiptFileName);

			int affectedRows = pstmt.executeUpdate();

			if (affectedRows == 0) {
				return -1; // 登録失敗
			}

			try (ResultSet rs = pstmt.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getLong(1);
				} else {
					return -1; // request_id 取得失敗
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}

	}

	// 親テーブルに登録して request_id を返す
	public long insertPassingFileProvisional(byte[] passingBytes, String passingFileName) {
		String sql = "INSERT INTO "
				+ "license_request_test_info "
				+ "(passing,passing_name) "
				+ "VALUES (?,?)";

		try (Connection con = DAOconnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			pstmt.setBytes(1, passingBytes);
			pstmt.setString(2, passingFileName);

			int affectedRows = pstmt.executeUpdate();

			if (affectedRows == 0) {
				return -1; // 登録失敗
			}

			try (ResultSet rs = pstmt.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getLong(1);
				} else {
					return -1; // request_id 取得失敗
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	/** 既存ファイルを更新 */
	public void updateReceiptFile(long fileId, byte[] fileBytes, String fileName) {
		String sql = "UPDATE "
				+ "license_request_test_info"
				+ " SET "
				+ "receipt = ?, "
				+ "receipt_name = ? "
				+ "WHERE license_request_test_id = ?";
		try (Connection conn = DAOconnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setBytes(1, fileBytes);
			ps.setString(2, fileName);
			ps.setLong(3, fileId);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/** 既存ファイルを更新 */
	public void updatePassingFile(long fileId, byte[] fileBytes, String fileName) {
		String sql = "UPDATE "
				+ "license_request_test_info"
				+ " SET "
				+ "passing = ?, "
				+ "passing_name = ? "
				+ "WHERE license_request_test_id = ?";
		try (Connection conn = DAOconnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setBytes(1, fileBytes);
			ps.setString(2, fileName);
			ps.setLong(3, fileId);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/** ファイルバイト取得 */
	public byte[] getReceiptFileById(long oldReceiptId) {
		String sql = "SELECT "
				+ "receipt "
				+ "FROM "
				+ "license_request_test_info "
				+ "WHERE license_request_test_id = ?";
		try (Connection conn = DAOconnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, oldReceiptId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return rs.getBytes("receipt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/** ファイルバイト取得 */
	public byte[] getPassingFileById(long oldPassingId) {
		String sql = "SELECT "
				+ "passing "
				+ "FROM "
				+ "license_request_test_info "
				+ "WHERE license_request_test_id = ?";
		try (Connection conn = DAOconnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, oldPassingId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return rs.getBytes("passing");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/** ファイル名取得 */
	public String getReceiptFileNameById(long fileId) {
		String sql = "SELECT "
				+ "receipt_name "
				+ "FROM "
				+ "license_request_test_info "
				+ "WHERE license_request_test_id = ?";
		try (Connection conn = DAOconnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, fileId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return rs.getString("receipt_name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/** ファイル名取得 */
	public String getPassingFileNameById(long fileId) {
		String sql = "SELECT "
				+ "passing_name "
				+ "FROM "
				+ "license_request_test_info "
				+ "WHERE license_request_test_id = ?";
		try (Connection conn = DAOconnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, fileId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return rs.getString("passing_name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * request_infoに登録してrequest_idを返すメソッド
	 * 
	 * @return int requestId
	 */
	public int insertApplicantId(int applicantId, String name, LocalDate localDate) {
		String sql = "INSERT INTO "
				+ "request_info "
				+ "(applicant_id,applicant,request_date) "
				+ "VALUES (?,?,?)";

		try (Connection con = DAOconnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			pstmt.setInt(1, applicantId);
			pstmt.setString(2, name);
			pstmt.setDate(3, java.sql.Date.valueOf(localDate));

			int affectedRows = pstmt.executeUpdate();

			if (affectedRows == 0) {
				return -1; // 登録失敗
			}

			try (ResultSet rs = pstmt.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getInt(1);
				} else {
					return -1; // request_id 取得失敗
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	/**
	 * license_request_test_infoに登録された情報を取り出すメソッド
	 * 
	 * @return licenseRequestExclusive
	 */
	public LicenseRequestExclusive selectRequestTestInfo(int requestId) {

		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();

		try {
			con = DAOconnection.getConnection();

			String sql = "SELECT "
					+ "group_id, "
					+ "department_id, "
					+ "license_id, "
					+ "exam_date, "
					+ "exam_time, "
					+ "receipt, "
					+ "passing, "
					+ "receipt_name, "
					+ "passing_name "
					+ "FROM "
					+ "license_request_test_info "
					+ "WHERE "
					+ "request_id = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, requestId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				licenseRequestExclusive.setGroupId(rs.getInt("group_id"));
				licenseRequestExclusive.setDepartmentId(rs.getInt("department_id"));
				licenseRequestExclusive.setLicenseId(rs.getInt("license_id"));
				licenseRequestExclusive.setExamDate(rs.getDate("exam_date").toLocalDate());
				licenseRequestExclusive.setExamTime(rs.getInt("exam_time"));
				licenseRequestExclusive.setReceipt(rs.getBytes("receipt"));
				licenseRequestExclusive.setPassing(rs.getBytes("passing"));
				licenseRequestExclusive.setReceiptName(rs.getString("receipt_name"));
				licenseRequestExclusive.setPassingName(rs.getString("passing_name"));
			}
		} catch (SQLException e) {
			// エラーが発生した場合の処理（例：ログ出力）
			e.printStackTrace();
		} finally {
			// finallyブロック内で発生するSQLExceptionを個別に処理する
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return licenseRequestExclusive;
	}

	/**
	 * 資格申請をデータベースに登録するメソッド
	 * @param nameRequest 登録したい申請データ
	 * @return 登録に成功した場合は true, 失敗した場合は false
	 */
	public boolean insertLicenseInfo(LicenseRequestExclusive licenseRequestExclusive) {

		// try-with-resources構文で、処理が終わったら自動でリソースを閉じる
		try {

			Connection con = null;
			PreparedStatement pstmt = null;

			// 1. データベースへ接続
			con = DAOconnection.getConnection();

			// 2. INSERT文
			String sql = "INSERT "
					+ "INTO license_request_info( "
					+ "request_id, "
					+ "group_id, "
					+ "department_id, "
					+ "license_id, "
					+ "exam_date, "
					+ "exam_time, "
					+ "receipt, "
					+ "passing, "
					+ "receipt_name, "
					+ "passing_name) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = con.prepareStatement(sql);

			// 3. SQL文の「?」に値をセット
			pstmt.setInt(1, licenseRequestExclusive.getRequestId());
			pstmt.setInt(2, licenseRequestExclusive.getGroupId());
			pstmt.setInt(3, licenseRequestExclusive.getDepartmentId());
			pstmt.setInt(4, licenseRequestExclusive.getLicenseId());
			pstmt.setDate(5, Date.valueOf(licenseRequestExclusive.getExamDate()));
			pstmt.setInt(6, licenseRequestExclusive.getExamTime());
			pstmt.setBytes(7, licenseRequestExclusive.getReceipt());
			pstmt.setBytes(8, licenseRequestExclusive.getPassing());
			pstmt.setString(9, licenseRequestExclusive.getReceiptName());
			pstmt.setString(10, licenseRequestExclusive.getPassingName());

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
	 * useridで資格申請に必要な情報(氏名、部名、グループ名)を取り出すメソッド
	 * @param  userId
	 * @return 必要な情報を格納したuser
	 */
	public User selectUserName(int userId) {
		PreparedStatement pstmt = null;
		Connection con = null;
		ResultSet rs = null;

		User user = new User();

		try {
			String sql = "SELECT "
					+ "name, "
					+ "name_kana "
					+ "FROM "
					+ "user_info  "
					+ "WHERE "
					+ "user_id = ?";

			con = DAOconnection.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				user.setName(rs.getString("name"));
				user.setNameKana(rs.getString("name_kana"));
			}
		} catch (SQLException e) {
			// エラーが発生した場合の処理（例：ログ出力）
			e.printStackTrace();
		} finally {
			// finallyブロック内で発生するSQLExceptionを個別に処理する
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return user;
	}

	/**
	 * useridで資格申請に必要な情報(氏名、部名、グループ名)を取り出すメソッド
	 * @param  userId
	 * @return 必要な情報を格納したArrayList
	 */
	public User selectUserAddress(int userId) {
		PreparedStatement pstmt = null;
		Connection con = null;
		ResultSet rs = null;

		User user = new User();

		try {
			String sql = "SELECT "
					+ "employee_number, "
					+ "name, "
					+ "post, "
					+ "address "
					+ "FROM "
					+ "user_info  "
					+ "WHERE "
					+ "user_id = ?";

			con = DAOconnection.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				user.setEmployeeNumber(rs.getString("employee_number"));
				user.setName(rs.getString("name"));
				user.setPost(rs.getString("post"));
				user.setAddress(rs.getString("address"));
			}
		} catch (SQLException e) {
			// エラーが発生した場合の処理（例：ログ出力）
			e.printStackTrace();
		} finally {
			// finallyブロック内で発生するSQLExceptionを個別に処理する
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return user;
	}

	/**
	 * フラグごとに資格取得者一覧を表示する機能
	 * （１．申請中  ２．承認済み ３．差戻中）
	 * @param requestFlag
	 * @return ArrayList<LicenseRequest> list 
	 */
	public ArrayList<Request> selectLicenseListByFlag(int requestFlag) {

		//変数宣言
		Connection con = null;
		PreparedStatement ps = null;

		// 検索結果を格納するArrayListの宣言
		ArrayList<Request> list = new ArrayList<Request>();

		String sql = "SELECT "
				+ "r.request_id, "
				+ "r.applicant "
				+ "FROM "
				+ "request_info AS r "
				+ "INNER JOIN "
				+ "license_request_info AS l "
				+ "ON "
				+ "r.request_id = l.request_id "
				+ "WHERE "
				+ "r.request_flag = ?";

		try {

			// DBに接続する
			con = DAOconnection.getConnection();
			ps = con.prepareStatement(sql);

			ps.setInt(1, requestFlag);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				// オブジェクト生成
				Request request = new Request();

				// 各クラス変数に値を代入する
				request.setRequestId(rs.getInt("request_id"));
				request.setApplicant(rs.getString("applicant"));

				// ArrayListに代入する
				list.add(request);
			}

		} catch (SQLException e) {
			System.err.println("RequestLicenseDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("RequestLicenseDAOの不明なエラー: " + e.getMessage());
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
				System.err.println("RequestLicenseDAOのcon，smtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("RequestLicenseDAOの不明なエラー: " + e.getMessage());
			}
		}

		return list;
	}

	/**
	 *license_request_test_infoに登録した仮登録情報をすべて削除する機能
	 
	 * */
	public void deleteLicenseRequestTest() {

		//変数宣言
		Statement smt = null;
		Connection con = null;
		try {
			String sql = "DELETE "
					+ "FROM "
					+ "license_request_test_info ";

			con = DAOconnection.getConnection();
			smt = con.createStatement();
			smt.executeUpdate(sql);

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
	}

	/**
	 *license_request_infoに登録した仮登録情報をすべて削除する機能
	 
	 * */
	public void deleteLicenseRequest(int applicantId) {

		//変数宣言
		PreparedStatement pstmt = null;
		Connection con = null;
		try {
			String sql = "DELETE "
					+ "FROM "
					+ "request_info "
					+ "WHERE "
					+ "applicant IS NULL "
					+ "AND "
					+ "applicant_id = ?";

			con = DAOconnection.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, applicantId);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println("RequestDAOのデータベース接続時にエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} catch (Exception e) {
			System.err.println("RequestDAOの不明なエラー: " + e.getMessage());
			throw new IllegalStateException(e);
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				System.err.println("RequestDAOのcon，pstmtクローズ時にエラー: " + e.getMessage());
			} catch (Exception e) {
				System.err.println("RequestDAOの不明なエラー: " + e.getMessage());
			}
		}
	}
	/**
	 * requestIdで領収書画像、領収書画像名、合格証画像、合格証画像名を取り出すメソッド
	 * @param  requestId
	 * @return licenseRequestExclusive
	 */
	public LicenseRequestExclusive selectPhotoByRequestId(int requestId) {
		PreparedStatement pstmt = null;
		Connection con = null;
		ResultSet rs = null;

		LicenseRequestExclusive licenseRequestExclusive = new LicenseRequestExclusive();

		try {
			String sql = "SELECT "
					+ "receipt, "
					+ "passing, "
					+ "receipt_name, "
					+ "passing_name "
					+ "FROM "
					+ "license_request_info  "
					+ "WHERE "
					+ "request_id = ?";

			con = DAOconnection.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, requestId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				licenseRequestExclusive.setReceipt(rs.getBytes("receipt"));
				licenseRequestExclusive.setPassing(rs.getBytes("passing"));
				licenseRequestExclusive.setReceiptName(rs.getString("receipt_name"));
				licenseRequestExclusive.setPassingName(rs.getString("passing_name"));
			}
		} catch (SQLException e) {
			// エラーが発生した場合の処理（例：ログ出力）
			e.printStackTrace();
		} finally {
			// finallyブロック内で発生するSQLExceptionを個別に処理する
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return licenseRequestExclusive;
	}
	
}