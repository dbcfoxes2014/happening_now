$("#input").on("autocomplete", function(event, data){
    console.log("Autocompleted id is " + data.id);
    console.log("Autocompleted value is "+ data.value);
});