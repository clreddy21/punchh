$(document).ready(function() {
    $(".primary-button").on('click', function() {
        var date_range = $('.daterange').val();
        var currencies = $('#currencies_select').val().slice(0,2);

        if (currencies.length > 1){
            $.ajax({
                data: {date_range: date_range, currencies: currencies},
                type: 'post',
                url: "/convert/",
                success: function (data, status, xhr) {
                    var keys = data[0]['keys'];
                    keys.unshift('x');
                    var values = data[0]['values'];
                    values.unshift('dates');

                    var chart = c3.generate({
                        bindto: '#chart',
                        data: {
                            x: 'x',
                            columns: [
                                keys,
                                values
                            ]
                        },
                        axis: {
                            x: {
                                type: 'timeseries',
                                tick: {
                                    format: '%Y-%m-%d'
                                }
                            },
                            y: {
                                label: currencies.join('/')
                            }
                        }
                    });

                }
            });

        }
        else {
            alert("Please select 2 currencies");
            return false;
        }
    });

});
