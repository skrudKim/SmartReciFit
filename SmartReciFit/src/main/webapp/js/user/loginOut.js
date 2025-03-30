const ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));

document.addEventListener('DOMContentLoaded', () => {
	// 모달 활성화
	const activateLoginModal = () => {
		document.querySelector('.login-modal').classList.add('active');
		document.querySelector('.overlay').classList.add('active');
	};

	// 모달 비활성화
	const deactivateLoginModal = () => {
		document.querySelector('.login-modal').classList.remove('active');
		document.querySelector('.overlay').classList.remove('active');
	};


	const loginAjax = (form) => {
	    const id = form.id.value.trim();
	    const pw = form.pw.value.trim();

	    if (!id || !pw) {
	        alert("아이디와 비밀번호를 입력해주세요.");
	        return;
	    }

	    fetch(ctx + "/login.do", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
	        body: `id=${id}&pw=${pw}`
	    })
	        .then(response => response.text())
	        .then(data => {
	            if (data === "success") {
	                alert("로그인 성공");
	                location.reload(); // 일반 사용자 페이지로 이동
	            } else if (data === "admin_success") {
	                alert("관리자 로그인 성공");
	                location.href = ctx + "/adminMain.do"; // 관리자 페이지로 이동
	            } else {
	                alert("아이디 또는 비밀번호가 잘못 되었습니다. 아이디와 비밀번호를 정확히 입력해 주세요.");
	            }
	        })
	        .catch(error => console.error("로그인 요청 에러:", error));
	};
	// 이벤트 리스너 등록
	const loginOpenButton = document.querySelector('.login-open');
	if (loginOpenButton) {
		loginOpenButton.addEventListener('click', activateLoginModal);
	}

	const loginCloseButton = document.querySelector('.login-close');
	if (loginCloseButton) {
		loginCloseButton.addEventListener('click', deactivateLoginModal);
	}

	// 폼 제출 이벤트 리스너 추가
	const loginForm = document.querySelector('#loginForm');
	if (loginForm) {
		loginForm.addEventListener('submit', (event) => {
			event.preventDefault();
			loginAjax(loginForm);
		});
	}
});

document.addEventListener('DOMContentLoaded', () => {
	const logoutBtn = document.querySelector('.logout-btn');
	if (logoutBtn) { // 로그아웃 버튼이 존재할 경우에만 이벤트 리스너 추가
		logoutBtn.addEventListener('click', (event) => {
			event.preventDefault(); // 기본 링크 동작 방지
			const logoutUrl = event.target.href; // href 속성 값 가져오기

			fetch(logoutUrl, {
				method: "GET",
			})
				.then(response => response.text())
				.then(data => {
					if (data === "done") {
						alert("로그아웃 성공");
						setTimeout(() => {
							location.href = ctx + '/recipes.do';
						}, 500);
					} else {
						alert("로그아웃 실패");
					}
				})
				.catch(error => console.error('Error:', error));
		});
	}
});

