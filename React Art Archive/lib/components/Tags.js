import React from "react";
/**
 * Class representing a collection of Tags.
 * @property {Array} tags - A list of tags.
 */
class Tags extends React.Component {
  render() {
    return (
      <>
      <ul>
        {this.PrintTags(this.props.tags)}
      </ul>
      </>
    );
  }
  /**
   * 
   * @param {Array} tags - List of strings, or tags.
   * @returns {Array} Tags as a list of JSX.Element.
   */
  PrintTags(tags) {
    const listItems = tags.map((tag) =>  <li>{tag}</li>);
    return listItems
  }
}

export default Tags;