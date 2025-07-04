package bean;

public class Favorite {

	
	private int favorite_id;		//お気に入りID
	private int user_id;			//ユーザー情報ID
	private int announce_id;		//お知らせID
	private int favorite_flag;		//お気に入りフラグ
	
	
	

		public int getFavorite_id() {
			return favorite_id;
		}
		

		public void setFavorite_id(int favorite_id) {
			this.favorite_id = favorite_id;
		}


		public int getUser_id() {
			return user_id;
		}


		public void setUser_id(int user_id) {
			this.user_id = user_id;
		}


		public int getAnnounce_id() {
			return announce_id;
		}


		public void setAnnounce_id(int announce_id) {
			this.announce_id = announce_id;
		}


		public int getFavorite_flag() {
			return favorite_flag;
		}


		public void setFavorite_flag(int favorite_flag) {
			this.favorite_flag = favorite_flag;
		}


		
}


