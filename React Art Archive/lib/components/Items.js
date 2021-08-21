import React from 'react'
import {Item, Tags} from './'


/**
 * Class representing a collection of Items.
 * @property {Array} items - An array of Database Items.
 * @property {string} title - Title of the collection of Items. 
 */
class Items extends React.Component {
  render() {
    return (
      <>
      <section>
        <header>
          <h1>{this.props.title}</h1>
        </header>
        {this.printItems(this.props.items)}
      </section>
      </>
    )
  }
  /**
   * Renders a given list of objects as a collection of Item.
   * @param {Array} items An array of Item objects.
   * @returns {Array} An array of JSX.Element.
   */
  printItems(items) {
    const listItems = items.map((item => {
      const tags = <Tags tags = { item.metadata.tags } />;

      return (
        <Item 
          metadata = {item.metadata} 
          img = {item.img} 
          tags = {tags}
        />
      )
    }));
  
    return listItems
  }
}


export default Items;

