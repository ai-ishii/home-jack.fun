/*
 * 資格申請系のDAOファイル
 * 
 * 作成者：大北直弥
 * 
 * 作成日：8/26
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.LicenseRequest;
import util.DAOconnection;

public class RequestLicenseDAO {
	
	/**
	 * フラグごとに資格取得者一覧を表示する機能
	 * （１．申請中  ２．承認済み ３．差戻中）
	 * @param requestFlag
	 * @return ArrayList<LicenseRequest> list 
	 */
	public ArrayList<LicenseRequest> selectLicenseListByFlag(int requestFlag) {
		
		//変数宣言
		Connection con = null;
		PreparedStatement ps = null;
		
		// 検索結果を格納するArrayListの宣言
		ArrayList<LicenseRequest> list = 
				new ArrayList<LicenseRequest>();
		
		String sql = "SELECT "
						+ "l.request_id, "
						+ "l.department_id, "
						+ "l.group_id, "
						+ "l.license_id, "
						+ "l.exam_date "
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
				LicenseRequest licenseRequest = new LicenseRequest();
				
				// 各クラス変数に値を代入する
				licenseRequest.setRequestId(rs.getInt("request_id"));
				licenseRequest.setDepartmentId(rs.getInt("department_id"));
				licenseRequest.setGroupId(rs.getInt("group_id"));
				licenseRequest.setLicenseId(rs.getInt("license_id"));
				licenseRequest.setExamDate(rs.getDate("exam_date").toLocalDate());
				
				// ArrayListに代入する
				list.add(licenseRequest);
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


}
