/*
 * 機能：資格、氏名、住所、(副業)申請に関するDAO
 * 
 * 作成者：桑原岳
 *  
 * 最終更新日：2025/08/19
 *  
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Map;

import bean.AddressRequestExclusive;
import bean.LicenseRequestExclusive;
import bean.NameRequest;
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
	    ResultSet rs = null;           // 生成されたrequest_idを取得するため

	    try {
	        // データベース接続を取得
	        con = DAOconnection.getConnection();

	        // トランザクションを開始
	        con.setAutoCommit(false);

	        // --- 処理1：request_infoテーブルに氏名と現在日時をINSERT ---
	     // --- 親テーブルにINSERT ---
	     // --- 親テーブルにINSERT ---
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

	        // --- 子テーブルにINSERT ---
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
	                addressRequestExclusive.getAddressChangedDate().atStartOfDay()
	        ));

	        int affectedRows = smt2.executeUpdate();
	        con.commit();
	        return affectedRows > 0;

	    // ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	    // ★★★ catchブロックを SQLException と ClassNotFoundException に分離 ★★★
	    // ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
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
	        // --- 最後に必ずリソースを解放する ---
	        try {
	            if (rs != null) rs.close();
	            if (smt1 != null) smt1.close();
	            if (smt2 != null) smt2.close();
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
	 * 資格申請の情報をトランザクション内で2つのテーブルに登録します。
	 * @param userInput 登録するデータが格納されたMap
	 * @return 2つの登録処理がすべて成功した場合は true, 途中で失敗した場合は false
	 */
	public boolean insertLicenseRequest(Map<String, Object> userInput) {
		Connection con = null;
		PreparedStatement smt1 = null; // request_infoへのINSERT用
		PreparedStatement smt2 = null; // license_request_infoへのINSERT用
		ResultSet rs = null; // 生成されたrequest_idを取得するため

		try {
			// データベース接続を取得
			con = DAOconnection.getConnection(); // ご自身の接続クラス名にしてください

			// ★★★ トランザクションを開始（自動コミットを無効化） ★★★
			con.setAutoCommit(false);

			// --- 処理1：request_infoテーブルにINSERT ---
			// NOW() を使うことで、DBサーバーの現在日時が記録される
			// --- 親テーブルにINSERT ---
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

			// --- 子テーブルにINSERT ---
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
			        addressRequestExclusive.getAddressChangedDate().atStartOfDay()
			));

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
}