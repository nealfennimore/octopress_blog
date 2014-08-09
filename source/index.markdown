---
layout: page
title: "OctoFound"
subtitle: "A Foundation-5 Theme for Octopress"
comments: false
sharing: false
footer: true
body_id: "main_page"
sidebar: true
---
Welcome to OctoFound! OctoFound is a <strong>responsive</strong> and <strong>highly customizable</strong> Foundation-5 theme for Octopress. Browse the theme using the navigation above, or read about the features below. Scroll down for notes on installation.

<h3>Theme Features:</h3>

<ul>
	<li><strong>Completely responsive</strong>: adapts to any screen size, from ginormous to mobile.</li>
	<li><strong>All of Foundation's SASS and Javascript components</strong> are included. <a href="http://foundation.zurb.com/docs/sass.html">Browse Foundation's docs</a> to learn about what these components enable you to do.</li>
	<li><strong>SASS files</strong> that are highly documented and easy-to-edit: _settings.scss & screen.scss</li>
	<li><strong>No-sidebar, left-sidebar, and right-sidebar</strong> page templates. To use these different layouts, open <code>your_page_or_post.markdown</code> and add the line <code>sidebar: false</code> to hide the sidebar, or <code>sidebar_left: true</code> to make the sidebar display on the left. The sidebar displays on the right by default.</li>
	<li><strong>Sticky navigation bar:</strong> to make the navigation bar stick to the top of the page, add the line <code>fixed_navigation: true</code> to your <code>_config.yml</code> file.</li>
	<li><strong>Optional subtitles on pages:</strong> in <code>your_page.markdown</code>, put the line <code>subtitle: Your Subtitle Here</code> in the header to give that page a subtitle.</li>
	<li><strong>Font Awesome 4.0.3:</strong> <a href="http://fortawesome.github.io/Font-Awesome/icons/">click here</a> to browse the amazing icons at your fingertips. <i class="fa fa-smile-o"></i></li>
</ul>




<h3>Installation:</h3>
<ol>
	<li>Install <a href="http://foundation.zurb.com/docs/sass.html">Foundation 5</a> & dependencies using these commands:
		<ul>
			<li>
				<code>$ [sudo] npm install -g bower grunt-cli</code>
			</li>
			<li>
				<code>$ gem install foundation</code>
			</li>
		</ul>
		If you have an older version of Foundation already, you may need to uninstall it completely before re-installing the latest version (note that the name of the gem changed between versions 4 and 5).
	</li>
	<li>Add the following lines to your config.rb file:
		<ul>
			<li><code>add_import_path "bower_components/foundation/scss"</code>
			</li>
			<li><code>javascripts_dir = "source/js"</code></li>
		</ul>

	</li>
	<li>Install the theme using these commands:
		<ul>
			<li><code>$ cd your_octopress_root</code></li>
			<li><code>$ git clone https://github.com/annejohnson/octofound .themes/octofound</code></li>
			<li><code>$ rake install['octofound']</code></li>
			<li><code>$ rake generate</code></li>
		</ul>
	</li>
	<li>Verify that <code>bower_components</code>, its contents, and <code>bower.json</code> got added to your root directory. If they didn't, you will need to add theme manually.</li>
	<li>If you see any gem version errors, try updating your Gemfiles to reflect updates you made while installing Foundation, and/or run your rake commands with <code>bundle exec</code>. If there are any Foundation errors, try adding Foundation to your Gemfiles.</li>
	<li>Change the home page, and change or delete the no-sidebar, left-sidebar, right-sidebar, and example-formatting pages. 
		<ul><li>Update <strong>_includes/custom/navigation.html</strong> to reflect these changes. Remember to update not just the link URLs and text, but also the conditionals in the list elements (which are responsible for adding the "active" class).</li></ul>
	</li>

</ol>

