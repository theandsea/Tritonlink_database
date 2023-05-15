function greet() {
  alert("Hello, world!");
}

// different button function
function button_insert(){
  button = document.createElement('button');
  button.innerText = "insert";
  button.onclick = function(){insert(this)}; // wrap to avoid automatically run
  return button;
}

function button_update(){
  button = document.createElement('button');
  button.innerText = "update";
  button.onclick = function(){update(this)};
  return button;
}

function button_delete(){
  button = document.createElement('button');
  button.innerText = "delete";
  button.onclick = function(){delete_(this)};
  return button;
}

function button_detail(){
  button = document.createElement('button');
  button.innerText = "detail";
  button.onclick = function(){detail(this)};
  return button;
}
function data_entity(data, table_name) {
  var table = document.createElement("table");

  // Loop over the data array to add rows and cells to the table
  for (var i = 0; i < data.length; i++) {
    //prompt
    if (i == 0) {
      // var cell = table.insertRow();
      var heading = document.createElement("h2");
      switch(true){
        case (typeof(student)!=="undefined" && data == student ): heading.textContent = "Register a student:"; break;
        case (typeof(undergraduates) !=="undefined" && data == undergraduates): heading.textContent = "Register a student as an undergraduate:"; break;
        case (typeof(graduates) !=="undefined" && data == graduates): heading.textContent = "Register a student as a graduate:"; break;
        case (typeof(previous_d) !=="undefined" && data == previous_d): heading.textContent = "Register student's non-UCSD degree:"; break;
        case (typeof(attendence) !=="undefined" && data == attendence): heading.textContent = "Register a student's attendence:"; break;
        case (typeof(faculty)!== "undefined" && data == faculty): heading.textContent = "Register a faculty:"; break;
        case (typeof(course) !=="undefined" && data == course): heading.textContent = "Register a course:"; break;
        case (typeof(prerequirement) !=="undefined" && data == prerequirement): heading.textContent = "Log Pre-required Course:"; break;
        case (typeof(cat_belong) !=="undefined" && data == cat_belong): heading.textContent = "Log category:"; break;
        case (typeof(con_belong) !=="undefined" && data == con_belong): heading.textContent = "Log concentration:"; break;
        case (typeof(classes) !=="undefined" && data == classes): heading.textContent = "Register a class:"; break;
        case (typeof(section) !=="undefined" && data == section): heading.textContent = "Register a section:"; break;
        case (typeof(weekly_meeting) !=="undefined" && data == weekly_meeting): heading.textContent = "register weekly meetings for section:"; break;
        case (typeof(enrollment) !=="undefined" && data == enrollment): heading.textContent = "Enroll a student into course:"; break;
        case (typeof(waitlist) !=="undefined" && data == waitlist): heading.textContent = "Waitlist a student into course:"; break;
        case (typeof(thesis_committee) !=="undefined" && data == thesis_committee): heading.textContent = "Register student's thesis Committee:"; break;
        case (typeof(advisory) !=="undefined" && data == advisory): heading.textContent = "Register student's advisory:"; break;
        case (typeof(probation) !=="undefined" && data == probation): heading.textContent = ":"; break;
        case (typeof(review) !=="undefined" && data == review): heading.textContent = "Register section review:"; break;
        case (typeof(ucsd_degree) !=="undefined" && data == ucsd_degree): heading.textContent = "Register a UCSD Degree requirement:"; break;
        case (typeof(cat_requirement) !=="undefined" && data == cat_requirement): heading.textContent = "Register UCSD category requirement:"; break;
        case (typeof(con_requirement) !=="undefined" && data == con_requirement): heading.textContent = "Register UCSD concentration requirement:"; break;
        case (typeof(research) !=="undefined" && data == research): heading.textContent = "Register research:"; break;
        case (typeof(research_lead) !=="undefined" && data == research_lead): heading.textContent = "Register research lead:"; break;
        case (typeof(work_on_research) !=="undefined" && data == work_on_research): heading.textContent = "Register student to research:"; break;
      }
      mainContent = document.getElementById("mainContent");
      mainContent.appendChild(heading);
    }
    //if (i==1) // maybe i==1 just as new value......
    // ---> insert as an independent function...since still use it 
    //  continue;
    // i==1 still need, at least 1 row.
    var row = table.insertRow();
    for (var j = 0; j < data[i].length; j++) {
      var cell = row.insertCell();
      //cell.innerHTML = data[i][j];
      var box;
      if (i == 0) { // all just label
        cell.innerHTML = data[i][j];
      }
      else {
        if (data[1][j] === "varchar") {
          box = document.createElement('input');
          box.type = "text";
          if (i > 1)
            box.value = data[i][j];
        } else if (data[1][j] === "bool") {
          box = document.createElement('input');
          box.type = "checkbox";
          if (i > 1) {
            if (data[i][j] == "t")
              box.checked = true;
            else if (data[i][j] == "f")
              box.checked = false;
            else
              alert("unhandled value " + data[1][j] + "  " + data[i][j]);
          }
        } else if (data[1][j] === "int4" || data[1][j] === "float4") {
          box = document.createElement('input');
          box.type = "number";
          if(i > 1)
            box.value = data[i][j];
        } else if(data[1][j] === "time"){
          box = document.createElement("input");
          box.type = "time";
          if(i > 1)
            box.value = data[i][j]
        }else if(data[1][j] === "date"){
          box = document.createElement("input");
          box.type = "date";
          if(i > 1)
            box.value = data[i][j];
        }else{
          alert("unhandled type  " + data[1][j]);
        }
        box.setAttribute("data_name",data[0][j]);
        box.setAttribute("data_type",data[1][j]);
        cell.appendChild(box);
      }
    }

    // action
    cell = row.insertCell();
    if (i==0){
      cell.innerHTML = "action";
    } else if (i==1){
      cell.appendChild(button_insert());
    } else {
      cell.appendChild(button_update());
      cell.appendChild(button_delete());
      cell.appendChild(button_detail());
    }
  }
  table.setAttribute("table_name",table_name);
  // Add the table to the page
  mainContent = document.getElementById("mainContent");
  mainContent.appendChild(table);
  return table;
}

function entity_insertrow(table) {
  //table.insertBefore
  var row = table.insertRow(1);
  var row_pre = table.rows[2];
  row.outerHTML = row_pre.outerHTML; // already not include the value ???? 
  // change button
  button = document.createElement('button');
  button.innerText = "insert";
  row = table.rows[1]; // this makes more stable ????????????????
  cell = row.cells[row.cells.length-1];
  cell.innerHTML = ""; // can't just use innerHTML...otherwise onclick not add
  cell.appendChild(button);
  // add onclick event... button reuse below
  button.onclick = function(){insert(this)};

  // change the previous row's button
  cell_pre = row_pre.cells[row_pre.cells.length-1];
  cell_pre.innerHTML = "";
  cell_pre.appendChild(button_update());
  cell_pre.appendChild(button_delete());
  cell_pre.appendChild(button_detail());

  // table.innerHTML = table.innerHTML; // force to refresh
  return row;
  // refresh automatically, but need content

  // var row =  copy_row.cloneNode();//table.insertRow(1);

  /*for (var j = 0; j < copy_row.length; j++) {
      // just copy to avoid the discussion
      var cell = copy_row.tcell[j].cloneNode();
      row.insertCell().outerHTML = cell.outerHTML; // outer is entire, innerHTML only inside
  }*/
  // table.innerHTML = table.innerHTML; // force to refresh
  return row;
  // refresh automatically, but need content
}

function row_json(row){
  json ={};
  table = button.parentNode.parentNode.parentNode.parentNode;
  json["table_name"]=table.getAttribute("table_name");

  // row information
  row = button.parentNode.parentNode;
  cells = row.cells;
  for (i=0;i<cells.length-1;i++){
    box = cells[i].childNodes;
    data_type = box.getAttribute("data_type");
    data_name = box.getAttribute("data_name");
    value = null;
    if(data_type==="varchar"){
      value = box.value;
    } else if (data_type==="int4"){
      value = box.value;
    } else if(data_type === "float4"){
      value = box.value;
    }else if (data_type === "date"){
      value = box.value;
    }else if(data_type === "bool"){
      if(box.checked){
        value = "true";
      }else{
        value = "false";
      }
    }else if(data_type === "time"){
        value = box.value;
    }else{
      alert ("unhandled data type to convert into sql "+data_type);
    }

    json[data_name] = value;
  }

  return json;
}

function insert(button) {
  // check validation ???

  // server side...send to insert into the database

  // client side...add new row
  table = button.parentNode.parentNode.parentElement;
  entity_insertrow(table);
}

function update(button) {
  // server side...send to update the database

  // client side...on extra 
}

function delete_(button) {
  // server side...send to update the database

  // client side...add new row
  entity_insertrow(table);
}

function detail(button) {
  // server side...send to update the database

  // client side...add new row
  entity_insertrow(table);
}

/*
table = data_entity(student); 
mainContent = document.getElementById("mainContent");
row = entity_insertrow(table);
*/





