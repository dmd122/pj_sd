#!/bin/bash

# ==========================================
# 1. 환경 설정 및 초기화
# ==========================================
DIARY_DIR="$HOME/.my_diary"

# 디렉터리가 없으면 생성하고 Git을 초기화합니다.
if [ ! -d "$DIARY_DIR" ]; then
    mkdir -p "$DIARY_DIR"
    cd "$DIARY_DIR"
    git init > /dev/null
    echo "📂 초기 설정 완료: $DIARY_DIR"
fi

# ==========================================
# 2. 기능 함수 정의
# ==========================================

# [기능: GitHub 설정] - 토큰 및 주소 등록
setup_github() {
    echo "⚙️  --- GitHub 환경 설정 ---"
    echo "GitHub 연동을 위해 'Personal Access Token'과 '저장소 주소'가 필요합니다."
    echo ""

    # 1. 토큰 입력
    echo -n "🔑 GitHub Personal Access Token 입력: "
    read -s token
    echo ""
    
    if [ -z "$token" ]; then
        echo "❌ 토큰이 입력되지 않았습니다. 설정을 취소합니다."
        return
    fi

    # 2. 주소 입력
    echo -n "🌐 GitHub 저장소 주소 입력 (https://github.com/...): "
    read repo_url

    if [ -z "$repo_url" ]; then
        echo "❌ 주소가 입력되지 않았습니다. 설정을 취소합니다."
        return
    fi

    # 3. 인증 URL 생성
    auth_url="${repo_url/https:\/\//https:\/\/$token@}"

    cd "$DIARY_DIR"

    # 기존 연결 재설정
    if git remote | grep "origin" > /dev/null; then
        git remote remove origin
    fi

    git remote add origin "$auth_url"
    git branch -M main > /dev/null 2>&1

    echo ""
    echo "✅ 설정이 완료되었습니다."
}

# [기능: 백업 및 업로드 (Push)]
perform_backup() {
    
}

# [기능: 동기화 (Pull)]
synchronize_diary() {
    
}

# [기능: 일기 작성]
write_diary() {
    
}

# [기능: 일기 조회]
read_diary() {
    
}

# [기능: 일기 수정]
modify_diary() {
    
}

# [기능: 일기 삭제]
delete_diary() {
    
}

# ==========================================
# 3. 메인 실행 루프
# ==========================================
while true; do
    echo ""
    echo "=============================="
    echo "   🐧 BASH SECRET DIARY"
    echo "=============================="
    echo "0. ⚙️  GitHub 설정"
    echo "1. 작성 (Write)"
    echo "2. 조회 (Read)"
    echo "3. 수정 (Modify)"
    echo "4. 삭제 (Delete)"
    echo "5. 백업 (Push)"
    echo "6. 동기화 (Pull)"
    echo "7. 종료 (Exit)"
    echo -n "선택 >> "
    read choice

    case $choice in
        0) setup_github ;;
        1) write_diary ;;
        2) read_diary ;;
        3) modify_diary ;;
        4) delete_diary ;;
        5) perform_backup ;;
        6) synchronize_diary ;;
        7) echo "프로그램을 종료합니다."; break ;;
        *) echo "잘못된 입력입니다." ;;
    esac
done