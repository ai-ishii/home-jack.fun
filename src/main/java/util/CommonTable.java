//<!-- 疑似テーブルメソッド（作：石井） -->
//<!-- 作成日：7/28　最終更新日：7/29 11:45 -->

package util;

import java.util.HashMap;
import java.util.Map;

// テーブルを使用せずにデータを取得するメソッドまとめ
public class CommonTable {
	
	// 部を取得するメソッド
	public String selectDepartment(int departmentId) {
		
		Map<Integer, String> map = new HashMap<>();
		
		map.put(1, "ビジネスソリューション第1部");
		map.put(2, "ビジネスソリューション第2部");
		map.put(100, "営業部");
		map.put(200, "NEXTINOVATION");
		map.put(300, "経営管理部");
		
		return map.get(departmentId);
		
	}
	
	// グループを取得するメソッド
	public String selectGroup(int groupId) {
		
		Map<Integer, String> map = new HashMap<>();
		
		map.put(0, "／");
		map.put(1, "第1グループ");
		map.put(2, "第2グループ");
		map.put(3, "第3グループ");
		map.put(4, "第4グループ");
		
		return map.get(groupId);
	}
	
	//お知らせカテゴリを取得するメソッド
	public String selectAnnounceCategory(int categoryId) {
		
		Map<Integer, String> map = new HashMap<>();
		
		map.put(1, "お知らせ");
		map.put(2, "チーム活動");
		map.put(3, "ナレッジベース");
		map.put(4, "その他");
		
		return map.get(categoryId);
	}
	
	

}
