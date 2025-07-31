<%@page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<!-- タイトル -->
<title>申請フォーム</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/style.css">
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
function handleEnter(event, type) {
	  if (event.key === "Enter") {
	    event.preventDefault();
	    fetchAddress(type);
	  }
	}

	function fetchAddress(type) {
	  // typeが 'old' または 'new' でIDを振り分け
	  const postalId = type === 'old' ? 'postal' : 'postal_new';
	  const addressId = type === 'old' ? 'oldaddress' : 'newaddress';

	  let postal = document.getElementById(postalId).value;

	  if (!postal.match(/^\d{3}-?\d{4}$/)) {
	    alert("郵便番号の形式が不正です（例: 1234567 または 123-4567）");
	    return;
	  }

	  const zipcode = postal.replace(/-/g, "");

	  fetch("https://zipcloud.ibsnet.co.jp/api/search?zipcode=" + zipcode)
	    .then(response => response.json())
	    .then(data => {
	      if (data.results) {
	        const result = data.results[0];
	        const partialAddress = result.address1 + result.address2 + result.address3;
	        const addressInput = document.getElementById(addressId);

	        addressInput.value = partialAddress;
	        addressInput.focus();
	        addressInput.setSelectionRange(partialAddress.length, partialAddress.length);
	      } else {
	        alert("住所が見つかりませんでした");
	      }
	    })
	    .catch(err => {
	      alert("通信エラーが発生しました");
	      console.error(err);
	    });
	}
</script>
</head>
<style>
#main2 {
	position: relative;
	width: 100%;
	margin: 0px;
	flex-direction: row;
	z-index: 10;
}

.addressrequest {
	margin: 0 auto;
}

.name {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.namefield {
	width: 200px;
	height: 30px;
}

.oldpost {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.oldaddress {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.newpost {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.newaddress {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.send {
	padding-top: 40px;
	text-align: center;
}

.oldaddressfield {
	resize: none;
}

.newaddressfield {
	resize: none;
}

<%--ここから下が氏名変更申請--%>
.namerequest {
	margin: 0 auto;
}

.oldname {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.oldnamefield {
	width: 200px;
	height: 30px;
}

.oldnamekana {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.oldnamekanafield {
	width: 200px;
	height: 30px;
}

.newname {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.newnamefield {
	width: 200px;
	height: 30px;
}

.newnamekana {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.newnamekanafield {
	width: 200px;
	height: 30px;
}
<%--ここから下が氏名変更申請--%>
.licenserequest {
	margin: 0 auto;
}

.licensename {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.licensenamefield {
	width: 200px;
	height: 30px;
}

.licenseimage {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.licenseimagefield {
	width: 300px;
	height: 30px;
}

.licensedate {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.licensedatefield {
	width: 200px;
	height: 30px;
}

.licensetime {
	width: 30%;
	text-align: right;
	padding: 20px 20px 20px 20px;
}

.licensetimefield {
	width: 200px;
	height: 30px;
}
</style>

<body>
	<div id="wrap">
		<!-- ヘッダー部分 -->
		<%@ include file="../common/header.jsp"%>

		<!-- メイン部分 -->
		<div id="main2" class="container">
			<table>
				<tr>
					<h2 style="text-align: center">住所変更申請</h2>
				</tr>
			</table>
			<form action="<%=request.getContextPath()%>/requestInsert"
				method="get">
				<table class="addressrequest">
					<tr>
						<td class="name">氏名</td>
						<td><input type="text" name="name" class="namefield"></td>
					</tr>
					<tr>
						<td class="oldpost"><label for="oldpost">旧郵便番号</label></td>
						<td><input type="text" id="postal" name="oldpostfield"
							placeholder="例: 1234-567" onkeydown="handleEnter(event, 'old')">
							<button type="button" onclick="fetchAddress()">住所を自動入力</button></td>
					</tr>
					<tr>
						<td class="oldaddress"><label for="oldaddress">旧住所</label></td>
						<td><textarea id="oldaddress" name="oldaddressfield"
								class="oldaddressfield" rows="10" cols="40"
								placeholder="例: 大阪府大阪市淀川区西中島５丁目１１−３ 新大阪サンアールビル西館"
								style="font-size: 16px;"></textarea></td>
					</tr>
					<tr>
						<td class="newpost"><label for="newpost">新郵便番号</label></td>
						<td><input type="text" id="postal_new" name="newpostfield"
							placeholder="例: 1234-567" onkeydown="handleEnter(event, 'new')">
							<button type="button" onclick="fetchAddress()">住所を自動入力</button></td>
					</tr>
					<tr>
						<td class="newaddress"><label for="newaddress">新住所</label></td>
						<td><textarea id="newaddress" name="newaddressfield"
								class="newaddressfield" rows="10" cols="40"
								placeholder="例: 大阪府大阪市淀川区西中島５丁目１１−３ 新大阪サンアールビル西館"
								style="font-size: 16px;"></textarea></td>
					</tr>
					<tr>
						<td class="send" colspan="2"><input type="submit" value="送信"></td>

					</tr>
				</table>
			</form>
			<table>
				<tr>
					<h2 style="text-align: center">氏名変更申請</h2>
				</tr>
			</table>

			<form action="<%=request.getContextPath()%>/requestInsert"
				method="get">
				<table class="namerequest">
					<tr>
						<td class="oldname">旧氏名</td>
						<td><input type="text" name="oldname" class="oldnamefield"></td>
					</tr>
					<tr>
						<td class="oldnamekana">旧氏名かな</td>
						<td><input type="text" name="oldnamekana"
							class="oldnamekanafield"></td>
					</tr>
					<tr>
						<td class="newname">新氏名</td>
						<td><input type="text" name="newname" class="newnamefield"></td>
					</tr>
					<tr>
						<td class="newnamekana">新氏名かな</td>
						<td><input type="text" name="newnamekana"
							class="newnamekanafield"></td>
					</tr>
					<tr>
						<td class="send" colspan="2"><input type="submit" value="送信"></td>

					</tr>
				</table>
			</form>
			<table>
				<tr>
					<h2 style="text-align: center">資格申請</h2>
				</tr>
			</table>
			<form action="<%=request.getContextPath()%>/requestInsert"
				method="post" enctype="multipart/form-data">
				<table class="licenserequest">
					<tr>
						<td class="name">氏名</td>
						<td><input type="text" name="name" class="namefield"></td>
					</tr>
					<tr>
						<td class="licensename">資格名</td>
						<td><input type="text" name="licensename"
							class="licensenamefield"></td>
					</tr>
					<tr>
						<td class="licenseimage">資格画像</td>
						<td><input type="file" name="licenseimage"
							class="licenseimagefield"></td>
					</tr>
					<tr>
						<td class="licensedate">受験日時</td>
						<td><input type="text" name="licensedate"
							class="licensedatefield"></td>
					</tr>
					<tr>
						<td class="licensetime">受験回数</td>
						<td><input type="text" name="licensetime"
							class="licensetimefield"></td>
					</tr>
					<tr>
						<td class="send" colspan="2"><input type="submit" value="送信"></td>
					</tr>

					</form>

					</div>
					</div>
</body>

</html>