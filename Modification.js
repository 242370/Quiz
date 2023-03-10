let fileName = "XML/zad3.xml";
let doc;
let pieces;
let fileContent;

function init(xml) {
    let xhttp = new XMLHttpRequest();
    xhttp.open("GET", xml, false);
    xhttp.send();
    doc = xhttp.responseXML;
    fileContent = doc.children[0];
    pieces = doc.getElementsByTagName("Work");
    let data = document.getElementById("table");
    for (let i = data.rows.length - 1; i > 0 ; i--) {
        data.deleteRow(i);
    }
    for (let i = 0; i < pieces.length; i++) {
        if (pieces[i].getAttribute("removed") == "yes")
            continue;
        let row = data.insertRow(-1);
        let title = row.insertCell(0);
        let composer = row.insertCell(1);
        let file = row.insertCell(2);
        let action = row.insertCell(3);
        title.innerText = pieces[i].getElementsByTagName("Title")[0].textContent;
        composer.innerText = pieces[i].getElementsByTagName("Composer")[0].textContent;
        file.innerText = pieces[i].getElementsByTagName("URL")[0].textContent;
        let editButton = document.createElement("button");
        editButton.id = "edit" + (i + 1);
        editButton.innerText = "Edit";
        editButton.onclick = function () {
            edit(i + 1);
        };
        action.appendChild(editButton);
        let delButton = document.createElement("button");
        delButton.id = "del" + (i + 1);
        delButton.innerText = "Delete";
        delButton.onclick = function () {
            del(i + 1);
        };
        action.appendChild(delButton);
        let saveButton = document.createElement("button");
        saveButton.id = "save" + (i + 1);
        saveButton.innerText = "Confirm";
        saveButton.onclick = function () {
            save(i + 1);
        };
        saveButton.style.display = "none";
        action.appendChild(saveButton);
        let cancelButton = document.createElement("button");
        cancelButton.id = "cancel" + (i + 1);
        cancelButton.innerText = "Cancel";
        cancelButton.onclick = function () {
            cancel(i + 1);
        };
        cancelButton.style.display = "none";
        action.appendChild(cancelButton);
    }
    document.getElementById("fileNameInput").value = xml;
}

function edit(index) {
    let data = document.getElementById("table");
    let row = data.rows[index];
    let titleInput = document.createElement("input");
    let composerInput = document.createElement("input");
    let fileInput = document.createElement("input");
    titleInput.id = "title" + index;
    composerInput.id = "composer" + index;
    fileInput.id = "file" + index;
    if(row.cells[0].innerText.length > 0)
    {
        titleInput.size = row.cells[0].innerText.length;
        composerInput.size = row.cells[1].innerText.length;
        fileInput.size = row.cells[2].innerText.length;
    }
    titleInput.value = row.cells[0].innerText;
    composerInput.value = row.cells[1].innerText;
    fileInput.value = row.cells[2].innerText;
    row.cells[0].innerText = "";
    row.cells[1].innerText = "";
    row.cells[2].innerText = "";
    row.cells[0].appendChild(titleInput);
    row.cells[1].appendChild(composerInput);
    row.cells[2].appendChild(fileInput);
    document.getElementById("edit" + index).style.display = 'none';
    document.getElementById("del" + index).style.display = 'none';
    document.getElementById("save" + index).style.display = 'inline';
    document.getElementById("cancel" + index).style.display = 'inline';
}

function add() {
    let data = document.getElementById("table");
    let row = data.insertRow(-1);
    row.insertCell(0);
    row.insertCell(1);
    row.insertCell(2);
    let action = row.insertCell(3);
    let work = doc.createElement("Work");
    let title = doc.createElement("Title");
    let composer = doc.createElement("Composer");
    let file = doc.createElement("URL");
    work.appendChild(title);
    work.appendChild(composer);
    work.appendChild(file);
    doc.getElementsByTagName("Works")[0].appendChild(work);
    let editButton = document.createElement("button");
    editButton.id = "edit" + (pieces.length);
    editButton.innerText = "Edit";
    editButton.onclick = function () {
        edit(pieces.length);
    };
    action.appendChild(editButton);
    let delButton = document.createElement("button");
    delButton.id = "del" + (pieces.length);
    delButton.innerText = "Delete";
    delButton.onclick = function () {
        del(pieces.length);
    };
    action.appendChild(delButton);
    let saveButton = document.createElement("button");
    saveButton.id = "save" + (pieces.length);
    saveButton.innerText = "Confirm";
    saveButton.onclick = function () {
        save(pieces.length);
    };
    saveButton.style.display = "none";
    action.appendChild(saveButton);
    let cancelButton = document.createElement("button");
    cancelButton.id = "cancel" + (pieces.length);
    cancelButton.innerText = "Cancel";
    cancelButton.onclick = function () {
        cancel(pieces.length);
    };
    cancelButton.style.display = "none";
    action.appendChild(cancelButton);
    edit(pieces.length);
}

function del(index) {
    let data = document.getElementById("table");
    let row = data.rows[index];
    row.style.display = "none";
    pieces[index - 1].setAttribute("removed", "yes");
}

function save(index) {
    let data = document.getElementById("table");
    let row = data.rows[index];
    let title = document.getElementById("title" + index).value;
    let composer = document.getElementById("composer" + index).value;
    let file = document.getElementById("file" + index).value;
    if (title.length == 0) {
        alert("You can't leave the title empty");
        return;
    }
    if (composer.length == 0) {
        alert("You can't leave the composer empty");
        return;
    }
    if (file.length == 0 || !file.endsWith(".mp3")) {
        alert("The file field has to be a non-empty .mp3 file");
        return;
    }
    pieces[index - 1].getElementsByTagName("Title")[0].textContent = title;
    pieces[index - 1].getElementsByTagName("Composer")[0].textContent = composer;
    pieces[index - 1].getElementsByTagName("URL")[0].textContent = file;
    row.cells[0].innerText = pieces[index - 1].getElementsByTagName("Title")[0].textContent;
    row.cells[1].innerText = pieces[index - 1].getElementsByTagName("Composer")[0].textContent;
    row.cells[2].innerText = pieces[index - 1].getElementsByTagName("URL")[0].textContent;
    document.getElementById("save" + index).style.display = 'none';
    document.getElementById("cancel" + index).style.display = 'none';
    document.getElementById("edit" + index).style.display = 'inline';
    document.getElementById("del" + index).style.display = 'inline';
}

function cancel(index) {
    let data = document.getElementById("table");
    let row = data.rows[index];
    if (pieces[index - 1].getElementsByTagName("Title")[0].textContent == "") {
        del(index);
    } else {
        row.cells[0].innerText = pieces[index - 1].getElementsByTagName("Title")[0].textContent;
        row.cells[1].innerText = pieces[index - 1].getElementsByTagName("Composer")[0].textContent;
        row.cells[2].innerText = pieces[index - 1].getElementsByTagName("URL")[0].textContent;
    }
    document.getElementById("save" + index).style.display = 'none';
    document.getElementById("cancel" + index).style.display = 'none';
    document.getElementById("edit" + index).style.display = 'inline';
    document.getElementById("del" + index).style.display = 'inline';
}

function saveFile() {
    const serializer = new XMLSerializer();
    const serializedString = `<?xml version="1.0" encoding="UTF-8"?>` + "\n" + serializer.serializeToString(fileContent);

    // Stw??rz plik tymczasowy
    const blob = new Blob([serializedString], {type: "text/xml"});

    // Stw??rz wirtualny element z linkiem do pobrania
    // powy??szego pliku
    const aElement = document.createElement("a");
    aElement.href = URL.createObjectURL(blob);
    aElement.download = "save.xml";
    aElement.click();
}