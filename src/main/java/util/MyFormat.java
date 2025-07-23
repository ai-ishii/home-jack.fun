/*
 * 表示形式を変換するクラス
 * 作成者 : 占部虎司郎
 * 作成日 : 2025/7/9
 */

package util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class MyFormat {
	/**
	 * 引数のTimestampをyyyy年\r\nMM月dd日の形式に変換するメソッド
	 * @param Timestamp
	 * @return 変換された日付データ
	 */
	public String breakDateFormat(Timestamp timestamp) {
		//TimestampをDate型に変換する
		Date condate = new Date(timestamp.getTime());

		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年\r\nMM月dd日");

		//フォーマット使用
		String date = dateFormat.format(condate);

		return date;
	}

	/**
	 * 引数のTimestampをyyyy年 MM月 dd日の形式に変換するメソッド
	 * @param Timestamp
	 * @return 変換された日付データ
	 */
	public String dateFormat(Timestamp timestamp) {
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
	public String monthDayFormat(Timestamp timestamp) {
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
	public String yearFormat(Timestamp timestamp) {
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
	public String datetimeFormat(Timestamp timestamp) {
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
	public String yearMonthFormat(Timestamp timestamp) {
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
	public String breakDateFormat(Date birthday) {

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
	public String dateFormat(Date birthday) {

		//SimpleDateFormatをオブジェクト化し、フォーマット指定
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年 MM月 dd日");

		//フォーマット使用
		String date = dateFormat.format(birthday);

		return date;
	}

	/**
	 * 引数の郵便番号を000-0000の形式に変換するメソッド
	 * @param 郵便番号
	 * @return 変換された郵便番号
	 */
	public String addHyphen(String postalCode) {
		if (postalCode.length() == 7) {
			return postalCode.substring(0, 3) + '-' + postalCode.substring(3, 7);
		} else {
			return postalCode;
		}
	}
	
	/**
	 * 引数のdateをyyyy-MM-ddの形式に変換するメソッド
	 * @param String
	 * @return 変換された日付データ
	 */
	public String forRegisterDate(String date) {

		//DateTimeFormatterをオブジェクト化し、フォーマット指定
		DateTimeFormatter inputFormatter= DateTimeFormatter.ofPattern("yyyy年MM月dd日");
		DateTimeFormatter outputFormatter= DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		//入力文字列をlocalDate型に変換
		LocalDate localDate = LocalDate.parse(date, inputFormatter);
		
		//目的の文字列に変換
		String formatDate= localDate.format(outputFormatter);

		return formatDate;
	}
}
