import React from 'react';
/**
 * Class representing an Item.
 * @property {Object} metadata
 * @property {Object} img 
 * @property {React.Component} tags
 */
class Item extends React.Component {
  /**
   * Render React component.
   * @returns {JSX.Element} React.Fragment
   */
  render() {
    /**
     * Item metadata.
     * @property {string} title - Title of the Item.
     * @property {string} series - Title of the Item series.
     * @property {string} transcription - Transcription of the Item.
     * @property {object} img - Metadata for the img of the Item.
     * @property {string} img.alt - Alt text for the img.
     */
    const metadata = this.props.metadata;
    /**
     * Item image.
     * @property {string} src - Image filename + ext.
     * @property {string} srcSet - Image srcset.
     * @property {number} width - Image intrinsic width.
     * @property {number} height - Image intrinsic height.
     * @property {array} images - Array of Image objects.
     * @property {number} images[i].height - ith image height.
     * @property {number} images[i].width - ith image width.
     * @property {string} images[i].path - ith image path.
     */
    const img = this.props.img;

    return (
      <>
      <article>
        <header>
          <h2>{metadata.title}</h2>
          <h3>{metadata.series}</h3>
        </header>
        
        <img 
        src={img.src} 
        srcSet={img.srcSet}
        alt={metadata.img.alt} 
        width={img.width} 
        height={img.height}
        />

        <p>{metadata.transcription}</p>

        {this.props.tags}
      </article>
      </>
    );
  }
}

export default Item;

