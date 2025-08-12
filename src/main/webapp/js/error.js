document.addEventListener('DOMContentLoaded',() => {
	
	//.errorFormの要素を取得
	const errorForm = document.querySelector('.errorForm');
	//form要素の存在チェック
	if(errorForm){
		const errorClassName = 'error';

		//requiredクラスの要素の集まり
		const required =document.querySelectorAll('.required');
	
			//エラーメッセージを表示する
			//elem:要素
			//errorMessage:エラーメッセージ
			const createError = (elem, errorMessage) =>{
				//span要素の生成
				const errorSpan = document.createElement('span');
				errorSpan.classList.add(errorClassName);
				errorSpan.textContent = errorMessage;
				elem.parentNode.appendChild(errorSpan);
			}
			
			errorForm.addEventListener('submit',(e) => {
				const errorElems = errorForm.querySelectorAll('.' + errorClassName);
				errorElems.forEach( (elem)=>{
					elem.remove();
				});

				required.forEach( (elem) => {
					//値が空の場合はエラー表示する
					if(elem.value.length === 0){
						createError(elem,'入力してください。');
						e.preventDefault();
					}else{
						//値の前後の空白文字を削除
					const elemValue = elem.value.trim();
					//値が空の場合はエラー表示する
					if(elemValue.length === 0){
						createError(elem,'入力形式が間違っています。');
						e.preventDefault();
					}
					
					}

				});
			});
	}
});