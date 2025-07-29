//<!-- 疑似テーブルメソッド（作：石井） -->
//<!-- 作成日：7/28　最終更新日：7/29 11:45 -->

package util;

import java.util.ArrayList;

// テーブルを使用せずにデータを取得するメソッドまとめ
public class CommonTable {
	
	// 部を取得するメソッド
	public String selectDepartment(int departmentId) {
		
		// 部のデータ一覧
		ArrayList<String> departmentList = new ArrayList<String>();
		departmentList.add("ビジネスソリューション第1部");
		departmentList.add("ビジネスソリューション第2部");
		departmentList.add("営業部");
		departmentList.add("NEXTINOVATION");
		departmentList.add("経営管理部");

		// 取得した部のデータを返すための変数
		String department = "";
		
		switch(departmentId) {
		case 1: 
			department = departmentList.get(0);
			break;
		case 2: 
			department = departmentList.get(1);
			break;
		case 99: 
			department = departmentList.get(2);
			break;
		case 100: 
			department = departmentList.get(3);
			break;
		case 101: 
			department = departmentList.get(4);
			break;
//		default:	ここにエラー処理を書いたらいいのかもしれない
		}
		
		return department;
		
	}
	
	// グループを取得するメソッド
	public String selectGroup(int groupId) {
		
		// 部のデータ一覧
		ArrayList<String> groupList = new ArrayList<String>();
		groupList.add("／");
		groupList.add("第1グループ");
		groupList.add("第2グループ");
		groupList.add("第3グループ");
		groupList.add("第4グループ");
		
		// 取得した部のデータを返すための変数
		String group = "";
		
		switch(groupId) {
		case 0: 
			group = groupList.get(0);
			break;
		case 1: 
			group = groupList.get(1);
			break;
		case 2: 
			group = groupList.get(2);
			break;
		case 3: 
			group = groupList.get(3);
			break;
		case 4: 
			group = groupList.get(4);
			break;
//		default:	ここにエラー処理を書いたらいいのかもしれない
		}
		
		return group;
		
	}

}
