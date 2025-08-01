package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class TodoDAO {

	//接続用の情報をフィールドに定数として定義
		private static final String RDB_DRIVE="org.mariadb.jdbc.Driver";
	 	private static final String URL="jdbc:mariadb://localhost/jackdb";
	 	private static final String USER="root";
	 	private static final String PASSWD="root123";
	 
	 	/**
	 	 * データベース接続を行うメソッド
	 	 * データベース接続用定義を基にデータベースへ接続し、戻り値としてコネクション情報を返す
	 	 * @return con
	 	 */
	 	private static Connection getConnection(){
	 		try{
	 			Class.forName(RDB_DRIVE);
	 			Connection con = DriverManager.getConnection(URL, USER, PASSWD);
	 			return con;
	 		}catch(Exception e){
	 			throw new IllegalStateException(e);
	 		}
	 	}
}
