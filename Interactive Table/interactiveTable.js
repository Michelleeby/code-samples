/**
 * Moves a row in a table given an action 'move-up', 'move-down', or 'delete'.
 * @param {string} action The action to perform on the row. Either 'move-up', 
 * 'move-down', or 'delete'.
 * @param {Element} row The row to perform the action on.
 * @param {Element} table The table the row is within.
 */
 const moveRow = (action, row, table) => {
  
	switch (action) {
  
  	case 'move-up':
    	const rowUp = row.previousSibling;
      if ( rowUp ) { table.insertBefore(row, rowUp); }
      break;
      
    case 'move-down':
    	const rowDown = row.nextSibling;
      if ( rowDown ) { table.insertBefore(rowDown, row); }
      break;
      
    case 'delete':
    	table.removeChild(row);
  }
};


/**
 * Adds a new row with the given form data to a mount element.
 * @param {Element} form The form data to insert into the row.
 * @param {Element} mount The mount element to insert the row into.
 */
const addRow = (form, mount) => {
  

  /**
   * Builds buttons and their event listeners and returns the button elements for a given row.
   * @param {Element} row The row element the buttons will belong to.
   * @param {Array} names An array of button names as strings.
   * @param {Array} buttons The accumulator to store a button element once built.
   * @returns {Array} An array of button elements.
   */
  const buttons = (row, names, buttons = []) => {
    // Build Buttons
    names.forEach( (name) => {
      const button = document.createElement('button');
      const label = document.createTextNode(name);

      button.className = name;
      button.appendChild(label);
      buttons.push(button);
    });
    
    // Build button event listeners
    buttons.forEach( (button) => {
    	button.addEventListener('click', () => moveRow(button.className, row, mount));
    });
    
    return buttons
  };
  

  /**
   * Builds and returns table data elements given data.
   * @param {Array} data An array of objects that hold data values.
   * @param {Array} fill The accumulator to store table data elements once built.
   * @returns {Array} An array of table data elements filled with data values.
   */
  const fillData = (data, fill = []) => {

    for (const datum of data) {
      if ( datum.name ) {
        const val = document.createTextNode(datum.value);
        const element = document.createElement('td');

        element.appendChild(val);
        fill.push(element);
      }
    }

    return fill
  };

	
  /**
   * Builds and returns a table data element filled with buttons.
   * @param {Array} buttons An array of button elements to append to the table data element.
   * @returns {Element} Returns a table data element filled with buttons.
   */
  const fillButtons = (buttons) => {
  	const element = document.createElement('td');
    
  	buttons.forEach( (button) => element.appendChild(button) );
    
    return element
  };
  
	
  
  /**
   * Fills a row element with the given data and the default control buttons.
   * @param {Element} row The row element to fill.
   * @param {Array} data The data array to fill the row with.
   * @returns {Element} Returns the row filled with data and control buttons.
   */
  const fillRow = (row, data) => {
    data.forEach( (datum) => row.appendChild(datum) );
    
    const buttonNames = ['move-up', 'move-down', 'delete'];
    row.appendChild( fillButtons( buttons( row, buttonNames)));
    
    return row
  };


  const rowElement = document.createElement('tr');
  rowElement.className = 'data-row';
  
  const row = fillRow( rowElement, fillData(form) );
  mount.appendChild(row);
};


var form = document.querySelector('form');
var table = document.getElementById('table-mount');


form.addEventListener('submit', function(e) {
  e.preventDefault();
  addRow(form, table);
});

