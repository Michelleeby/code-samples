import { Db, DbItem } from './lib';
import { items } from './items';

/**
 * Consumes Raw Items and returns Database Items.
 */
const dbItems = (rawItems) => {
  return rawItems.map( (item) => {
    return new DbItem(item.metadata.slug, item.img, item.metadata)
  })
}

/**
 * Consumes an array of Database Items and returns a populated Database object.
 * @property {Array} items - An array of Database Item.
 */
const db = new Db(dbItems(items));


export default db;

