document.addEventListener('DOMContentLoaded',() => {
	
	//.errorFormの要素を取得
	const errorForm = document.querySelector('.errorForm');
	//form要素の存在チェック
	if(errorForm){
		//エラー用のクラス
		const errorClassName = 'error';

		//requiredクラスの要素の集まり
		const required = document.querySelectorAll('.required');
		//errorSelectクラスの要素の集まり
		const errorSelect = document.querySelectorAll('.errorSelect');
	
			//エラーメッセージを表示する
			//elem:要素
			//errorMessage:エラーメッセージ
			const createError = (elem, errorMessage) =>{
				//span要素の生成
				const errorSpan = document.createElement('span');
				//エラー用のクラス追加
				errorSpan.classList.add(errorClassName);
				//引数のエラーメッセージを設定
				errorSpan.textContent = errorMessage;
				//elemの親要素の子要素として追加
				elem.parentNode.appendChild(errorSpan);
			}
			
			//form要素のsubmitイベントを使った送信時の処理
			errorForm.addEventListener('submit',(e) => {
				//エラー表示の初期化
				const errorElems = errorForm.querySelectorAll('.' + errorClassName);
				errorElems.forEach( (elem)=>{
					elem.remove();
				});

				//.requiredの要素を検証
				required.forEach( (elem) => {
					elem.classList.remove("error-back");
					//未入力の場合にエラー表示する
					if(elem.value.length === 0){
						elem.classList.add("error-back");
						createError(elem,'入力してください。');
					}else{
					//値の前後の空白文字を削除
					const elemValue = elem.value.trim();
						//値が空の場合にエラー表示する
						if(elemValue.length === 0){
							elem.classList.add("error-back");
							createError(elem,'入力形式が間違っています。');
						}
					}
					//フォームの送信を中止
					e.preventDefault();
				});
				
				//.errorSelectの要素の検証
				errorSelect.forEach( (elem) => {
					if(elem.value.length === 0 && elem.tagName === 'SELECT'){
						createError(elem,'選択してください。');	
					}
					//フォームの送信を中止
					e.preventDefault();
				});
			});
	}
});