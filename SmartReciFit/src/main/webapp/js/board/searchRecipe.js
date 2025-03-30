function searchRecipes() {
       var keyword = document.getElementById("keyword").value;

       var xhr = new XMLHttpRequest();
       xhr.open("GET", `${ctx}/searchRecipes.do?keyword=` + keyword, true);

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
   }

   function displayResults(results) {
       var searchResultsDiv = document.getElementById("searchResults");
       searchResultsDiv.innerHTML = ""; // 이전 결과 지우기
      

       if (results && results.length > 0) {
           var ul = document.createElement("ul");
           results.forEach(function(recipe) {
            console.log(recipe);
               var li = document.createElement("li");
               var label = document.createElement("label");
               var input = document.createElement("input");

               input.type = "radio";
               input.name = "recipeNum";
               input.value = recipe.recipeNum;

               label.appendChild(input);
               label.appendChild(document.createTextNode(recipe.recipeName + " (" + recipe.recipeIngredient + ")"));
               li.appendChild(label);
               ul.appendChild(li);
           });
           searchResultsDiv.appendChild(ul);
       } else {
           searchResultsDiv.innerHTML = "<p>검색 결과가 없습니다.</p>";
       }
   }