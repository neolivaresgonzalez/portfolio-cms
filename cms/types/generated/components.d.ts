import type { Schema, Struct } from '@strapi/strapi';

export interface BlocksCodeSample extends Struct.ComponentSchema {
  collectionName: 'components_blocks_code_samples';
  info: {
    displayName: 'Code Sample';
    icon: 'code';
  };
  attributes: {};
}

export interface BlocksGallery extends Struct.ComponentSchema {
  collectionName: 'components_blocks_galleries';
  info: {
    displayName: 'Gallery';
    icon: 'landscape';
  };
  attributes: {};
}

export interface BlocksHero extends Struct.ComponentSchema {
  collectionName: 'components_blocks_heroes';
  info: {
    displayName: 'Hero';
    icon: 'gate';
  };
  attributes: {};
}

export interface BlocksImageWithCaption extends Struct.ComponentSchema {
  collectionName: 'components_blocks_image_with_captions';
  info: {
    displayName: 'Image with caption';
    icon: 'landscape';
  };
  attributes: {};
}

export interface BlocksLink extends Struct.ComponentSchema {
  collectionName: 'components_blocks_links';
  info: {
    displayName: 'Link';
    icon: 'link';
  };
  attributes: {};
}

export interface BlocksMetric extends Struct.ComponentSchema {
  collectionName: 'components_blocks_metrics';
  info: {
    displayName: 'Metric';
    icon: 'magic';
  };
  attributes: {};
}

export interface BlocksRichBody extends Struct.ComponentSchema {
  collectionName: 'components_blocks_rich_bodies';
  info: {
    displayName: 'Rich Body';
    icon: 'bulletList';
  };
  attributes: {};
}

export interface BlocksVideoEmbed extends Struct.ComponentSchema {
  collectionName: 'components_blocks_video_embeds';
  info: {
    displayName: 'Video Embed';
    icon: 'landscape';
  };
  attributes: {};
}

export interface NavigationNavItem extends Struct.ComponentSchema {
  collectionName: 'components_navigation_nav_items';
  info: {
    displayName: 'Nav Item';
    icon: 'bulletList';
  };
  attributes: {};
}

export interface NavigationSocialLink extends Struct.ComponentSchema {
  collectionName: 'components_navigation_social_links';
  info: {
    displayName: 'Social Link';
    icon: 'handHeart';
  };
  attributes: {};
}

export interface SeoOpenGraph extends Struct.ComponentSchema {
  collectionName: 'components_seo_open_graphs';
  info: {
    displayName: 'Open Graph';
    icon: 'search';
  };
  attributes: {};
}

export interface SeoSeo extends Struct.ComponentSchema {
  collectionName: 'components_seo_seos';
  info: {
    displayName: 'Seo';
    icon: 'search';
  };
  attributes: {};
}

export interface SeoXCard extends Struct.ComponentSchema {
  collectionName: 'components_seo_x_cards';
  info: {
    displayName: 'X Card';
    icon: 'twitter';
  };
  attributes: {};
}

declare module '@strapi/strapi' {
  export module Public {
    export interface ComponentSchemas {
      'blocks.code-sample': BlocksCodeSample;
      'blocks.gallery': BlocksGallery;
      'blocks.hero': BlocksHero;
      'blocks.image-with-caption': BlocksImageWithCaption;
      'blocks.link': BlocksLink;
      'blocks.metric': BlocksMetric;
      'blocks.rich-body': BlocksRichBody;
      'blocks.video-embed': BlocksVideoEmbed;
      'navigation.nav-item': NavigationNavItem;
      'navigation.social-link': NavigationSocialLink;
      'seo.open-graph': SeoOpenGraph;
      'seo.seo': SeoSeo;
      'seo.x-card': SeoXCard;
    }
  }
}
