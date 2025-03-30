
/* ------------------------ 카카오 script ------------------------ */
Kakao.init('c73862c0803a70accb9cd1840b0c6bcb');
function kakaoLogin() {
	Kakao.Auth.login({
		success: function(response) {
			Kakao.API.request({
				url: '/v2/user/me',
				success: function(response) {
					const nickname = response.properties.nickname; // 사용자 닉네임
					const email = response.kakao_account.email; // 사용자 이메일

					sendUserInfoToServer('kakao', nickname, email);

					alert('로그인 성공')
					location.href = ctx + "/main.do";
				},
				fail: function(error) {
					console.error(error);
				},
			})
		},
		fail: function(error) {
			console.error(error);
		},
	})
}

function sendUserInfoToServer(platform, nickname, email) {
	$.ajax({
		type: 'POST',
		url: `${ctx}/saveSocialLoginInfo.do`,
		data: {
			platform: platform,
			nickname: nickname,
			email: email
		},
		success: function(data) {
			if (data === '닉네임 중복') {
				// 닉네임 입력 폼으로 이동
				window.location.href = `${ctx}/nicknameInputForm.do?platform=${platform}&email=${email}&nickname=${nickname}`;
			} else {
				// 메인 페이지로 이동
				window.location.href = `${ctx}/main.do`;
			}
		},
		error: function(error) {
			console.error('Error sending user info:', error);
		}
	});
}

/* ------------------------ 네이버 script ------------------------ */
var naver_id_login = new naver_id_login("Kc4oajEGWigub1aElsL9",
	"http://localhost:8084/SmartReciFit/loginSuccess.do");
var state = naver_id_login.getUniqState();
naver_id_login.setButton("white", 2, 40);
let domain = window.location.pathname;
console.log(domain);
naver_id_login.setDomain("http://localhost:8084/SmartReciFit/main.do");
naver_id_login.setState(state);
naver_id_login.setPopup();
naver_id_login.init_naver_id_login();

window.addEventListener('message', function(event) {
	if (event.origin !== "http://localhost:8084")
		return; // 팝업 창의 도메인
	if (event.data.type === 'naverLogin') {
		var accessToken = event.data.accessToken;
		// 네이버 사용자 프로필 정보 가져오기
		getNaverProfile(accessToken);
	}
}, false);


/* ------------------------ 구글 script ------------------------ */
function handleCredentialResponse(response) {
	const jwtToken = response.credential;
	const payload = JSON.parse(Base64.decode(jwtToken.split('.')[1]));

	console.log('ID: ' + payload.sub);
	console.log('Full Name: ' + payload.name);
	console.log('Given Name: ' + payload.given_name);
	console.log('Family Name: ' + payload.family_name);
	console.log('Image URL: ' + payload.picture);
	console.log('Email: ' + payload.email);

	const nickname = payload.name;
	const email = payload.email;

	sendUserInfoToServer('google', nickname, email);
}

function sendUserInfoToServer(platform, nickname, email) {
	console.log('sendUserInfoToServer');
	$.ajax({
		type: 'POST',
		url: `${ctx}/saveSocialLoginInfo.do`,
		data: {
			platform: platform,
			nickname: nickname,
			email: email
		},
		success: function(data) {
			if (data === '닉네임 중복') {
				// 닉네임 입력 폼으로 이동
				window.location.href = `${ctx}/nicknameInputForm.do?platform=${platform}&email=${email}&nickname=${nickname}`;
			} else {
				// 메인 페이지로 이동
				window.location.href = `${ctx}/main.do`;
			}
		},
		error: function(error) {
			console.error('Error sending user info:', error);
		}
	});
}

window.onload = function() {
	google.accounts.id
		.initialize({
			client_id: "231194762579-nbasfr2j9k5nrb2nu78t6r6ou03c3btk.apps.googleusercontent.com", // 여기에 클라이언트 ID를 입력하세요
			callback: handleCredentialResponse,
			login_uri: "http://localhost:8084/SmartReciFit/main.do" // 로그인 URI 설정
		});
	google.accounts.id.renderButton(document.querySelector(".g_id_signin"),
		{
			theme: "outline",
			size: "large",
			shape: "rectangular",
			logo_alignment: "left"
		});
	google.accounts.id.prompt();
}
