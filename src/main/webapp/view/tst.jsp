<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<meta charset="UTF-8">
<style>
.tab-4 {
    display: flex;
    flex-wrap: wrap;
    max-width: 500px;
}

.tab-4 > label {
    flex: 1 1;
    order: -1;
    min-width: 70px;
    padding: .7em 1em .5em;
    background-color: #f2f2f2;
    color: #999;
    font-weight: 600;
    font-size: .9em;
    text-align: center;
    cursor: pointer;
}

.tab-4 > label:hover {
    opacity: .8;
}

.tab-4 input {
    display: none;
}

.tab-4 > div {
    display: none;
    width: 100%;
    padding: 1.5em 1em;
    background-color: #fff;
}

.tab-4 label:has(:checked) {
    border-bottom: 4px solid #ffdd00;
    color: #ffdd00;
}

.tab-4 label:has(:checked) + div {
    display: block;
 }
.square_btn {
  display: block;
  position: relative;
  width: 30px;
  height: 30px;
  border: 2px solid #333; /* 枠の調整 */
  background: #fff; /* ボタンの背景色 */
}

.square_btn::before, .square_btn::after {
  content: "";
  position: absolute;
  top: 50%;
  left: 50%;
  width: 3px; /* 棒の幅（太さ） */
  height: 27px; /* 棒の高さ */
  background: #333; /* バツ印の色 */
}

.square_btn::before {
  transform: translate(-50%,-50%) rotate(45deg);
}

.square_btn::after {
  transform: translate(-50%,-50%) rotate(-45deg);
}

.switch_content {
  width: 400px; /* 全体の幅 */
  border: 1px solid #333; /* 全体を囲む枠線 */
}

#switch {
  display: none; /* チェックボックスを除去 */
}

.button {
  display: block;
  position: relative;
  padding: 10px 20px;
}

.icon { /* アイコン全体のスタイル */
  display: inline-block;
  position: absolute;
  top: 50%;
  transform: translateY(-52%);
  width: 22px;
  height: 22px;
  border: 2px solid #333;
  border-radius: 50%;
}

.icon::before, .icon::after{ /* 「×」印のスタイル */
  content: "";
  position: absolute;
  top: 50%;
  left: 50%;
  width: 2px; /* 棒の幅（太さ） */
  height: 15px; /* 棒の高さ */
  background: #333; /* 棒の色 */
  transform: translate(-50%,-50%) rotate(90deg); /* デフォルトは「-」印に */
  transition: 0.5s all; /* クリック時のアニメーション設定 */
}

.open,.close {
  margin-left: 27px;
}

.open { /* 表示ボタンのスタイル */
  display: inline-block; /* デフォルトは表示 */
}

.close { /* 閉じるボタンのスタイル */
  display: none; /* デフォルトは非表示 */
}

.contents { /* コンテンツのスタイル */
  display: none; /* デフォルトは非表示 */
  padding: 0 20px 15px;
}

 /* 以降、チェック時（クリック後）のスタイル */

#switch:checked + .button > .icon::before{
  transform: translate(-50%,-50%) rotate(45deg);
}

#switch:checked + .button > .icon::after{
  transform: translate(-50%,-50%) rotate(-45deg);
}

#switch:checked + .button > .open{
  display: none; /* 表示ボタンを非表示 */
}

#switch:checked + .button > .close{
  display: inline-block; /* 閉じるボタンを表示 */
}

#switch:checked ~ .contents {
  display: block; /* コンテンツを表示 */
}

</style>
<div class="tab-4">
    <label>
        <input type="radio" name="tab-4" >
        タブ1
    </label>
    <div>
        アクティブになると下線が付くタブです。アクティブ時の文字色と下線の色は揃えるのがおすすめです。
    </div>

    <label>
        <input type="radio" name="tab-4">
        タブ2
    </label>
    <div>ぜひお好みの色にアレンジしてみてください。</div>

    <label>
        <input type="radio" name="tab-4">
        タブ3
    </label>
    <div>もちろんレスポンシブ対応で、タブの追加にも対応しています。</div>
    
    <label>
        <input type="radio" name="tab-4">
        タブ4
    </label>
    <div>わあああああああああああああ。</div>

    
</div>

<div class="switch_content">
  <input id="switch" type="checkbox">
  <label class="button" for="switch">
    <span class="icon"></span>
    <span class="open">表示する</span>
    <span class="close">閉じる</span>
  </label>
  <div class="contents">
    <p>このコンテンツを表示する時だけ、閉じるボタンに切り替わるよ</p>
  </div>
</div>	
</html>
