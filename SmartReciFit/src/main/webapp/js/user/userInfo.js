const form = document.querySelector('#userInfoForm');
const cancelButton = document.querySelector('#btn-infoCancel');
const submitButton = document.querySelector('#btn-infoSubmit');

//어떤 이벤트를 명시적으로 처리하지 않은 경우, 해당 이벤트에 대한 사용자 에이전트의 기본 동작을 실행하지 않도록 지정
form.addEventListener('submit', (event) => {
	event.preventDefault();
});

cancelButton.addEventListener('click', (event) => {
	console.log("cancelButton 클릭");
	window.location.href = "index.jsp";
});

submitButton.addEventListener('click', (event) => {
	console.log("submitButton 클릭");
	document.getElementById("userInfoForm").submit();
});

$(document).ready(function() {
	// if (!isLoggedIn) {
	// 	Swal.fire({
	// 		icon: "info",
	// 		title: "추가 정보 입력",
	// 		text: "내가 선호하는 음식을 기록해둘 수 있어요",
	// 		showDenyButton: true,
	// 		showCancelButton: false,
	// 		confirmButtonText: "네, 입력할게요",
	// 		denyButtonText: "입력하지 않을래요"
	// 	}).then((result) => {
	// 		if (result.isConfirmed) {
	// 			console.log("입력하기 선택");
	// 		} else if (result.isDenied) {
	// 			console.log("입력안하기 선택");
	// 	        Swal.fire({
	// 				title: "회원가입 완료!",
	// 	            text: "저희 사이트에 가입해주셔서 감사합니다.",
	// 	            icon: "success",
	// 	            confirmButtonText: "확인"
	// 	        }).then(() => {
	// 				window.location.href = "index.jsp";
	// 	        });
	// 		}
	// 	});
	// }
	
    const checkboxes = $('input[type="checkbox"]');
    const submitButton = $('#btn-infoSubmit');

    async function updateSubmitButtonState() {
        const checkedCount = checkboxes.filter(':checked').length;
        // 비동기적으로 버튼 상태 업데이트
        await new Promise(resolve => setTimeout(resolve, 0));
        submitButton.prop('disabled', checkedCount < 1 || checkedCount > 5);
    }
    // 초기 상태 설정
    updateSubmitButtonState();
    // 체크박스 변경 시 상태 업데이트
    checkboxes.on('change', updateSubmitButtonState);
});
