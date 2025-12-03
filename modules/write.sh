#!/bin/bash

function write_diary() {
    print_line
    echo " >> [1] 일기 쓰기 모드"
    
    echo -n " 날짜를 입력하세요 (예: 2024-11-26): "
    read input_date
    
    filename="$DATA_DIR/${input_date}${DIARY_EXT}"

    if [ -f "$filename" ]; then
        echo " [!] 이미 해당 날짜의 일기가 존재합니다. '수정' 기능을 이용해주세요."
        return
    fi

    echo -n " 내용을 입력하세요: "
    read content

    echo ""
    echo -n " [보안] 암호화 비밀번호 설정: "
    read -s password
    echo ""

    echo "$content" | openssl enc -aes-256-cbc -base64 -pbkdf2 -pass pass:"$password" -out "$filename"

    if [ $? -eq 0 ]; then
        echo " [성공] 암호화되어 저장되었습니다: $filename"
    else
        echo " [실패] 저장 중 오류가 발생했습니다."
    fi
}