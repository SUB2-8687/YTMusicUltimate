#!/bin/sh
# 패키징(staging) 폴더 안에서 en.lproj, ko.lproj 를 제외한 나머지 언어팩(*.lproj)을 삭제합니다.
# (Base.lproj 는 xib/storyboard 가 들어 있을 수 있어 안전을 위해 유지합니다.)
#
# 사용법: sh prune_localizations.sh <폴더>

set -e

TARGET="$1"

if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
    echo "prune_localizations: 폴더를 찾을 수 없습니다: $TARGET" >&2
    exit 1
fi


count=$(find "$TARGET" -type d -name '*.lproj' ! -name en.lproj ! -name ko.lproj ! -name Base.lproj | wc -l | tr -d ' ')

if [ "$count" -gt 0 ]; then
    find "$TARGET" -type d -name '*.lproj' ! -name en.lproj ! -name ko.lproj ! -name Base.lproj -prune -exec rm -rf {} +
fi

echo "prune_localizations: 언어팩 ${count}개 삭제 (유지: en, ko, Base)"
