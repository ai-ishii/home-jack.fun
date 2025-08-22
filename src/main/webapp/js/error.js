document.addEventListener('DOMContentLoaded', () => {
	
	//エラーチェックを行いたいフォーム要素をすべて取得
	const errorForm = document.querySelector('.error-form');
	//form要素の存在チェック
	if (errorForm) {
		
		const errorClassName = 'error';		//エラー文用のクラス
		const errorBack = 'error-back';		//エラー箇所の表示用クラス
		
		const fileLimit = 1024 * 1024 * 3;	//最大ファイルサイズ指定
		const telDigit = [10, 11];			//電話番号の桁数
		
		let errorFlag = false;				//エラー状態管理用フラグ
		

		//画像の拡張子チェック用
		function fileNameCheck(fileName) {
			//該当する場合trueを返す
			const fileCheck = /\.(jpe?g|png|gif)$/i;
			return fileCheck.test(fileName);
		}
		
		const convertClass = "convert-full-to-half";	//半角変換を行いたいフォームにつけるクラス
		const defaultClass = "error-check-default";		//空文字・空白チェックを行いたいフォームにつけるクラス
		const numberClass = "error-check-number";		//空文字・空白チェック、数値チェックを行いたいフォームにつけるクラス
		const selectClass = "error-check-select";		//セレクトボックスのチェックを行いたいフォームにつけるクラス
		const dateClass = "error-check-date";			//日付チェックを行いたいフォームにつけるクラス
		const telClass = "error-check-tel";				//電話番号チェックを行いたいフォームにつけるクラス
		const digitClass = "error-check-digit";			//桁数・文字数チェックを行いたいフォームにつけるクラス
		const fileClass = "error-check-file";			//ファイルチェックを行いたいフォームにつけるクラス
		
		
		//半角変換を行いたいフォーム要素(クラス名:convert-full-to-half)をすべて取得(ほかのクラスと重複OK)
		const convert = document.querySelectorAll('.' + convertClass);
		
		//空文字・空白チェックを行いたいフォーム要素(クラス名:error-check-default)をすべて取得
		const errorDefaults = document.querySelectorAll('.' + defaultClass);
		//空文字・空白チェック、数値チェックを行いたいフォーム要素(クラス名:error-check-number)をすべて取得
		const errorNumbers = document.querySelectorAll('.' + numberClass);
		//セレクトボックスチェックを行いたいフォーム要素(クラス名:error-check-select)をすべて取得
		const errorSelects = document.querySelectorAll('.' + selectClass);
		//空文字チェック、日付チェックを行いたいフォーム要素(クラス名:error-check-date)をすべて取得
		const errorDates = document.querySelectorAll('.' + dateClass);
		//電話番号チェックを行いたいフォーム要素(クラス名:error-check-tel)をすべて取得
		const errorTel = document.querySelectorAll('.' + telClass);
		
		//桁数・文字数チェックを行いたいフォーム要素(クラス名:error-check-digit)をすべて取得(ほかのクラスと重複OK)
		const errorDigits = document.querySelectorAll('.' + digitClass);
		
		
		//error-fileクラスの要素の集まり(画像入力用)
		const errorFiles = document.querySelectorAll('.' + fileClass);
		
		
		//数字のみ
		//桁数文字数チェック
		//セレクトボックスの必須選択
		//
		
		//エラーメッセージを表示する関数
		//elem:要素
		//errorMessage:エラーメッセージ
		const createError = (elem, errorMessage) => {
			
			//div要素の生成
			const errorDiv = document.createElement('div');
			//エラー用のクラス追加
			errorDiv.classList.add(errorClassName);
			//引数のエラーメッセージを設定
			errorDiv.textContent = errorMessage;
			//elemの親要素の子要素として追加
			elem.parentNode.appendChild(errorDiv);
		}
		
		//エラーメッセージを削除する関数
		const removeError = (elem) => {			
			//古いエラーメッセージの削除
			//elemの親要素を取得
			const parent = elem.parentNode;
			//エラー文があるかどうかのチェック
			const oldError = parent.querySelector('.' + errorClassName); 
			//エラー文がある場合削除
			if (oldError) {
				elem.classList.remove(errorBack);
				oldError.remove();
			}
		}
		
		//半角変換
		const checkConvert = (elem) => {
			//空の場合は何もしない
			if (!elem.value) {
				return;
			}
			//値の変換
			elem.value = elem.value.normalize('NFKC');
		}
		
		//空文字チェック 空白チェック
		const checkSpace = (elem, cmd) => {
			//対象が空の場合
			if(!elem.value) {
				//エラー用のクラス追加
				elem.classList.add(errorBack);
				//class名がerror-check-defaultのとき
				if (cmd == defaultClass) {
					createError(elem, '文字を入力してください。');
				}
				//class名がerror-check-numberのとき
				if (cmd == numberClass) {
					createError(elem, '数字を入力してください。');
				}
				if (cmd == selectClass) {
					createError(elem, '選択必須項目です。');
				}
				if (cmd == dateClass) {
					createError(elem, '日付を入力してください。');
				}
				//エラーのフラグを変更
				return true;
			} else {
				//値の前後の空白文字を削除
				const elemValue = elem.value.trim();
				//値が空の場合にエラー表示する
				if (elemValue.length === 0) {
					elem.classList.add(errorBack);
					createError(elem, 'スペース（空白）のみでの入力はできません。');
					return true;
				}
			}
			return false;
		}
		
		//数値チェック
		const checkNum = (elem) => {
			//数値以外が入力されている場合
			if (isNaN(elem.value)) {
				//エラー用のクラス追加
				elem.classList.add(errorBack);
				createError(elem, '文字が入力されています。数字のみを入力してください。');
				return true;
			}
			return false;
		}
		
		//日付チェック
		const checkDate = (elem) => {
			const today = new Date();			//現在日時
			const input = new Date(elem.value);	//入力日時
			today.setSeconds(0);		//現在日時の秒をリセット
			today.setMilliseconds(0);	//現在日時のミリ秒をリセット
			const yyyy = today.getFullYear();					//現在日時の年を取得
			const MM = ("0"+(today.getMonth()+1)).slice(-2);	//現在日時の月を取得
			const dd = ("0"+today.getDate()).slice(-2);			//現在日時の日を取得
			const HH = ("0"+today.getHours()).slice(-2);		//現在日時の時を取得
			const mm = ("0"+today.getMinutes()).slice(-2);		//現在日時の分を取得
			const todayStr = (yyyy + '-' + MM + '-' + dd + 'T' + HH + ':' + mm);	//現在時刻を文字列に
			
			//現在時刻より前の日時が入力された場合
			if (today > input) {
				elem.value = todayStr;	//現在時刻に更新
				createError(elem, '過去の日付は入力できないため、現在日時で置き換えました。');
			}
			return false;
		}
		
		//文字数チェック
		const checkDigit = (elem, cmd, digit) => {
			//最大文字数チェックの場合
			if (cmd == 'max'){
				//文字数が最大文字数を超えていた場合
				if(elem.value.trim().length > digit) {
					//エラー用のクラス追加
					elem.classList.add(errorBack);
					createError(elem, '最大文字数は' + digit + '文字です。');
					return true;
				}
			}
			//指定文字数チェックの場合
			if (cmd == 'exact') {
				//文字数が指定文字数でない場合
				if(elem.value.trim().length != digit) {
					//エラー用のクラス追加
					elem.classList.add(errorBack);
					createError(elem, digit + '文字で入力してください。');
					return true;
				}
			}
			return false;
		}
		
		
		
		//convert-full-to-halfクラスのリアルタイム変換
		convert.forEach((elem) => {
			elem.addEventListener('blur', () => {
				checkConvert(elem);
			});
		});
		
		//error-check-defaultクラスのリアルタイム入力チェック
		errorDefaults.forEach((elem) => {
			//フォームからフォーカスが外れたタイミングを指定
			elem.addEventListener ('blur', () => {
				//エラー文の初期化
				removeError(elem);
				//空文字チェック 空白チェック
				checkSpace(elem, defaultClass);
			});
		});
		
		//error-check-numberクラスのリアルタイム入力チェック
		errorNumbers.forEach((elem) => {
			//フォームからフォーカスが外れたタイミングを指定
			elem.addEventListener ('blur', () => {
				//エラー文の初期化
				removeError(elem);
				//空文字チェック 空白チェック
				checkSpace(elem, numberClass);
				//数値チェック
				checkNum(elem);
			});
		});
		
		//error-check-selectクラスのリアルタイム入力チェック
		errorSelects.forEach((elem) => {
			//フォームからフォーカスが外れたタイミングを指定
			elem.addEventListener ('blur', () => {
				//エラー文の初期化
				removeError(elem);
				//空文字チェック 空白チェック
				checkSpace(elem, selectClass);
			});
		});
		
		//error-check-dateクラスのリアルタイム入力チェック
		errorDates.forEach((elem) => {
			elem.addEventListener('blur', () => {
				//エラー文の初期化
				removeError(elem);
				//空文字チェック 空白チェック
				checkSpace(elem, dateClass);
				//日付チェック
				checkDate(elem);
				
			});
		});
		
		//error-check-telクラスのリアルタイム入力チェック
		errorTel.forEach((elem) => {
			elem.addEventListener('blur', () => {
				let cmd = 'exact'
				let flag = true;
				let message = "";
				//エラー文の初期化
				removeError(elem);
				//半角変換
				checkConvert(elem);
				//空文字チェック 空白チェック
				checkSpace(elem, numberClass);
				//数値チェック
				checkNum(elem);
				//エラー文がついていない場合のみチェックを行う
				if (elem.parentNode.querySelector('.' + errorClassName) == null) {
					telDigit.forEach((digit) => {
						//桁数チェック
						if(flag = checkDigit(elem, cmd, digit)){
							removeError(elem);
						} else {
							flag = false;
						}
						message ='' + digit + '文字, ';
					});
					
					if (flag) {
						elem.classList.add(errorBack);
						createError(elem, message + 'で入力してください。');
						
					}
				}
			});
		});
		
		//error-check-digitクラスのリアルタイム入力チェック
		errorDigits.forEach((elem) => {
			//最大文字数、指定文字数の取得(取得できない場合は0を代入)
			const maxLength = parseInt(elem.dataset.maxlength) || 0;
			const exactDigit = parseInt(elem.dataset.exactlength) || 0;
			
			let digit;	//文字数用
			let cmd;	//最大or指定判定用
			
			//maxlengthが取得されている場合
			if (maxLength > exactDigit) {
				digit = maxLength;	//最大文字数を格納
				cmd = 'max';
				
			//exactlengthが取得されている場合
			} else {
				digit = exactDigit;	//指定文字数を格納
				cmd = 'exact';
			}
			//フォームからフォーカスが外れたタイミングを指定
			elem.addEventListener ('blur', () => {
				
				//エラー文がついていない場合のみチェックを行う
				if (elem.parentNode.querySelector('.' + errorClassName) == null) {
					checkDigit(elem, cmd, digit);
				}
			});
		});
		
		
		//送信時チェック
		errorForm.addEventListener('submit', (event) => {
			//エラー状態の初期化
			errorFlag = false;
			
			//convert-full-to-halfクラスの半角変換
			convert.forEach((elem) => {
				checkConvert(elem);
			});
			
			//error-check-defaultクラスの入力チェック
			errorDefaults.forEach ((elem) => {
				//エラー文の初期化
				removeError(elem);
				if (checkSpace(elem, defaultClass)) {
					errorFlag = true;
				}
				elem.value = elem.value.trim();
			});
			
			//error-check-numberクラスの入力チェック
			errorNumbers.forEach ((elem) => {
				//エラー文の初期化
				removeError(elem);
				if (checkSpace(elem, numberClass)) {
					errorFlag = true;
				}
				if (checkNum(elem, numberClass)) {
					errorFlag = true;
				}
				elem.value = elem.value.trim();
			});
			
			//error-check-selectクラスの入力チェック
			errorSelects.forEach ((elem) =>{
				//エラー文の初期化
				removeError(elem);
				if (checkSpace(elem, selectClass)) {
					errorFlag = true;
				}
			});
			
			//error-check-dateクラスの入力チェック
			errorDates.forEach ((elem) => {
				//エラー文の初期化
				removeError(elem);
				if (checkSpace(elem, dateClass)) {
					errorFlag = true;
				}
				if (checkDate(elem)) {
					errorFlag = true;
				}
			});
			
			//error-check-digitクラスの入力チェック
			errorDigits.forEach((elem) => {
				
				const maxLength = parseInt(elem.dataset.maxlength) || 0;
				const equalDigit = parseInt(elem.dataset.exactlength) || 0;
				let digit;
				let cmd;
				if (maxLength > equalDigit) {
					digit = maxLength;
					cmd = 'max';
				} else {
					digit = equalDigit;
					cmd = 'exact';
				}
				if (elem.parentNode.querySelector('.' + errorClassName) == null) {
					if (checkDigit(elem, cmd, digit)){
						errorFlag = true;
					}
				}
				elem.value = elem.value.trim();
			});
			
			if (errorFlag) {
				//フォームの送信を中止
				event.preventDefault();
			}
		});

	}
	
/*	
	//空白チェック→半角変換を行う関数の準備
	const convert = function(event) {
		//フォーム要素を取得
		const input = event.target;

		//中身がない場合は終了
		if(!input.value) {
			return;
		}

		//半角に変換する
		const convertedValue = input.value.normalize('NFKC');

		//変換後の値を戻す
		input.value = convertedValue;
	}

	//取得したフォーム要素にイベントリスナーを設定
	elements.forEach(function(elem) {
		//フォーカスが外れたタイミングでconvert(半角変換)を行う
		elem.addEventListener ('blur', convert);
	});







		//form要素のsubmitイベントを使った送信時の処理
		errorForm.addEventListener('submit', (e) => {
			//エラー表示の初期化
			const errorElems = errorForm.querySelectorAll('.' + errorClassName);
			errorElems.forEach((elem) => {
				elem.remove();
			});

			//エラーの有無を管理するフラグ(有:true,無:false)
			let errorFlag = false;

			//.requiredの要素を検証
			required.forEach((elem) => {
				elem.classList.remove("error-back");
				//未入力の場合にエラー表示する
				if (elem.value.length === 0) {
					elem.classList.add("error-back");
					createError(elem, '文字を入力してください。');
					//エラーのフラグを変更
					errorFlag = true;
				} else {
					//値の前後の空白文字を削除
					const elemValue = elem.value.trim();
					//値が空の場合にエラー表示する
					if (elemValue.length === 0) {
						elem.classList.add("error-back");
						createError(elem, 'スペース（空白）のみでの入力はできません。');
						errorFlag = true;
					}
				}
			});

			//.numRequiredの要素を検証
			numRequired.forEach((elem) => {
				elem.classList.remove("error-back");
				//未入力の場合にエラー表示する
				if (elem.value.length === 0) {
					elem.classList.add("error-back");
					createError(elem, '数字を入力してください。');
					//エラーのフラグを変更
					errorFlag = true;
					//値が空の場合にエラー表示する
				} else if (elem.value.trim().length === 0) {
					elem.classList.add("error-back");
					createError(elem, 'スペース（空白）のみでの入力はできません。');
					errorFlag = true;
					//文字が入っていた場合にエラー表示する
				} else if (isNaN(elem.value)) {
					elem.classList.add("error-back");
					createError(elem, '文字が入力されています。数字のみを入力してください。');
					//エラーのフラグを変更
					errorFlag = true;
				} else {
					//.errorEmployeeの要素を検証
					errorEmployee.forEach((elem) => {
						//値の前後の空白文字を削除
						const elemValue = elem.value.trim();
						//社員番号の桁数(6)以外の場合
						if (elemValue.length !== employeeDigit && elemValue.length !== 11) {
							elem.classList.add("error-back");
							createError(elem, '社員番号は6桁で入力してください。');
							//エラーのフラグを変更
							errorFlag = true;
						}
					});
				}
			});

			//.errorSelectの要素の検証
			errorSelect.forEach((elem) => {
				elem.classList.remove("error-back");
				//値が空かつ要素がSELECTの場合にエラー表示する
				if (elem.value.length === 0 && elem.tagName === 'SELECT') {
					elem.classList.add("error-back");
					createError(elem, '選択必須項目です。');
					errorFlag = true;
				}
			});

			//.errorDateの要素の検証
			errorDate.forEach((elem) => {
				elem.classList.remove("error-back");
				//値が空文字の場合にエラー表示する
				if (elem.value.trim() === '') {
					elem.classList.add("error-back");
					createError(elem, '日付を入力してください。');
					errorFlag = true;
				}
			});

			//.errorFileの要素の検証
			errorFile.forEach((elem) => {
				const files = elem.files;
				for (const file of files) {
					//ファイルサイズがfileLimitより大きければエラー表示
					if (file.size > fileLimit) {
						elem.classList.add("error-button");
						createError(elem, 'ファイルサイズが3MBを超えています。');
						errorFlag = true;
					}
				}

				//値の前後の空白文字を削除
				const elemValue = elem.value.trim();
				//拡張子をチェックするメソッド
				const filename = fileNameCheck(elemValue);
				//falseの場合、エラー表示
				if (!filename) {
					elem.classList.add("error-button");
					createError(elem, '指定の画像ファイルを選択してください。');
					errorFlag = true;
				}
			});

			//エラーフラグがtrueのとき
			if (errorFlag) {
				//フォームの送信を中止
				e.preventDefault();
			}
		});
	}*/
});