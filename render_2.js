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


function data_entity(data, table_name){
  table = document.createElement("table");
      
  // Loop over the data array to add rows and cells to the table
  for (var i = 0; i < data.length; i++) {
    //if (i==1) // maybe i==1 just as new value......
    // ---> insert as an independent function...since still use it 
    //  continue;
    // i==1 still need, at least 1 row.
    var row = table.insertRow();
    for (var j = 0; j < data[i].length; j++) {
      var cell = row.insertCell();
      //cell.innerHTML = data[i][j];
      var box;
      if (i==0){ // all just label
        cell.innerHTML = data[i][j];
      }
      else {
        if (data[1][j] === "varchar"){
          box = document.createElement('input');
          box.type = "text";
          if (i>1)
            box.value = data[i][j];
        } else if (data[1][j] === "bool"){
          box = document.createElement('input');
          box.type = "checkbox";
          if(i>1){
            if (data[i][j] == "t")
              box.checked = true;
            else if (data[i][j] == "f")
              box.checked = false;
            else 
              alert("unhandled value "+data[1][j]+"  "+data[i][j]);
          }
        } else {
          alert("unhandled type  "+data[1][j]);
        }


        // set the data_type, data_name
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
  var h1 = document.createElement("h1");
  h1.innerText = table_name;
  mainContent.appendChild(h1); 
  mainContent.appendChild(table); 
  return table;
}

function entity_insertrow(table){
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
}


function row_json(button){
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

    } else if (data_type==="int4"){

    } else {
      alert ("unhandled data type to convert into sql "+data_type);
    }

    json[data_name] = value;
  }

  return json;
}

function insert(button){
  

  // server side...send to insert into the database

  // client side...add new row
  table = button.parentNode.parentNode.parentElement;
  entity_insertrow(table);
}

function update(button){
  // server side...send to update the database

  // client side...on extra 
}

function delete_(button){
  // server side...send to update the database

  // client side...add new row
  entity_insertrow(table);
}

function detail(button){
  // server side...send to update the database

  // client side...add new row
  entity_insertrow(table);
}

/*
table = data_entity(faculty,"faculty"); 
mainContent = document.getElementById("mainContent");
row = entity_insertrow(table);
*/
