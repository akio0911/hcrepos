


// ToDo implement super function
function iknowSearchItems(word, suffix) {
    var suffix = suffix ? "." + suffix : "";
    var uri = "http://api.iknow.co.jp/items/matching/" + word + suffix + "?callback=?";
    var result = document.getElementById('result');

    $.getJSON(uri, function(data){
	result.innerHTML = data;
    });
}

function iknowSearchItemsInJson(word) {
    var uri = "http://api.iknow.co.jp/items/matching/" + word + ".json?callback=?";
    var result = document.getElementById('result');

    $.getJSON(uri, function(data){
	result.innerHTML = data;
    });

}

function iknowSearchItemsInHtml(word) {
    var uri = "http://api.iknow.co.jp/items/matching/" + word;
    var result = document.getElementById('result');

    $.get(uri, function(data){
	result.innerHTML = data;
    });
}


function hoge() {
    alert('hoge');
}

