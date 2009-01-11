

function iknowSearchItems(word) {
    var uri = "http://api.iknow.co.jp/items/matching/" + word + ".json?callback=?";
    $.getJSON(uri, function(data){
	result = document.getElementById('result');
	result.innerHTML = data;
    });
}





function hoge() {
    alert('hoge');
}

