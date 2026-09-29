

function startQuizTimer(durationInSeconds, displayElementId, formId) {
    var timeLeft = durationInSeconds;
    var display = document.getElementById(displayElementId);

    var countdown = setInterval(function () {
        var minutes = Math.floor(timeLeft / 60);
        var seconds = timeLeft % 60;

      
        if (seconds < 10) { seconds = "0" + seconds; }
        if (minutes < 10) { minutes = "0" + minutes; }

        display.textContent = minutes + ":" + seconds;

        if (timeLeft <= 0) {
            clearInterval(countdown);
            alert("Time's up! Your quiz has been submitted.");
            document.getElementById(formId).submit();
        }

        timeLeft--;
    }, 1000);
}
