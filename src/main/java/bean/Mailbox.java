package bean;

import java.sql.Timestamp;

public class Mailbox {
	private int contactId;				//お問い合わせID
	private int adminId;				//管理者ID
	private int senderId;				//送信者ID
	private String text;				//内容
	private String title;				//件名
	private String category;			//カテゴリ
	private String registDate;			//登録日時
	private Timestamp unreadFlag;		//未読フラグ


	
}