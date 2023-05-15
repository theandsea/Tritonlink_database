function greet() {
  alert("Hello, world!");
}

function data_entity(data) {
  var table = document.createElement("table");

  // Loop over the data array to add rows and cells to the table
  for (var i = 0; i < data.length; i++) {
    //prompt
    if (i == 0) {
      var cell = table.insertRow();
      switch(true){
        case (typeof(student)!=="undefined" && data == student ): cell.innerHTML = "Register a student:"; break;
        case (typeof(undergraduates) !=="undefined" && data == undergraduates): cell.innerHTML = "Register a student as an undergraduate:"; break;
        case (typeof(graduates) !=="undefined" && data == graduates): cell.innerHTML = "Register a student as a graduate:"; break;
        case (typeof(previous_d) !=="undefined" && data == previous_d): cell.innerHTML = "Register student's non-UCSD degree:"; break;
        case (typeof(attendence) !=="undefined" && data == attendence): cell.innerHTML = "Register a student's attendence:"; break;
        case (typeof(faculty)!== "undefined" && data == faculty): cell.innerHTML = "Register a faculty:"; break;
        case (typeof(course) !=="undefined" && data == course): cell.innerHTML = "Register a course:"; break;
        case (typeof(prerequirement) !=="undefined" && data == prerequirement): cell.innerHTML = "Log Pre-required Course:"; break;
        case (typeof(cat_belong) !=="undefined" && data == cat_belong): cell.innerHTML = "Log category:"; break;
        case (typeof(con_belong) !=="undefined" && data == con_belong): cell.innerHTML = "Log concentration:"; break;
        case (typeof(classes) !=="undefined" && data == classes): cell.innerHTML = "Register a class:"; break;
        case (typeof(section) !=="undefined" && data == section): cell.innerHTML = "Register a section:"; break;
        case (typeof(weekly_meeting) !=="undefined" && data == weekly_meeting): cell.innerHTML = "register weekly meetings for section:"; break;
        case (typeof(enrollment) !=="undefined" && data == enrollment): cell.innerHTML = "Enroll a student into course:"; break;
        case (typeof(waitlist) !=="undefined" && data == waitlist): cell.innerHTML = "Waitlist a student into course:"; break;
        case (typeof(thesis_committee) !=="undefined" && data == thesis_committee): cell.innerHTML = "Register student's thesis Committee:"; break;
        case (typeof(advisory) !=="undefined" && data == advisory): cell.innerHTML = "Register student's advisory:"; break;
        case (typeof(probation) !=="undefined" && data == probation): cell.innerHTML = ":"; break;
        case (typeof(review) !=="undefined" && data == review): cell.innerHTML = "Register section review:"; break;
        case (typeof(ucsd_degree) !=="undefined" && data == ucsd_degree): cell.innerHTML = "Register a UCSD Degree requirement:"; break;
        case (typeof(cat_requirement) !=="undefined" && data == cat_requirement): cell.innerHTML = "Register UCSD category requirement:"; break;
        case (typeof(con_requirement) !=="undefined" && data == con_requirement): cell.innerHTML = "Register UCSD concentration requirement:"; break;
        case (typeof(research) !=="undefined" && data == research): cell.innerHTML = "Register research:"; break;
        case (typeof(research_lead) !=="undefined" && data == research_lead): cell.innerHTML = "Register research lead:"; break;
        case (typeof(work_on_research) !=="undefined" && data == work_on_research): cell.innerHTML = "Register student to research:"; break;


      }
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
        } else if(data[1][j] === "time"){
          box = document.createElement("input");
          box.type = "time";
        }else if(data[1][j] === "date"){
          box = document.createElement("input");
          box.type = "date";
        }else{
          alert("unhandled type  " + data[1][j]);
        }

        cell.appendChild(box);
      }
    }

    // action
    cell = row.insertCell();
    if (i == 0) {
      cell.innerHTML = "action";
    } else if (i == 1) {
      /**/
      button = document.createElement('button');
      button.innerText = "insert";
      button.onclick = function () { insert(this) };; // wrap to avoid automatically run
      cell.appendChild(button);

    } else {
      button = document.createElement('button');
      button.innerText = "update";
      cell.appendChild(button);
      button = document.createElement('button');
      button.innerText = "delete";
      cell.appendChild(button);
      button = document.createElement('button');
      button.innerText = "detail";
      cell.appendChild(button);
    }
  }

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
  cell = row.cells[row.cells.length - 1];
  cell.innerHTML = ""; // can't just use innerHTML...otherwise onclick not add
  cell.appendChild(button);
  // add onclick event... button reuse below
  button.onclick = function () { insert(this) };

  // change the previous row's button
  cell_pre = row_pre.cells[row_pre.cells.length - 1];
  cell_pre.innerHTML = "";
  button = document.createElement('button');
  button.innerText = "update";
  cell_pre.appendChild(button);
  button = document.createElement('button');
  button.innerText = "delete";
  cell_pre.appendChild(button);
  button = document.createElement('button');
  button.innerText = "detail";
  cell_pre.appendChild(button);

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



