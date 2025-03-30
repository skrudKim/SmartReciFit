function searchRecipes() {
	var keyword = document.getElementById("keyword").value;
	if (keyword) {
		var xhr = new XMLHttpRequest();
		xhr.open("GET", `${ctx}/searchRecipes.do?keyword=${keyword}&limit=10`, true);

		xhr.onload = function() {
			if (xhr.status >= 200 && xhr.status < 300) {
				var results = JSON.parse(xhr.responseText);
				displayResults(results);
			} else {
				console.error("Request failed with status: " + xhr.status);
			}
		};

		xhr.onerror = function() {
			console.error("Request failed");
		};

		xhr.send();
	} else {
		var searchResultsDiv = document.getElementById("searchResults");
		searchResultsDiv.innerHTML = ""; // 이전 결과 지우기
	}

}

function displayResults(results) {
	var searchResultsDiv = document.getElementById("searchResults");
	searchResultsDiv.innerHTML = ""; // 이전 결과 지우기
	if (results && results.length > 0) {
		results.forEach(function(recipe) {
			html = `<div class="search-result ${recipe.recipeNum}">`
			html += `<img src="${recipe.recipeThumbnail}" alt="" width="100px" height="auto">`;
			html += `<div class="search-result-title">${recipe.recipeName}</div>`
			html += '</div>'
			searchResultsDiv.innerHTML += html;
		});
		let searchResults = searchResultsDiv.querySelectorAll('.search-result');
		searchResults.forEach(e => e.addEventListener('click', function() {
			location.href = `${ctx}/recipeContent.do?rn=${this.classList[1]}`;
		}))
	} else {
		searchResultsDiv.innerHTML = "<p>검색 결과가 없습니다.</p>";
	}

}