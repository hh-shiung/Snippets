# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Landing Page
Rails.application.config.assets.precompile += %w( jquery-2.1.4.min.js )
Rails.application.config.assets.precompile += %w( jquery.scrollex.min.js )
Rails.application.config.assets.precompile += %w( jquery.scrolly.min.js )
Rails.application.config.assets.precompile += %w( skel.min.js )
Rails.application.config.assets.precompile += %w( util.js )
Rails.application.config.assets.precompile += %w( main.js )

# Snippets Dashboard Page JS
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( modernizr.min.js )
Rails.application.config.assets.precompile += %w( jquery.dcjqaccordion.2.7.js )
Rails.application.config.assets.precompile += %w( jquery-ui-1.9.2.custom.min.js )
Rails.application.config.assets.precompile += %w( jquery.ui.touch-punch.min.js )
Rails.application.config.assets.precompile += %w( jquery.scrollTo.min.js )
Rails.application.config.assets.precompile += %w( jquery.nicescroll.js )
Rails.application.config.assets.precompile += %w( jquery.sparkline.js )
Rails.application.config.assets.precompile += %w( jquery.gritter.js )
Rails.application.config.assets.precompile += %w( gritter-conf.js )
Rails.application.config.assets.precompile += %w( sparkline-chart.js )
Rails.application.config.assets.precompile += %w( zabuto_calendar.js )
Rails.application.config.assets.precompile += %w( common-scripts.js )
Rails.application.config.assets.precompile += %w( Chart.js )

# Snippets Login Page JS
Rails.application.config.assets.precompile += %w( jquery.backstretch.min.js )

# Snippets Page CSS
Rails.application.config.assets.precompile += %w( zabuto_calendar.css )
Rails.application.config.assets.precompile += %w( jquery.gritter.css )
Rails.application.config.assets.precompile += %w( lineicons_style.css )
Rails.application.config.assets.precompile += %w( bootstrap-theme.min.css )
Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( font-awesome.min.css )
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( style-responsive.css )
