package bean;

import java.sql.Timestamp;

public class Announce {

	private int announceId; 			//お知らせID
	private int userId; 				//ユーザー情報ID
	private String name;				//編集者名
	private Timestamp registDate;		//登録日時
	private Timestamp updateDate;		//更新日時
	private String title; 				//タイトル
	private String text; 				//本文
	private String image; 				//画像
	private String comment; 			//コメント
	private int likeFlag; 				//いいねフラグ
	private int announceFlag; 			//お知らせ表示フラグ
	private int favoriteFlag; 			//お気に入りフラグ
	private int category; 				//カテゴリ
	private String tag; 				//タグ
	private String file; 				//ファイル

	
	
}
