/**
 * Class representing a Database.
 * @property {Array} items - Exposed Import objects.
 */
class Db {
  /**
   * @param {Array} imports - Array of Import objects.
   */
  constructor(imports) {
    this.items = imports;
  };
};

export default Db