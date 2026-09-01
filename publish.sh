#!/bin/sh
# 更新公開名單頁。網址不變：https://goldenfreedom1217.github.io/qulla-pages/
#
# GitHub Pages 的來源是 gh-pages 分支（Settings 那條路對新帳號行不通，
# 靠推 gh-pages 分支自動啟用的），所以兩個分支都要推。
set -e
PY="C:/Users/Water.Hsu/finlab-env/Scripts/python.exe"
cd /c/stock && PYTHONIOENCODING=utf-8 PYTHONUTF8=1 "$PY" build_public.py
cd "$HOME/qulla-pages"
cp /c/stock/public/index.html .
DAY=$(grep -o 'class="stamp">[0-9-]*' index.html | head -1 | cut -d'>' -f2)
git add -A
git diff --cached --quiet && { echo "內容沒變，不用推。"; exit 0; }
git commit -q -m "台股觀察名單 $DAY"
git push -q origin main
git push -q origin main:gh-pages     # Pages 實際讀的是這個分支
echo "已更新 $DAY -> https://goldenfreedom1217.github.io/qulla-pages/"
