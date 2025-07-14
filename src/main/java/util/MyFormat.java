/*
 * 表示形式を変換するクラス
 * 作成者 : 占部虎司郎
 * 作成日 : 2025/7/9
 */

package util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MyFormat {
	/**
	 * 引数のTimestampをyyyy年 MM月 dd日の形式に変換するメソッド
	 * @param Timestamp
	 * @return 変換された日付データ
	 */
	public String DateFormat(Timestamp timestamp) {
		//TimestampをDate型に変換する
		Date condate = new Date(timestamp.getTime());
		
		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年 MM月 dd日");
		
		//フォーマット使用
		String date = dateFormat.format(condate);
		
		return date;
	}
	
	/**
	 * 引数のDateをyyyy年 MM月 dd日の形式に変換するメソッド
	 * @param Date
	 * @return 変換された日付データ
	 */
	public String birthDateFormat(Date date) {
		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年M月d日");
		
		//フォーマット使用
		String birthDate = dateFormat.format(date);
		
		return birthDate;
	}
	
	/**
	 * 引数のTimestampをMM/ddの形式に変換するメソッド
	 * @param Timestamp
	 * @return 変換された日付データ
	 */
	public String MonthDayFormat(Timestamp timestamp) {
		//TimestampをDate型に変換する
		Date condate = new Date(timestamp.getTime());
		
		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat dateFormat = new SimpleDateFormat("M/d");
		
		//フォーマット使用
		String date = dateFormat.format(condate);
		
		return date;
	}
	
	/**
	 * 引数のTimestampをyyyyの形式に変換するメソッド
	 * @param Timestamp
	 * @return 変換された日付データ
	 */
	public String YearFormat(Timestamp timestamp) {
		//TimestampをDate型に変換する
		Date condate = new Date(timestamp.getTime());
		
		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
		
		//フォーマット使用
		String date = dateFormat.format(condate);
		
		return date;
	}
	
	/**
	 * 引数のTimeStampをyyyy年 MM月 dd日 HH時mm分ss秒の形式に変換するメソッド
	 * @param Timestamp
	 * @return 変換された日付データ
	 */
	public String DatetimeFormat(Timestamp timestamp) {
		//TimestampをDate型に変換する
		Date condate = new Date(timestamp.getTime());
				
		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy年 MM月 dd日 HH時mm分ss秒");
		
		String date = datetimeFormat.format(condate);
		
		return date;
	}
	
	/**
	 * 引数のTimeStampをyyyy年MM月の形式に変換するメソッド
	 * @param Timestamp
	 * @return 変換された日付データ
	 */
	public String YearMonthFormat(Timestamp timestamp) {
		//TimestampをDate型に変換する
		Date condate = new Date(timestamp.getTime());
		
		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat yearMonthFormat = new SimpleDateFormat("yyyy年MM月");
		
		String date = yearMonthFormat.format(condate);
		
		return date;
	}
	
	/**
	 * 引数のbirthdayをyyyy年\r\nMM月dd日の形式に変換するメソッド
	 * @param Date
	 * @return 変換された日付データ
	 */
	public String birthdayFormat(Date birthday) {
			
		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年\r\nMM月dd日");
		
		//フォーマット使用
		String date = dateFormat.format(birthday);
		
		return date;
	}
	
	
	/**
	 * 引数のbirthdayをyyyy年 MM月 dd日の形式に変換するメソッド
	 * @param Date
	 * @return 変換された日付データ
	 */
	public String birthdayFormat(Date birthday) {
			
		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年 MM月 dd日");
		
		//フォーマット使用
		String date = dateFormat.format(birthday);
		
		return date;
	}
	
}
