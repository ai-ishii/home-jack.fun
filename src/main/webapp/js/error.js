document.addEventListener('DOMContentLoaded', () => {

	//.errorFormの要素を取得
	const errorForm = document.querySelector('.error-form');
	//form要素の存在チェック
	if (errorForm) {
		//エラー用のクラス
		const errorClassName = 'error';
		//社員番号の桁数管理用
		const employeeDigit = 6;
		//ファイルサイズ指定
		const fileLimit = 1024 * 1024 * 3;

		//画像の拡張子チェック用
		function fileNameCheck(fileName) {
			//該当する場合trueを返す
			const fileCheck = /\.(jpe?g|png|gif)$/i;
			return fileCheck.test(fileName);
		}

		//requiredクラスの要素の集まり(テキストボックス/エリア用)
		const required = document.querySelectorAll('.required');
		//num-requiredクラスの要素の集まり(数字のみ：テキストボックス用)
		const numRequired = document.querySelectorAll('.num-required');
		//error-employeeクラスの要素の集まり(社員番号の桁数チェック)
		const errorEmployee = document.querySelectorAll('.error-employee');
		//errorSelectクラスの要素の集まり(セレクトボックス用)
		const errorSelect = document.querySelectorAll('.error-select');
		//error-dateクラスの要素の集まり(日付入力用)
		const errorDate = document.querySelectorAll('.error-date');
		//error-fileクラスの要素の集まり(画像入力用)
		const errorFile = document.querySelectorAll('.error-file');

		//エラーメッセージを表示する
		//elem:要素
		//errorMessage:エラーメッセージ
		const createError = (elem, errorMessage) => {
			//span要素の生成
			const errorSpan = document.createElement('div');
			//エラー用のクラス追加
			errorSpan.classList.add(errorClassName);
			//引数のエラーメッセージを設定
			errorSpan.textContent = errorMessage;
			//elemの親要素の子要素として追加
			elem.parentNode.appendChild(errorSpan);
		}

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
	}
});