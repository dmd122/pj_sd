#!/bin/bash

function install_program() {
    echo " >> [7] 프로그램 설치 (단축 명령어 등록)"
    
    # 현재 실행 중인 메인 스크립트(diary.sh)의 절대 경로를 가져옵니다.
    CURRENT_SCRIPT=$(realpath "$0")
    
    # 등록할 명령어 이름
    CMD_NAME="diary"
    
    # 쉘 설정 파일 감지 (zsh 또는 bash)
    if [[ "$SHELL" == *"zsh"* ]]; then
        RC_FILE="$HOME/.zshrc"
        MY_SHELL="zsh"
    else
        RC_FILE="$HOME/.bashrc"
        MY_SHELL="bash"
    fi
    
    echo "[!] 감지된 쉘: $MY_SHELL ($RC_FILE)"

    # ---------------------------------------------------------
    # [수정됨] 기존 설정이 있어도 지우고 다시 등록 (강제 업데이트)
    # ---------------------------------------------------------
    
    # 1. 기존에 등록된 diary alias가 있다면 설정 파일에서 해당 줄 삭제
    # (sed 명령어를 사용하여 'alias diary='로 시작하는 줄을 찾아서 지웁니다)
    if [ -f "$RC_FILE" ]; then
        sed -i "/alias $CMD_NAME=/d" "$RC_FILE"
    fi

    # 2. 새로운 경로로 다시 등록
    echo "" >> "$RC_FILE"
    echo "# Secret Database Diary Shortcut" >> "$RC_FILE"
    echo "alias $CMD_NAME='\"$CURRENT_SCRIPT\"'" >> "$RC_FILE"
    
    echo "✅ [성공] 명령어 경로가 최신 상태로 업데이트되었습니다."
    echo "   연결된 경로: $CURRENT_SCRIPT"
    
    # ---------------------------------------------------------
    
    print_line
    echo "⚠️ 설정을 즉시 적용하려면 쉘(터미널)을 새로고침 해야 합니다."
    echo "   (주의: 프로그램이 즉시 종료되고 터미널이 리셋됩니다.)"
    echo -n "   지금 적용하시겠습니까? (y/n): "
    read answer

    if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
        echo "[!] 쉘을 다시 로드합니다..."
        exec "$MY_SHELL"
    else
        echo "[!] 적용을 취소했습니다. 나중에 터미널을 껐다 켜거나 'source $RC_FILE'을 입력하세요."
    fi
}