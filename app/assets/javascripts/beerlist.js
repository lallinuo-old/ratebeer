var BEERS = {};

BEERS.show = function(){
    $("#beertable tr:gt(0)").remove()

    var table = $("#beertable");

    $.each(BEERS.list, function (index, beer) {
        table.append('<tr>'
            +'<td><a href=beers/'+beer['id']+'>'+beer["name"]+'</a></td>'
            +'<td>'+beer['style']['style']+'</td>'
            +'<td>'+beer['brewery']['name']+'</td>'
            +'</tr>');
    });
};

BEERS.sort_by_name = function(){
    BEERS.list.sort( function(a,b){
        return a.name.toUpperCase() > b.name.toUpperCase();
    });
};

BEERS.sort_by_style = function(){
    BEERS.list.sort( function(a,b){
        return a.style.style.toUpperCase() > (b.style.style.toUpperCase());
    });
};

BEERS.sort_by_brewery = function(){
    BEERS.list.sort( function(a,b){
        return a.brewery.name.toUpperCase() > (b.brewery.name.toUpperCase());
    });
};

$(document).ready(function () {

    $("#name").click(function (e) {
        BEERS.sort_by_name();
        BEERS.show();
        e.preventDefault();
    });

    $("#style").click(function (e) {
        BEERS.sort_by_style();
        BEERS.show();
        e.preventDefault();
    });

    $("#brewery").click(function (e) {
        BEERS.sort_by_brewery();
        BEERS.show();
        e.preventDefault();
    });

    $.getJSON('beers.json', function (beers) {
        BEERS.list = beers;
        BEERS.sort_by_name;
        BEERS.show();
    });
});