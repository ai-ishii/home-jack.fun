/*
 * プログラム名：Home-Jack.ver.2.0
 * 作成者：占部虎司郎
 * 作成日：2025/7/29
 * 更新日：2025/7/30
 */

//テーブルリンクにする処理
document.addEventListener("DOMContentLoaded", function() {
	// .user-link がついてるタグを全部探す
	const linkCells = document.querySelectorAll(`.user-link`);
            
	// クラスが記述されたタグにクリックしたときの処理を追加
	linkCells.forEach(function(cell) {
		cell.addEventListener("click", function(event) {
			//ボタンを押した場合を省く
			if(event.target.closest('.btn')){
				return;
				}

			//対象に設定されたdatasetを取り出す
			const url = cell.dataset.href; 
			
			if (url) {
				//設定したURLに遷移する
				window.location.href = url;
			}
		});
	});

	const btn = document.querySelectorAll(".btn--delete");

	// 削除ボタンをクリックしたときの処理を追加
	btn.forEach(function(button) {
		button.addEventListener("click", function(event) {
			//イベントの伝播を止める処理
			event.stopPropagation();
			//イベントのデフォルトの動作を止める処理
			event.preventDefault();
			const jackDelete = button.dataset.href;

			//アラートと画面遷移
			if(confirm("本当に削除しますか？")){
				alert("削除しました。");
				window.location.href= jackDelete;
			}else{
				alert("キャンセルしました。");
			}
		});
	});
	
});

//検索用数字分割処理
document.addEventListener('DOMContentLoaded', function() {
	const searchInput = document.getElementById('searchInput');
	const searchButton = document.getElementById('searchButton');
	
	//エンターキーを押したときにも対応
	searchInput.addEventListener('keydown', function(event) {
        // 押されたキーがEnterキー (keyCode 13 または event.key === 'Enter') であるかチェック
        if (event.key === 'Enter') {
            // フォームのデフォルト送信をキャンセル
            event.preventDefault(); 
            // searchButton のクリックイベントをプログラム的に発火させる
            searchButton.click(); 
        }
    });

	//検索ボタンがクリックされた時のイベントを追加
	searchButton.addEventListener('click', function() {
		// 検索窓の入力値を取得
		const inputText = searchInput.value; 
		 // 正規表現で文字列から数字をすべて抽出
		const numbers = inputText.match(/\d+/g);
		//画面遷移用のURLを宣言
		let URL; 

		// 数字が2つ以上見つかった場合
		//エラーが起きないようnumbersがnull出ないかの確認をしている
 		if (numbers && numbers.length >= 2) { 
			 // 最初の数字 (部) を整数に変換
			const partNumber = parseInt(numbers[0], 10);  
			// 2番目の数字 (グループ) を整数に変換
			const groupNumber = parseInt(numbers[1], 10); 

			//遷移先の設定
			URL = `${CONTEXT_PATH}/userList?part=${partNumber}&group=${groupNumber}word=${encodeURIComponent(inputText)}&cmd=search`;
		
		//数字が一つしか見つからなかった場合の処理
		}else if(numbers && numbers.length === 1) {
			const employeeNumber = numbers[0];
			URL = `${CONTEXT_PATH}/userList?employeeNum=${employeeNumber}&cmd=search&word=${encodeURIComponent(inputText)}`;
		
		//数字が見つからない(テキストのみ)の場合の処理
		}else{
			const text = inputText.trim();
			URL =  `${CONTEXT_PATH}/userList?text=${encodeURIComponent(text)}&cmd=search&word=${encodeURIComponent(inputText)}`;
		}

		//決められたURLに遷移する
 		 if (URL) { 
 		window.location.href = URL;
 		 }
 		 return false; 
	});
});