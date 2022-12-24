let correct;
let attempt;
let step;
const total = 5;
let timeout;
let pieces;
let indices;
let audio;

function onStartButtonClick() {
    document.getElementById("rules").style.display = "none";
    document.getElementById("start-game").style.display = "none";
    document.getElementById("score").style.display = "inline";
    document.getElementById("question-text1").style.display = "inline";
    document.getElementById("options").style.display = "block";
    timeout = setTimeout(check, 25000, 0);
    indices = indices.sort((l, r) => 0.5 - Math.random());
    attempt = 1;
    step = 1;
    chosenFill();
    audio.src = "XML/mp3/" + pieces[indices[attempt - 1]].getElementsByTagName("URL")[0].textContent;
    audio.play();
}

function chosenFill() {
    let chosen = new Array();
    let forbidden = new Array();
    let property;
    if (step == 1)
        property = "Title";
    else
        property = "Composer";
    chosen.push(indices[attempt - 1]);
    forbidden.push(pieces[chosen[0]].getElementsByTagName(property)[0].textContent);
    for (let i = 1; i <= 3; i++) {
        let index = getRandomIndex(property, forbidden);
        chosen.push(index);
        forbidden.push(pieces[index].getElementsByTagName(property)[0].textContent);
    }
    chosen = chosen.sort((l, r) => 0.5 - Math.random());
    chosen = chosen.sort((l, r) => 0.5 - Math.random());
    for (let i = 0; i < chosen.length; i++) {
        if (chosen[i] == indices[attempt - 1]) {
            correct = i + 1;
            break;
        }
    }
    document.getElementById("b1").innerText = pieces[chosen[0]].getElementsByTagName(property)[0].textContent;
    document.getElementById("b2").innerText = pieces[chosen[1]].getElementsByTagName(property)[0].textContent;
    document.getElementById("b3").innerText = pieces[chosen[2]].getElementsByTagName(property)[0].textContent;
    document.getElementById("b4").innerText = pieces[chosen[3]].getElementsByTagName(property)[0].textContent;
}

function getRandomIndex(property, forbidden) {
    let temp = Math.floor(Math.random() * total);
    while (forbidden.includes(pieces[temp].getElementsByTagName(property)[0].textContent)) {
        temp = Math.floor(Math.random() * total);
    }
    return temp;
}

function init(xml) {
    let xhttp = new XMLHttpRequest();
    xhttp.open("GET", xml, false);
    xhttp.send();
    let doc = xhttp.responseXML;
    pieces = doc.getElementsByTagName("Work");
    indices = new Array();
    for (let i = 0; i < pieces.length; i++) {
        indices.push(i);
    }

    let temp = total * 2;
    document.getElementById("total-score").innerText = temp;
    document.getElementById("total-pieces").innerText = total;
    audio = document.getElementById("audio");
}

async function check(choice) {
    switch (correct) {
        case 1:
            document.getElementById("b1").style.border = "#4CAF50 solid 5px";
            document.getElementById("b2").style.border = "#F44336 solid 5px";
            document.getElementById("b3").style.border = "#F44336 solid 5px";
            document.getElementById("b4").style.border = "#F44336 solid 5px";
            break;
        case 2:
            document.getElementById("b1").style.border = "#F44336 solid 5px";
            document.getElementById("b2").style.border = "#4CAF50 solid 5px";
            document.getElementById("b3").style.border = "#F44336 solid 5px";
            document.getElementById("b4").style.border = "#F44336 solid 5px";
            break;
        case 3:
            document.getElementById("b1").style.border = "#F44336 solid 5px";
            document.getElementById("b2").style.border = "#F44336 solid 5px";
            document.getElementById("b3").style.border = "#4CAF50 solid 5px";
            document.getElementById("b4").style.border = "#F44336 solid 5px";
            break;
        case 4:
            document.getElementById("b1").style.border = "#F44336 solid 5px";
            document.getElementById("b2").style.border = "#F44336 solid 5px";
            document.getElementById("b3").style.border = "#F44336 solid 5px";
            document.getElementById("b4").style.border = "#4CAF50 solid 5px";
            break;
    }
    clearTimeout(timeout);
    if (correct == choice) {
        let currentScore = document.getElementById("user-score").innerText;
        currentScore++;
        document.getElementById("user-score").innerText = currentScore;
    }
    document.getElementById("b1").disabled = true;
    document.getElementById("b2").disabled = true;
    document.getElementById("b3").disabled = true;
    document.getElementById("b4").disabled = true;
    await new Promise(R => setTimeout(R, 2500));
    document.getElementById("b1").disabled = false;
    document.getElementById("b2").disabled = false;
    document.getElementById("b3").disabled = false;
    document.getElementById("b4").disabled = false;
    if (step == 1) {
        document.getElementById("question-text1").style.display = "none";
        document.getElementById("question-text2").style.display = "inline";
        step = 2;
    } else {
        document.getElementById("question-text1").style.display = "inline";
        document.getElementById("question-text2").style.display = "none";
        step = 1;
        audio.pause();
        attempt++;
        if (attempt > total) {
            document.getElementById("question-text2").style.display = "none";
            document.getElementById("question-text1").style.display = "none";
            document.getElementById("options").style.display = "none";
            alert(document.getElementById("user-score").innerText + '/' + document.getElementById("total-score").innerText);
            window.location.reload();
            return;
        }
        document.getElementById("piece").innerText = attempt;
    }
    document.getElementById("b1").style.border = "solid 0px";
    document.getElementById("b2").style.border = "solid 0px";
    document.getElementById("b3").style.border = "solid 0px";
    document.getElementById("b4").style.border = "solid 0px";
    chosenFill();
    if (step == 1) {
        audio.src = "XML/mp3/" + pieces[indices[attempt - 1]].getElementsByTagName("URL")[0].textContent;
        audio.play();
    }
    timeout = setTimeout(check, 25000, 0);
}