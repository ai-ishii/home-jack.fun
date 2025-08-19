<%--
機能：資格申請の入力フォーム
 
制作者：桑原岳

最終更新日：2025/08/19
 --%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>資格申請フォーム</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <style>
        .form-wrapper-container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 30px;
            gap: 40px;
        }

        .form-wrapper {
            flex: 1;
            max-width: 800px;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
            position: relative;
        }

        .instruction-box {
            display: none;
            flex: 1;
            max-width: 500px;
            padding: 30px;
            background-color: #fff3e0;
            border-left: 4px solid #ffb74d;
            border-radius: 10px;
        }

        .form-row {
            width: 80%;
            margin: 0 auto 15px;
            display: flex;
            align-items: flex-start;
        }

        .form-label {
            width: 180px;
            padding-right: 20px;
            text-align: center;
            font-weight: bold;
            flex-shrink: 0;
        }

        .form-input input[type="text"], .form-input-date input[type="date"] {
            width: 250px;
            font-size: 18px;
            padding: 5px;
        }

        .form-input-address textarea {
            width: 300px;
            height: 100px;
            resize: none;
        }

        select {
            height: 30px;
        }

        .form-link {
            width: 80%;
            margin: 20px auto 0;
            text-align: right;
        }

        .instruction-box h3 {
            margin-bottom: 15px;
        }

        .required {
            color: #dc3545;
            font-weight: bold;
        }

        .error-field {
            border: 2px solid red !important;
        }

        .form-cautionary-note {
            width: 80%;
            margin: 0 auto 15px;
            padding-left: 200px;
            box-sizing: border-box;
        }

        .form-cautionary-note h4 {
            margin: 0;
            padding-top: 5px;
            font-size: 14px;
            font-weight: normal;
            color: #555;
            line-height: 1.5;
        }

        .button-area form {
            display: inline-block;
            margin: 0 10px;
        }

        .application-button {
            text-align: center;
            padding: 30px;
        }

        .help-container {
            position: absolute;
            top: 25px;
            right: 25px;
            z-index: 10;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        #helpBtn {
            width: 36px;
            height: 36px;
            font-size: 20px;
            border-radius: 50%;
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border: none;
            padding: 0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            display: inline-flex;
            justify-content: center;
            align-items: center;
        }

        #helpBtn:hover {
            background-color: #0056b3;
            transform: scale(1.1);
        }

        #helpBtn.close {
            background-color: #dc3545;
        }

        #helpBtn.close:hover {
            background-color: #c82333;
        }
    </style>
</head>

<body>
    <%-- ★★★ エラー時(userInput)と修正時(sessionScope.userInput)の両方から値を取得 ★★★ --%>
    <c:set var="formValues" value="${not empty userInput ? userInput : sessionScope.userInput}" />

    <div id="wrap">
        <%@ include file="../common/header.jsp"%>
        <div id="main" class="container">
            <div class="form-wrapper-container">
                <div class="form-wrapper">
                    <div class="help-container">
                        <span>手順がわからない方へ</span>
                        <button type="button" id="helpBtn">?</button>
                    </div>
                    <h1 style="text-align: center">-資格申請フォーム-</h1>
                    <form id="sendform" action="<%=request.getContextPath()%>/licenseConfirm" method="post" enctype="multipart/form-data">

                        <c:if test="${not empty errorMessage}">
                            <h2 style="color: red; text-align: center;">${errorMessage}</h2>
                        </c:if>

                        <div class="form-row">
                            <div class="form-label">
                                <label for="name">氏名<span class="required">【必須】</span></label>
                            </div>
                            <div class="form-input">
                                <input type="text" id="name" name="name" class="${errors.name_error ? 'error-field' : ''}" value="${formValues.name}" />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-label">
                                <label for="department">部署名<span class="required">【必須】</span></label>
                            </div>
                            <div class="form-select">
                                <select name="department" id="department" size="1" class="savable-select ${errors.department_error ? 'error-field' : ''}">
                                    <option value="">--部を選択してください--</option>
                                    <%-- ★★★ selected属性を追加して選択状態を復元 ★★★ --%>
                                    <option value="BS0001" ${formValues.department == 'BS0001' ? 'selected' : ''}>BS事業部第1部</option>
                                    <option value="BS0002" ${formValues.department == 'BS0002' ? 'selected' : ''}>BS事業部第2部</option>
                                    <option value="SA0099" ${formValues.department == 'SA0099' ? 'selected' : ''}>営業部</option>
                                    <option value="NX0100" ${formValues.department == 'NX0100' ? 'selected' : ''}>NEXTINOVATION</option>
                                    <option value="MG0101" ${formValues.department == 'MG0101' ? 'selected' : ''}>経営管理部</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-label">
                                <label for="group">グループ名<span class="required">【必須】</span></label>
                            </div>
                            <div class="form-select">
                                <select name="group" id="group" size="1" class="savable-select ${errors.group_error ? 'error-field' : ''}">
                                    <option value="">--グループを選択してください--</option>
                                    <%-- ★★★ selected属性を追加して選択状態を復元 ★★★ --%>
                                    <option value="GR0000" ${formValues.group == 'GR0000' ? 'selected' : ''}></option>
                                    <option value="GR0001" ${formValues.group == 'GR0001' ? 'selected' : ''}>第1グループ</option>
                                    <option value="GR0002" ${formValues.group == 'GR0002' ? 'selected' : ''}>第2グループ</option>
                                    <option value="GR0003" ${formValues.group == 'GR0003' ? 'selected' : ''}>第3グループ</option>
                                    <option value="GR0004" ${formValues.group == 'GR0004' ? 'selected' : ''}>第4グループ</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-label">
                                <label for="license">資格名<span class="required">【必須】</span></label>
                            </div>
                            <div class="form-select">
                                <select name="license" id="license" size="1" class="savable-select ${errors.license_error ? 'error-field' : ''}">
                                    <option value="">--資格を選択してください--</option>
                                    <%-- ★★★ selected属性を追加して選択状態を復元 ★★★ --%>
                                    <option value="AIL001" ${formValues.license == 'AIL001' ? 'selected' : ''}>G検定</option>
                                    <option value="JAV001" ${formValues.license == 'JAV001' ? 'selected' : ''}>Oracle認定Javaプログラマ(Silver)</option>
                                    <option value="JAV002" ${formValues.license == 'JAV002' ? 'selected' : ''}>Oracle認定Javaプログラマ (Gold)</option>
                                    <option value="PYN001" ${formValues.license == 'PYN001' ? 'selected' : ''}>Python3 エンジニア認定基礎試験</option>
                                    <option value="PYN002" ${formValues.license == 'PYN002' ? 'selected' : ''}>Python3 エンジニア認定実践試験</option>
                                    <option value="PYN003" ${formValues.license == 'PYN003' ? 'selected' : ''}>Python3 エンジニア認定データ分析試験</option>
                                    <option value="AWS001" ${formValues.license == 'AWS001' ? 'selected' : ''}>AWS 認定クラウドプラクティショナー</option>
                                    <option value="AWS002" ${formValues.license == 'AWS002' ? 'selected' : ''}>AWS 認定デベロッパー アソシエイト</option>
                                    <option value="IPA001" ${formValues.license == 'IPA001' ? 'selected' : ''}>基本情報技術者試験</option>
                                    <option value="IPA002" ${formValues.license == 'IPA002' ? 'selected' : ''}>応用情報技術者試験</option>
                                    <option value="IPA003" ${formValues.license == 'IPA003' ? 'selected' : ''}>スペシャリスト試験データベース</option>
                                    <option value="IPA004" ${formValues.license == 'IPA004' ? 'selected' : ''}>スペシャリスト試験_ネットワーク</option>
                                    <option value="IPA005" ${formValues.license == 'IPA005' ? 'selected' : ''}>スペシャリスト試験_エンベデッドシステム</option>
                                    <option value="IPA006" ${formValues.license == 'IPA006' ? 'selected' : ''}>プロジェクトマネージャ</option>
                                    <option value="IPA007" ${formValues.license == 'IPA007' ? 'selected' : ''}>システムアーキテクト</option>
                                    <option value="IPA008" ${formValues.license == 'IPA008' ? 'selected' : ''}>ITストラテジスト</option>
                                    <option value="IPA009" ${formValues.license == 'IPA009' ? 'selected' : ''}>ITサービスマネージャ</option>
                                    <option value="IPA010" ${formValues.license == 'IPA010' ? 'selected' : ''}>システム監査技術者</option>
                                    <option value="IPA011" ${formValues.license == 'IPA011' ? 'selected' : ''}>ITパスポート</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-label">
                                <label for="exam-date">受験日<span class="required">【必須】</span></label>
                            </div>
                            <div class="form-input">
                                <input type="date" id="exam-date" name="exam-date" class="${errors['exam-date_error'] ? 'error-field' : ''}" value="${formValues.examDate}" />
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-label">
                                <label for="exam-time">受験回数<span class="required">【必須】</span></label>
                            </div>
                            <div class="form-input">
                                <input type="text" id="exam-time" name="exam-time" class="${errors['exam-time_error'] ? 'error-field' : ''}" value="${formValues.examTime}" />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-label">
                                <label for="receipt">受験料領収書<span class="required">【必須】</span></label>
                            </div>
                            <div class="form-input">
                                <input type="file" name="receipt" class="${errors.receipt_error ? 'error-field' : ''}">
                                <%-- ★★★ アップロード済みファイル名を表示する処理 ★★★ --%>
                                <c:if test="${not empty formValues.receiptPart}">
                                    <br><span style="color:blue;">[${formValues.receiptOriginalFileName}] はアップロード済みです。</span>
                                </c:if>
                            </div>
                        </div>
                        <div class="form-cautionary-note">
                            <h4>※受験料の支給については上長への経費申請も必要となります。</h4>
                        </div>
                        <div class="form-row">
                            <div class="form-label">
                                <label for="passing">合格証<span class="required">【必須】</span></label>
                            </div>
                            <div class="form-input">
                                <input type="file" name="passing" class="${errors.passing_error ? 'error-field' : ''}">
                                <%-- ★★★ アップロード済みファイル名を表示する処理 ★★★ --%>
                                <c:if test="${not empty formValues.passingPart}">
                                    <br><span style="color:blue;">[${formValues.passingOriginalFileName}] はアップロード済みです。</span>
                                </c:if>
                            </div>
                        </div>

                        <div class="application-button">
                            <button type="submit">申請</button>
                        </div>
                    </form>
                </div>
                <div class="instruction-box">
                    <h2>資格変更申請フォーム手順</h2>
					<h3>1. 入力欄をすべて記入します（空欄があると再入力になります）。</h3>
					<h3>2. 入力後、「申請」ボタンを押して内容確認をします。</h3>
					<h3>3. 確認してよければ「この内容で確定する」ボタンを押します。</h3>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://yubinbango.github.io/yubinbango/yubinbango.js" charset="UTF-8"></script>
    <script>
        // このセクションはlocalStorageを使った補助的な入力保持機能なので、変更なし
        function submitForm() {
            document.getElementById("sendform").submit();
        }
    
        document.getElementById("helpBtn").addEventListener(
                "click",
                function() {
                    const instructionBox = document
                            .querySelector(".instruction-box");
                    if (instructionBox.style.display === "none"
                            || instructionBox.style.display === "") {
                        instructionBox.style.display = "block";
                        this.textContent = "×";
                        this.classList.add("close");
                    } else {
                        instructionBox.style.display = "none";
                        this.textContent = "?";
                        this.classList.remove("close");
                    }
                });

        { // スクリプトのスコープを分離
            const savableSelects = document.querySelectorAll('.savable-select');
            const storageKey = 'multipleSelectValues';

            const saveValues = () => {
                const values = {};
                savableSelects.forEach(select => {
                    values[select.id] = select.value;
                });
                localStorage.setItem(storageKey, JSON.stringify(values));
                console.log('保存しました:', values);
            };

            const loadValues = () => {
                const savedData = localStorage.getItem(storageKey);
                if (savedData) {
                    const values = JSON.parse(savedData);
                    savableSelects.forEach(select => {
                        if (select.value === "" && values[select.id]) {
                            select.value = values[select.id];
                        }
                    });
                    console.log('復元しました:', values);
                }
            };
            window.addEventListener('load', loadValues);
            savableSelects.forEach(select => {
                select.addEventListener('change', saveValues);
            });
        }
    </script>
</body>
</html>