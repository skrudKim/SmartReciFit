let isIdValid = 1;//아이디 검사
let isNicknameValid = 1;//닉네임 검사
let isPwValid = 1;//비밀번호 검사
let isNameValid = 1;//이름 인증 검사 0 인증검사 전 -1 인증검사 중 1 인증검사 완료
let isidentityValid = 1;//이메일 인증 검사 0 인증검사 전 -1 인증검사 중 1 인증검사 완료
//나중에 이메일인증검사랑 소셜인증검사랑 분리해야할 것 같으면 소셜검사를 따로 빼야지
let identityCode = null;//인증번호 저장
let emailChickTimeout = null;//2분 카운트 저장

//const form = document.querySelector('form');
const form = document.querySelector('#userFixForm');
const inputs = form.querySelectorAll('input');
const imgPreview = document.querySelector('#imgPreview');



const idInput = document.querySelector('#id-new');
const nicknameInput = document.querySelector('#nickName');
const emailInput = document.querySelector('#email');
const emailOkInput = document.querySelector('#checkEmailOk');

const checkIdButton = document.querySelector('#btn-checkId');
const checkNickNameButton = document.querySelector('#btn-checkNickName');
const checkEmailButton = document.querySelector('#btn-checkEmail');
const checkcheckEmailOkButton = document.querySelector('#btn-checkEmailOk');
const submitButton = document.querySelector('#btn-submit');

checkIdButton.disabled=true;
checkNickNameButton.disabled=true;
checkEmailButton.disabled=true;
checkcheckEmailOkButton.disabled=true;


//처음 나타나는 이미지
/*if(fistImg!=null){
	imgPreview.append(${ctx}/img/fistImg);
}*/
//기존 이미지를 임시에 띄워놓고

//imgChange=0이면 이미지는 기존 값 저장
//imgChange==1이면 이미지는 새로운 값 저장

let imgChange=document.getElementById('originalImgHidden').dataset.originalId;;

const elementImg = document.getElementById('originalImgHidden');
const btnImgDel= document.querySelector('#btn-imgDel');

//let isbtnClick = false;

btnImgDel.addEventListener('click', (event) => {
	console.log("버튼 클릭 전: "+ imgChange);
	elementImg.setAttribute('data-original-id', null);
	elementImg.value=null;
	//imgChange=null;
	//isbtnClick = true;
	console.log("버튼 클릭 후: "+ imgChange);
});

//어떤 이벤트를 명시적으로 처리하지 않은 경우, 해당 이벤트에 대한 사용자 에이전트의 기본 동작을 실행하지 않도록 지정
form.addEventListener('submit', (event) => {
	event.preventDefault();
	//alert("버튼 클릭 제출되는 값: "+elementImg);
	//alert("버튼 클릭 제출되는 값: "+document.getElementById('originalImgHidden').dataset.originalId);
	/*const formData = new FormData(form);
	    formData.append('imgChange', imgChange); // imgChange 값 추가

	    // 서버로 데이터 전송
	    fetch('/userFix.do', { // 컨트롤러 URL
	        method: 'POST',
	        body: formData,
	    })
	    .then(response => {
	        if (!response.ok) {
	            throw new Error('Network response was not ok');
	        }
	        return response.text(); // 또는 response.json()
	    })
	    .then(data => {
	        // 서버 응답 처리
	        console.log(data);
	        // 필요에 따라 페이지 이동 또는 다른 작업 수행
	        document.open();
	        document.write(data);
	        document.close();
	    })
	    .catch(error => {
	        console.error('There has been a problem with your fetch operation:', error);
	    });*/
	
});

submitButton.addEventListener('click', (event) => {
	console.log("아이디 확인 test="+isIdValid);
	console.log("닉네임 확인 test="+isNicknameValid);
	console.log("이름 확인 test="+isNameValid);
	console.log("비밀번호 확인 test="+isPwValid);
	console.log("메일 확인 test="+isidentityValid);
	console.log("모든 입력값 확인 test="+validateAll());

	if (isIdValid !== 1) {
		swal.fire({ //아이디 중복확인
			icon: "error",
			title: "Error!",
			text:"아이디 중복 확인을 해주세요",
			confirmButtonColor: "#F7C525",
		});
	    console.log("아이디 중복 확인="+isIdValid);
	    idInput.focus();
	    return;
	}
	
	if (isNicknameValid !== 1) { // 닉네임 중복 확인을 하지 않았다면 경고창 표시
		swal.fire({
			icon: "error",
			title: "Error!",
			text:"닉네임 중복 확인을 해주세요",
			confirmButtonColor: "#F7C525",
		});
	    console.log("닉네임 중복 확인="+isNicknameValid);
	    nicknameInput.focus();
	    return;
	}
	
	if (isidentityValid !== 1) { // 이메일 인증
		swal.fire({
			icon: "error",
			title: "Error!",
			text:"이메일 인증을 해주세요",
			confirmButtonColor: "#F7C525",
		});
	    console.log("이메일 확인="+isidentityValid);
	    emailInput.focus();
	    return;
	}

	if (!validateAll()) { // 모든 입력값이 유효한지 검사
	    console.log("모든 입력값 확인="+validateAll());
		swal.fire({
			icon: "error",
			title: "Error!",
			text:"입력값을 확인해주세요.",
			confirmButtonColor: "#F7C525",
		});
	    return;
	}else{
		console.log("모든 입력값 확인="+validateAll());
		form.submit();
	}
});

//input업데이트 될때마다 확인하는거
inputs.forEach(input => {
    input.addEventListener('input', () => validateField(input));
});

//아이디 중복검사
checkIdButton.addEventListener('click', async () => {
    const id = idInput.value.trim();
	const originalId = document.getElementById('originalIdHidden').dataset.originalId;
	
	console.log("id="+id);
	console.log("originalId="+originalId);
	console.log("id===originalId="+(id===originalId));

	if(id===originalId){
		swal.fire({
			text:"기존 아이디와 동일합니다",
			confirmButtonColor: "#F7C525"
		});
		isIdValid = 1;//기존아이디랑 동일하니까 패스
		checkIdButton.disabled=true;
		return;
	}
	isIdValid = 0;//기존 아이디와 동일하지 않은 값을 넣었으니까 인증 취소하기

    if (!id) {
		swal.fire({
			icon: "error",
			title: "Error!",
			text:"ID를 입력해주세요",
			confirmButtonColor: "#F7C525",
		});
        idInput.focus();
        idInput.style.border = '2px solid red';
        return;
    }

    try {
        const response = await fetch('checkId.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            },
            body: new URLSearchParams({ id }).toString(),
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const result = await response.text();
        handleIdValidationResult(result);
    } catch (error) {
        console.error('ID validation error:', error);
		swal.fire({
			icon: "error",
			title: "Error!",
			text:"아이디 확인 중 오류가 발생했습니다",
			confirmButtonColor: "#F7C525",
		});
        idInput.style.border = '2px solid orange';
    }
});

//닉네임 중복검사
checkNickNameButton.addEventListener('click', async () => {
    const nickName = nicknameInput.value.trim();
	const originalNickName = document.getElementById('originalNickNameHidden').dataset.originalId;; // 서버에서 전달받은 기존 닉네임

	if(nickName===originalNickName){
		swal.fire({
			text:"기존 닉네임과 동일합니다",
			confirmButtonColor: "#F7C525"
		});
		isNicknameValid = 1;//기존닉네임과 동일하니까 패스
		checkNickNameButton.disabled=true;
		return;
	}
	isNicknameValid = 0;//기존 닉네임과 동일하지 않은 값을 넣었으니까 인증 취소하기

    if (!nickName) {
		swal.fire({
			icon: "error",
			title: "Error!",
			text:"닉네임을 입력해주세요",
			confirmButtonColor: "#F7C525",
		});
        idInput.focus();
        idInput.style.border = '2px solid red';
        return;
    }

    try {
        const response = await fetch('checkNickName.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            },
            body: new URLSearchParams({ nickName }).toString(),
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const result = await response.text();
        handleNickNameValidationResult(result);
    } catch (error) {
        console.error('NickName validation error:', error);
		swal.fire({
			icon: "error",
			title: "Error!",
			text:"닉네임 확인 중 오류가 발생했습니다",
			confirmButtonColor: "#F7C525",
		});
        idInput.style.border = '2px solid orange';
    }
});

//문구 적합성 검사
function validateField(input) {
    const value = input.value.trim();
    let isValid = true;
    let message = '';

    switch (input.id) {
        case 'id-new':
            if (!value) {
                message = '아아디는 영문 대소문자, 숫자, 기호로 이루어신 6-16자 사이로 입력해주세요';
                isValid = false;
				isIdValid=-1;
            }else if (!value.match(/^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]{4,14}$/)) {
			message = '올바른 아이디 형식이 아닙니다';
			isValid = false;
				isIdValid=-1;
			}else{
				checkIdButton.disabled=false;
			}
            break;

        case 'pw-new':
            if (!value) {
                message = '비밀번호는 영문 대소문자, 숫자, 기호로 이루어신 6-16자 사이로 입력해주세요';
                isValid = false;
				isPwValid=-1;
            }else if (!value.match(/^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]{6,14}$/)) {
				message = '올바른 비밀번호 형식이 아닙니다';
				isPwValid=0;
				isValid = false;
			}else{
				isPwValid=1;
			}
            break;

        case 'name':
            if (!value) {
                message = '이름을 입력해주세요';
                isValid = false;
				isNameValid=-1;
            }else{
				isNameValid=1;
			}
            break;
			
        case 'nickName':
            if (!value) {
                message = '닉네임은 2~8자 사이로 입력해주세요';
                isValid = false;
            }else if(!value.match(/^[a-zA-Z0-9가-힣!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]{2,8}$/)){
			message = '올바른 닉네임 형식이 아닙니다';
			isValid = false;
			}else{
				checkNickNameButton.disabled=false;
			}
            break;
		
		case 'email':
		    if (!value) {
		        message = '이메일을 입력해주세요';
		        isValid = false;
		    } else if (!value.match(/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)) {
		        message = '올바른 이메일 형식이 아닙니다';
		        isValid = false;
		    }else{
				checkEmailButton.disabled=false;
			}
		    break;

		case 'phone':
			if (!value) {
		    } else if (!value.match(/^010-\d{3,4}-\d{4}$/)) {
		        message = '전화번호 형식(010-XXXX-XXXX)이 맞지 않습니다';
		        isValid = false;
		    }
		    break;

    }

    input.style.border = isValid ? '2px solid green' : '2px solid red';
    showError(input, message);
    if (!isValid && document.activeElement !== input) {
        input.focus();
    }
    return isValid;
}

function validateAll() {
    let isValid = true;
    inputs.forEach(input => {
        if (!validateField(input)) {
            isValid = false;
        }
    });
    return isIdValid === 1 && isNicknameValid === 1 && isidentityValid===1&& isNameValid===1&& isPwValid===1;
}

function handleIdValidationResult(data) {
    const pwInput = document.querySelector('#pw-new');

    switch (data) {
        case 'valid':
			swal.fire({
				icon: "success",
				title: "Okay!",
				text:"이 아이디는 사용 가능합니다",
				confirmButtonColor: "#F7C525",
			});
            idInput.style.border = '2px solid green';
            pwInput.focus();
            isIdValid = 1;
            break;

        case 'notValid':
			swal.fire({
				icon: "error",
				title: "Error!",
				text:"이 아이디는 사용 불가능합니다",
				confirmButtonColor: "#F7C525",
			});
            idInput.style.border = '2px solid red';
            idInput.value = '';
            idInput.focus();
            isIdValid = -1;
            break;

        default:
			swal.fire({
				icon: "error",
				title: "Error!",
				text:"예상치 못한 응답입니다",
				confirmButtonColor: "#F7C525",
			});
            idInput.style.border = '2px solid orange';
            isIdValid = 0;
    }
}

function handleNickNameValidationResult(data) {
    switch (data) {
        case 'valid':
			swal.fire({
				icon: "success",
				title: "Okay!",
				text:"이 닉네임은 사용 가능합니다",
				confirmButtonColor: "#F7C525",
			});
            nicknameInput.style.border = '2px solid green';
            emailInput.focus();
            isNicknameValid = 1;
            break;

        case 'notValid':
			swal.fire({
				icon: "error",
				title: "Error!",
				text:"이 닉네임은 사용 불가능합니다",
				confirmButtonColor: "#F7C525",
			});
            nicknameInput.style.border = '2px solid red';
            nicknameInput.value = '';
            nicknameInput.focus();
            isNicknameValid = -1;
            break;

        default:
			swal.fire({
				icon: "error",
				title: "Error!",
				text:"예상치 못한 응답입니다",
				confirmButtonColor: "#F7C525",
			});
            nicknameInput.style.border = '2px solid orange';
            isNicknameValid = 0;
    }
}

const countdownDisplay = document.getElementById('countdown');
let countdownTime;
let timerInterval;

//카운트 다운 함수
function startCountdown() {
    let minutes = 2;
    let seconds = 0;

    countdownTime = minutes * 60 + seconds;

    timerInterval = setInterval(() => {
        minutes = Math.floor(countdownTime / 60);
        seconds = countdownTime % 60;

        // 시간을 00:00 형식으로 표시
        countdownDisplay.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
		
		// 남은 시간이 30초 이하일 때 글씨색 변경
		if (countdownTime <= 30) {
		    countdownDisplay.style.color = 'red';
		} else {
		    countdownDisplay.style.color = ''; // 기본 색상으로 복원
		}

        countdownTime--;

        if (countdownTime < 0) {
            clearInterval(timerInterval);
            countdownDisplay.textContent = '시간 종료!';
        }
    }, 1000);
}

let isEmailDupValid = 1; // 이메일 중복 검사 상태 변수 추가

function handleEmailDupValidationResult(data) {
    switch (data) {
        case 'valid':
            emailInput.style.border = '2px solid green';
            isEmailDupValid = 1;
            break;

        case 'notValid':
            swal.fire({
                icon: "error",
                title: "Error!",
                text: "이미 사용 중인 이메일입니다.",
                confirmButtonColor: "#F7C525",
            });
            emailInput.style.border = '2px solid red';
            emailInput.value = '';
            emailInput.focus();
            isEmailDupValid = -1;
            break;

        default:
            swal.fire({
                icon: "error",
                title: "Error!",
                text: "예상치 못한 응답입니다.",
                confirmButtonColor: "#F7C525",
            });
            emailInput.style.border = '2px solid orange';
            isEmailDupValid = 0;
    }
}


async function email_ok(str){
	
	console.log("str:"+str);
	const originalEmail =  document.getElementById('originalEmailHidden').dataset.originalId; // 서버에서 전달받은 기존 닉네임

		if(str===originalEmail){
			swal.fire({
				text:"기존 이메일과 동일합니다",
				confirmButtonColor: "#F7C525"
			});
			isEmailDupValid=1;
			isidentityValid = 1;//기존이메일과 동일하니까 패스
			checkEmailButton.disabled=true;
			return;
		}
		isEmailDupValid=0;
		isidentityValid=0;//기존 이메일과 동일하지 않은 값을 넣었으니까 인증 취소하기
	
	try {
	        const response = await fetch('checkEmailDouble.do', { // 이메일 중복 검사 URL
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
	            },
	            body: new URLSearchParams({ str }).toString(),
	        });

	        if (!response.ok) {
	            throw new Error(`HTTP error! status: ${response.status}`);
	        }

	        const result = await response.text();
	        handleEmailDupValidationResult(result);
	    } catch (error) {
	        console.error('Email duplication check error:', error);
	        swal.fire({
	            icon: "error",
	            title: "Error!",
	            text: "이메일 중복 확인 중 오류가 발생했습니다.",
	            confirmButtonColor: "#F7C525",
	        });
	        emailInput.style.border = '2px solid orange';
	    }
		
		if(isEmailDupValid!=1){
			return;
		}
	
	const ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	let num = parseInt(Math.random() * 100000);
	console.log(num);
	isidentityValid=-1;//인증검사 진행 중
	
	identityCode=num; //인증번호 저장
	clearTimeout(emailChickTimeout); //이전 타임아웃 제거
	checkEmailButton.disabled=true; //인증버튼 비활성화
	checkcheckEmailOkButton.disabled=false; //인증번호 버튼 활성화
	
	clearInterval(timerInterval); // 기존 타이머가 실행 중이면 초기화
	startCountdown();
	
	emailChickTimeout = setTimeout(() => {
	  identityCode = null; // 2분 후 인증번호 초기화
	  swal.fire({
	    icon: "error",
	    title: "인증 시간 초과",
	    text: "인증 시간이 만료되었습니다. 다시 인증해주세요.",
	    confirmButtonColor: "#F7C525",
	  });
	  isidentityValid=0;//인증검사 진행 전
	  checkEmailButton.disabled=false; //이메일 인증버튼 활성화
	  checkcheckEmailOkButton.disabled=true; //인증번호 버튼 활성화
	}, 120000); // 2분 (120000 밀리초) 후 타임아웃 설정

	$.ajax({
		url: ctx + "/mailSend.do", //전송받을 페이지 경로 //서블릿
		type: "post", //데이터 읽어오는 방식 //데이터 전송방식
		dataType: "text", //데이터 방식
		data: "num="+num+"&email="+str,
		success:function(text){ //성공일 경우
			//$("#id_result").html(text);
			swal.fire({
				icon: "success",
				title: "Check yout E-mail!",
				text:"인증번호를 확인해 입력하세요. \n혹시 오지 않았다면 메일 주소를 확인해주세요.",
				confirmButtonColor: "#F7C525",
				})
			
		},
		error:function(){ //실패일 경우
			swal.fire({
				icon: "error",
				title: "Error!",
				text:"메일 발송에 실패했습니다.",
				confirmButtonColor: "#F7C525",
				})
			isidentityValid=0;//인증검사 진행 전
		}
	});
}


checkcheckEmailOkButton.addEventListener("click", function () {
  const enteredCode = document.querySelector('#checkEmailOk');
  let enterCode =parseInt(enteredCode.value);
  //이거 일단 input을 number로 해서 int 로 변환하긴 했는데 혹시나 나중에 문자 섞어서 인증할거면 String으로 바꾸기
  console.log("내가 입력한 인증번호:"+enterCode);
  console.log("저장한 인증번호:"+identityCode);
  console.log(enterCode == identityCode);
  
  if (identityCode !== null && enterCode == identityCode) {
    clearTimeout(emailChickTimeout); // 인증 성공 시 타임아웃 제거
    identityCode = null; // 인증 성공 후 인증번호 초기화
    swal.fire({
      icon: "success",
      title: "인증 성공",
      text: "이메일 인증이 완료되었습니다.",
      confirmButtonColor: "#F7C525",
    });
	isidentityValid=1;//인증검사 완료
	
	clearInterval(timerInterval);
	countdownDisplay.textContent = '인증완료';
	
	checkEmailButton.disabled=false; //이메일 인증버튼 비활성화
	checkcheckEmailOkButton.disabled=true; //인증번호 버튼 활성화
  } else {
    swal.fire({
      icon: "error",
      title: "인증 실패",
      text: "인증번호가 일치하지 않습니다.",
      confirmButtonColor: "#F7C525",
    });
  }
});


function showError(input, message) {
    let errorElement = input.nextElementSibling;
    if (!errorElement || !errorElement.classList.contains('error-message')) {
        errorElement = document.createElement('div');
        errorElement.classList.add('error-message');
        input.parentNode.insertBefore(errorElement, input.nextSibling);
    }
    errorElement.textContent = message;
    errorElement.style.color = 'red';
}


//기존 이미지 주소 가져오기
const fistImg = document.getElementById('originalImgHidden').dataset.originalId;

/*이미지 삭제*/
document.getElementById('btn-imgDel').addEventListener('click', function() {
  document.querySelector('input[name="uploadFile"]').value = '';
  $('#imgPreview').empty();
});

/*이미지 미리보기*/
function tryImgPreview(event) {
  let files = event.target.files;
  let fileArr = Array.from(files);
  const preview = $('#imgPreview');
  const existingImage = preview.find('img'); // 기존 이미지 요소 찾기

  if (fileArr.length > 0) { // 파일이 선택되었을 때만 처리
    // 기존 이미지 미리보기 삭제
    preview.empty();

    fileArr.forEach(function (f) {
      // 이미지만 가능
      if (!f.type.match("image.*")) {
		swal.fire({
			icon: "error",
			title: "확장자 오류",
			text: "이미지 확장자만 가능합니다.",
			confirmButtonColor: "#F7C525",
		  });
        return;
      }
      // 이미지를 읽을 객체
      let reader = new FileReader();
      // reader.onload ==> 읽기가 완료되었을때
      reader.onload = function (e) {
        let img_html = "<img src=\"" + e.target.result + "\" style='width:30%; margin-right: 10px;' />";
        preview.append(img_html);
		//alert("e.target.result: "+e.target.result);
		elementImg.setAttribute('data-original-id', e.target.result);
		elementImg.value=e.target.result;
      }
      // 이미지를 읽자
      reader.readAsDataURL(f);
    });
  } else {
    // 파일 선택이 취소된 경우 기존 이미지 유지
    if (existingImage.length === 0) {
      // 기존 이미지가 없는 경우 기본 이미지 표시 (선택 사항)
      preview.html('<img src="${ctx}/img/ProfileBasicImg.png" class="photo" id="default" />');
    }
  }
}
// input 요소에 change 이벤트 리스너 추가
$('#imageInput').on('change', tryImgPreview);
const style = document.createElement('style');
style.textContent = `
    input[readonly] {
        background-color: #f0f0f0;
    }
    .error-message {
        font-size: 0.8em;
        margin: 2px 0;
    }
`;
document.head.appendChild(style);