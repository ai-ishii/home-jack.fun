/*
 * プログラム名：Home-Jack.ver.2.0
 * 作成者：占部虎司郎
 * 作成日：2025/7/29
 * 更新日：2025/7/30
 */


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
			URL = `${CONTEXT_PATH}/userList?part=${partNumber}&group=${groupNumber}&cmd=search`;
		
		//数字が一つしか見つからなかった場合の処理
		}else if(numbers && numbers.length === 1) {
			const employeeNumber = numbers[0];
			URL = `${CONTEXT_PATH}/userList?employeeNum=${employeeNumber}&cmd=search`;
		
		//数字が見つからない(テキストのみ)の場合の処理
		}else{
			const text = inputText.trim();
			URL =  `${CONTEXT_PATH}/userList?text=${text}&cmd=search`;
		}

		//決められたURLに遷移する
 		 if (URL) { 
 		window.location.href = URL;
 		 }
 		 return false; 
	});
});