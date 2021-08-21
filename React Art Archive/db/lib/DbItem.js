/**
 * Class representing a Database Item.
 * @property {string} name - Name of the Item.
 * @property {Object} img - Image file object for the Item.
 * @property {Object} metadata - Metadata file object for the Item.
 */
class DbItem {
  /**
   * Constructor for a Database Item.
   * @param {string} name - Name of the Item.
   * @param {Object} img - Image file object for the Item.
   * @param {Object} metadata - Metadata file object for the Item.
   */
  constructor(name, img, metadata) {
    this.name = name;
    this.img = img;
    this.metadata = metadata;
  };
};


export default DbItem;

