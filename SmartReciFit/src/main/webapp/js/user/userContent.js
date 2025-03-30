//function formatPhoneNumber(phoneNumber) {
 // if (!phoneNumber) return ''; // 전화번호가 없는 경우 빈 문자열 반환

  //const parts = phoneNumber.split('-');
 // if (parts.length !== 3) return phoneNumber; // 형식이 맞지 않으면 원래 번호 반환

//  return `${parts[0]}-0***-0***`;
//}

// 예시: userContent.user_phone을 010-0***-0*** 형식으로 변환
//const formattedPhoneNumber = formatPhoneNumber(userContent.user_phone);

// HTML 테이블에 적용
document.querySelector('#phoneNumberCell').textContent = formattedPhoneNumber;


//document.querySelector('#phoneNumberCell').textContent = formattedPhoneNumber;
