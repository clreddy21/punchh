$(document).ready(function() {

    //using multi select for selecting multiple currencies
    $("#currencies_select").multiselect({
        header: false
    });

    $(".ui-multiselect-menu").click(function(){
        if ($("input:checkbox:checked").length > 2){
            this.checked = false;
            return false;
        }
    });



    //using daterange picker with the date format supported by currency api
    var start = moment().subtract(1, 'months');
    var end = moment();

    $('input[class="daterange"]').daterangepicker({
        startDate: start,
        endDate: end,
        locale: {
            format: 'YYYY-MM-DD'
        }
    });



});
